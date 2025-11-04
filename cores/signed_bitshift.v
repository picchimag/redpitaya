module signed_bitshift #(
    parameter integer SHIFT        = 2,
    parameter integer INPUT_WIDTH  = 16,
    parameter integer OUTPUT_WIDTH = 16
)(
    input  wire signed [INPUT_WIDTH-1:0] din,
    output wire signed [OUTPUT_WIDTH-1:0] dout
);
    // Arithmetic shift depending on SHIFT sign
    wire signed [INPUT_WIDTH-1:0] shifted;

    generate
        if (SHIFT > 0) begin
            assign shifted = din >>> SHIFT;   // arithmetic right shift
        end else if (SHIFT < 0) begin
            assign shifted = din <<< (-SHIFT); // left shift
        end else begin
            assign shifted = din;
        end
    endgenerate

    // Truncate or sign-extend to OUTPUT_WIDTH
    assign dout = shifted[OUTPUT_WIDTH-1 : 0];
endmodule