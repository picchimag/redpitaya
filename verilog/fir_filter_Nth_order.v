module fir_filter_Nth_order #(
    parameter DATA_WIDTH = 16,    // Input/output data width
    parameter COEFF_WIDTH = 16,   // Coefficient width
    parameter ORDER = 3,          // Filter order (modifiable parameter)
    parameter ACC_WIDTH = DATA_WIDTH + COEFF_WIDTH  // Accumulator width
)(
    input wire clk,                   // System clock
    input wire rst,                   // Reset signal
    input wire signed [DATA_WIDTH-1:0] x,  // Current input sample (16-bit)
    input wire signed [COEFF_WIDTH-1:0] coeffs [0:ORDER], // Array of FIR coefficients
    output reg signed [DATA_WIDTH-1:0] y    // Filter output (16-bit)
);

    // Registers to store delayed input samples
    reg signed [DATA_WIDTH-1:0] x_reg [0:ORDER];  // Delayed input samples

    // Registers to store multiplication results
    reg signed [ACC_WIDTH-1:0] mult_results [0:ORDER];  // Multiplication results

    // Accumulation register
    reg signed [ACC_WIDTH-1:0] acc_ff_stage;  // Single accumulation stage

    integer i;

    // Shift input samples in the pipeline
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i <= ORDER; i = i + 1) begin
                x_reg[i] <= 0;
            end
        end else begin
            for (i = ORDER; i > 0; i = i - 1) begin
                x_reg[i] <= x_reg[i-1];  // Shift previous input samples
            end
            x_reg[0] <= x;  // Store current input sample
        end
    end

    // Multiply inputs by coefficients in parallel (pipelined)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i <= ORDER; i = i + 1) begin
                mult_results[i] <= 0;
            end
        end else begin
            for (i = 0; i <= ORDER; i = i + 1) begin
                mult_results[i] <= coeffs[i] * x_reg[i];  // Multiply by corresponding coefficients
            end
        end
    end

    // Accumulate all terms in a single stage
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            acc_ff_stage <= 0;
            y <= 0;
        end else begin
            acc_ff_stage = 0;  // Reset accumulator
            for (i = 0; i <= ORDER; i = i + 1) begin
                acc_ff_stage = acc_ff_stage + mult_results[i];  // Accumulate all terms
            end
            y <= acc_ff_stage[ACC_WIDTH-1:ACC_WIDTH-DATA_WIDTH];  // Truncate to 16-bit output
        end
    end

endmodule
