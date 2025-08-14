/**
 * @module integrator
 * @brief Standalone integrator/accumulator module for Red Pitaya ADC data
 * 
 * This module separates the integration logic from the filter to allow
 * relaxed timing constraints on downstream filter while maintaining tight
 * timing on this critical 125 MHz integrator stage.
 * 
 * Accumulates input samples over 2^LOG_DIV clock cycles, then outputs
 * the scaled result and resets the accumulator. Provides data rate
 * conversion from 125 MHz input to ~122 kHz output (with LOG_DIV=10).
 *
 * @param IN_DATA_WIDTH   Input sample width (16-bit from ADC)
 * @param OUT_DATA_WIDTH  Output width (32-bit to downstream filter)
 * @param LOG_DIV         Clock division factor (10 = 1024x decimation)
 */
 

`timescale 1 ns / 1 ps

module integrator #(
    parameter IN_DATA_WIDTH = 16,    // Input/output data width
    parameter OUT_DATA_WIDTH = 32,
    parameter LOG_DIV = 10 // division of clock by 2**LOG_DIV
  
)(
    input wire clk,                   // System clock
    input wire rst,                   // Reset signal
    input wire signed [IN_DATA_WIDTH-1:0] x_in,          // signed current input sample (16-bit)
    output reg signed [OUT_DATA_WIDTH-1:0] x_out, // output (32-bit)
    output wire counter_clk           // slow clock output (high every 2^LOG_DIV cycles)
);


    localparam ADC_DATA_WIDTH = 14; // The actual max value coming from the adc
    localparam DATA_SHIFT_OUT = OUT_DATA_WIDTH - ( ADC_DATA_WIDTH + LOG_DIV ) ;// OUT_DATA_WIDTH-(ADC_DATA_WIDTH+LOG_DIV)25-(14+2)=9 / 32-(14+2) = 16 // 32-(14+10) = 16  
    
    // Internal registers
    reg [LOG_DIV-1:0] counter;
    reg signed [OUT_DATA_WIDTH - 1:0] x_sum;


   
    // Internal downsampled Clock
    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
    // Generates a clock signal (counter_clk) that is high only when the counter value is zero.
    assign counter_clk = (counter == 0); 
    
    // Integrator
    always @(posedge clk) begin
        if (rst) begin
            x_out <=0;
            x_sum <= 0;
        // if the shift is positive, that means we are not filling up the accumulator, so we shift it up so that 
        // the most significant bits are at the beginning. The next module will choose the desired bits.
        end else if (counter_clk && DATA_SHIFT_OUT >= 0) begin
            x_out <= (x_sum + x_in) <<< DATA_SHIFT_OUT;
            x_sum <= 0;
        // if the shift is negative, that means we are accumulting so much  that we need to shift the input down
        end else if (counter_clk && DATA_SHIFT_OUT < 0) begin
            x_out <= (x_sum + x_in) >>> (- DATA_SHIFT_OUT);
            x_sum <= 0;
        end else begin
            x_sum <= x_sum + x_in;       
        end
    end
    
    
endmodule