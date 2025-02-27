`timescale 1 ns / 1 ps

module iir_filter_2nd_order #(
    parameter IN_DATA_WIDTH = 16,    // Input/output data width
    parameter OUT_DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 32,   // Coefficient width
    parameter DATA_WIDTH = 32,  // 
    parameter EXTRA_SHIFT = 2, // Extra shift for safety
    parameter ACC_WIDTH = DATA_WIDTH + COEFF_WIDTH   // Accumulator width
    
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

    // Pipeline registers
    reg signed [DATA_WIDTH-1:0] x, x_1, x_2;      // Delayed input samples
    reg signed [DATA_WIDTH-1:0] y, y_1, y_2;      // Delayed output samples
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, b2_reg, a1_reg, a2_reg;
    reg signed [COEFF_WIDTH-1:0] gain_reg;

    // Multiplication results
    reg signed [DATA_WIDTH + COEFF_WIDTH - 1:0] mult_b0_x, mult_b1_x1, mult_b2_x2;
    reg signed [DATA_WIDTH + COEFF_WIDTH -1:0] mult_a1_y1, mult_a2_y2;
    reg signed [DATA_WIDTH + COEFF_WIDTH - 1:0] y_gain;  // Output with gain applied

    // Add pipeline registers for multiplication results
    reg signed [DATA_WIDTH + COEFF_WIDTH - 1:0] mult_b0_x_pipe, mult_b1_x1_pipe, mult_b2_x2_pipe;
    reg signed [DATA_WIDTH + COEFF_WIDTH - 1:0] mult_a1_y1_pipe, mult_a2_y2_pipe;

    // Accumulation register
    reg signed [ACC_WIDTH-1:0] acc_stage;  // Pipeline accumulation

    // Pipeline for input delays
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x <= 0;
            x_1 <= 0;
            x_2 <= 0;
            y_1 <= 0;
            y_2 <= 0;
        end else begin
            x   <= x_in <<< (DATA_WIDTH - IN_DATA_WIDTH); 
            x_1 <= x;     // Delay x
            x_2 <= x_1;   // Delay x_1
            y_1 <= y;     // Delay y[n]
            y_2 <= y_1;   // Delay y[n-1] -> y[n-2]
        end
    end

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

    // Multiply inputs by coefficients in parallel (pipelined)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mult_b0_x <= 0;
            mult_b1_x1 <= 0;
            mult_b2_x2 <= 0;
            mult_a1_y1 <= 0;
            mult_a2_y2 <= 0;
        end else begin
            mult_b0_x <= b0_reg * x ;        // b0 * x[n]
            mult_b1_x1 <= b1_reg * x_1;     // b1 * x[n-1]
            mult_b2_x2 <= b2_reg * x_2;     // b2 * x[n-2]
            mult_a1_y1 <= a1_reg * y_1;     // a1 * y[n-1]
            mult_a2_y2 <= a2_reg * y_2;     // a2 * y[n-2]
        end
    end

    // Add extra pipeline stage after multiplications
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mult_b0_x_pipe <= 0;
            mult_b1_x1_pipe <= 0;
            mult_b2_x2_pipe <= 0;
            mult_a1_y1_pipe <= 0;
            mult_a2_y2_pipe <= 0;
        end else begin
            mult_b0_x_pipe <= mult_b0_x;
            mult_b1_x1_pipe <= mult_b1_x1;
            mult_b2_x2_pipe <= mult_b2_x2;
            mult_a1_y1_pipe <= mult_a1_y1;
            mult_a2_y2_pipe <= mult_a2_y2;
        end
    end

    // Accumulate 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            acc_stage <= 0;
        end else begin
            acc_stage <= (mult_b0_x_pipe + mult_b1_x1_pipe + mult_b2_x2_pipe - mult_a1_y1_pipe - mult_a2_y2_pipe); 
        end
    end

    
// Apply gain (second pipeline stage)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y <= 0;
            y_gain <= 0;       
        end else begin
            y <= acc_stage >>> (COEFF_WIDTH-2);  //  // Divide by a0 (2^(COEFF_WIDTH-2)) for unity gain 
            y_gain <= y * gain_reg;  // Apply gain
        end
    end

    // Attenuate the output
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y_out <= 0;
        end else begin
            y_out <= y_gain >>> DATA_WIDTH; // Unity gain with gain = 2^16 if input is normalized to 2^30.
        end
    end

endmodule