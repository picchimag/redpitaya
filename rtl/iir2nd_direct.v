
/**
 * @module iir_filter_2nd_order
 * @brief Second-order IIR filter for use with separated integrator architecture
 * 
 * This is the filter stage that works with the separated integrator module.
 * Takes 32-bit input from integrator, scales it down to DATA_WIDTH, and applies
 * the IIR filter without integration logic for relaxed timing constraints.
 *
 * Performance notes:
 * - Works with pre-integrated data from integrator module
 * - Relaxed timing constraints compared to integrator stage
 * - Processes data at reduced rate (~122 kHz with LOG_DIV=10)
 *
 * @param IN_DATA_WIDTH    Width of input from integrator (32 bits)
 * @param OUT_DATA_WIDTH   Width of output data samples (default: 16 bits)
 * @param DATA_WIDTH       Internal data processing width (default: 32 bits)
 * @param COEFF_WIDTH      Internal coefficient processing width (default: 32 bits)
 * @param LOG_UNITY_GAIN   Logarithm of unity gain factor (default: 9)
 *
 * @input clk              System clock
 * @input rst              Reset signal (active high)
 * @input x_integrated     Pre-integrated input from integrator [IN_DATA_WIDTH-1:0]
 * @input slow_clk         Slow clock enable from integrator
 * @input b0,b1,b2         Feed-forward filter coefficients [COEFF_WIDTH-1:0]
 * @input a1,a2            Feedback filter coefficients [COEFF_WIDTH-1:0]
 * @input gain_in         18-bit gain control
 * @input filter_reset    Filter reset control signal
 * @output y_out           Filtered output sample [OUT_DATA_WIDTH-1:0]
 *
 * Filter transfer function:
 *   H(z) = (b0 + b1*z^(-1) + b2*z^(-2)) / (1 + a1*z^(-1) + a2*z^(-2))
 */



`timescale 1 ns / 1 ps

module iir2nd_direct #(
    parameter IN_DATA_WIDTH = 32,    // Input from integrator (32-bit)
    parameter OUT_DATA_WIDTH = 16,   // Output data width
    parameter DATA_WIDTH = 32,       // Internal processing width
    parameter COEFF_WIDTH = 32,      // Coefficient width
    parameter GAIN_DATA_WIDTH = 25,  // For DSP optimization
    parameter GAIN_WIDTH = 18     // Logarithm of unity gain

)(
    input wire clk,                                        // System clock
    input wire rst,                                        // Reset signal  
    input wire signed [IN_DATA_WIDTH-1:0] x_in,   // Pre-integrated input (32-bit)
    input wire slow_clk,                                   // Slow clock enable from integrator
    input wire signed [COEFF_WIDTH-1:0] b0,              // Filter coefficients
    input wire signed [COEFF_WIDTH-1:0] b1,
    input wire signed [COEFF_WIDTH-1:0] b2,
    input wire signed [COEFF_WIDTH-1:0] a1,
    input wire signed [COEFF_WIDTH-1:0] a2,
    input wire signed [GAIN_WIDTH-1:0] gain_in,          // 18-bit gain control
    input wire filter_reset,                              // Filter reset control
    output reg signed [OUT_DATA_WIDTH-1:0] y_out_reg        // Filtered output
);

    // Local parameters
    localparam LOG_A0 = COEFF_WIDTH - 2; 
    localparam ADC_DATA_WIDTH = 14; 
    localparam DATA_SHIFT_IN = IN_DATA_WIDTH - DATA_WIDTH; // Shift from 32-bit input to internal width
    localparam DATA_SHIFT_OUT = GAIN_DATA_WIDTH - ADC_DATA_WIDTH;
    localparam LOG_UNITY_GAIN = GAIN_WIDTH/2;
    

    // Internal registers
    reg rst_sync;
    reg signed [DATA_WIDTH - 1:0] x0, x1, x2, y1, y2;
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, b2_reg, a1_reg, a2_reg;
    reg signed [2*LOG_UNITY_GAIN-1:0] gain_reg;

    // Internal signals for filter calculations
    wire signed [DATA_WIDTH + COEFF_WIDTH -1:0] b0_x0, b1_x1, b2_x2, a1_y1, a2_y2, acc;
    wire signed [DATA_WIDTH-1:0] y;
    wire signed [GAIN_DATA_WIDTH-1:0] y_shift;
    wire signed [GAIN_DATA_WIDTH + GAIN_WIDTH - 1:0] y_gain;
    wire signed [OUT_DATA_WIDTH -1:0] y_out;


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
            if (DATA_SHIFT_IN >= 0) begin
                x0 <= x_in >>> DATA_SHIFT_IN; // Scale down from 32-bit to internal width
            end else begin
                x0 <= x_in <<< (-DATA_SHIFT_IN); // Scale up if needed
            end
        end
    end
    // Pipeline for coefficient registers
    always @(posedge clk) begin
        if (rst_sync) begin
            b0_reg <= 0;
            b1_reg <= 0;
            b2_reg <= 0;
            a1_reg <= 0;
            a2_reg <= 0;
            gain_reg <= 0;
        end else begin
            b0_reg <= b0;
            b1_reg <= b1;
            b2_reg <= b2;
            a1_reg <= a1;
            a2_reg <= a2;
            gain_reg <= gain_in;
        end
    end

    // Pipeline for filter delay registers - only update when slow clock is active
    always @(posedge clk) begin
          if (rst_sync) begin
            x1 <= 0;
            x2 <= 0;
            y1 <= 0;  // Reset y1 as well
            y2 <= 0;
          end else if (slow_clk) begin   // Update only when slow clock is active
            x1 <= x0;
            x2 <= x1;
            y2 <= y1;
            y1 <= y;
          end
      end
      
        
            
    // Combinational multiplications
    assign b0_x0 = x0 * b0_reg;
    assign b1_x1 = x1 * b1_reg;
    assign b2_x2 = x2 * b2_reg;
    assign a1_y1 = y1 * a1_reg;
    assign a2_y2 = y2 * a2_reg;
    
    //Filter equation 
    assign acc = b0_x0 + b1_x1 + b2_x2 - a1_y1 - a2_y2;
    assign y = acc >>> LOG_A0;


    // Gain and output scaling
    assign y_shift = y >>> (DATA_WIDTH - GAIN_DATA_WIDTH);
    assign y_gain  =  y_shift * gain_reg;     //25*18
    assign y_out  = y_gain >>> (LOG_UNITY_GAIN+DATA_SHIFT_OUT);

   
    // output register - only update when new pipeline result is available  
    always @(posedge clk) begin
        if (rst_sync) begin
            y_out_reg <= 0;
        end else if (slow_clk) begin
            y_out_reg <= y_out;
        end
    end
    
endmodule



