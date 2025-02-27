//attempt with direct form 2, transposed.


`timescale 1 ns / 1 ps

module iir_filter_2nd_order #(
    parameter IN_DATA_WIDTH = 16,    // Input/output data width
    parameter OUT_DATA_WIDTH = 16,
    parameter IN_COEFF_WIDTH = 32,   // Coefficient width
    parameter DATA_WIDTH = 16,  // 
    parameter COEFF_WIDTH = 16,   // Coefficient width
    parameter LOG_A0 = COEFF_WIDTH - 2, // A0 is 2^30
    parameter LOG_DIV = 2 // division of clock by 2**LOG_DIV
)(
    input wire clk,                   // System clock
    input wire clk2,
    input wire rst,                   // Reset signal
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          // signed current input sample (16-bit)
    input wire signed [IN_COEFF_WIDTH-1:0] b0, // Pre-scaled Coefficients from GPIO (32-bit)
    input wire signed [IN_COEFF_WIDTH-1:0] b1,
    input wire signed [IN_COEFF_WIDTH-1:0] b2,
    input wire signed [IN_COEFF_WIDTH-1:0] a1,
    input wire signed [IN_COEFF_WIDTH-1:0] a2,
    input wire signed [IN_COEFF_WIDTH-1:0] gain, // Controllable output gain
    output reg signed [OUT_DATA_WIDTH-1:0] y_out // output (16-bit)
);

    // Internal registers
    reg [LOG_DIV-1:0] clock_counter;

    reg signed [DATA_WIDTH - 1:0] x1, x2, y1, y2, x_sum;
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, b2_reg, a1_reg, a2_reg, gain_reg;

    wire signed [DATA_WIDTH + COEFF_WIDTH -1:0] b0_x, b1_x, b2_x, a1_y, a2_y, acc, y_gain;
    wire signed [DATA_WIDTH-1:0] x, y;
    
   
    
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
            gain_reg <= gain;
        end
    end

    // Pipeline filter states
    always @(posedge clk)
      if (rst) begin
        w1 <= 0;
        w2 <= 0;
      end else begin
        w1 <= w1_new;
        w2 <= w2_new;
      end
        
            
    // Combinational multiplications
    assign b0_x = x_in * b0_reg;
    assign b1_x = x_in * b1_reg;
    assign b2_x = x_in * b2_reg;
    assign a1_y = y * a1_reg;
    assign a2_y = y * a2_reg;

    assign w0_new = b1_x1 - a1_x1 + w1;
    assign w1_new = b2_x2 - a2_x2;

    
    //Filter equation 
    assign acc = b0_x + b1_x1 + b2_x2 - a1_y1 - a2_y2;
    assign y = acc >>> LOG_A0;
    
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y_out <= 0;
        end else begin
            y_out <= y;
        end
    end
    
endmodule