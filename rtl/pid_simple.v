


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
 *
 * Scaling:
 *   Each product (K*arg) is shifted by LOG_A0 = COEFF_WIDTH/2,
 *   then summed. Final y is downshifted to 14-bit ADC range.
 */

`timescale 1 ns / 1 ps

module pid_simple #(
    parameter IN_DATA_WIDTH   = 32,
    parameter OUT_DATA_WIDTH  = 16,
    parameter DATA_WIDTH      = 32,
    parameter INTEGRATOR_WIDTH = 56, // wider to avoid overflow in integrator
    parameter COEFF_WIDTH     = 32,
    parameter ALPHA_WIDTH     = 18,
    parameter LOG_A0_INTEGRATOR = 20
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
    reg signed [INTEGRATOR_WIDTH-1:0] i_acc_sat; // saturated integrator accumulator
    reg signed [INTEGRATOR_WIDTH:0] i_acc_wide; // integrator accumulator with one extra bit for saturation detection
    reg signed [DATA_WIDTH-1:0] d_filt;      // filtered derivative

    // ------------------------
    // Intermediate computation wires - grouped by function
    // ------------------------
    // Integrator computation wires
    wire signed [INTEGRATOR_WIDTH:0] i_acc;                   // Next integrator value with overflow detection
    wire signed [INTEGRATOR_WIDTH:0] i_acc_antiwindup;        // Anti-windup adjusted wide accumulator value
    
    // Derivative computation wires
    wire signed [DATA_WIDTH-1:0] d_arg;                        // Derivative argument (e0 - e1)
    wire signed [COEFF_WIDTH-1:0] one_q;                       // Unity in Q format
    wire signed [COEFF_WIDTH-1:0] one_minus_alpha;             // (1 - alpha_d)
    wire signed [DATA_WIDTH+ALPHA_WIDTH-1:0] a_df, b_dr;       // Derivative filter products
    
    // PID term computation wires
    wire signed [DATA_WIDTH+COEFF_WIDTH-1:0] Pprod;           // P term product
    wire signed [INTEGRATOR_WIDTH+COEFF_WIDTH-1:0] Iprod;     // I term product  
    wire signed [INTEGRATOR_WIDTH+COEFF_WIDTH-LOG_A0_INTEGRATOR-1:0] Iterm_wide; // I term after scaling, before saturation
    wire signed [DATA_WIDTH+COEFF_WIDTH-1:0] Dprod;           // D term product
    wire signed [DATA_WIDTH-1:0] Pterm, Iterm, Dterm;         // Scaled PID terms
    
    // PID summation wires (with extra bits to prevent overflow)
    wire signed [DATA_WIDTH+1:0] P_w, I_w, D_w;               // Sign-extended terms
    wire signed [DATA_WIDTH+2:0] y_sum_w;                     // Wide sum
    wire signed [DATA_WIDTH-1:0] y_sum;                       // Truncated sum
    
    // Output wire
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


    // Integrator registers - simplified logic
    always @(posedge clk) begin
        if (rst_sync || i_reset) begin
            e1         <= 0;
            i_acc_sat  <= 0;
            i_acc_wide <= 0;
        end else if (slow_clk) begin
            e1 <= e0;
            // Simple integrator: just accumulate e0 into i_acc_wide
            i_acc_wide <= i_acc_wide + e0;
            i_acc_sat <= i_acc_wide + e0;  // For now, no saturation
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
    assign Iprod = i_acc_sat * Ki;
    assign Dprod = d_filt * Kd;

    
    // add saturation of Iterm_wide.. it will be reducting from INTEGRATOR_WIDTH+COEFF_WIDTH-LOGA0_INTEGRATOR down to DATA_WIDTH, so we can check for overflow before truncation
    assign Iterm_wide = Iprod >>> LOG_A0_INTEGRATOR;
    assign Iterm = (Iterm_wide > $signed((1 << (DATA_WIDTH-1)) - 1)) ? $signed((1 << (DATA_WIDTH-1)) - 1) :
                   (Iterm_wide < $signed(-(1 << (DATA_WIDTH-1)))) ? $signed(-(1 << (DATA_WIDTH-1))) :
                   Iterm_wide[DATA_WIDTH-1:0];

    // Scale each product by LOG_A0, then take DATA_WIDTH, these dont saturate because max gain is equal to bitshift!
    assign Pterm = Pprod >>> LOG_A0;
    assign Dterm = Dprod >>> LOG_A0;


    // Widen BEFORE adding to avoid wrap
    assign P_w = {{2{Pterm[DATA_WIDTH-1]}}, Pterm};
    assign I_w = {{2{Iterm[DATA_WIDTH-1]}}, Iterm};
    assign D_w = {{2{Dterm[DATA_WIDTH-1]}}, Dterm};

    assign y_sum_w = $signed(P_w) + $signed(I_w) + $signed(D_w);
    assign y_sum = (y_sum_w > $signed((1 << (DATA_WIDTH-1)) - 1)) ? $signed((1 << (DATA_WIDTH-1)) - 1) :
                   (y_sum_w < $signed(-(1 << (DATA_WIDTH-1)))) ? $signed(-(1 << (DATA_WIDTH-1))) :
                   y_sum_w[DATA_WIDTH-1:0];

    // Output scaling without gain multiplication
    wire signed [DATA_WIDTH-1:0] y_scaled;
    assign y_scaled = y_sum >>> (DATA_WIDTH - ADC_DATA_WIDTH);
    
    // Final output saturation at ADC range
    assign y_out = (y_scaled > $signed((1 << (ADC_DATA_WIDTH-1)) - 1)) ? $signed((1 << (ADC_DATA_WIDTH-1)) - 1) :
                   (y_scaled < $signed(-(1 << (ADC_DATA_WIDTH-1)))) ? $signed(-(1 << (ADC_DATA_WIDTH-1))) :
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
