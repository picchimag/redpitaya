

module ramp #(
    parameter OUT_DATA_WIDTH = 12
)(

    input wire clk,                   // System clock
    input wire rst,                   // System clock
    output reg [OUT_DATA_WIDTH-1:0] ramp // output (32-bit)

);
    
    always @(posedge clk) begin
        if (rst)
            ramp <= 0;
        else
            ramp <= ramp + 1;
    end

    
    
endmodule

