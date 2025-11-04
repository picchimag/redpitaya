`timescale 1 ns / 1 ps
// -------------------------------------------------------------
// Minimal AXI4-Lite wrapper for peak_detector
// - 32-bit word regs, offset = 4*index (ADDR_LSB=2)
// - N_REGS = 2**LOG_NPAR
// - Only edit: USER MAP and USER INSTANTIATION
// -------------------------------------------------------------
module peak_detector_axi_wrap #(
    // AXI
    parameter integer C_S_AXI_ADDR_WIDTH = 8,
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    // Register bank
    parameter integer LOG_NPAR = 4  // 4 -> 16 regs (expanded for more readonly registers)
    
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
    input  wire                              slow_clk,      // Sample clock enable
    input  wire  signed [15:0]               x_in,          // ADC sample input
    output wire                              peak_detected_out, // Peak detection pulse
    output wire  signed [15:0]               peak_value_out,  // Selected output (integration or max)
    output wire  signed [15:0]               peak_integral_out, // Integration accumulator result
    output wire  signed [15:0]               peak_max_out,    // Maximum value detected
    output wire         [15:0]               max_delay        // Delay at which maximum was detected
);


    localparam integer ADDR_LSB = 2;                  // 32-bit words
    localparam integer N_REGS   = (1 << LOG_NPAR);    // number of regs
    localparam integer N_READONLY = 6;                // Registers 10-15 are read-only
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
    // ---------------------------------------------------------
    //Control registers
    
    wire signed [31:0] trig_level_reg    = regs[0];   // +0x00
    wire signed [31:0] fall_level_reg    = regs[1];   // +0x04
    wire signed [31:0] base_return_reg   = regs[2];   // +0x08
    wire        [31:0] dead_time_reg     = regs[3];   // +0x0C
    wire        [31:0] control_reg       = regs[4];   // +0x10  (bit 0=filter_reset, bit 1=invert_input)
    wire        [31:0] n_integration_reg = regs[5];   // +0x14
    // regs[6] is read-only status register
    
    // Wire from peak detector module
    wire        [1:0]  state_out;                       // FSM state
    
    // Status register assignments (read-only) - using registers 10-15
    always @(posedge s_axi_aclk) begin
        regs[10] <= {30'd0, state_out};                  // Register 10: state_out[1:0]
        regs[11] <= {16'd0, max_delay};                  // Register 11: max_delay[15:0]
        regs[12] <= {peak_value_out, x_in};              // Register 12: peak_value_out[31:16], x_in[15:0]
        regs[13] <= {16'd0, peak_integral_out};          // Register 13: peak_integral_out[15:0]
        regs[14] <= {16'd0, peak_max_out};               // Register 14: peak_max_out[15:0]
        regs[15] <= 32'd0;                               // Register 15: reserved
    end

    // choose the filter clock/reset (simple: tie to AXI)
    wire fclk = s_axi_aclk;
    wire frst = ~s_axi_aresetn;  //AXI reset is active low, filter reset is active high

    // ---------------------------------------------------------
    // USER INSTANTIATION BEGIN (drop your module here)
    // ---------------------------------------------------------
    // All module parameter VALUES are set right here (nowhere else).
    peak_detector #(
        .DATA_WIDTH        (16),
        .COUNTER_WIDTH     (16),
        .INTEGRATION_WIDTH (32)                          // Increased to 32 bits
    ) u_peak_detector (
        .clk               (fclk),
        .rst               (frst),
        .x_in              (x_in),                       // 16-bit ADC input
        .slow_clk          (slow_clk),
        .trig_level        (trig_level_reg[15:0]),       // Use lower 16 bits
        .fall_level        (fall_level_reg[15:0]),
        .base_return       (base_return_reg[15:0]),
        .dead_time_setting (dead_time_reg[15:0]),
        .n_integration     (n_integration_reg[15:0]),    // Use lower 16 bits
        .log_attenuation   (control_reg[7:4]),           // Control bits [7:4]: log_attenuation
        .integration_mode  (control_reg[2]),             // Control bit 2: integration mode
        .invert_input      (control_reg[1]),             // Control bit 1: polarity inversion
        .filter_reset      (control_reg[0]),             // Control bit 0: filter reset
        .peak_detected_out (peak_detected_out),              // Output wire
        .peak_value_out    (peak_value_out),             // Selected output wire
        .peak_integral_out (peak_integral_out),          // Integration output wire
        .peak_max_out      (peak_max_out),               // Max value output wire
        .max_delay         (max_delay),                  // Max delay output wire
        .state_out         (state_out)                   // Connect to status register
    );

endmodule