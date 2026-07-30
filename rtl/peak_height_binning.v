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
    parameter THRESHOLD_WIDTH = 16,    // Width of threshold values
    parameter GAIN_WIDTH = 16          // Width of gain parameter
)(
    input wire clk,                                           // System clock
    input wire slow_clk,                                      // Slow clock (available for future use)
    input wire rst,                                           // Reset signal  
    input wire peak_detected,                                 // Peak detection input
    input wire signed [PEAK_DATA_WIDTH-1:0] peak_value_in,  // Peak value from detector
    
    // Binning configuration (gain/offset method)
    input wire signed [PEAK_DATA_WIDTH-1:0] offset,         // Baseline offset correction
    input wire [GAIN_WIDTH-1:0] gain,                       // Gain multiplication factor (unity = 2^LOG_UNITY)
    input wire clear_bins,                                   // Clear all bin counters
    input wire counting_enable,                              // Enable/disable counting (for readout)
    

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

    // Fixed-point gain format: unity gain = 2^LOG_UNITY (e.g., 256 for 16-bit with LOG_UNITY=8)
    localparam LOG_UNITY = GAIN_WIDTH / 2;  // 8 for 16-bit gain

    // Internal registers
    reg signed [PEAK_DATA_WIDTH-1:0] offset_reg;
    reg [GAIN_WIDTH-1:0] gain_reg;
    reg signed [THRESHOLD_WIDTH-1:0] band_low_reg, band_high_reg;
    reg [15:0] pulse_width_reg;
    reg signed [PEAK_DATA_WIDTH-1:0] peak_value_captured;  // Capture peak value on detection edge
    
    // Pipeline registers for binning computation
    // Input pipeline stage
    reg peak_detected_input_reg;
    reg signed [PEAK_DATA_WIDTH-1:0] peak_value_input_reg;
    
    // Processing pipeline stages  
    reg peak_detected_reg;
    reg signed [PEAK_DATA_WIDTH-1:0] peak_value_reg;
    reg [PEAK_DATA_WIDTH+PEAK_DATA_WIDTH-1:0] peak_scaled_reg;  // Result of MAC operation
    reg [LOG_NBINS-1:0] bin_index_reg;
    reg band_match_reg;
    
    // BRAM pipeline stage
    reg peak_detected_reg2;
    reg [LOG_NBINS-1:0] bin_index_reg2;
    reg band_match_reg2;
    
    // Additional BRAM timing stage
    reg peak_detected_reg3;
    reg [LOG_NBINS-1:0] bin_index_reg3;
    reg band_match_reg3;
    
    // BRAM read pipeline stage
    reg peak_detected_reg4;
    reg [LOG_NBINS-1:0] bin_index_reg4;
    reg [BIN_COUNT_WIDTH-1:0] bin_value_reg4;  // Value read from BRAM
    
    // Internal signals for simplified binning
    wire [LOG_NBINS-1:0] bin_index;                          // LOG_NBINS bits for addressing
    wire band_match;
    
    reg [15:0] pulse_timer;
    reg band_detected_active;
    


    // Pipeline for parameter registers
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            offset_reg <= 0;
            gain_reg <= (1 << LOG_UNITY);  // Default gain = 1.0 (unity = 2^LOG_UNITY = 256)
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

    // Input pipeline stage: Register inputs for timing closure
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            peak_detected_input_reg <= 0;
            peak_value_input_reg <= 0;
        end else begin
            peak_detected_input_reg <= peak_detected;
            peak_value_input_reg <= peak_value_in;
        end
    end

    // Combinatorial binning logic (using pipelined inputs)
    assign band_match = (peak_value_input_reg >= band_low_reg) && (peak_value_input_reg <= band_high_reg);

    // Pipeline stage 1: MAC operation (gain * peak_value + offset) in single DSP
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            peak_detected_reg <= 0;
            peak_value_reg <= 0;
            peak_scaled_reg <= 0;
            band_match_reg <= 0;
        end else begin
            peak_detected_reg <= peak_detected_input_reg;
            peak_value_reg <= peak_value_input_reg;
            // MAC with fixed-point gain: (peak * gain) >> LOG_UNITY + offset
            peak_scaled_reg <= ((peak_value_input_reg * gain_reg) >>> LOG_UNITY) + offset_reg;
            band_match_reg <= band_match;
        end
    end

    // Combinatorial logic for pipeline stage 2 (uses registered values)
    // Saturate bin index: clamp to [0, NUM_BINS-1] range
    assign bin_index = (peak_scaled_reg[PEAK_DATA_WIDTH+PEAK_DATA_WIDTH-1]) ? {LOG_NBINS{1'b0}} :     // If negative (MSB=1), saturate to 0
                       (peak_scaled_reg[LOG_NBINS-1:0] >= NUM_BINS) ? (NUM_BINS-1) :                                    // If >= NUM_BINS, saturate to max
                       peak_scaled_reg[LOG_NBINS-1:0];                                                                   // Otherwise use raw value
    

    // Pipeline stage 2: Bin index calculation
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            bin_index_reg <= 0;
        end else begin
            bin_index_reg <= bin_index;
        end
    end

    // Pipeline stage 3: BRAM access pipeline
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            peak_detected_reg2 <= 0;
            bin_index_reg2 <= 0;
            band_match_reg2 <= 0;
        end else begin
            peak_detected_reg2 <= peak_detected_reg;
            bin_index_reg2 <= bin_index_reg;
            band_match_reg2 <= band_match_reg;
        end
    end

    // Pipeline stage 4: Additional BRAM timing stage
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            peak_detected_reg3 <= 0;
            bin_index_reg3 <= 0;
            band_match_reg3 <= 0;
        end else begin
            peak_detected_reg3 <= peak_detected_reg2;
            bin_index_reg3 <= bin_index_reg2;
            band_match_reg3 <= band_match_reg2;
        end
    end
    
    // Pipeline stage 5: BRAM read stage (separates read from write)
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            peak_detected_reg4 <= 0;
            bin_index_reg4 <= 0;
            bin_value_reg4 <= 0;
        end else begin
            peak_detected_reg4 <= peak_detected_reg3;
            bin_index_reg4 <= bin_index_reg3;
            bin_value_reg4 <= bin_counters[bin_index_reg3];  // Read in separate stage
        end
    end
    
    // Pulse timer control logic  
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            pulse_timer <= 0;
            band_detected_active <= 0;
        end else if (peak_detected_reg4 && band_match_reg3) begin
            // Start new pulse - using stage 5 pipelined signals
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

    // Clear counter for sequential clearing
    reg [LOG_NBINS-1:0] clear_counter;
    reg clearing_active;
    
    // BRAM-friendly memory with separate read/write ports and registered addresses
    // Force BRAM inference with (* ram_style = "block" *)
    (* ram_style = "block" *) reg [BIN_COUNT_WIDTH-1:0] bin_counters [0:NUM_BINS-1];
    
    // Registered addresses for BRAM inference
    reg [LOG_NBINS-1:0] write_addr_reg;
    reg [LOG_NBINS-1:0] read_addr_reg;
    reg write_enable_reg;
    reg [BIN_COUNT_WIDTH-1:0] write_data_reg;
    
    // Initialize memory to zero (for simulation)
    integer j;
    initial begin
        for (j = 0; j < NUM_BINS; j = j + 1) begin
            bin_counters[j] = 0;
        end
    end
    
    // BRAM Write Port (Port A) - with registered address and data
    always @(posedge clk) begin
        if (write_enable_reg) begin
            bin_counters[write_addr_reg] <= write_data_reg;
        end
    end
    
    // BRAM Read Port (Port B) - with registered address  
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            read_addr_reg <= 0;
            read_data <= 0;
        end else begin
            read_addr_reg <= read_addr;
            read_data <= bin_counters[read_addr_reg];
        end
    end
    
    // Write control logic - generates registered write signals
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            overflow_flag <= 0;
            data_ready <= 0;
            total_bins <= NUM_BINS;
            clear_counter <= 0;
            clearing_active <= 1;  // Start clearing on reset
            write_addr_reg <= 0;
            write_data_reg <= 0;
            write_enable_reg <= 0;
        end else if (clear_bins && !clearing_active) begin
            // Start sequential clear when clear_bins asserted
            clear_counter <= 0;
            clearing_active <= 1;
            write_enable_reg <= 0;
        end else if (clearing_active) begin
            // Sequential clearing - one bin per clock
            write_addr_reg <= clear_counter;
            write_data_reg <= 0;
            write_enable_reg <= 1;
            if (clear_counter == NUM_BINS - 1) begin
                clearing_active <= 0;  // Done clearing
                write_enable_reg <= 0;
            end else begin
                clear_counter <= clear_counter + 1;
            end
        end else if (peak_detected_reg4 && counting_enable) begin
            // Normal operation - increment histogram bin (using pre-read value)
            write_addr_reg <= bin_index_reg4;
            if (bin_value_reg4 == {BIN_COUNT_WIDTH{1'b1}}) begin
                overflow_flag <= 1;  // Set overflow flag if counter saturated
                write_enable_reg <= 0;  // Don't write if saturated
            end else begin
                write_data_reg <= bin_value_reg4 + 1;  // Use pre-read value
                write_enable_reg <= 1;
            end  
            data_ready <= 1;
        end else begin
            write_enable_reg <= 0;
        end
    end
    
endmodule