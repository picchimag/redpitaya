// DIRECT FORM II 2nd order IIR filter
// USING blocking operations to avoid timing issues

`timescale 1 ns / 1 ps

module iir_filter_2nd_order #(
    parameter IN_DATA_WIDTH = 16,    // Input/output data width
    parameter OUT_DATA_WIDTH = 16,
    parameter IN_COEFF_WIDTH = 32,   // Coefficient width
    parameter DATA_WIDTH = 18,  // 
    parameter COEFF_WIDTH = 32,   // Coefficient width
    parameter LOG_A0 = COEFF_WIDTH - 2, // A0 is 2^30
    parameter LOG_DIV = 2 // division of clock by 2**LOG_DIV
)(
    input wire clk,                   // System clock
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
    reg signed [DATA_WIDTH-1:0] x, y, x_sum;
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, b2_reg, a1_reg, a2_reg, gain_reg;
    reg signed [COEFF_WIDTH+DATA_WIDTH-1:0] w0, w1, y_gain;
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

    // Accumulate the input samples
    always @(posedge clk or posedge rst) begin
        if (rst || clock_counter == (1 << LOG_DIV) - 1) begin
            x_sum <= 0;
            clock_counter <= 0;
        end else begin
            x_sum <= x_sum + (x_in <<< (DATA_WIDTH - IN_DATA_WIDTH));
            clock_counter <= clock_counter + 1;
        end
    end

    // Filter equations (Direct type 2, transposed)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y <= 0;
            w0 <= 0;
            w1 <= 0;
            x <= 0;
        end else begin
            if (clock_counter == (1 << LOG_DIV) - 1) begin
                y <= (b0_reg * x + w0) >>> LOG_A0;
                w0 <= b1_reg * x - a1_reg * y + w1;
                w1 <= b2_reg * x - a2_reg * y;
                x <= x_sum;
            end
        end
    end

    // Output scaling and gain application
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y_out <= 0;
            y_gain <= 0;
        end else begin
            y_gain <= y * gain_reg;
            y_out <= y_gain >>> DATA_WIDTH;
        end
    end

endmodule