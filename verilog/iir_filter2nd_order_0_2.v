// DIRECT FORM II 2nd order IIR filter
// COMPILES, MEETS TIMING EXCEPT FOT THE OUTPUT
// NOT WORKING BUT NOW THE ERROR IS A FACTOR OF 2 NOT 4 AS BEFORE!

`timescale 1 ns / 1 ps


module iir_filter_2nd_order #(
    parameter IN_DATA_WIDTH = 16,    // Input/output data width
    parameter OUT_DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 32,   // Coefficient width
    parameter DATA_WIDTH = 32,  // 
    parameter LOG_A0 = 30 // A0 is 2^30
    
)(
    input wire clk,                   // System clock
    input wire rst,                   // Reset signal
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          //    signed current input sample (16-bit)
    input wire signed [COEFF_WIDTH-1:0] b0, // Pre-scaled Coefficients from GPIO (32-bit)
    input wire signed [COEFF_WIDTH-1:0] b1,
    input wire signed [COEFF_WIDTH-1:0] b2,
    input wire signed [COEFF_WIDTH-1:0] a1,
    input wire signed [COEFF_WIDTH-1:0] a2,
    input wire signed [COEFF_WIDTH-1:0] gain, // Controllable output gain
    output reg signed [OUT_DATA_WIDTH-1:0] y_out // output (16-bit)
);

    //Internal registers
    reg signed [DATA_WIDTH-1:0] x, y;
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, b2_reg, a1_reg, a2_reg, gain_reg;
    reg signed [DATA_WIDTH+COEFF_WIDTH-1:0] w0, w1, y_gain;
    reg signed [OUT_DATA_WIDTH-1:0] y_out_reg;
    

    // Pipeline for coefficient registers
    always @(posedge clk or posedge rst) begin
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
            gain_reg <= gain;
        end
    end

    // Filter equations (Direct type 2, transposed)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y <= 0;
            w0 <= 0;
            w1 <= 0; 
            x <=0;  
        end else begin
            x  <= x_in <<< (DATA_WIDTH - IN_DATA_WIDTH);
            w1 <= b2_reg * x - a2_reg * y;
            w0 <= b1_reg * x - a1_reg * y + w1;
            y <= (b0_reg * x + w0) >>> LOG_A0;
             
        end
    end


    // Calculate the (delayed) output 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y_gain <= 0;
            y_out_reg <=0;
            y_out <= 0;
        end else begin
            y_gain <= y * gain_reg;
            y_out_reg <= y_gain >>> DATA_WIDTH; // Unity gain with gain = 2^16 if input is normalized to 2^30.
            y_out <= y_out_reg;
        end
    end

endmodule