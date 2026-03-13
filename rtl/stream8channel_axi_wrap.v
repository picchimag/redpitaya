`timescale 1 ns / 1 ps
// -------------------------------------------------------------
// Minimal AXI4-Lite wrapper for stream8channel
// - 32-bit word regs, offset = 4*index (ADDR_LSB=2)
// - N_REGS = 2**LOG_NPAR
// - Only edit: USER MAP and USER INSTANTIATION
// -------------------------------------------------------------
module stream8channel_axi_wrap #(
    // AXI
    parameter integer C_S_AXI_ADDR_WIDTH = 8,
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    // Register bank
    parameter integer LOG_NPAR = 3,  // 3 -> 8 regs
    // Stream parameters
    parameter integer ADDR_BITS = 12  // BRAM address width (12 = 4096 samples)
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
    // Data inputs (8 channels)
    input  wire signed [15:0]                in0,
    input  wire signed [15:0]                in1,
    input  wire signed [15:0]                in2,
    input  wire signed [15:0]                in3,
    input  wire signed [15:0]                in4,
    input  wire signed [15:0]                in5,
    input  wire signed [15:0]                in6,
    input  wire signed [15:0]                in7,

    // BRAM Port-B interface (128-bit packed samples, 16 byte-enables)
    output wire [ADDR_BITS-1:0]              bram_addr,
    output wire [127:0]                      bram_din,
    output wire                              bram_en,
    output wire [15:0]                       bram_we
);


    localparam integer ADDR_LSB = 2;                  // 32-bit words
    localparam integer N_REGS   = (1 << LOG_NPAR);    // number of regs
    localparam integer N_READONLY = 1;                // Register 7 is read-only
    localparam [1:0]   RESP_OK  = 2'b00;


    // ----------------------------
    // AXI write channel
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
            // Only initialize writable registers to 0, leave readonly registers alone
            for (k = 0; k < (N_REGS - N_READONLY); k = k + 1) regs[k] <= 32'd0;
        end else if (write_fire) begin
            if (widx < (N_REGS - N_READONLY))  // Protect last N_READONLY registers from AXI writes
                regs[widx] <= (regs[widx] & ~wmask32(s_axi_wstrb))
                            | (s_axi_wdata &  wmask32(s_axi_wstrb));
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
    // USER MAP BEGIN (edit register assignments to match your IP)
    // Register map:
    //   +0x00  reg[0]  frame_len   (ADDR_BITS+1 bits)
    //   +0x04  reg[1]  log_div     (5 bits, log2 decimation)
    //   +0x08  reg[2]  arm         (bit 0)
    //   +0x0C  reg[3]  ack         (bit 0)
    //   +0x10  reg[4]  (reserved)
    //   +0x14  reg[5]  (reserved)
    //   +0x18  reg[6]  (reserved)
    //   +0x1C  reg[7]  status      (read-only)
    //              [0]        ready
    //              [2:1]      (padding)
    //              [10:3]     seq
    //              [22:11]    wr_idx
    //              [23]       sample_tick
    // ---------------------------------------------------------
    wire [31:0] frame_len_reg = regs[0];
    wire [31:0] log_div_reg   = regs[1];
    wire [31:0] arm_reg       = regs[2];
    wire [31:0] ack_reg       = regs[3];

    // Wires from stream8channel module
    wire        ready_out;
    wire [7:0]  seq_out;
    wire [ADDR_BITS-1:0] wr_idx_out;
    wire        sample_tick_out;

    // Status register (read-only) - register 7
    always @(posedge s_axi_aclk) begin
        regs[7] <= {{(32-1-ADDR_BITS-8-2-1){1'b0}}, sample_tick_out, wr_idx_out, seq_out, 2'd0, ready_out};
    end

    // Choose the clock/reset (simple: tie to AXI)
    wire fclk = s_axi_aclk;
    wire frstn = s_axi_aresetn;

    // ---------------------------------------------------------
    // USER INSTANTIATION BEGIN
    // ---------------------------------------------------------
    stream8channel #(
        .SAMPLE_WIDTH  (16),
        .N_CH          (8),
        .ADDR_BITS     (ADDR_BITS),
        .LOG_DIV_WIDTH (5)     // 5 bits = max log_div of 31, counter width = 32 bits
    ) u_stream8channel (
        .clk          (fclk),
        .rstn         (frstn),

        // Control
        .arm          (arm_reg[0]),
        .frame_len    (frame_len_reg[ADDR_BITS:0]),
        .log_div      (log_div_reg[4:0]),
        .ack_raw      (ack_reg[0]),

        // Data inputs
        .in0          (in0),
        .in1          (in1),
        .in2          (in2),
        .in3          (in3),
        .in4          (in4),
        .in5          (in5),
        .in6          (in6),
        .in7          (in7),

        // BRAM Port-B
        .bram_addr    (bram_addr),
        .bram_din     (bram_din),
        .bram_en      (bram_en),
        .bram_we      (bram_we),

        // Status
        .ready        (ready_out),
        .seq          (seq_out),
        .wr_idx       (wr_idx_out),
        .sample_tick  (sample_tick_out)
    );

endmodule
