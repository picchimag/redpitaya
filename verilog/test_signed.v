module signed_multiplier (
    input wire clk,  // Clock signal
    input wire [15:0] in_unsigned,  // 16-bit unsigned input
    input wire signed [31:0] reg_signed,  // 32-bit signed register
    output reg [15:0] out_unsigned  // 16-bit unsigned output
);

    // Internal signed register for the input
    reg signed [16:0] in_signed;
    always @(posedge clk) begin
       in_signed <= in_unsigned + (1 << 15);
    end

    // Buffer stage for the multiplication
    reg signed [16:0] in_signed_buf;
    reg signed [31:0] reg_signed_buf;
    always @(posedge clk) begin
        in_signed_buf <= in_signed;
        reg_signed_buf <= reg_signed;
    end

    // Internal signed register for the multiplication result
    reg signed [47:0] mult_result;
    always @(posedge clk) begin
        mult_result <= in_signed_buf * reg_signed_buf;
    end

    // Convert the result back to unsigned
    reg signed [47:0] mult_result_shifted;
    always @(posedge clk) begin
        mult_result_shifted <= mult_result - (1 << 15);
    end

    // Assign the lower 16 bits of the result to the output
    always @(posedge clk) begin
        out_unsigned <= mult_result_shifted[30:15];
    end

endmodule