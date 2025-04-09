
/**
 * @module iir_filter_2nd_order
 * @brief Second-order IIR (Infinite Impulse Response) filter implementation in Direct Form 2
 *ITV WORKS! following more or less instruction in 
 *https://www.hackster.io/pablotrujillojuan/implementation-of-an-iir-filter-on-fpga-from-scratch-4b8539
 *
 * This module implements a configurable 2nd-order IIR filter that can be used for
 * low-pass, high-pass, band-pass, and band-stop filtering applications. The filter
 * uses Direct Form 2 structure for implementation.
 *
 * Performance notes:
 * - 16*16 bit configuration at 125 MHz clock uses 6 DSPs and is stable above 200 kHz
 * - 32*32 bit configuration at 125 kHz clock uses 23 DSPs and is stable down to 100 Hz with Q=1000
 *
 * @param IN_DATA_WIDTH    Width of input data samples (default: 16 bits)
 * @param OUT_DATA_WIDTH   Width of output data samples (default: 16 bits)
 * @param IN_COEFF_WIDTH   Width of input filter coefficients (default: 32 bits)
 * @param DATA_WIDTH       Internal data processing width (default: 32 bits)
 * @param COEFF_WIDTH      Internal coefficient processing width (default: 32 bits)
 * @param LOG_DIV          Clock division factor (2^LOG_DIV, default: 10)
 * @param LOG_UNITY_GAIN   Logarithm of unity gain factor (default: 16)
 *
 * @input clk              System clock
 * @input rst              Reset signal (active high)
 * @input x_in             Signed input sample [IN_DATA_WIDTH-1:0]
 * @input b0,b1,b2         Feed-forward filter coefficients [IN_COEFF_WIDTH-1:0]
 * @input a1,a2            Feedback filter coefficients [IN_COEFF_WIDTH-1:0]
 * @input gain             Output gain control [IN_COEFF_WIDTH-1:0]
 * @output y_out           Filtered output sample [OUT_DATA_WIDTH-1:0]
 *
 * Filter transfer function:
 *   H(z) = (b0 + b1*z^(-1) + b2*z^(-2)) / (1 + a1*z^(-1) + a2*z^(-2))
 */



`timescale 1 ns / 1 ps

module iir_filter_2nd_order #(
    parameter IN_DATA_WIDTH = 16,    // Input/output data width
    parameter OUT_DATA_WIDTH = 16,
    parameter DATA_WIDTH = 32,
    parameter GAIN_DATA_WIDTH = 25,  //if this is 25 and gain width is 18, this operation will require a single DSP!
    parameter COEFF_WIDTH = 32,   // Coefficient width
    parameter LOG_DIV = 10, // division of clock by 2**LOG_DIV
    parameter LOG_UNITY_GAIN = 9 // logarithm of unity gain // Controllable output gain, HALF OF THE RANGE AMPLIFIES, HALF ATTENUATES

)(
    input wire clk,                   // System clock
    input wire rst_ext,                   // Reset signal
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          // signed current input sample (16-bit)
    input wire signed [COEFF_WIDTH-1:0] b0, // Pre-scaled Coefficients from GPIO (32-bit)
    input wire signed [COEFF_WIDTH-1:0] b1,
    input wire signed [COEFF_WIDTH-1:0] b2,
    input wire signed [COEFF_WIDTH-1:0] a1,
    input wire signed [COEFF_WIDTH-1:0] a2,
    input wire signed [31:0] gpio_in, //contains gain in the lower bits, reset in upper
    output reg signed [OUT_DATA_WIDTH-1:0] y_out // output (16-bit)
);


    localparam LOG_A0 = COEFF_WIDTH - 2; // one bit for the sign, and one bit for a1,a2 to rach 2. 
    localparam ADC_DATA_WIDTH = 14; // The actual max value coming from the adc
    localparam DATA_SHIFT_IN = DATA_WIDTH - ( ADC_DATA_WIDTH + LOG_DIV ) ;// DATA_WIDTH-(ADC_DATA_WIDTH+LOG_DIV)25-(14+2)=9 / 32-(14+2) = 16 // 32-(14+10) = 16  
    localparam DATA_SHIFT_OUT = GAIN_DATA_WIDTH - ADC_DATA_WIDTH;
    


    // Internal registers
    reg rst;
    reg [LOG_DIV-1:0] counter;

    reg signed [DATA_WIDTH - 1:0] x0, x1, x2, y1, y2;
    reg signed [25-1:0] y_pipe;
    
    reg signed [DATA_WIDTH + LOG_DIV - 1:0] x_sum;
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, b2_reg, a1_reg, a2_reg;
    reg signed [2*LOG_UNITY_GAIN-1:0] gain_reg;
    reg signed [DATA_WIDTH + COEFF_WIDTH -1:0] y_gain;

    wire signed [DATA_WIDTH + COEFF_WIDTH -1:0] b0_x0, b1_x1, b2_x2, a1_y1, a2_y2, acc_ff, acc_fb, acc;
    wire signed [DATA_WIDTH-1:0] x, y;


    //gpio controls
    always @(posedge clk) begin
        rst <= gpio_in[31];
    end
   
    // Internal downsampled Clock
    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
    wire counter_clk = (counter == 0);
    
    // Integrator
    always @(posedge clk) begin
        if (rst) begin
            x0 <=0;
            x_sum <= 0;
        end else if (counter_clk && DATA_SHIFT_IN >= 0) begin
            x0 <= (x_sum + x_in) <<< DATA_SHIFT_IN; //log_div = 2, -4->-2  >>>(LOG_DIV-4)
            x_sum <= 0;
        end else if (counter_clk && DATA_SHIFT_IN < 0) begin
            x0 <= (x_sum + x_in) >>> - DATA_SHIFT_IN;
            x_sum <= 0;
        end else begin
            x_sum <= x_sum + x_in;       
        end
    end
    
    /*// Alternative to Intewgrator: just decimation:
    always @(posedge clk) begin
        if (rst) begin
            x0 <=0;
        end else if (counter_clk) begin
            x0 <= x_in <<< DATA_SHIFT_IN;
        end
    end
    */
    
    // Pipeline for coefficient registers
    always @(posedge clk) begin
        if (rst) begin
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
            gain_reg <= gpio_in[2*LOG_UNITY_GAIN-1:0];
        end
    end

    // Pipeline for in and out registers
    always @(posedge clk) begin
          if (rst) begin
            x1 <= 0;
            x2 <= 0;
            y2 <= 0;
          end else if (counter_clk) begin   //IMPORTANT!
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
 
    //y pipeline
   always @(posedge clk) begin
        if (rst) begin
            y_pipe <= 0;
        end else begin
            y_pipe <= y >>> DATA_WIDTH - GAIN_DATA_WIDTH;
        end
   end
   
    // output register
    always @(posedge clk) begin
        if (rst) begin
            y_gain<=0;
            y_out <= 0;
        end else begin
            y_gain <= y_pipe * gain_reg >>> LOG_UNITY_GAIN;
            y_out <= y_gain >>> DATA_SHIFT_OUT;
        end
    end
    
endmodule