/**
 * @module iir2nd_coupled
 * @brief Second-order IIR filter using Coupled Form topology for use with separated integrator
 * 
 * This is the coupled form filter stage that works with the separated integrator module.
 * Takes 32-bit input from integrator, applies the coupled form IIR filter equations
 * with relaxed timing constraints compared to the integrator stage.
 *
 * The coupled form provides in-phase (P) and quadrature (Q) outputs and can be more
 * numerically stable than Direct Form for certain coefficient ranges.
 *
 * SIMPLIFIED INTERFACE: Updated to use direct filter_reset input instead of gpio_in[31:0]
 * for cleaner signal connections and better maintainability.
 *
 * Performance notes:
 * - Works with pre-integrated data from integrator module  
 * - Relaxed timing constraints compared to integrator stage
 * - Processes data at reduced rate (~122 kHz with LOG_DIV=10)
 * - Provides both I and Q outputs for complex filtering
 *
 * @param IN_DATA_WIDTH    Width of input from integrator (32 bits)
 * @param OUT_DATA_WIDTH   Width of output data samples (default: 16 bits)
 * @param DATA_WIDTH       Internal data processing width (default: 20 bits)
 * @param COEFF_WIDTH      Internal coefficient processing width (default: 20 bits)
 * @param LOG_UNITY_GAIN   Logarithm of unity gain factor (default: 10)
 *
 * Filter transfer function:
 *   H(z) = c * (beta*z^(-1)) / (1 - 2*alpha*z^(-1) + (alpha^2+beta^2)*z^(-2))
 *
 * Coupled form equations:
 *   u[n] = x[n] + alpha*u[n-1] - beta*v[n-1]  
 *   v[n] = beta*u[n-1] + alpha*v[n-1]
 *   y[n] = gainP*u[n] + gainQ*v[n]
 */

`timescale 1 ns / 1 ps

module iir2nd_coupled #(
    parameter IN_DATA_WIDTH = 32,    // Input from integrator (32-bit)
    parameter OUT_DATA_WIDTH = 16,   // Output data width
    parameter DATA_WIDTH = 20,       // Internal processing width
    parameter COEFF_WIDTH = 20,      // Coefficient width  
    parameter IN_COEFF_WIDTH = 32,   // Input coefficient width from GPIO
    parameter LOG_UNITY_GAIN = 10    // Logarithm of unity gain

)(
    input wire clk,                                        // System clock
    input wire rst,                                        // Reset signal
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          // Pre-integrated input (32-bit)
    input wire slow_clk,                                   // Slow clock enable from integrator
    input wire signed [IN_COEFF_WIDTH-1:0] alpha,        // Coupled form coefficients
    input wire signed [IN_COEFF_WIDTH-1:0] beta,
    input wire signed [IN_COEFF_WIDTH-1:0] gainP,        // I/Q gains
    input wire signed [IN_COEFF_WIDTH-1:0] gainQ,
    input wire filter_reset,                              // Filter reset control
    output reg signed [OUT_DATA_WIDTH-1:0] y_out_reg         // Filtered output
);

    localparam LOG_A0 = COEFF_WIDTH - 2;
    localparam ADC_DATA_WIDTH = 14;
    localparam INPUT_SCALE_SHIFT = IN_DATA_WIDTH - DATA_WIDTH; // 32-20 = 12
    localparam OUTPUT_SCALE_SHIFT = DATA_WIDTH - ADC_DATA_WIDTH; // 20-14 = 6

    // Internal registers
    reg rst_sync;
    reg signed [DATA_WIDTH-1:0] x0;
    reg signed [DATA_WIDTH-1:0] u, v;  // Coupled form state variables
    reg signed [COEFF_WIDTH-1:0] alpha_reg, beta_reg, gainP_reg, gainQ_reg;

    // Intermediate computation wires
    wire signed [DATA_WIDTH + COEFF_WIDTH-1:0] alpha_u, beta_v, alpha_v, beta_u;
    wire signed [DATA_WIDTH + COEFF_WIDTH-1:0] u_new, v_new;
    wire signed [DATA_WIDTH + COEFF_WIDTH-1:0] u_scaled, v_scaled;
    wire signed [OUT_DATA_WIDTH-1:0] y_out;

    // Reset synchronization with hold time (same as filter_1_2)
    reg rst_gpio_sync1, rst_gpio_sync2;
    reg [3:0] reset_counter;
    
    always @(posedge clk) begin
        if (rst) begin
            rst_gpio_sync1 <= 1'b1;
            rst_gpio_sync2 <= 1'b1;
            reset_counter <= 4'hF;
            rst_sync <= 1'b1;
        end else begin
            rst_gpio_sync1 <= filter_reset;
            rst_gpio_sync2 <= rst_gpio_sync1;
            
            if (rst_gpio_sync2) begin
                reset_counter <= 4'hF;
                rst_sync <= 1'b1;
            end else if (reset_counter > 0) begin
                reset_counter <= reset_counter - 1;
                rst_sync <= 1'b1;
            end else begin
                rst_sync <= 1'b0;
            end
        end
    end

    // Input scaling: Convert 32-bit integrated input to internal DATA_WIDTH
    always @(posedge clk) begin
        if (rst_sync) begin
            x0 <= 0;
        end else if (slow_clk) begin
            if (INPUT_SCALE_SHIFT >= 0) begin
                x0 <= x_in >>> INPUT_SCALE_SHIFT; // Scale down from 32-bit to internal width
            end else begin
                x0 <= x_in <<< (-INPUT_SCALE_SHIFT); // Scale up if needed
            end
        end
    end

    // Coefficient pipeline (runs at full clock for real-time updates)
    always @(posedge clk) begin
        if (rst_sync) begin
            alpha_reg <= 0;
            beta_reg <= 0;
            gainP_reg <= 0;
            gainQ_reg <= 0;
        end else begin
            alpha_reg <= alpha[COEFF_WIDTH-1:0];  // Take lower bits to fit COEFF_WIDTH
            beta_reg <= beta[COEFF_WIDTH-1:0];
            gainP_reg <= gainP[COEFF_WIDTH-1:0];
            gainQ_reg <= gainQ[COEFF_WIDTH-1:0];
        end
    end

    // Coupled form filter state updates - only when slow clock is active
    always @(posedge clk) begin
        if (rst_sync) begin
            u <= 0;
            v <= 0;
        end else if (slow_clk) begin
            u <= u_new[DATA_WIDTH + LOG_A0 - 1:LOG_A0];  // Scale result back to DATA_WIDTH
            v <= v_new[DATA_WIDTH + LOG_A0 - 1:LOG_A0];
        end
    end

    // Combinational coupled form computations
    assign alpha_u = alpha_reg * u;
    assign beta_v = beta_reg * v;
    assign alpha_v = alpha_reg * v;
    assign beta_u = beta_reg * u;

    // Coupled form equations:
    assign u_new = (x0 <<< LOG_A0) + alpha_u - beta_v;
    assign v_new = beta_u + alpha_v;


    // Output scaling and gain application
    assign u_scaled = (gainP_reg * u) >>> LOG_UNITY_GAIN; // Scale I output
    assign v_scaled = (gainQ_reg * v) >>> LOG_UNITY_GAIN; // Scale Q
    assign y_out = (u_scaled + v_scaled) >>> OUTPUT_SCALE_SHIFT; // Combine I and Q, scale to output width
    
    // Output register - maintains value for DAC between filter updates
    always @(posedge clk) begin
        if (rst_sync) begin
            y_out_reg <= 0;
        end else if (slow_clk) begin
            y_out_reg <= y_out;
        end
    end

endmodule