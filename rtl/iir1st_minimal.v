/**
 * @module iir1st_direct
 * @brief First-order IIR filter for use with separated integrator architecture
 * 
 *
 * Filter transfer function:
 *   H(z) = (b0 + b1*z^(-1)) / (1 + a1*z^(-1))
 */

`timescale 1 ns / 1 ps

module iir1st_minimal #(
    parameter IN_DATA_WIDTH = 18,    // Input from integrator (32-bit)
    parameter OUT_DATA_WIDTH = 16,   // Output data width
    parameter DATA_WIDTH = 18,       // Internal processing width
    parameter COEFF_WIDTH = 25      // Coefficient width
)(
    input wire clk,                                        // System clock
    input wire rst,                                        // Reset signal  
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          // Pre-integrated input (32-bit)
    input wire slow_clk,                                   // Slow clock enable from integrator
    input wire signed [COEFF_WIDTH-1:0] b0,              // Filter coefficients
    input wire signed [COEFF_WIDTH-1:0] b1,
    input wire signed [COEFF_WIDTH-1:0] a1,
    input wire filter_reset,                              // Filter reset control
    output reg signed [OUT_DATA_WIDTH-1:0] y_out_reg     // Filtered output
);

    // Local parameters
    localparam LOG_A0 = COEFF_WIDTH - 1;  // 24 for Q1.24 format (coefficients ±1)
    localparam DATA_SHIFT_IN = IN_DATA_WIDTH - DATA_WIDTH; // Shift from 32-bit input to internal width
    
    // Internal registers
    reg rst_sync;
    reg signed [DATA_WIDTH - 1:0] x0, x1, y1;  // Only need x1 and y1 for 1st order
    reg signed [COEFF_WIDTH-1:0] b0_reg, b1_reg, a1_reg;

    // Internal signals for filter calculations
    wire signed [DATA_WIDTH + COEFF_WIDTH - 1:0] b0_x0, b1_x1, a1_y1, acc;
    wire signed [DATA_WIDTH-1:0] y;
    wire signed [OUT_DATA_WIDTH -1:0] y_out;

    // GPIO controls - use counter as both sync and hold timer
    //allows minimal length reset ensuring all internal regs are cleared
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
   
    // Input scaling: Convert 32-bit integrated input to internal DATA_WIDTH
    always @(posedge clk) begin
        if (rst_sync) begin
            x0 <= 0;
        end else if (slow_clk) begin
            if (DATA_SHIFT_IN >= 0) begin
                x0 <= x_in >>> DATA_SHIFT_IN; // Scale down from 32-bit to internal width
            end else begin
                x0 <= x_in <<< (-DATA_SHIFT_IN); // Scale up if needed
            end
        end
    end

    // Pipeline for coefficient registers
    always @(posedge clk) begin
        if (rst_sync) begin
            b0_reg <= 0;
            b1_reg <= 0;
            a1_reg <= 0;
        end else begin
            b0_reg <= b0;
            b1_reg <= b1;
            a1_reg <= a1;
        end
    end

    // Pipeline for filter delay registers - only update when slow clock is active
    always @(posedge clk) begin
        if (rst_sync) begin
            x1 <= 0;
            y1 <= 0;  // Reset y1
        end else if (slow_clk) begin   // Update only when slow clock is active
            x1 <= x0;
            y1 <= y;
        end
    end
      
    // Combinational multiplications for 1st order filter
    assign b0_x0 = x0 * b0_reg;
    assign b1_x1 = x1 * b1_reg;
    assign a1_y1 = y1 * a1_reg;
    
    // 1st order filter equation: y[n] = b0*x[n] + b1*x[n-1] - a1*y[n-1]
    assign acc = b0_x0 + b1_x1 - a1_y1;
    assign y = acc >>> LOG_A0;

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