`timescale 1 ns / 1 ps
// -------------------------------------------------------------
// Minimal AXI4-Lite wrapper for peak_height_binning_cdma
// - 32-bit word regs, offset = 4*index (ADDR_LSB=2)
// - Bins live in an external bram_interface (Port-A -> AXI BRAM Ctrl/CDMA);
//   this wrap exposes Port-B (driven by the histogram) to the block design.
// - Only edit: USER MAP and USER INSTANTIATION
//
// Register map (offset = 4 * index):
//   0x00 offset   : [15:0] signed
//   0x04 gain     : [15:0] unity = 2^(GAIN_WIDTH/2) = 256
//   0x08 band_low : [15:0] signed  (DAC energy-band trigger)
//   0x0C band_high: [15:0] signed
//   0x10 control  : [0]clear_bins [1]counting_enable [2]filter_reset
//   0x14 pulse_width : [15:0] band_detected pulse (clk cycles)
//   0x18 spare
//   0x1C status   : [0]overflow_flag [1]clearing_active   (read-only)
// -------------------------------------------------------------
module peak_height_binning_cdma_axi_wrap #(
    parameter integer C_S_AXI_ADDR_WIDTH = 8,
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer LOG_NPAR        = 3,    // 3 -> 8 regs
    parameter integer LOG_NBINS       = 15,   // 32768 bins (full res for signed-16 peak)
    parameter integer BIN_COUNT_WIDTH = 32,
    parameter integer PEAK_DATA_WIDTH = 16,
    parameter integer THRESHOLD_WIDTH = 16,
    parameter integer GAIN_WIDTH      = 16
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
    // USER PORTS BEGIN
    // ---------------------------------------------------------
    input  wire                              peak_detected,
    input  wire signed [PEAK_DATA_WIDTH-1:0] peak_value_in,
    output wire signed [15:0]                band_detected,

    // BRAM Port-B (bins in external bram_interface; Port-A -> AXI BRAM Ctrl/CDMA)
    output wire [LOG_NBINS-1:0]              bram_addr,
    output wire [BIN_COUNT_WIDTH-1:0]        bram_din,
    output wire                              bram_en,
    output wire [(BIN_COUNT_WIDTH/8)-1:0]    bram_we,
    input  wire [BIN_COUNT_WIDTH-1:0]        bram_dout
);

    localparam integer ADDR_LSB   = 2;
    localparam integer N_REGS     = (1 << LOG_NPAR);
    localparam integer N_READONLY = 1;                // reg7 = status
    localparam [1:0]   RESP_OK    = 2'b00;

    // ---- AXI write channel ----
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

    // ---- register bank ----
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
            regs[7] <= {30'd0, clearing_active, overflow_flag};
        end
    end

    // ---- AXI read channel ----
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
    // USER MAP BEGIN
    // ---------------------------------------------------------
    wire signed [15:0] offset      = regs[0][15:0];  // +0x00
    wire        [15:0] gain        = regs[1][15:0];  // +0x04
    wire signed [15:0] band_low    = regs[2][15:0];  // +0x08
    wire signed [15:0] band_high   = regs[3][15:0];  // +0x0C
    wire        [31:0] control     = regs[4];        // +0x10
    wire        [15:0] pulse_width = regs[5][15:0];  // +0x14

    wire overflow_flag;
    wire clearing_active;

    wire fclk = s_axi_aclk;
    wire frst = ~s_axi_aresetn;

    // ---------------------------------------------------------
    // USER INSTANTIATION BEGIN
    // ---------------------------------------------------------
    peak_height_binning_cdma #(
        .PEAK_DATA_WIDTH  (PEAK_DATA_WIDTH),
        .BIN_COUNT_WIDTH  (BIN_COUNT_WIDTH),
        .LOG_NBINS        (LOG_NBINS),
        .THRESHOLD_WIDTH  (THRESHOLD_WIDTH),
        .GAIN_WIDTH       (GAIN_WIDTH)
    ) u_histogram_cdma (
        .clk             (fclk),
        .rst             (frst),
        .peak_detected   (peak_detected),
        .peak_value_in   (peak_value_in),
        .offset          (offset),
        .gain            (gain),
        .clear_bins      (control[0]),
        .counting_enable (control[1]),
        .band_low        (band_low),
        .band_high       (band_high),
        .pulse_width     (pulse_width),
        .filter_reset    (control[2]),
        .bram_addr       (bram_addr),
        .bram_din        (bram_din),
        .bram_en         (bram_en),
        .bram_we         (bram_we),
        .bram_dout       (bram_dout),
        .band_detected   (band_detected),
        .overflow_flag   (overflow_flag),
        .clearing_active (clearing_active)
    );

endmodule
