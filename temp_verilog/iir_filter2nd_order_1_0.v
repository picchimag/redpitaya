//works!!!!

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
    reg signed [DATA_WIDTH-1:0] x_sum;
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, b2_reg, a1_reg, a2_reg, gain_reg;
    reg signed [COEFF_WIDTH+DATA_WIDTH-1:0] w0, w1, y_gain;
    
    reg signed [DATA_WIDTH - 1:0] input_pipe1, input_pipe2, output_pipe1, output_pipe2;
    wire signed [DATA_WIDTH + COEFF_WIDTH -1:0] input_b0, input_b1, input_b2, output_a1,output_a2, acc;
 
    
    wire signed [DATA_WIDTH-1:0] f1_n0, x, y;
    
    // history pipeline regs
    reg signed [COEFF_WIDTH+DATA_WIDTH-1:0] f1_n1, f1_n2, f1_n3; 
    // history pipeline inputs
    wire signed [COEFF_WIDTH+DATA_WIDTH-1:0] f1_n1_input, f1_n2_input;
    
   
    
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

    /* pipeline registers */
    always @(posedge clk)
      if (rst) begin
        input_pipe1 <= 0;
        input_pipe2 <= 0;
        output_pipe1 <= 0;
        output_pipe2 <= 0;
      end else begin
        input_pipe1 <= x_in;
        input_pipe2 <= input_pipe1;
        output_pipe1 <= y;
        output_pipe2 <= output_pipe1;
      end
        
            
     /* combinational multiplications */
    assign input_b0 = x_in * b0_reg;
    assign input_b1 = input_pipe1 * b1_reg;
    assign input_b2 = input_pipe2 * b2_reg;
    assign output_a1 = output_pipe1 * a1_reg;
    assign output_a2 = output_pipe2 * a2_reg;
    
    assign acc = input_b0 + input_b1 + input_b2 - output_a1 - output_a2;
    assign y = acc >>> LOG_A0;
    
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y_out <= 0;
        end else begin
            y_out <= y;
        end
    end
    
endmodule