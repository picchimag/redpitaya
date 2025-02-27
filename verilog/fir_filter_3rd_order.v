module fir_filter_3rd_order #(
    parameter DATA_WIDTH = 16,    // Input/output data width
    parameter COEFF_WIDTH = 16,   // Coefficient width
    parameter ACC_WIDTH = DATA_WIDTH + COEFF_WIDTH + 1 + 2  // Accumulator width 1 because we are log2(0.5*4) = 1 (0.5 for signed coefficients), + log2(4) 2 because of the adc integration stage which results in a 4x signal!
)(
    input wire clk,                   // System clock
    input wire rst,                   // Reset signal
    input wire signed [DATA_WIDTH-1:0] x,  // Current input sample (16-bit)
    input wire signed [COEFF_WIDTH-1:0] b0, // FIR coefficients from GPIO (32-bit)
    input wire signed [COEFF_WIDTH-1:0] b1,
    input wire signed [COEFF_WIDTH-1:0] b2,
    input wire signed [COEFF_WIDTH-1:0] b3,
    output reg signed [DATA_WIDTH-1:0] y    // Filter output (16-bit)
);

    // Registers to store delayed input samples
    reg signed [DATA_WIDTH-1:0] x_1, x_2, x_3;  // Delayed input samples

    // Registers to store multiplication results
    reg signed [ACC_WIDTH-1:0] mult_b0_x, mult_b1_x1, mult_b2_x2, mult_b3_x3;

    // Accumulation register
    reg signed [ACC_WIDTH-1:0] acc_ff_stage;  // Single accumulation stage

    // Pipeline for input delays
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x_1 <= 0;
            x_2 <= 0;
            x_3 <= 0;
        end else begin
            x_1 <= x;       // Delay x[n]
            x_2 <= x_1;     // Delay x[n-1]
            x_3 <= x_2;     // Delay x[n-2]
        end
    end

    // Multiply inputs by coefficients in parallel (pipelined)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mult_b0_x <= 0;
            mult_b1_x1 <= 0;
            mult_b2_x2 <= 0;
            mult_b3_x3 <= 0;
        end else begin
            mult_b0_x <= b0 * x;        // b0 * x[n]
            mult_b1_x1 <= b1 * x_1;     // b1 * x[n-1]
            mult_b2_x2 <= b2 * x_2;     // b2 * x[n-2]
            mult_b3_x3 <= b3 * x_3;     // b3 * x[n-3]
        end
    end

    // Accumulate all terms in a single stage
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            acc_ff_stage <= 0;
            y <= 0;
        end else begin
            acc_ff_stage <= mult_b0_x + mult_b1_x1 + mult_b2_x2 + mult_b3_x3;  // Sum all terms
            y <= acc_ff_stage[ACC_WIDTH-1:ACC_WIDTH-DATA_WIDTH];  // Truncate to 16-bit output
        end
    end

endmodule
