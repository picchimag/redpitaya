`timescale 1 ns / 1 ps
// -------------------------------------------------------------
// Minimal AXI4-Lite wrapper for peak_height_binning
// - 32-bit word regs, offset = 4*index (ADDR_LSB=2)
// - N_REGS = 2**LOG_NPAR
// - Only edit: USER MAP and USER INSTANTIATION
// -------------------------------------------------------------
module peak_height_binning_axi_wrap #(
    // AXI
    parameter integer C_S_AXI_ADDR_WIDTH = 8,
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    // Register bank
    parameter integer LOG_NPAR = 4  // 4 -> 16 regs
    
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
    input  wire                              slow_clk,          // Slow clock (available for future use)
    input  wire                              peak_detected,     // Peak detection trigger
    input  wire signed [15:0]                peak_value_in,     // Peak amplitude
    output wire [15:0]                       band_detected      // Energy band filtered output (unsigned 14-bit DAC)
);


    localparam integer ADDR_LSB = 2;                  // 32-bit words
    localparam integer N_REGS = (1 << LOG_NPAR);      // Number of registers = 2^LOG_NPAR
    localparam integer N_READONLY = 2;                // Number of read-only registers at the end (14 and 15 are read-only)
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
            regs[14] <= read_data;
            regs[15] <= {28'd0, clearing_active, overflow_flag, data_ready};
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
    
    // Control registers
    wire signed [15:0] offset     = regs[0][15:0];  // +0x00
    wire        [15:0] gain       = regs[1][15:0];  // +0x04
    wire signed [15:0] band_low   = regs[2][15:0];  // +0x08
    wire signed [15:0] band_high  = regs[3][15:0];  // +0x0C
    wire        [31:0] control    = regs[4];        // +0x10 control bits
    wire         [9:0] read_addr  = regs[5][9:0];   // +0x14 (histogram read address)
    wire        [15:0] pulse_width = regs[6][15:0]; // +0x18 pulse width (in clk cycles)
    
    // Output registers (last N_READONLY registers are read-only)
    wire        [31:0] read_data;                  // Histogram data from module
    wire               overflow_flag;              // Histogram overflow flag (internal)
    wire               data_ready;                 // Data ready flag (internal)
    wire               clearing_active;            // Clearing in progress flag
    
    
    // choose the filter clock/reset (simple: tie to AXI)
    wire fclk = s_axi_aclk;
    wire frst = ~s_axi_aresetn;  //AXI reset is active low, filter reset is active high


    // ---------------------------------------------------------
    // USER INSTANTIATION BEGIN (drop your module here)
    // ---------------------------------------------------------
    // All module parameter VALUES are set right here (nowhere else).
    peak_height_binning #(
        .PEAK_DATA_WIDTH  (16),
        .BIN_COUNT_WIDTH  (32),
        .LOG_NBINS        (10),
        .THRESHOLD_WIDTH  (16)
    ) u_histogram (
        .clk              (fclk),
        .slow_clk         (slow_clk),
        .rst              (frst),
        .peak_detected    (peak_detected),
        .peak_value_in    (peak_value_in),
        .offset           (offset),
        .gain             (gain),
        .clear_bins       (control[0]),
        .counting_enable  (control[1]),
        .band_low         (band_low),
        .band_high        (band_high),
        .pulse_width      (pulse_width),
        .filter_reset     (control[2]),
        .read_addr        (read_addr),
        .read_data        (read_data),
        .band_detected    (band_detected),
        .overflow_flag    (overflow_flag),
        .total_bins       (),  // not used
        .data_ready       (data_ready)
    );

endmodule