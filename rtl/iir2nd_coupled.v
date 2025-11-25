/**
 * @module iir2nd_coupled
 * @brief Second-order IIR filter using Coupled Form topology for use with separated integrator
 * 
 * This is the coupled form filter stage that works with the separated integrator module.
 * Takes 32-bit input from integrator, applies the coupled form IIR filter equations
 * with relaxed timing constraints compared to the integrator stage.
 *
 * SCALING METHODOLOGY: Unlike direct form filters, the coupled form scales each
 * multiplication product individually before accumulation. This provides better
 * numerical stability and prevents overflow saturation issues.
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
 * - Includes overflow protection via saturation
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
    parameter IN_COEFF_WIDTH = 32,   // Input coefficient width from GPIO
    
    parameter DATA_WIDTH = 20,       // Internal processing width
    parameter COEFF_WIDTH = 20,      // Coefficient width
    parameter STATE_EXTRA_BITS = 14, // Extra guard bits for state variables to prevent saturation
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

    localparam LOG_A0 = COEFF_WIDTH - 1; // For the coupled form max alpha and beta is 1.0, so LOG_A0 = COEFF_WIDTH - 1
    localparam ADC_DATA_WIDTH = 14;
    localparam INPUT_SCALE_SHIFT = IN_DATA_WIDTH - DATA_WIDTH; // 32-20 = 12
    localparam OUTPUT_SCALE_SHIFT = DATA_WIDTH - ADC_DATA_WIDTH; // 20-14 = 6
    localparam STATE_WIDTH = DATA_WIDTH + STATE_EXTRA_BITS; // 20 + 4 = 24 bits for state variables

    // Internal registers
    reg rst_sync;
    reg signed [DATA_WIDTH-1:0] x0;
    reg signed [STATE_WIDTH-1:0] u, v;  // Coupled form state variables with extra guard bits
    reg signed [COEFF_WIDTH-1:0] alpha_reg, beta_reg, gainP_reg, gainQ_reg;

    // Intermediate computation wires - grouped by function
    wire signed [STATE_WIDTH + COEFF_WIDTH-1:0] alpha_u, beta_v, alpha_v, beta_u; // Multiplication products
    wire signed [STATE_WIDTH-1:0] alpha_u_scaled, beta_v_scaled, alpha_v_scaled, beta_u_scaled; // Scaled products
    wire signed [STATE_WIDTH:0] u_new, v_new; // New state values - NEED +1 bit to detect overflow before saturation
    wire signed [STATE_WIDTH-1:0] x0_extended; // Sign-extended input
    wire signed [STATE_WIDTH + COEFF_WIDTH-1:0] u_gain, v_gain; // Output gain products
    wire signed [STATE_WIDTH-1:0] u_scaled_full, v_scaled_full; // Scaled gain products
    wire signed [STATE_WIDTH:0] uv_sum; // Combined I/Q output
    wire signed [OUT_DATA_WIDTH-1:0] uv_scaled; // Scaled for output width - MUST be OUT_DATA_WIDTH for saturation to work
    wire signed [OUT_DATA_WIDTH-1:0] y_out; // Final output with saturation

    // GPIO controls - use counter as both sync and hold timer
    reg [3:0] reset_counter;

    always @(posedge clk) begin
        if (rst) begin
            reset_counter <= 4'hF;
            rst_sync <= 1'b1;
        end else begin
            if (filter_reset) begin
                reset_counter <= 4'hF;  // Restart reset hold
            end else if (reset_counter > 0) begin
                reset_counter <= reset_counter - 1;
            end
            rst_sync <= (reset_counter > 0);
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
    // Include overflow handling with wider state variables for safety
    // Coupled form filter state updates - only when slow clock is active
    // Include saturation protection for STATE_WIDTH variables
    always @(posedge clk) begin
        if (rst_sync) begin
            u <= 0;
            v <= 0;
        end else if (slow_clk) begin
            // Saturation protection to prevent overflow
            if (u_new > ((1 << (STATE_WIDTH-1)) - 1)) begin
                u <= (1 << (STATE_WIDTH-1)) - 1;  // Max positive for STATE_WIDTH
            end else if (u_new < (-(1 << (STATE_WIDTH-1)))) begin
                u <= -(1 << (STATE_WIDTH-1));     // Max negative for STATE_WIDTH
            end else begin
                u <= u_new;
            end
            
            if (v_new > ((1 << (STATE_WIDTH-1)) - 1)) begin
                v <= (1 << (STATE_WIDTH-1)) - 1;  // Max positive for STATE_WIDTH
            end else if (v_new < (-(1 << (STATE_WIDTH-1)))) begin
                v <= -(1 << (STATE_WIDTH-1));     // Max negative for STATE_WIDTH
            end else begin
                v <= v_new;
            end
        end
    end

    // Combinational coupled form computations - MATCH PYTHON APPROACH EXACTLY
    assign alpha_u = alpha_reg * u;
    assign beta_v = beta_reg * v;
    assign alpha_v = alpha_reg * v;
    assign beta_u = beta_reg * u;

    // Scale each product individually
    assign alpha_u_scaled = alpha_u >>> LOG_A0;
    assign beta_v_scaled = beta_v >>> LOG_A0;
    assign alpha_v_scaled = alpha_v >>> LOG_A0;
    assign beta_u_scaled = beta_u >>> LOG_A0;

    // Coupled form equations - properly extend x0 to STATE_WIDTH
    assign x0_extended = {{STATE_EXTRA_BITS{x0[DATA_WIDTH-1]}}, x0};
    assign u_new = x0_extended + alpha_u_scaled - beta_v_scaled;
    assign v_new = beta_u_scaled + alpha_v_scaled;

    // Output scaling and gain application - use FULL STATE_WIDTH variables
    assign u_gain = gainP_reg * u;  // Use full u state variable (STATE_WIDTH)
    assign v_gain = gainQ_reg * v;  // Use full v state variable (STATE_WIDTH)
    
    // Scale gain products and combine
    assign u_scaled_full = u_gain >>> LOG_UNITY_GAIN;
    assign v_scaled_full = v_gain >>> LOG_UNITY_GAIN;
    
    // Combine I and Q channels - result is STATE_WIDTH+1 bits
    assign uv_sum = u_scaled_full + v_scaled_full;
    
    // Scale down AND saturate at the same time
    // First compute the shifted value, then saturate it
    wire signed [STATE_WIDTH:0] uv_shifted;
    assign uv_shifted = uv_sum >>> (STATE_WIDTH - OUT_DATA_WIDTH);
    
    // Saturate at ADC_DATA_WIDTH (14-bit) range, since DAC only uses lower 14 bits
    assign uv_scaled = (uv_shifted > $signed((1 << (ADC_DATA_WIDTH-1)) - 1)) ? $signed((1 << (ADC_DATA_WIDTH-1)) - 1) :
                       (uv_shifted < $signed(-(1 << (ADC_DATA_WIDTH-1)))) ? $signed(-(1 << (ADC_DATA_WIDTH-1))) :
                       uv_shifted[OUT_DATA_WIDTH-1:0];
    
    // Output is already saturated
    assign y_out = uv_scaled;
    
    // Output register - maintains value for DAC between filter updates
    always @(posedge clk) begin
        if (rst_sync) begin
            y_out_reg <= 0;
        end else if (slow_clk) begin
            y_out_reg <= y_out;
        end
    end

endmodule




 //   assign y_out = (uv_scaled > $signed((1 << (OUT_DATA_WIDTH-1)) - 1)) ? $signed((1 << (OUT_DATA_WIDTH-1)) - 1) :  // Max positive (e.g., +32767)
 //                  (uv_scaled < $signed(-(1 << (OUT_DATA_WIDTH-1)))) ? $signed(-(1 << (OUT_DATA_WIDTH-1))) :  // Max negative (e.g., -32768)
//                   uv_scaled[OUT_DATA_WIDTH-1:0];  // Normal case