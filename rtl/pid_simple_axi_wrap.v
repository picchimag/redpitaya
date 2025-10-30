`timescale 1 ns / 1 ps
// -------------------------------------------------------------
// Minimal AXI4-Lite wrapper for iir2nd_direct
// - 32-bit word regs, offset = 4*index (ADDR_LSB=2)
// - N_REGS = 2**LOG_NPAR
// - Only edit: USER MAP and USER INSTANTIATION
// -------------------------------------------------------------
module pid_simple_axi_wrap #(
    // AXI
    parameter integer C_S_AXI_ADDR_WIDTH = 8,
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    // Register bank
    parameter integer LOG_NPAR = 3  // 3 -> 8 regs
    
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
    input  wire                              slow_clk,   // optional sample boundary/enable
    input  wire  signed [31:0]               x_in,       // example data input
    output wire  signed [15:0]               y_out       // example data output
);


    localparam integer ADDR_LSB = 2;                  // 32-bit words
    localparam integer N_REGS   = (1 << LOG_NPAR);    // number of regs
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
        end else if (write_fire) begin
            if (widx < N_REGS)
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
    // USER MAP BEGIN  (name your registers here)
    // ---------------------------------------------------------
    // Example (direct-form):
    wire signed [31:0] setpoint = regs[0]; // +0x18
    wire signed [31:0] Kp   = regs[1];  // +0x00
    wire signed [31:0] Ki   = regs[2];  // +0x04
    wire signed [31:0] Kd   = regs[3];  // +0x08
    wire signed [31:0] alpha_d   = regs[4];  // +0x08
    wire signed [31:0] gain = regs[5];  // +0x0C
    wire        [31:0] control  = regs[6];  // +0x10
    

    // choose the filter clock/reset (simple: tie to AXI)
    wire fclk = s_axi_aclk;
    wire frst = ~s_axi_aresetn;  //AXI reset is active low, filter reset is active high


    // ---------------------------------------------------------
    // USER INSTANTIATION BEGIN (drop your module here)
    // ---------------------------------------------------------
    // All module parameter VALUES are set right here (nowhere else).
    pid_simple #(
        .IN_DATA_WIDTH  (32),
        .OUT_DATA_WIDTH (16),
        .DATA_WIDTH     (32),
        .INTEGRATOR_WIDTH   (56), // wider to avoid overflow in integrator
        .COEFF_WIDTH    (32),
        .ALPHA_WIDTH    (18),
        .GAIN_DATA_WIDTH (25),
        .GAIN_WIDTH     (18)
    ) u_pid (
        .clk          (fclk),
        .rst          (frst),
        .x_in         (x_in),                 // 32-bit
        .slow_clk     (slow_clk),
        .setpoint     (setpoint[31:0]),           // 32-bit
        .Kp           (Kp[31:0]),        // module uses only COEFF_WIDTH LSBs
        .Ki           (Ki[31:0]),
        .Kd           (Kd[31:0]),
        .alpha_d      (alpha_d[17:0]),  // LPF for D term
        .gain_in      (gain[17:0]),      // lower 18 bits
        .filter_reset (control[0]),
        .i_reset      (control[1]),          // integrator reset
        .y_out_reg    (y_out)                // change to .y_out if needed
    );

endmodule


