/**
 * @module axi_iir_filter_2nd_order_2_2
 * @brief AXI4-Lite wrapper for second-order IIR filter (Coupled Form)
 * 
 * This wrapper provides AXI4-Lite interface for the coupled form IIR filter,
 * allowing configuration of alpha, beta    // Instantiate the coupled form IIR filter
    iir_filter_2nd_order #(
        .IN_DATA_WIDTH(IN_DATA_WIDTH),
        .OUT_DATA_WIDTH(OUT_DATA_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .COEFF_WIDTH(COEFF_WIDTH),
        .IN_COEFF_WIDTH(32),  // Use 32-bit input coefficients
        .LOG_UNITY_GAIN(LOG_UNITY_GAIN)
    ) filter_inst (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .slow_clk(slow_clk),
        .alpha(alpha_reg),
        .beta(beta_reg),
        .gainP(gainP_reg),
        .gainQ(gainQ_reg),
        .gpio_in(control_reg),
        .y_out_reg(y_out)
    );oefficients
 * through memory-mapped registers.
 *
 * Register Map:
 * 0x00: alpha    - Coupled form coefficient alpha [31:0]
 * 0x04: beta     - Coupled form coefficient beta [31:0] 
 * 0x08: gainP    - In-phase gain coefficient [31:0]
 * 0x0C: gainQ    - Quadrature gain coefficient [31:0]
 * 0x10: control  - Control register [31:0]
 *                  [31]: reset (GPIO reset passthrough)
 *                  [30:0]: reserved
 * 0x14: status   - Status register [31:0] (read-only)
 *                  [0]: filter_active
 *                  [31:1]: reserved
 *
 * Performance notes:
 * - Works with separated integrator architecture
 * - Coupled form provides I/Q processing capabilities
 * - Real-time coefficient updates supported
 * - Hardware-timed reset with automatic release
 */

`timescale 1 ns / 1 ps

module axi_iir_filter_2nd_order_2_2 #(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 32,
    parameter integer IN_DATA_WIDTH = 32,    // Input from integrator
    parameter integer OUT_DATA_WIDTH = 16,   // Output data width
    parameter integer DATA_WIDTH = 20,       // Internal processing width
    parameter integer COEFF_WIDTH = 20,      // Coefficient width
    parameter integer GAIN_WIDTH = 18,       // Gain register width (for consistency with 1_2)
    parameter integer LOG_UNITY_GAIN = 10    // Logarithm of unity gain
)(
    // Filter data interface
    input wire clk,
    input wire rst,
    input wire signed [IN_DATA_WIDTH-1:0] x_in,
    input wire slow_clk,
    output wire signed [OUT_DATA_WIDTH-1:0] y_out,

    // AXI4-Lite Slave Interface
    input wire s_axi_aclk,
    input wire s_axi_aresetn,
    input wire [C_S_AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
    input wire [2:0] s_axi_awprot,
    input wire s_axi_awvalid,
    output wire s_axi_awready,
    input wire [C_S_AXI_DATA_WIDTH-1:0] s_axi_wdata,
    input wire [(C_S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
    input wire s_axi_wvalid,
    output wire s_axi_wready,
    output wire [1:0] s_axi_bresp,
    output wire s_axi_bvalid,
    input wire s_axi_bready,
    input wire [C_S_AXI_ADDR_WIDTH-1:0] s_axi_araddr,
    input wire [2:0] s_axi_arprot,
    input wire s_axi_arvalid,
    output wire s_axi_arready,
    output wire [C_S_AXI_DATA_WIDTH-1:0] s_axi_rdata,
    output wire [1:0] s_axi_rresp,
    output wire s_axi_rvalid,
    input wire s_axi_rready
);

    // Register addresses
    localparam ADDR_ALPHA   = 5'h00;
    localparam ADDR_BETA    = 5'h04;
    localparam ADDR_GAINP   = 5'h08;
    localparam ADDR_GAINQ   = 5'h0C;
    localparam ADDR_CONTROL = 5'h10;
    localparam ADDR_STATUS  = 5'h14;

    // Internal registers
    reg [31:0] alpha_reg;
    reg [31:0] beta_reg;
    reg [31:0] gainP_reg;
    reg [31:0] gainQ_reg;
    reg [31:0] control_reg;
    reg [31:0] status_reg;

    // AXI4-Lite signals
    reg [C_S_AXI_ADDR_WIDTH-1:0] axi_awaddr;
    reg axi_awready;
    reg axi_wready;
    reg [1:0] axi_bresp;
    reg axi_bvalid;
    reg [C_S_AXI_ADDR_WIDTH-1:0] axi_araddr;
    reg axi_arready;
    reg [C_S_AXI_DATA_WIDTH-1:0] axi_rdata;
    reg [1:0] axi_rresp;
    reg axi_rvalid;

    // GPIO control bus (for reset functionality)
    wire [31:0] gpio_control;
    assign gpio_control = control_reg;

    // Filter status
    wire filter_active;
    assign filter_active = ~rst & s_axi_aresetn;

    // Status register assignment
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            status_reg <= 32'h0;
        end else begin
            status_reg[0] <= filter_active;
            status_reg[31:1] <= 31'h0;  // Reserved
        end
    end

    // AXI4-Lite implementation
    assign s_axi_awready = axi_awready;
    assign s_axi_wready = axi_wready;
    assign s_axi_bresp = axi_bresp;
    assign s_axi_bvalid = axi_bvalid;
    assign s_axi_arready = axi_arready;
    assign s_axi_rdata = axi_rdata;
    assign s_axi_rresp = axi_rresp;
    assign s_axi_rvalid = axi_rvalid;

    // Write address ready
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            axi_awready <= 1'b0;
            axi_awaddr <= 0;
        end else begin
            if (~axi_awready && s_axi_awvalid && s_axi_wvalid) begin
                axi_awready <= 1'b1;
                axi_awaddr <= s_axi_awaddr;
            end else begin
                axi_awready <= 1'b0;
            end
        end
    end

    // Write data ready
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            axi_wready <= 1'b0;
        end else begin
            if (~axi_wready && s_axi_wvalid && s_axi_awvalid) begin
                axi_wready <= 1'b1;
            end else begin
                axi_wready <= 1'b0;
            end
        end
    end

    // Write response
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            axi_bvalid <= 1'b0;
            axi_bresp <= 2'b0;
        end else begin
            if (axi_awready && s_axi_awvalid && ~axi_bvalid && axi_wready && s_axi_wvalid) begin
                axi_bvalid <= 1'b1;
                axi_bresp <= 2'b0; // OKAY response
            end else begin
                if (s_axi_bready && axi_bvalid) begin
                    axi_bvalid <= 1'b0;
                end
            end
        end
    end

    // Register writes
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            alpha_reg <= 32'h0;
            beta_reg <= 32'h0;
            gainP_reg <= 32'h0;
            gainQ_reg <= 32'h0;
            control_reg <= 32'h0;
        end else begin
            if (axi_wready && s_axi_wvalid && axi_awready && s_axi_awvalid) begin
                case (axi_awaddr[6:2])
                    ADDR_ALPHA[6:2]:   alpha_reg <= s_axi_wdata;
                    ADDR_BETA[6:2]:    beta_reg <= s_axi_wdata;
                    ADDR_GAINP[6:2]:   gainP_reg <= s_axi_wdata;
                    ADDR_GAINQ[6:2]:   gainQ_reg <= s_axi_wdata;
                    ADDR_CONTROL[6:2]: control_reg <= s_axi_wdata;
                    default: ; // No operation for other addresses
                endcase
            end
        end
    end

    // Read address ready
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            axi_arready <= 1'b0;
            axi_araddr <= 32'b0;
        end else begin
            if (~axi_arready && s_axi_arvalid) begin
                axi_arready <= 1'b1;
                axi_araddr <= s_axi_araddr;
            end else begin
                axi_arready <= 1'b0;
            end
        end
    end

    // Read data valid
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            axi_rvalid <= 1'b0;
            axi_rresp <= 2'b0;
        end else begin
            if (axi_arready && s_axi_arvalid && ~axi_rvalid) begin
                axi_rvalid <= 1'b1;
                axi_rresp <= 2'b0; // OKAY response
            end else if (axi_rvalid && s_axi_rready) begin
                axi_rvalid <= 1'b0;
            end
        end
    end

    // Register reads
    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            axi_rdata <= 32'h0;
        end else begin
            if (axi_arready && s_axi_arvalid && ~axi_rvalid) begin
                case (axi_araddr[6:2])
                    ADDR_ALPHA[6:2]:   axi_rdata <= alpha_reg;
                    ADDR_BETA[6:2]:    axi_rdata <= beta_reg;
                    ADDR_GAINP[6:2]:   axi_rdata <= gainP_reg;
                    ADDR_GAINQ[6:2]:   axi_rdata <= gainQ_reg;
                    ADDR_CONTROL[6:2]: axi_rdata <= control_reg;
                    ADDR_STATUS[6:2]:  axi_rdata <= status_reg;
                    default:           axi_rdata <= 32'h0;
                endcase
            end
        end
    end

    // Instantiate the coupled form IIR filter
    iir_filter_2nd_order #(
        .IN_DATA_WIDTH(IN_DATA_WIDTH),
        .OUT_DATA_WIDTH(OUT_DATA_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .COEFF_WIDTH(COEFF_WIDTH),
        .IN_COEFF_WIDTH(IN_COEFF_WIDTH),
        .LOG_UNITY_GAIN(LOG_UNITY_GAIN)
    ) filter_inst (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .slow_clk(slow_clk),
        .alpha(alpha_reg),
        .beta(beta_reg),
        .gainP(gainP_reg),
        .gainQ(gainQ_reg),
        .gpio_in(gpio_control),
        .y_out_reg(y_out)
    );

endmodule