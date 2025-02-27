module buffer #(parameter WIDTH = 32) (
    input wire clk,                  // Clock signal
    input wire rst,                  // Reset signal (active high)
    input wire [WIDTH-1:0] din,      // Data input
    output wire [WIDTH-1:0] dout     // Data output after pipelining
);

    // Pipeline registers
    reg [WIDTH-1:0] stage1;
    reg [WIDTH-1:0] stage2;

    // Sequential logic: shift the input data through the pipeline stages
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            stage1 <= 0;
            stage2 <= 0;
        end else begin
            stage1 <= din;   // First pipeline stage
            stage2 <= stage1; // Second pipeline stage
        end
    end

    // Output is from the final stage
    assign dout = stage2;

endmodule
