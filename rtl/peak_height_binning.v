/**
 * @module peak_height_binning
 * @brief Peak height binning with gain/offset calibration and configurable pulse width energy band detection
 * 
 * This module bins detected peak heights into a histogram using efficient gain/offset
 * calibration and bit-selection for bin indexing. Provides energy band filtering
 * that forwards peak_detected pulses when energy falls within a configurable range.
 * Features configurable pulse width for band_detected output for DAC triggering.
 * Processes peaks immediately upon detection.
 *
 * Performance notes:
 * - Triggered directly by peak detector output
 * - Immediate processing on peak detection edge
 * - No division - uses bit-shift for ultra-fast binning
 * - Gain/offset calibration for flexible energy scaling
 * - Real-time histogram building and band filtering
 *
 * Binning method:
 * - bin_index = (peak_value_in + offset) * gain >> (16 - LOG_NBINS)
 * - Uses upper LOG_NBINS bits of scaled value as bin address
 * - Automatic range mapping via bit selection
 *
 * @param PEAK_DATA_WIDTH  Width of input peak values (default: 16 bits)
 * @param BIN_COUNT_WIDTH  Width of bin counters (default: 32 bits)
 * @param LOG_NBINS        log2(NUM_BINS) - 10 = 1024 bins
 * @param NUM_BINS         Number of histogram bins (2^LOG_NBINS)
 * @param THRESHOLD_WIDTH  Width of threshold values (default: 16 bits)
 *
 * @input clk              System clock (unused - kept for compatibility)
 * @input slow_clk         Slow clock for all histogram operations (same as peak detector)
 * @input rst              Reset signal (active high)
 * @input peak_detected    Peak detection input signal (triggers processing)
 * @input peak_value_in    Peak value from detector [PEAK_DATA_WIDTH-1:0]
 * @input peak_positive    Positive/negative peak flag
 * @input offset           Baseline offset correction [PEAK_DATA_WIDTH-1:0]
 * @input gain             Gain multiplication factor [PEAK_DATA_WIDTH-1:0]
 * @input band_low         Lower threshold for energy band [THRESHOLD_WIDTH-1:0]
 * @input band_high        Upper threshold for energy band [THRESHOLD_WIDTH-1:0]
 * @input pulse_width      Pulse width for band_detected output (in slow_clk cycles) [15:0]
 * @input enable_pos_bin   Enable binning of positive peaks
 * @input enable_neg_bin   Enable binning of negative peaks
 * @input clear_bins       Clear all bin counters
 * @input counting_enable  Enable/disable counting (for clean readout)
 * @input filter_reset     Filter reset control signal
 * @input read_addr        Read address for histogram data [LOG_NBINS-1:0]
 * @output read_data       Read data output [BIN_COUNT_WIDTH-1:0]
 * @output band_detected   Peak detected pulse filtered by energy band (signed 14-bit DAC output: 0 or 8191)
 * @output overflow_flag   Bin counter overflow flag
 * @output total_bins      Total number of bins (for software) [LOG_NBINS-1:0]
 * @output data_ready      Data ready flag
 */

`timescale 1 ns / 1 ps

module peak_height_binning #(
    parameter PEAK_DATA_WIDTH = 16,    // Width of input peak values
    parameter BIN_COUNT_WIDTH = 32,    // Width of bin counters
    parameter LOG_NBINS = 10,          // log2(NUM_BINS) - 10 = 1024 bins
    parameter NUM_BINS = (1 << LOG_NBINS), // 2^LOG_NBINS bins
    parameter THRESHOLD_WIDTH = 16     // Width of threshold values
)(
    input wire clk,                                           // System clock
    input wire slow_clk,                                      // Slow clock (available for future use)
    input wire rst,                                           // Reset signal  
    input wire peak_detected,                                 // Peak detection input
    input wire signed [PEAK_DATA_WIDTH-1:0] peak_value_in,  // Peak value from detector
    
    // Binning configuration (gain/offset method)
    input wire signed [PEAK_DATA_WIDTH-1:0] offset,         // Baseline offset correction
    input wire [PEAK_DATA_WIDTH-1:0] gain,                  // Gain multiplication factor
    input wire clear_bins,                                   // Clear all bin counters
    input wire counting_enable,                              // Enable/disable counting (for readout)
    
    // Energy band configuration  
    input wire signed [THRESHOLD_WIDTH-1:0] band_low,       // Energy band lower threshold
    input wire signed [THRESHOLD_WIDTH-1:0] band_high,      // Energy band upper threshold
    input wire [15:0] pulse_width,                           // Band detected pulse width (in clk cycles)
    
    input wire filter_reset,                                 // Filter reset control
    
    // Memory readout interface
    input wire [LOG_NBINS-1:0] read_addr,                   // Read address (bin index)
    output reg [BIN_COUNT_WIDTH-1:0] read_data,             // Read data output
    
    // Outputs
    output wire signed [15:0] band_detected,                 // Peak detected pulse filtered by energy band (signed DAC output: 0 or 2^13-1)
    output reg overflow_flag,                                // Bin counter overflow flag
    output reg [LOG_NBINS-1:0] total_bins,                  // Total number of bins (for software)
    output reg data_ready                                    // Data ready flag
);

    // Internal registers
    reg signed [PEAK_DATA_WIDTH-1:0] offset_reg;
    reg [PEAK_DATA_WIDTH-1:0] gain_reg;
    reg signed [THRESHOLD_WIDTH-1:0] band_low_reg, band_high_reg;
    reg [15:0] pulse_width_reg;
    reg signed [PEAK_DATA_WIDTH-1:0] peak_value_captured;  // Capture peak value on detection edge
    
    // Internal signals for simplified binning
    wire [LOG_NBINS-1:0] bin_index;                          // LOG_NBINS bits for addressing
    wire signed [PEAK_DATA_WIDTH-1:0] peak_corrected;       // After offset correction
    wire [PEAK_DATA_WIDTH+PEAK_DATA_WIDTH-1:0] peak_scaled; // After gain multiplication
    wire band_match;
    
    // Bin counter array (for easier manipulation)
    reg [BIN_COUNT_WIDTH-1:0] bin_counters [0:NUM_BINS-1];
    
    // Readout pipeline registers with synchronizer for read_addr
    reg [LOG_NBINS-1:0] read_addr_sync1, read_addr_sync2; // 2-stage synchronizer
    reg [LOG_NBINS-1:0] read_addr_reg;

    // Pipeline for parameter registers
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            offset_reg <= 0;
            gain_reg <= 1;  // Default gain = 1 (no scaling)
            band_low_reg <= 0;
            band_high_reg <= 0;
            pulse_width_reg <= 16'd125;  // Default: 1µs at 125MHz (125 cycles)
        end else begin
            offset_reg <= offset;
            gain_reg <= gain;
            band_low_reg <= band_low;
            band_high_reg <= band_high;
            pulse_width_reg <= pulse_width;
        end
    end

    // Simplified binning logic using gain/offset and bit selection
    assign peak_corrected = peak_value_in + offset_reg;      // Apply offset correction
    assign peak_scaled = peak_corrected * gain_reg;          // Apply gain multiplication
    
    // Extract LOG_NBINS bits as bin index - use lower bits for small peak values  
    wire [LOG_NBINS-1:0] bin_index_raw = peak_scaled[LOG_NBINS-1:0];  // Use lower 10 bits directly
    assign bin_index = (bin_index_raw >= NUM_BINS) ? (NUM_BINS-1) : bin_index_raw;  // Clamp to valid range

    // Energy band detection logic
    assign band_match = (peak_value_in >= band_low_reg) && (peak_value_in <= band_high_reg);
    
    // Pulse width timer for band_detected output
    reg [15:0] pulse_timer;
    reg band_detected_active;
    
    // Pulse timer control logic
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            pulse_timer <= 0;
            band_detected_active <= 0;
        end else if (peak_detected && band_match) begin
            // Start new pulse (extend if already active)
            pulse_timer <= pulse_width_reg;
            band_detected_active <= 1;
        end else if (band_detected_active && pulse_timer > 0) begin
            // Count down active pulse
            pulse_timer <= pulse_timer - 1;
        end else if (pulse_timer == 0) begin
            // End pulse when timer expires
            band_detected_active <= 0;
        end
    end
    
    // Output filtered peak detection pulse scaled for signed DAC output
    assign band_detected = band_detected_active ? 14'h1FFF : 14'h0000;  // 0 or 2^13-1 (8191)

    // BRAM-friendly histogram counter with proper initialization
    // This will synthesize to Block RAM instead of registers, and stes the to 0.
    integer j;
    initial begin
        for (j = 0; j < NUM_BINS; j = j + 1) begin
            bin_counters[j] = 0;
        end
    end
    
    // Clear counter for sequential clearing. Otherwise it would try to clear all in parrallel, which is not feasible.
    reg [LOG_NBINS-1:0] clear_counter;
    reg clearing_active;
    
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            overflow_flag <= 0;
            data_ready <= 0;
            total_bins <= NUM_BINS;
            clear_counter <= 0;
            clearing_active <= 1;  // Start clearing on reset
        end else if (clear_bins && !clearing_active) begin
            // Start sequential clear when clear_bins asserted
            clear_counter <= 0;
            clearing_active <= 1;
        end else if (clearing_active) begin
            // Sequential clearing - one bin per clock
            bin_counters[clear_counter] <= 0;
            if (clear_counter == NUM_BINS - 1) begin
                clearing_active <= 0;  // Done clearing
            end else begin
                clear_counter <= clear_counter + 1;
            end
        end else if (peak_detected && counting_enable) begin
            // Normal operation - increment histogram bin
            if (bin_counters[bin_index] == {BIN_COUNT_WIDTH{1'b1}}) begin
                overflow_flag <= 1;  // Set overflow flag if counter saturated
            end else begin
                bin_counters[bin_index] <= bin_counters[bin_index] + 1;
            end  
            data_ready <= 1;
        end
    end

    // Memory readout interface - simple read (no clock crossing)
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            read_addr_sync1 <= 0;
            read_addr_sync2 <= 0;
            read_addr_reg <= 0;
            read_data <= 0;
        end else begin
            // Simple pipeline (no synchronizer needed - same clock domain)
            read_addr_sync1 <= read_addr;
            read_addr_sync2 <= read_addr_sync1;
            
            // Read from memory
            read_addr_reg <= read_addr_sync2;
            read_data <= bin_counters[read_addr_reg];
        end
    end
    
endmodule