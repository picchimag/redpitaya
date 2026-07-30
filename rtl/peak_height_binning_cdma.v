/**
 * @module peak_height_binning_cdma
 * @brief Full-resolution pulse-height histogram with CDMA-friendly BRAM readout
 *
 * Same front-end as peak_height_binning (gain/offset calibration -> bin index,
 * plus energy-band DAC trigger), but the bin counters live in an EXTERNAL
 * dual-port BRAM (bram_interface) instead of an internal array read out one
 * word at a time. Port B is driven here (read-modify-write increment); Port A
 * is wired in the block design to an AXI BRAM Controller so the PS/CDMA can
 * sweep the whole spectrum in one burst -- essential once NUM_BINS is large
 * (32768 register reads over SSH would take ~30 s; a CDMA drain is instant).
 *
 * Bin index (unchanged): (peak_value * gain >> LOG_UNITY) + offset, saturated
 * to [0, NUM_BINS-1]. With unity gain / zero offset, bin = peak_value directly.
 *
 * Storage: bins are in a bram_interface(DATA_WIDTH=BIN_COUNT_WIDTH,
 * ADDR_BITS=LOG_NBINS). Increment is a 3-cycle Port-B read->modify->write; MCA
 * dead time keeps peaks far enough apart that the RMW never collides (max
 * throughput 1 event / 3 clk = ~41 M/s >> 100 k/s). Clear sweeps all bins.
 *
 * Resolution note: peak_value is signed 16-bit, so LOG_NBINS=15 (32768 bins)
 * already resolves every distinct positive peak. LOG_NBINS=16 only adds empty
 * bins AND needs BIN_COUNT_WIDTH<=18 to fit xc7z010 BRAM.
 */

`timescale 1 ns / 1 ps

module peak_height_binning_cdma #(
    parameter integer PEAK_DATA_WIDTH = 16,
    parameter integer BIN_COUNT_WIDTH = 32,   // 32 -> no overflow; <=18 needed for LOG_NBINS=16
    parameter integer LOG_NBINS       = 15,   // 15 -> 32768 bins = full res for signed-16 peak
    parameter integer NUM_BINS        = (1 << LOG_NBINS),
    parameter integer THRESHOLD_WIDTH = 16,
    parameter integer GAIN_WIDTH      = 16
)(
    input  wire                              clk,
    input  wire                              rst,

    // event input (peak_detector output domain)
    input  wire                              peak_detected,
    input  wire signed [PEAK_DATA_WIDTH-1:0] peak_value_in,

    // calibration / control
    input  wire signed [PEAK_DATA_WIDTH-1:0] offset,
    input  wire        [GAIN_WIDTH-1:0]      gain,
    input  wire                              clear_bins,
    input  wire                              counting_enable,
    input  wire signed [THRESHOLD_WIDTH-1:0] band_low,
    input  wire signed [THRESHOLD_WIDTH-1:0] band_high,
    input  wire        [15:0]                pulse_width,
    input  wire                              filter_reset,

    // external BRAM Port-B (bins in a bram_interface; Port-A -> AXI BRAM Ctrl/CDMA)
    output reg  [LOG_NBINS-1:0]              bram_addr,
    output reg  [BIN_COUNT_WIDTH-1:0]        bram_din,
    output reg                               bram_en,
    output reg  [(BIN_COUNT_WIDTH/8)-1:0]    bram_we,
    input  wire [BIN_COUNT_WIDTH-1:0]        bram_dout,

    // outputs
    output wire signed [15:0]                band_detected,   // 0 or 2^13-1 for DAC
    output reg                               overflow_flag,
    output reg                               clearing_active
);

    localparam integer LOG_UNITY = GAIN_WIDTH / 2;         // unity gain = 2^LOG_UNITY
    localparam integer LANES     = BIN_COUNT_WIDTH / 8;
    localparam [1:0] S_IDLE = 2'd0, S_READ = 2'd1, S_MODIFY = 2'd2, S_CLR = 2'd3;

    // ---- parameter pipeline ----
    reg signed [PEAK_DATA_WIDTH-1:0] offset_reg;
    reg        [GAIN_WIDTH-1:0]      gain_reg;
    reg signed [THRESHOLD_WIDTH-1:0] band_low_reg, band_high_reg;
    reg        [15:0]                pulse_width_reg;

    always @(posedge clk) begin
        if (rst || filter_reset) begin
            offset_reg      <= 0;
            gain_reg        <= (1 << LOG_UNITY);
            band_low_reg    <= 0;
            band_high_reg   <= 0;
            pulse_width_reg <= 16'd125;
        end else begin
            offset_reg      <= offset;
            gain_reg        <= gain;
            band_low_reg    <= band_low;
            band_high_reg   <= band_high;
            pulse_width_reg <= pulse_width;
        end
    end

    // ---- front-end pipeline: peak -> bin index (mirrors peak_height_binning) ----
    // stage 0: register inputs
    reg                              pk0;
    reg signed [PEAK_DATA_WIDTH-1:0] pv0;
    always @(posedge clk) begin
        if (rst || filter_reset) begin pk0 <= 0; pv0 <= 0; end
        else begin pk0 <= peak_detected; pv0 <= peak_value_in; end
    end
    wire band_match0 = (pv0 >= band_low_reg) && (pv0 <= band_high_reg);

    // stage 1: MAC  (peak * gain >> LOG_UNITY) + offset
    reg                                 pk1, bm1;
    reg [2*PEAK_DATA_WIDTH-1:0]         scaled1;
    always @(posedge clk) begin
        if (rst || filter_reset) begin pk1 <= 0; bm1 <= 0; scaled1 <= 0; end
        else begin
            pk1     <= pk0;
            bm1     <= band_match0;
            scaled1 <= ((pv0 * gain_reg) >>> LOG_UNITY) + offset_reg;
        end
    end

    // stage 2: saturate to a valid bin index
    wire neg  = scaled1[2*PEAK_DATA_WIDTH-1];
    wire over = |scaled1[2*PEAK_DATA_WIDTH-2:LOG_NBINS];   // any bit above the index range
    wire [LOG_NBINS-1:0] bin_idx = neg  ? {LOG_NBINS{1'b0}} :
                                   over ? (NUM_BINS-1)      :
                                          scaled1[LOG_NBINS-1:0];
    reg                    hit_valid, hit_band;
    reg [LOG_NBINS-1:0]    hit_bin;
    always @(posedge clk) begin
        if (rst || filter_reset) begin hit_valid <= 0; hit_band <= 0; hit_bin <= 0; end
        else begin hit_valid <= pk1; hit_band <= bm1; hit_bin <= bin_idx; end
    end

    // ---- Port-B read-modify-write / clear FSM ----
    reg [1:0]             st;
    reg [LOG_NBINS-1:0]   rmw_bin, clr_addr;
    reg                   clear_pending;

    always @(posedge clk) begin
        if (rst || filter_reset) begin
            st <= S_CLR; clr_addr <= 0; clearing_active <= 1'b1; clear_pending <= 1'b0;
            rmw_bin <= 0; overflow_flag <= 1'b0;
            bram_addr <= 0; bram_din <= 0; bram_en <= 1'b0; bram_we <= {LANES{1'b0}};
        end else begin
            if (clear_bins) clear_pending <= 1'b1;   // latch async clear request
            // defaults (single-cycle strobes)
            bram_en <= 1'b0;
            bram_we <= {LANES{1'b0}};

            case (st)
                S_IDLE: begin
                    clearing_active <= 1'b0;
                    if (clear_pending) begin
                        clear_pending  <= 1'b0;
                        clr_addr       <= 0;
                        clearing_active<= 1'b1;
                        bram_addr <= 0; bram_din <= 0; bram_en <= 1'b1; bram_we <= {LANES{1'b1}};
                        st <= S_CLR;
                    end else if (hit_valid && counting_enable) begin
                        rmw_bin   <= hit_bin;
                        bram_addr <= hit_bin; bram_en <= 1'b1; bram_we <= {LANES{1'b0}}; // read
                        st <= S_READ;
                    end
                    // else: hits arriving while busy are ignored (dead time prevents this)
                end

                S_READ: begin
                    st <= S_MODIFY;                    // wait one cycle for Port-B read latency
                end

                S_MODIFY: begin
                    if (bram_dout == {BIN_COUNT_WIDTH{1'b1}}) begin
                        overflow_flag <= 1'b1;         // saturate: do not wrap
                    end else begin
                        bram_addr <= rmw_bin;
                        bram_din  <= bram_dout + 1'b1;
                        bram_en   <= 1'b1;
                        bram_we   <= {LANES{1'b1}};
                    end
                    st <= S_IDLE;
                end

                S_CLR: begin
                    bram_addr <= clr_addr; bram_din <= 0; bram_en <= 1'b1; bram_we <= {LANES{1'b1}};
                    if (clr_addr == NUM_BINS-1) begin
                        clearing_active <= 1'b0;
                        st <= S_IDLE;
                    end else begin
                        clr_addr <= clr_addr + 1'b1;
                    end
                end

                default: st <= S_IDLE;
            endcase
        end
    end

    // ---- energy-band DAC trigger (stretched pulse), unchanged behaviour ----
    reg [15:0] pulse_timer;
    reg        band_active;
    always @(posedge clk) begin
        if (rst || filter_reset) begin
            pulse_timer <= 16'd0; band_active <= 1'b0;
        end else if (hit_valid && hit_band) begin
            pulse_timer <= pulse_width_reg; band_active <= 1'b1;
        end else if (band_active && pulse_timer > 0) begin
            pulse_timer <= pulse_timer - 1'b1;
        end else if (pulse_timer == 0) begin
            band_active <= 1'b0;
        end
    end
    assign band_detected = band_active ? 16'sh1FFF : 16'sh0000;

endmodule
