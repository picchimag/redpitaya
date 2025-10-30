/**
 * @module fir9_direct
 * @brief 9-tap FIR filter for use with separated integrator architecture

 *
 * Filter transfer function:
 *   H(z) = h0 + h1*z^(-1) + h2*z^(-2) + ... + h8*z^(-8)
 */

`timescale 1 ns / 1 ps

module fir9_direct #(
    parameter IN_DATA_WIDTH = 16,    // Input from integrator
    parameter OUT_DATA_WIDTH = 16,   // Output data width
    parameter DATA_WIDTH = 18,       // Internal processing width
    parameter COEFF_WIDTH = 8     // Coefficient width
 
)(
    input wire clk,                                        // System clock
    input wire rst,                                        // Reset signal  
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          // Input signal
    input wire slow_clk,                                   // Slow clock enable from integrator
    input wire signed [COEFF_WIDTH-1:0] h0,              // FIR coefficients
    input wire signed [COEFF_WIDTH-1:0] h1,
    input wire signed [COEFF_WIDTH-1:0] h2,
    input wire signed [COEFF_WIDTH-1:0] h3,
    input wire signed [COEFF_WIDTH-1:0] h4,
    input wire signed [COEFF_WIDTH-1:0] h5,
    input wire signed [COEFF_WIDTH-1:0] h6,
    input wire signed [COEFF_WIDTH-1:0] h7,
    input wire signed [COEFF_WIDTH-1:0] h8,
    input wire filter_reset,                              // Filter reset control
    output reg signed [OUT_DATA_WIDTH-1:0] y_out_reg     // Filtered output
);

    // Local parameters
    localparam LOG_A0 = COEFF_WIDTH - 1; 
    localparam DATA_SHIFT_IN = IN_DATA_WIDTH - DATA_WIDTH; // Shift from input to internal width
    
    // Internal registers
    reg rst_sync;
    reg signed [DATA_WIDTH - 1:0] x0, x1, x2, x3, x4, x5, x6, x7, x8;  // 9-tap delay line
    reg signed [COEFF_WIDTH-1:0] h0_reg, h1_reg, h2_reg, h3_reg, h4_reg, h5_reg, h6_reg, h7_reg, h8_reg;

    // Internal signals for filter calculations
    wire signed [DATA_WIDTH + COEFF_WIDTH -1:0] h0_x0, h1_x1, h2_x2, h3_x3, h4_x4, h5_x5, h6_x6, h7_x7, h8_x8;
    
    // 2-stage pipelined accumulator for better timing (3+3+3 grouping)
    reg signed [DATA_WIDTH + COEFF_WIDTH + 1:0] acc_pipe1_a, acc_pipe1_b, acc_pipe1_c;
    reg signed [DATA_WIDTH + COEFF_WIDTH + 3:0] acc_pipe2;
    reg signed [DATA_WIDTH-1:0] y;
    wire signed [OUT_DATA_WIDTH -1:0] y_out;

    // GPIO controls - use counter as both sync and hold timer
    reg [3:0] reset_counter;

    always @(posedge clk) begin
        if (rst) begin
            reset_counter <= 4'hF;
            rst_sync <= 1'b1;
        end else begin
            if (filter_reset) begin
                reset_counter <= 4'hF;  // Restart reset hold
            end else if (reset_counter > 0) begin
                reset_counter <= reset_counter - 1;
            end
            rst_sync <= (reset_counter > 0);
        end
    end
   
    // Input scaling: Convert input to internal DATA_WIDTH
    always @(posedge clk) begin
        if (rst_sync) begin
            x0 <= 0;
        end else if (slow_clk) begin
            if (DATA_SHIFT_IN >= 0) begin
                x0 <= x_in >>> DATA_SHIFT_IN; // Scale down to internal width
            end else begin
                x0 <= x_in <<< (-DATA_SHIFT_IN); // Scale up if needed
            end
        end
    end

    // Pipeline for coefficient registers
    always @(posedge clk) begin
        if (rst_sync) begin
            h0_reg <= 0;
            h1_reg <= 0;
            h2_reg <= 0;
            h3_reg <= 0;
            h4_reg <= 0;
            h5_reg <= 0;
            h6_reg <= 0;
            h7_reg <= 0;
            h8_reg <= 0;
        end else begin
            h0_reg <= h0;
            h1_reg <= h1;
            h2_reg <= h2;
            h3_reg <= h3;
            h4_reg <= h4;
            h5_reg <= h5;
            h6_reg <= h6;
            h7_reg <= h7;
            h8_reg <= h8;
        end
    end

    // Pipeline for FIR delay line - only update when slow clock is active
    always @(posedge clk) begin
        if (rst_sync) begin
            x1 <= 0;
            x2 <= 0;
            x3 <= 0;
            x4 <= 0;
            x5 <= 0;
            x6 <= 0;
            x7 <= 0;
            x8 <= 0;
        end else if (slow_clk) begin   // Update only when slow clock is active
            x1 <= x0;
            x2 <= x1;
            x3 <= x2;
            x4 <= x3;
            x5 <= x4;
            x6 <= x5;
            x7 <= x6;
            x8 <= x7;
        end
    end
      
    // Combinational multiplications for 9-tap FIR
    assign h0_x0 = x0 * h0_reg;
    assign h1_x1 = x1 * h1_reg;
    assign h2_x2 = x2 * h2_reg;
    assign h3_x3 = x3 * h3_reg;
    assign h4_x4 = x4 * h4_reg;
    assign h5_x5 = x5 * h5_reg;
    assign h6_x6 = x6 * h6_reg;
    assign h7_x7 = x7 * h7_reg;
    assign h8_x8 = x8 * h8_reg;
    
    // 2-stage pipelined accumulator tree for better timing (3+3+3 grouping)
    always @(posedge clk) begin
        if (rst_sync) begin
            acc_pipe1_a <= 0;
            acc_pipe1_b <= 0;
            acc_pipe1_c <= 0;
            acc_pipe2 <= 0;
            y <= 0;
        end else if (slow_clk) begin
            // Pipeline stage 1: Add groups of 3 products each (balanced 3-input adders)
            acc_pipe1_a <= h0_x0 + h1_x1 + h2_x2;
            acc_pipe1_b <= h3_x3 + h4_x4 + h5_x5;
            acc_pipe1_c <= h6_x6 + h7_x7 + h8_x8;
            
            // Pipeline stage 2: Final accumulation (3-input adder)
            acc_pipe2 <= acc_pipe1_a + acc_pipe1_b + acc_pipe1_c;
            y <= acc_pipe2 >>> LOG_A0;
        end
    end

    // Gain and output scaling
    assign y_out = y >>> (DATA_WIDTH - OUT_DATA_WIDTH);
 
    // output register - only update when new pipeline result is available  
    always @(posedge clk) begin
        if (rst_sync) begin
            y_out_reg <= 0;
        end else if (slow_clk) begin
            y_out_reg <= y_out;
        end
    end
    
endmodule