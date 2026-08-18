`timescale 1 ns / 1 ps
// -------------------------------------------------------------
// Minimal AXI4-Lite wrapper for event_logger
// - 32-bit word regs, offset = 4*index (ADDR_LSB=2)
// - N_REGS = 2**LOG_NPAR
// - Only edit: USER MAP and USER INSTANTIATION
//
// Register map (offset = 4 * index):
//   0x00 control  : [0]arm [1]clear_ts [2]reset [3]snap [4]ack
//   0x04 presc    : [15:0] clk cycles per us tick (125 @125 MHz)
//   0x08 frame_len: [ADDR_BITS-2:0] records per buffer before swap
//   0x0C flush_ticks: [31:0] us before forced swap of a partial buffer (0=never)
//   0x10 band_low : [15:0] signed  (log only peaks in [band_low, band_high])
//   0x14 band_high: [15:0] signed
//   0x18 chb_thr  : [15:0] signed  (channel-B digital threshold)
//   0x1C veto_ms  : [15:0] chB-transition veto window, ms (0 = off)
//                  events inside the window are logged with record[63]=1
//   ---- read-only ----
//   0x20 status   : [0]ready [1]ready_buf [2]dropped_nonzero
//   0x24 ready_count
//   0x28 dropped
//   0x2C ts_snap_lo  : timestamp[31:0]
//   0x30 ts_snap_hi  : timestamp[46:32]  (15 bits)
//   0x34 events_lo   : total_events[31:0]
//   0x38 events_hi   : total_events[46:32]
//   0x3C spare
// -------------------------------------------------------------
module event_logger_axi_wrap #(
    // AXI
    parameter integer C_S_AXI_ADDR_WIDTH = 8,
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    // Register bank
    parameter integer LOG_NPAR   = 4,   // 4 -> 16 regs
    // event_logger geometry
    parameter integer TS_WIDTH   = 47,
    parameter integer E_WIDTH    = 15,
    parameter integer REC_WIDTH  = 64,
    parameter integer ADDR_BITS  = 13,  // 2^ADDR_BITS words total (2 buffers)
    parameter integer PEAK_WIDTH = 16,
    parameter integer VETO_WIDTH = 16   // veto_ms width (16 -> up to 65.5 s)
)(
    // AXI4-Lite
    input  wire                              s_axi_aclk,
    input  wire                              s_axi_aresetn,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]     s_axi_awaddr,
    input  wire                              s_axi_awvalid,
    output wire                              s_axi_awready,
    input  wire [C_S_AXI_DATA_WIDTH-1:0]     s_axi_wdata,
    input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
    input  wire                              s_axi_wvalid,
    output wire                              s_axi_wready,
    output wire [1:0]                        s_axi_bresp,
    output wire                              s_axi_bvalid,
    input  wire                              s_axi_bready,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]     s_axi_araddr,
    input  wire                              s_axi_arvalid,
    output wire                              s_axi_arready,
    output wire [C_S_AXI_DATA_WIDTH-1:0]     s_axi_rdata,
    output wire [1:0]                        s_axi_rresp,
    output wire                              s_axi_rvalid,
    input  wire                              s_axi_rready,

    // ---------------------------------------------------------
    // USER PORTS BEGIN (edit to match your IP)
    // ---------------------------------------------------------
    input  wire                              peak_detected,   // 1-cycle pulse from peak_detector
    input  wire signed [PEAK_WIDTH-1:0]      peak_value_in,   // peak amplitude
    input  wire signed [PEAK_WIDTH-1:0]      chb_raw,         // channel-B ADC sample (tdata[31:16])

    // BRAM Port-B (Port-A -> AXI BRAM Ctrl / CDMA source)
    output wire [ADDR_BITS-1:0]              bram_addr,
    output wire [REC_WIDTH-1:0]              bram_din,
    output wire                              bram_en,
    output wire [(REC_WIDTH/8)-1:0]          bram_we
);

    localparam integer ADDR_LSB = 2;                  // 32-bit words
    localparam integer N_REGS   = (1 << LOG_NPAR);    // 16
    localparam integer N_READONLY = 8;                // regs 8..15 are read-only
    localparam [1:0]   RESP_OK  = 2'b00;

    // ----------------------------
    // AXI write channel (tiny)
    // ----------------------------
    reg awready, wready, bvalid;
    reg [1:0] bresp;
    reg [C_S_AXI_ADDR_WIDTH-1:0] awaddr_q;

    assign s_axi_awready = awready;
    assign s_axi_wready  = wready;
    assign s_axi_bvalid  = bvalid;
    assign s_axi_bresp   = bresp;

    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            awready <= 1'b0; wready <= 1'b0; bvalid <= 1'b0; bresp <= RESP_OK;
            awaddr_q <= {C_S_AXI_ADDR_WIDTH{1'b0}};
        end else begin
            awready <= (!awready && s_axi_awvalid && s_axi_wvalid);
            wready  <= (!wready  && s_axi_wvalid  && s_axi_awvalid);
            if (!awready && s_axi_awvalid && s_axi_wvalid) awaddr_q <= s_axi_awaddr;

            if (!bvalid && awready && s_axi_awvalid && wready && s_axi_wvalid) begin
                bvalid <= 1'b1; bresp <= RESP_OK;
            end else if (bvalid && s_axi_bready) begin
                bvalid <= 1'b0;
            end
        end
    end

    // ----------------------------
    // Register bank (N_REGS x 32)
    // ----------------------------
    reg [31:0] regs [0:N_REGS-1];

    function [31:0] wmask32(input [3:0] strobe);
        wmask32 = { {8{strobe[3]}}, {8{strobe[2]}}, {8{strobe[1]}}, {8{strobe[0]}} };
    endfunction

    wire write_fire = awready && s_axi_awvalid && wready && s_axi_wvalid;
    wire [LOG_NPAR-1:0] widx = awaddr_q[ADDR_LSB +: LOG_NPAR];

    integer k;
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            for (k = 0; k < N_REGS; k = k + 1) regs[k] <= 32'd0;
        end else begin
            if (write_fire && widx < (N_REGS - N_READONLY))
                regs[widx] <= (regs[widx] & ~wmask32(s_axi_wstrb))
                            | (s_axi_wdata &  wmask32(s_axi_wstrb));
            regs[8]  <= {29'd0, (dropped != 32'd0), ready_buf, ready};
            regs[9]  <= {{(32-ADDR_BITS){1'b0}}, ready_count};
            regs[10] <= dropped;
            regs[11] <= ts_snap[31:0];
            regs[12] <= {{(32-(TS_WIDTH-32)){1'b0}}, ts_snap[TS_WIDTH-1:32]};
            regs[13] <= total_events[31:0];
            regs[14] <= {{(32-(TS_WIDTH-32)){1'b0}}, total_events[TS_WIDTH-1:32]};
        end
    end

    // ----------------------------
    // AXI read channel (tiny)
    // ----------------------------
    reg arready, rvalid;
    reg [1:0] rresp;
    reg [31:0] rdata;
    reg [C_S_AXI_ADDR_WIDTH-1:0] araddr_q;

    assign s_axi_arready = arready;
    assign s_axi_rvalid  = rvalid;
    assign s_axi_rresp   = rresp;
    assign s_axi_rdata   = rdata;

    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            arready <= 1'b0; rvalid <= 1'b0; rresp <= RESP_OK; rdata <= 32'd0; araddr_q <= 0;
        end else begin
            arready <= (!arready && s_axi_arvalid);
            if (!arready && s_axi_arvalid) araddr_q <= s_axi_araddr;

            if (!rvalid && arready && s_axi_arvalid) begin
                rvalid <= 1'b1; rresp <= RESP_OK;
                if (araddr_q[ADDR_LSB +: LOG_NPAR] < N_REGS)
                    rdata <= regs[araddr_q[ADDR_LSB +: LOG_NPAR]];
                else
                    rdata <= 32'd0;
            end else if (rvalid && s_axi_rready) begin
                rvalid <= 1'b0;
            end
        end
    end

    // ---------------------------------------------------------
    // USER MAP BEGIN  (name your registers here)
    // ---------------------------------------------------------
    wire        [31:0] control     = regs[0];        // +0x00
    wire               arm         = control[0];
    wire               clear_ts    = control[1];
    wire               ctrl_reset  = control[2];
    wire               snap        = control[3];
    wire               ack         = control[4];
    wire        [15:0] presc       = regs[1][15:0];  // +0x04
    wire [ADDR_BITS-1:0] frame_len = regs[2][ADDR_BITS-1:0]; // +0x08
    wire        [31:0] flush_ticks = regs[3];        // +0x0C
    wire signed [15:0] band_low    = regs[4][15:0];  // +0x10
    wire signed [15:0] band_high   = regs[5][15:0];  // +0x14
    wire signed [15:0] chb_thr     = regs[6][15:0];  // +0x18
    wire [VETO_WIDTH-1:0] veto_ms  = regs[7][VETO_WIDTH-1:0]; // +0x1C

    // Read-only outputs from the module
    wire               ready;
    wire               ready_buf;
    wire [ADDR_BITS-1:0] ready_count;
    wire        [31:0] dropped;
    wire [TS_WIDTH-1:0] ts_snap;
    wire [TS_WIDTH-1:0] total_events;


    // clock/reset (simple: tie to AXI, plus soft reset bit)
    wire fclk = s_axi_aclk;
    wire frst = ~s_axi_aresetn | ctrl_reset;

    // ---------------------------------------------------------
    // USER INSTANTIATION BEGIN (drop your module here)
    // ---------------------------------------------------------
    event_logger #(
        .TS_WIDTH    (TS_WIDTH),
        .E_WIDTH     (E_WIDTH),
        .REC_WIDTH   (REC_WIDTH),
        .ADDR_BITS   (ADDR_BITS),
        .PRESC_WIDTH (16),
        .PEAK_WIDTH  (PEAK_WIDTH),
        .VETO_WIDTH  (VETO_WIDTH)
    ) u_event_logger (
        .clk           (fclk),
        .rst           (frst),
        .arm           (arm),
        .clear_ts      (clear_ts),
        .presc         (presc),
        .frame_len     (frame_len),
        .flush_ticks   (flush_ticks),
        .band_low      (band_low),
        .band_high     (band_high),
        .chb_threshold (chb_thr),
        .veto_ms       (veto_ms),
        .snap          (snap),
        .ack           (ack),
        .peak_detected (peak_detected),
        .peak_value_in (peak_value_in),
        .chb_raw       (chb_raw),
        .bram_addr     (bram_addr),
        .bram_din      (bram_din),
        .bram_en       (bram_en),
        .bram_we       (bram_we),
        .ready         (ready),
        .ready_buf     (ready_buf),
        .ready_count   (ready_count),
        .dropped       (dropped),
        .ts_snap       (ts_snap),
        .total_events  (total_events)
    );

endmodule
