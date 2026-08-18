/**
 * @module event_logger
 * @brief Continuous timestamped event logger for the MCA chain (ping-pong BRAM)
 *
 * Taps the peak_detector outputs (peak_detected_out / peak_value_out) and, for
 * every in-band peak, writes a 64-bit record into the active BRAM buffer:
 *
 *     record[TS_WIDTH-1:0]           = timestamp  (microseconds since clear_ts)
 *     record[TS_WIDTH+E_WIDTH-1:TS_WIDTH] = energy (E_WIDTH-bit peak height)
 *     record[62]                     = chb_bit    (channel-B digital input)
 *     record[63]                     = veto       (event fell in a chB veto window)
 *
 * Time base: one free-running TS_WIDTH-bit counter, incremented once every
 * `presc` clk cycles (presc = f_clk/1e6 => 1 us tick; 125 for a 125 MHz clk).
 * 2^47 us = 4.5 years, so a single counter covers a 100-day run with no wrap
 * (16x margin). Software slices the stream into per-day files; do NOT reset.
 *
 * Ping-pong: two buffers share one BRAM (buffer = MSB of the write address).
 * While one buffer fills, the PS drains the other; on fill (or flush timeout)
 * they swap, so capture never stops -- unlike the hold-until-ack stream modules
 * whose S_HOLD state is dead time. A full buffer whose predecessor has not yet
 * been acked is held (not overwritten); only events arriving while BOTH buffers
 * are occupied are dropped and counted in `dropped`.
 *
 * Tie-points: writing snap=1 latches the live counter into ts_snap, so the PS
 * can read a coherent 47-bit value (no 32-bit read tearing) and pair it with
 * its NTP wall-clock time to calibrate absolute time and crystal drift offline.
 *
 * chB veto: every transition of the channel-B digital bit (either direction)
 * starts a forward-only window of `veto_ms` milliseconds. Events arriving in
 * that window are still logged, but tagged with record[63]=1 so the host can
 * filter them offline -- nothing is discarded, so `dropped` keeps its single
 * meaning (both buffers full) and `total_events` counts tagged events too.
 * The window is NOT retriggerable -- edges arriving while it is already running
 * are ignored. Capture, us counter, flush timer, buffer swaps and ack drain all
 * run unchanged, so timing is unaffected. veto_ms = 0 disables tagging.
 */

`timescale 1 ns / 1 ps

module event_logger #(
    parameter integer TS_WIDTH    = 47,   // microsecond counter width (2^47 us ~ 4.5 yr)
    parameter integer E_WIDTH     = 15,   // stored energy width (peak height, unsigned)
    parameter integer REC_WIDTH   = 64,   // BRAM word = TS_WIDTH + E_WIDTH + chb + veto = 64
    parameter integer ADDR_BITS   = 13,   // total BRAM depth = 2^ADDR_BITS words (2 buffers)
    parameter integer PRESC_WIDTH = 16,   // width of the microsecond prescaler
    parameter integer PEAK_WIDTH  = 16,   // width of peak_value_in / thresholds
    parameter integer VETO_WIDTH  = 16    // width of veto_ms (16 -> up to 65.5 s)
)(
    input  wire                       clk,          // processing clock (= s_axi_aclk, 125 MHz)
    input  wire                       rst,          // active-high reset

    // ---- control (from AXI regs) ----
    input  wire                       arm,          // 1 = logging enabled
    input  wire                       clear_ts,     // reset the microsecond counter
    input  wire [PRESC_WIDTH-1:0]     presc,        // clk cycles per us tick (125 @125 MHz)
    input  wire [ADDR_BITS-1:0]       frame_len,    // records per buffer before swap (1..2^(ADDR_BITS-1))
    input  wire [31:0]                flush_ticks,  // us before a forced swap of a partial buffer (0 = never)
    input  wire signed [PEAK_WIDTH-1:0] band_low,   // log only peaks with value in [band_low, band_high]
    input  wire signed [PEAK_WIDTH-1:0] band_high,
    input  wire signed [PEAK_WIDTH-1:0] chb_threshold, // channel-B digital threshold
    input  wire [VETO_WIDTH-1:0]      veto_ms,      // blanking after a chB transition, ms (0 = off)
    input  wire                       snap,         // rising edge latches counter into ts_snap
    input  wire                       ack,          // PS acknowledges it has drained ready_buf

    // ---- event input (peak_detector output domain) ----
    input  wire                       peak_detected,   // 1-cycle pulse
    input  wire signed [PEAK_WIDTH-1:0] peak_value_in, // peak amplitude
    input  wire signed [PEAK_WIDTH-1:0] chb_raw,       // channel-B ADC sample (sign-extended)

    // ---- BRAM Port-B (Port-A -> AXI BRAM Ctrl / CDMA source for PS reads) ----
    output reg  [ADDR_BITS-1:0]       bram_addr,    // {buffer, index}
    output reg  [REC_WIDTH-1:0]       bram_din,
    output reg                        bram_en,
    output reg  [(REC_WIDTH/8)-1:0]   bram_we,

    // ---- status (to AXI readonly regs) ----
    output reg                        ready,        // a full buffer is waiting for the PS
    output reg                        ready_buf,    // which buffer (0/1) is ready
    output reg  [ADDR_BITS-1:0]       ready_count,  // valid records in the ready buffer
    output reg  [31:0]                dropped,      // events lost (both buffers occupied)
    output reg  [TS_WIDTH-1:0]        ts_snap,      // latched counter (tie-point read)
    output reg  [TS_WIDTH-1:0]        total_events  // lifetime accepted-event count
);

    localparam integer BYTE_LANES = REC_WIDTH/8;
    localparam integer IDX_BITS   = ADDR_BITS - 1;   // per-buffer index width

    // ---- register control inputs (timing) ----
    reg [PRESC_WIDTH-1:0]     presc_reg;
    reg [IDX_BITS-1:0]        last_idx;               // frame_len-1, per buffer
    reg signed [PEAK_WIDTH-1:0] band_low_reg, band_high_reg, chb_thr_reg;
    reg [VETO_WIDTH-1:0]      veto_ms_reg;

    always @(posedge clk) begin
        if (rst) begin
            presc_reg     <= 16'd125;
            last_idx      <= {IDX_BITS{1'b0}};
            band_low_reg  <= {PEAK_WIDTH{1'b0}};
            band_high_reg <= {PEAK_WIDTH{1'b0}};
            chb_thr_reg   <= {PEAK_WIDTH{1'b0}};
            veto_ms_reg   <= {VETO_WIDTH{1'b0}};
        end else begin
            presc_reg     <= (presc == 0) ? 16'd1 : presc; // avoid div-by-0 -> tick every cycle
            last_idx      <= frame_len[IDX_BITS-1:0] - 1'b1;
            band_low_reg  <= band_low;
            band_high_reg <= band_high;
            chb_thr_reg   <= chb_threshold;
            veto_ms_reg   <= veto_ms;
        end
    end

    // ---- microsecond prescaler + free-running counter ----
    reg [PRESC_WIDTH-1:0] pcnt;
    reg [TS_WIDTH-1:0]    ts;
    reg                   us_tick;

    always @(posedge clk) begin
        if (rst || clear_ts) begin
            pcnt <= {PRESC_WIDTH{1'b0}};
            ts   <= {TS_WIDTH{1'b0}};
            us_tick <= 1'b0;
        end else begin
            us_tick <= 1'b0;
            if (pcnt >= presc_reg - 1'b1) begin
                pcnt    <= {PRESC_WIDTH{1'b0}};
                ts      <= ts + 1'b1;
                us_tick <= 1'b1;
            end else begin
                pcnt <= pcnt + 1'b1;
            end
        end
    end

    // ---- millisecond tick (veto time base) ----
    // Derived from us_tick, so it inherits presc: a "ms" is 1000 us ticks.
    // Not reset by clear_ts (a running veto window must not be disturbed), but
    // note that us_tick is held low while clear_ts is asserted.
    localparam integer MS_DIV = 1000;
    reg [9:0] ms_cnt;
    reg       ms_tick;

    always @(posedge clk) begin
        if (rst) begin
            ms_cnt  <= 10'd0;
            ms_tick <= 1'b0;
        end else begin
            ms_tick <= 1'b0;
            if (us_tick) begin
                if (ms_cnt >= MS_DIV - 1) begin
                    ms_cnt  <= 10'd0;
                    ms_tick <= 1'b1;
                end else begin
                    ms_cnt <= ms_cnt + 1'b1;
                end
            end
        end
    end

    // ---- snapshot for coherent 48-bit tie-point read ----
    reg snap_d;
    always @(posedge clk) begin
        if (rst) begin snap_d <= 1'b0; ts_snap <= {TS_WIDTH{1'b0}}; end
        else begin
            snap_d <= snap;
            if (snap & ~snap_d) ts_snap <= ts;   // rising edge latches
        end
    end

    // ---- channel-B digital bit (threshold -> 2FF sync for safety) ----
    wire chb_over = (chb_raw >= chb_thr_reg);
    reg  chb_m, chb_sync;
    always @(posedge clk) begin
        if (rst) begin chb_m <= 1'b0; chb_sync <= 1'b0; end
        else begin chb_m <= chb_over; chb_sync <= chb_m; end
    end

    // ---- chB transition veto (forward-only, non-retriggerable) ----
    // Any edge of chb_sync (either direction) opens a veto_ms window; events
    // inside it are logged with record[63]=1. Edges during an active window are
    // ignored. Because the window is loaded at an arbitrary point inside the
    // current ms, its true length is in (veto_ms-1, veto_ms] ms -- irrelevant at
    // the ~100 ms scale.
    //
    // Windows only open while armed: chb_thr_reg resets to 0, so the host's
    // first write of a real threshold moves chb_over and fakes a chB edge. That
    // happens during configuration, before arm, so gating on arm discards it.
    // chb_sync_d tracks free-running, so a chB already high at arm time is not
    // seen as an edge either. (Changing the threshold while armed still opens a
    // window -- which is arguably correct, the digital state really did move.)
    reg chb_sync_d;
    reg [VETO_WIDTH-1:0] veto_cnt;

    wire chb_edge    = chb_sync ^ chb_sync_d;
    wire veto_active = (veto_cnt != {VETO_WIDTH{1'b0}});

    always @(posedge clk) begin
        if (rst) begin
            chb_sync_d <= 1'b0;
            veto_cnt   <= {VETO_WIDTH{1'b0}};
        end else begin
            chb_sync_d <= chb_sync;
            if (arm && chb_edge && !veto_active)
                veto_cnt <= veto_ms_reg;          // 0 => stays inactive (veto off)
            else if (ms_tick && veto_active)
                veto_cnt <= veto_cnt - 1'b1;
        end
    end

    // ---- ack edge (level pulse from PS control bit) ----
    reg ack_d;
    always @(posedge clk) begin
        if (rst) ack_d <= 1'b0; else ack_d <= ack;
    end
    wire ack_edge = ack & ~ack_d;

    // ---- in-band event qualifier ----
    wire in_band = (peak_value_in >= band_low_reg) && (peak_value_in <= band_high_reg);
    wire event_q = arm && peak_detected && in_band;

    // ---- energy field: low E_WIDTH bits of the (positive) peak height ----
    wire [E_WIDTH-1:0] energy_u = peak_value_in[E_WIDTH-1:0];

    // ---- ping-pong writer ----
    reg               wr_buf;               // buffer currently being filled
    reg [IDX_BITS-1:0] wr_idx;              // index within the current buffer
    reg               held_full;            // current buffer full but predecessor not yet acked
    reg [31:0]        flush_cnt;            // us since last swap
    wire              at_last = (wr_idx == last_idx);

    always @(posedge clk) begin
        if (rst) begin
            bram_addr   <= {ADDR_BITS{1'b0}};
            bram_din    <= {REC_WIDTH{1'b0}};
            bram_en     <= 1'b0;
            bram_we     <= {BYTE_LANES{1'b0}};
            ready       <= 1'b0;
            ready_buf   <= 1'b0;
            ready_count <= {ADDR_BITS{1'b0}};
            dropped     <= 32'd0;
            total_events<= {TS_WIDTH{1'b0}};
            wr_buf      <= 1'b0;
            wr_idx      <= {IDX_BITS{1'b0}};
            held_full   <= 1'b0;
            flush_cnt   <= 32'd0;
        end else begin
            // defaults
            bram_en <= 1'b0;
            bram_we <= {BYTE_LANES{1'b0}};

            // ack frees the ready buffer
            if (ack_edge) ready <= 1'b0;

            // flush timer (counts only while a partial buffer is actually open)
            if (us_tick && arm && wr_idx != {IDX_BITS{1'b0}}) flush_cnt <= flush_cnt + 1'b1;

            if (!arm) begin
                // idle: do not capture, keep counters/state but let ack drain
                flush_cnt <= 32'd0;
            end else if (held_full) begin
                // buffer full, waiting for predecessor to be acked
                if (event_q) dropped <= dropped + 1'b1;   // nowhere to store
                if (!ready) begin
                    // predecessor drained -> publish the held buffer, swap
                    ready       <= 1'b1;
                    ready_buf   <= wr_buf;
                    ready_count <= {1'b0, last_idx} + 1'b1;   // == frame_len
                    wr_buf      <= ~wr_buf;
                    wr_idx      <= {IDX_BITS{1'b0}};
                    held_full   <= 1'b0;
                    flush_cnt   <= 32'd0;
                end
            end else if (event_q) begin
                // write one record
                bram_din  <= { veto_active, chb_sync, energy_u, ts };
                bram_addr <= { wr_buf, wr_idx };
                bram_en   <= 1'b1;
                bram_we   <= {BYTE_LANES{1'b1}};
                total_events <= total_events + 1'b1;

                if (at_last) begin
                    if (!ready) begin
                        ready       <= 1'b1;
                        ready_buf   <= wr_buf;
                        ready_count <= {1'b0, last_idx} + 1'b1;
                        wr_buf      <= ~wr_buf;
                        wr_idx      <= {IDX_BITS{1'b0}};
                        flush_cnt   <= 32'd0;
                    end else begin
                        held_full <= 1'b1;   // hold; predecessor not yet drained
                    end
                end else begin
                    wr_idx <= wr_idx + 1'b1;
                end
            end else if (flush_ticks != 32'd0 && flush_cnt >= flush_ticks
                         && wr_idx != {IDX_BITS{1'b0}} && !ready) begin
                // low-rate flush: publish a partial buffer so data isn't stuck
                ready       <= 1'b1;
                ready_buf   <= wr_buf;
                ready_count <= {{(ADDR_BITS-IDX_BITS){1'b0}}, wr_idx};  // partial count
                wr_buf      <= ~wr_buf;
                wr_idx      <= {IDX_BITS{1'b0}};
                flush_cnt   <= 32'd0;
            end
        end
    end

endmodule
