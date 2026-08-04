/**
 * @module peak_detector
 * @brief FSM-based peak detector with trigger, fall, and baseline return
 * 
 * This module implements a finite state machine peak detector suitable for
 * pulse height analysis applications like nuclear spectroscopy. It tracks
 * peaks from trigger to fall, with configurable dead time and baseline return.
 *
 * FSM States:
 * - IDLE: Waiting for trigger condition (x_in > trig_level)
 * - TRACK: Following peak, updating peak_value with maximum value
 * - HOLD: Peak detected, ready for readout, starting dead time
 * - DEAD: Dead time active, waiting for baseline return
 *
 * @param DATA_WIDTH       Width of input/output data (default: 16 bits)
 * @param COUNTER_WIDTH    Width of dead time counter (default: 16 bits)
 *
 * @input clk              System clock
 * @input rst              Reset signal (active high)
 * @input x_in             Input sample (ADC data) [DATA_WIDTH-1:0]
 * @input slow_clk         Slow clock enable from integrator
 * @input trig_level       Trigger threshold [DATA_WIDTH-1:0]
 * @input fall_level       Fall threshold [DATA_WIDTH-1:0] (RESERVED - not used in fixed integration mode)
 * @input base_return      Baseline return level [DATA_WIDTH-1:0]
 * @input dead_time_setting Dead time count [COUNTER_WIDTH-1:0]
 * @input n_integration    Integration window size [COUNTER_WIDTH-1:0]
 * @input invert_input     Invert input polarity (0=positive peaks, 1=negative peaks)
 * @input filter_reset     Filter reset control signal
 * @output peak_detected   Peak detection pulse (1 clock cycle)
 * @output peak_value        Detected peak value (integrated over fixed window) [DATA_WIDTH-1:0]
 * @output state_out       Current FSM state for debugging [1:0]
 */

`timescale 1 ns / 1 ps

module peak_detector #(
    parameter DATA_WIDTH = 16,        // Width of input/output data
    parameter COUNTER_WIDTH = 16,     // Width of dead time counter
    parameter INTEGRATION_WIDTH = 32  // Width of integration accumulator (wider to prevent overflow)
)(
    input wire clk,                                        // System clock
    input wire rst,                                        // Reset signal  
    input wire signed [DATA_WIDTH-1:0] x_in,             // Input sample (ADC data)
    input wire slow_clk,                                   // Slow clock enable from integrator
    input wire signed [DATA_WIDTH-1:0] trig_level,       // Trigger threshold
    input wire signed [DATA_WIDTH-1:0] fall_level,       // Fall threshold (RESERVED - for future adaptive peak tracking)
    input wire signed [DATA_WIDTH-1:0] base_return,      // Baseline return level
    input wire [COUNTER_WIDTH-1:0] dead_time_setting,    // Dead time count
    input wire [COUNTER_WIDTH-1:0] n_integration,        // Integration window size
    input wire [3:0] log_attenuation,                    // Bit shift for output scaling (0-15)
    input wire integration_mode,                          // 0=max tracking, 1=integration
    input wire invert_input,                              // Invert input polarity (0=positive peaks, 1=negative peaks)
    input wire filter_reset,                              // Filter reset control
    output reg peak_detected_out,                             // Peak detection pulse
    output reg signed [DATA_WIDTH-1:0] peak_value_out,     // Selected output (integration or max based on mode)
    output reg signed [DATA_WIDTH-1:0] peak_integral_out,  // Integration accumulator output (always available)
    output reg signed [DATA_WIDTH-1:0] peak_max_out,       // Maximum value detected in window (always available)
    output reg [COUNTER_WIDTH-1:0] max_delay,            // Delay at which maximum was detected
    output reg [1:0] state_out                            // Current FSM state for debugging
);

    // FSM states
    localparam [1:0] IDLE  = 2'b00;
    localparam [1:0] TRACK = 2'b01;
    localparam [1:0] HOLD  = 2'b10;
    localparam [1:0] DEAD  = 2'b11;
    
    // Internal registers
    reg [1:0] state;
    reg [COUNTER_WIDTH-1:0] dead_cnt;
    reg [COUNTER_WIDTH-1:0] integration_cnt;     // Fixed integration counter
    reg signed [DATA_WIDTH-1:0] x_reg;
    reg signed [DATA_WIDTH-1:0] trig_level_reg;
    reg signed [DATA_WIDTH-1:0] fall_level_reg;          // RESERVED - for future adaptive peak tracking
    reg signed [DATA_WIDTH-1:0] base_return_reg;
    reg [COUNTER_WIDTH-1:0] dead_time_reg;
    reg [COUNTER_WIDTH-1:0] n_integration_reg;           // Integration window size
    reg [3:0] log_attenuation_reg;                       // Bit shift for output scaling
    reg integration_mode_reg;                            // 0=max tracking, 1=integration
    reg invert_input_reg;                                 // Polarity inversion control
    reg signed [DATA_WIDTH-1:0] peak_max;
    reg [COUNTER_WIDTH-1:0] max_delay_reg;               // Delay at which max was found
    reg signed [INTEGRATION_WIDTH-1:0] peak_integral;
    
    // Pipeline registers for outputs (updated by slow_clk domain)
    reg peak_detected_pipe;
    reg signed [DATA_WIDTH-1:0] peak_value_pipe;         // Selected output (integration or max based on mode)
    reg signed [DATA_WIDTH-1:0] peak_integral_pipe;      // Integration accumulator output (always available)
    reg signed [DATA_WIDTH-1:0] peak_max_pipe;           // Maximum value detected in window (always available)

    
    // Polarity inversion: invert input for negative peak detection
    // value = condition ? value_if_true : value_if_false
    wire signed [DATA_WIDTH-1:0] x_pos;
    assign x_pos = invert_input_reg ? -x_in : x_in;

    // Pipeline for parameter registers
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            trig_level_reg <= 0;
            fall_level_reg <= 0;  // RESERVED - maintained for future development
            base_return_reg <= 0;
            dead_time_reg <= 0;
            n_integration_reg <= 1;  // Default to 1 sample
            log_attenuation_reg <= 0;
            integration_mode_reg <= 0;  // Default to max tracking
            invert_input_reg <= 0;    // Default to positive peaks
        end else begin
            trig_level_reg <= trig_level;
            fall_level_reg <= fall_level;  // RESERVED - for future adaptive mode
            base_return_reg <= base_return;
            dead_time_reg <= dead_time_setting;
            n_integration_reg <= n_integration;
            log_attenuation_reg <= log_attenuation;
            integration_mode_reg <= integration_mode;
            invert_input_reg <= invert_input;
        end
    end

    // Input sample pipeline (slow_clk domain)
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            x_reg <= 0;
        end else if (slow_clk) begin
            x_reg <= x_pos;  // Register the polarity-adjusted signal
        end
    end

    // FSM-based peak detector with max tracking or integration modes
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            state <= IDLE;
            peak_value_pipe <= 0;
            peak_integral_pipe <= 0;
            peak_max_pipe <= 0;
            peak_detected_pipe <= 0;
            peak_integral <= 0;
            peak_max <= 0;
            max_delay_reg <= 0;
            max_delay <= 0;
            dead_cnt <= 0;
            integration_cnt <= 0;
            state_out <= IDLE;
        end else if (slow_clk) begin
            peak_detected_pipe <= 0;  // Default: no peak detected
            state_out <= state;  // Output current state for debugging
            
            case (state)
                IDLE: begin
                    if (x_reg > trig_level_reg) begin 
                        peak_integral <= x_reg;         // Always start integration with first sample
                        peak_max <= x_reg;              // Always start max tracking with first sample
                        max_delay_reg <= 1;             // Max found at first sample
                        integration_cnt <= 1;           // Start counter
                        state <= TRACK; 
                    end
                end
                
                TRACK: begin
                    // Always accumulate samples (integration)
                    peak_integral <= peak_integral + x_reg;
                    
                    // Always track maximum value and its delay
                    if (x_reg > peak_max) begin
                        peak_max <= x_reg;
                        max_delay_reg <= integration_cnt + 1;  // Delay at which max was found
                    end
                    
                    integration_cnt <= integration_cnt + 1;
                    
                    if (integration_cnt >= n_integration_reg) begin
                        state <= HOLD;  // Window completed
                    end
                end
                
                HOLD: begin
                    peak_detected_pipe <= 1;  // Signal peak is ready
                    dead_cnt <= dead_time_reg;  // Load dead time
                    max_delay <= max_delay_reg;  // Output the delay at which max was found
                    
                    // Always output both values with attenuation to pipeline registers
                    peak_integral_pipe <= peak_integral >>> log_attenuation_reg;  // Integration result
                    peak_max_pipe <= peak_max >>> log_attenuation_reg;            // Max tracking result
                    
                    // Select which one goes to peak_value_pipe based on mode
                    if (integration_mode_reg) begin
                        peak_value_pipe <= peak_integral >>> log_attenuation_reg;  // Integration mode
                    end else begin
                        peak_value_pipe <= peak_max >>> log_attenuation_reg;       // Max tracking mode
                    end
                    state <= DEAD;
                end
                
                DEAD: begin
                    if (dead_cnt > 0) begin
                        dead_cnt <= dead_cnt - 1;
                    end else if (x_reg < base_return_reg) begin
                        state <= IDLE;
                        integration_cnt <= 0;    // Reset counter
                        peak_integral <= 0;      // Reset accumulator
                        peak_max <= 0;           // Reset max value
                        max_delay_reg <= 0;      // Reset max delay
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end


    // Output pipeline stage - runs on full clk rate for timing closure
    reg peak_detected_pipe_d;
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            peak_detected_out <= 0;
            peak_detected_pipe_d <= 0;
            peak_value_out <= 0;
            peak_integral_out <= 0;
            peak_max_out <= 0;
        end else begin
            peak_detected_pipe_d <= peak_detected_pipe;
            // Rising-edge detect: peak_detected_pipe spans 2 clk cycles (one slow_clk period),
            // so raw pipelining would produce a 2-cycle pulse. Edge detect gives exactly 1 cycle.
            peak_detected_out <= peak_detected_pipe & ~peak_detected_pipe_d;
            peak_value_out <= peak_value_pipe;
            peak_integral_out <= peak_integral_pipe;
            peak_max_out <= peak_max_pipe;
        end
    end

    
endmodule