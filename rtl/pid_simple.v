


/**
 * @module pid_simple
 * @brief Discrete PID controller for separated-integrator architecture
 *
 * Matches the style of iir2nd_direct:
 * - 32-bit input, scales to DATA_WIDTH
 * - Multiplies are individually scaled by LOG_A0 before accumulation
 * - Runs at reduced rate using slow_clk
 * - Optional overall output gain (like your IIR block)
 *
 * Control law (discrete, backward difference for D):
 *   e[n]   = x_in (provided upstream, typically setpoint - measurement)
 *   I[n]   = I[n-1] + e[n]          (resettable via i_reset)
 *   D[n]   = e[n] - e[n-1]
 *   y[n]   = Kp*e[n] + Ki*I[n] + Kd*D[n]
 *
 * @param IN_DATA_WIDTH    32-bit input path (matches your integrator output bus)
 * @param OUT_DATA_WIDTH   Output width for DAC/stream (default 16)
 * @param DATA_WIDTH       Internal datapath width (default 32)
 * @param COEFF_WIDTH      Coefficient width (default 32, Q1.(COEFF_WIDTH-1))
 * @param GAIN_DATA_WIDTH  Width used before final gain multiply (25 by default)
 * @param GAIN_WIDTH       Width of external scalar gain_in (18 like your IIR)
 *
 * Scaling:
 *   Each product (K*arg) is shifted by LOG_A0 = COEFF_WIDTH-2 (≈Q1.31 → 31),
 *   then summed. Final y is downshifted and scaled by gain_in like iir2nd_direct.
 */

`timescale 1 ns / 1 ps

module pid_simple #(
    parameter IN_DATA_WIDTH   = 32,
    parameter OUT_DATA_WIDTH  = 16,
    parameter DATA_WIDTH      = 32,
    parameter INTEGRATOR_WIDTH    = 56, // wider to avoid overflow in integrator
    parameter COEFF_WIDTH     = 32,
    parameter ALPHA_WIDTH     = 18,
    parameter GAIN_DATA_WIDTH = 25,
    parameter GAIN_WIDTH      = 18
)(
    input  wire                         clk,
    input  wire                         rst,          // active high
    input  wire signed [IN_DATA_WIDTH-1:0]  x_in,     // error input e[n]
    input  wire                         slow_clk,     // sample enable (like your filters)
    // gains (register outside via AXI; pass-through here)
    input  wire signed [IN_DATA_WIDTH-1:0] setpoint, // new setpoint input
    input  wire signed [COEFF_WIDTH-1:0]    Kp,
    input  wire signed [COEFF_WIDTH-1:0]    Ki,
    input  wire signed [COEFF_WIDTH-1:0]    Kd,
    input  wire signed [ALPHA_WIDTH-1:0]  alpha_d,   // 0..1 in Q1.(COEFF_WIDTH-1), LP for derivative
    input  wire signed [GAIN_WIDTH-1:0]     gain_in,   // same usage as iir2nd_direct
    // resets
    input  wire                         filter_reset, // staged reset (same pattern as your filters)
    input  wire                         i_reset,      // **integrator-only** reset (1 → zero I state on next slow tick)
    // output
    output reg  signed [OUT_DATA_WIDTH-1:0] y_out_reg
);
    // Local scaling params (mirrors iir2nd_direct)
    localparam LOG_A0           = COEFF_WIDTH/2;
    localparam ADC_DATA_WIDTH   = 14;
    localparam DATA_SHIFT_IN    = IN_DATA_WIDTH - DATA_WIDTH;
    localparam DATA_SHIFT_OUT   = GAIN_DATA_WIDTH - ADC_DATA_WIDTH;
    localparam LOG_UNITY_GAIN   = GAIN_WIDTH/2;

    // ------------------------
    // Synchronized reset hold
    // ------------------------
    reg [3:0] reset_counter;
    reg       rst_sync;
    always @(posedge clk) begin
        if (rst) begin
            reset_counter <= 4'hF;
            rst_sync      <= 1'b1;
        end else begin
            if (filter_reset) begin
                reset_counter <= 4'hF;
            end else if (reset_counter > 0) begin
                reset_counter <= reset_counter - 1;
            end
            rst_sync <= (reset_counter > 0);
        end
    end

    // ------------------------
    // Input scaling & taps
    // ------------------------
    reg signed [DATA_WIDTH-1:0] e0;          // current error
    reg signed [DATA_WIDTH-1:0] e1;          // previous error (for derivative)
    reg signed [INTEGRATOR_WIDTH-1:0] i_acc; // integrator accumulator
    reg signed [DATA_WIDTH-1:0] d_filt;      // filtered derivative

    // ------------------------
    // Intermediate computation wires - grouped by function
    // ------------------------
    // Derivative computation wires
    wire signed [DATA_WIDTH-1:0] d_arg;                        // Derivative argument (e0 - e1)
    wire signed [COEFF_WIDTH-1:0] one_q;                       // Unity in Q format
    wire signed [COEFF_WIDTH-1:0] one_minus_alpha;             // (1 - alpha_d)
    wire signed [DATA_WIDTH+ALPHA_WIDTH-1:0] a_df, b_dr;       // Derivative filter products
    
    // PID term computation wires
    wire signed [DATA_WIDTH+COEFF_WIDTH-1:0] Pprod;           // P term product
    wire signed [INTEGRATOR_WIDTH+COEFF_WIDTH-1:0] Iprod;     // I term product  
    wire signed [DATA_WIDTH+COEFF_WIDTH-1:0] Dprod;           // D term product
    wire signed [DATA_WIDTH-1:0] Pterm, Iterm, Dterm;         // Scaled PID terms
    
    // PID summation wires (with extra bits to prevent overflow)
    wire signed [DATA_WIDTH+1:0] P_w, I_w, D_w;               // Sign-extended terms
    wire signed [DATA_WIDTH+2:0] y_sum_w;                     // Wide sum
    wire signed [DATA_WIDTH-1:0] y_sum;                       // Truncated sum
    
    // Output scaling and saturation wires
    wire signed [GAIN_DATA_WIDTH-1:0] y_shift;                // Gain input scaling
    wire signed [GAIN_DATA_WIDTH+GAIN_WIDTH-1:0] y_gain;      // Gain product
    wire signed [GAIN_DATA_WIDTH+GAIN_WIDTH-1:0] y_scaled;    // Scaled for output
    wire signed [OUT_DATA_WIDTH-1:0] y_out;                   // Final output with saturation

    // Input processing - scale and pipeline
    // Note: i_acc and d_filt already declared above in the registers section

    always @(posedge clk) begin
        if (rst_sync) begin
            e0   <= 0;
        end else if (slow_clk) begin
            if (DATA_SHIFT_IN >= 0) e0 <= (setpoint - x_in) >>> DATA_SHIFT_IN;
            else                    e0 <= (setpoint - x_in) <<< (-DATA_SHIFT_IN);
        end
    end


    // Delay line & integrator (advance only on slow tick)
    always @(posedge clk) begin
        if (rst_sync) begin
            e1   <= 0;
            i_acc<= 0;
        end else if (slow_clk) begin
            e1 <= e0;
            // Integrator reset takes effect on the sample boundary
            if (i_reset) i_acc <= 0;
            else         i_acc <= i_acc + e0;
        end
    end


    // Derivative computation - LP filtered derivative term
    assign d_arg = e0 - e1;
    assign one_q = $signed(1'b1) <<< (COEFF_WIDTH-1);
    assign one_minus_alpha = one_q - alpha_d;
    assign a_df = d_filt * alpha_d;
    assign b_dr = d_arg * one_minus_alpha;
  
    always @(posedge clk) begin
        if (rst_sync) begin
            d_filt <= 0;
        end else if (slow_clk) begin
            d_filt <= (a_df >>> (ALPHA_WIDTH-1)) + (b_dr >>> (ALPHA_WIDTH-1));
        end
    end


    // PID term computation
    assign Pprod = e0 * Kp;
    assign Iprod = i_acc * Ki;
    assign Dprod = d_filt * Kd;

    // Scale each product by LOG_A0, then take DATA_WIDTH
    assign Pterm = Pprod >>> LOG_A0;
    assign Iterm = Iprod >>> LOG_A0;
    assign Dterm = Dprod >>> LOG_A0;

    // Widen BEFORE adding to avoid wrap
    assign P_w = {{2{Pterm[DATA_WIDTH-1]}}, Pterm};
    assign I_w = {{2{Iterm[DATA_WIDTH-1]}}, Iterm};
    assign D_w = {{2{Dterm[DATA_WIDTH-1]}}, Dterm};

    assign y_sum_w = $signed(P_w) + $signed(I_w) + $signed(D_w);
    assign y_sum = y_sum_w[DATA_WIDTH-1:0];   // (optional: saturate here)

    // Gain & output scaling with saturation
    assign y_shift = y_sum >>> (DATA_WIDTH - GAIN_DATA_WIDTH);
    assign y_gain = y_shift * gain_in;
    assign y_scaled = y_gain >>> (LOG_UNITY_GAIN + DATA_SHIFT_OUT);
    
    // Saturate at ADC_DATA_WIDTH (14-bit) range before truncation
    // Create intermediate shifted value that we can properly compare
    wire signed [GAIN_DATA_WIDTH+GAIN_WIDTH-1:0] y_shifted_sat;
    assign y_shifted_sat = y_scaled;

    // Final output saturation at ADC range
    assign y_out = (y_shifted_sat > $signed((1 << (ADC_DATA_WIDTH-1)) - 1)) ? $signed((1 << (ADC_DATA_WIDTH-1)) - 1) :
                   (y_shifted_sat < $signed(-(1 << (ADC_DATA_WIDTH-1)))) ? $signed(-(1 << (ADC_DATA_WIDTH-1))) :
                   y_scaled[OUT_DATA_WIDTH-1:0];


    // Registered output on slow tick
    always @(posedge clk) begin
        if (rst_sync) begin
            y_out_reg <= 0;
        end else if (slow_clk) begin
            y_out_reg <= y_out;
        end
    end

endmodule
