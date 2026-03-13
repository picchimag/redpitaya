`timescale 1 ns / 1 ps
// stream8channel.v  (hold-until-ack; decimated 8ch snapshot into BRAM)

module stream8channel #(
  parameter integer SAMPLE_WIDTH = 16,
  parameter integer N_CH         = 8,
  parameter integer PACK_WIDTH   = SAMPLE_WIDTH * N_CH,  // 128
  parameter integer ADDR_BITS    = 12,                   // max samples = 2^ADDR_BITS
  parameter integer LOG_DIV_WIDTH = 5                    // log_div input width (5 bits = max log_div of 31)
)(
  input  wire                     clk,
  input  wire                     rstn,

  // Control
  input  wire                     arm,                   // 1=run, 0=idle
  input  wire [ADDR_BITS:0]       frame_len,             // 1..2^ADDR_BITS (samples per frame)
  input  wire [LOG_DIV_WIDTH-1:0] log_div,               // sample every 2^log_div clk cycles

  // Ack from PS (async → synced inside)
  input  wire                     ack_raw,

  // Channels
  input  wire [SAMPLE_WIDTH-1:0]  in0,
  input  wire [SAMPLE_WIDTH-1:0]  in1,
  input  wire [SAMPLE_WIDTH-1:0]  in2,
  input  wire [SAMPLE_WIDTH-1:0]  in3,
  input  wire [SAMPLE_WIDTH-1:0]  in4,
  input  wire [SAMPLE_WIDTH-1:0]  in5,
  input  wire [SAMPLE_WIDTH-1:0]  in6,
  input  wire [SAMPLE_WIDTH-1:0]  in7,

  // BRAM Port-B (Port-A → AXI BRAM Ctrl for PS reads)
  output reg  [ADDR_BITS-1:0]     bram_addr,
  output reg  [PACK_WIDTH-1:0]    bram_din,
  output reg                      bram_en,
  output reg  [(PACK_WIDTH/8)-1:0] bram_we,

  // Status
  output reg                      ready,                 // stays 1 until ack
  output reg  [7:0]               seq,                   // ++ on each completed frame
  output reg  [ADDR_BITS-1:0]     wr_idx,                // debug
  output reg                      sample_tick            // decimated strobe (debug)
);

  localparam integer DIV_COUNTER_BITS = (1 << LOG_DIV_WIDTH);  // Counter width = 2^LOG_DIV_WIDTH
  localparam integer BYTE_LANES = PACK_WIDTH/8;

  // ---- sync ack (PS → clk) ----
  reg ack_meta, ack_sync, ack_sync_d;
  always @(posedge clk) begin
    ack_meta   <= ack_raw;
    ack_sync   <= ack_meta;
    ack_sync_d <= ack_sync;
  end
  wire ack_edge = ack_sync & ~ack_sync_d;

  // ---- log2 divider → 1-cycle sample_tick ----
  reg [DIV_COUNTER_BITS-1:0] div_cnt;
  wire [DIV_COUNTER_BITS-1:0] div_reload =
      (log_div == {LOG_DIV_WIDTH{1'b0}}) ? {DIV_COUNTER_BITS{1'b0}}
                        : (({{(DIV_COUNTER_BITS-1){1'b0}},1'b1} << log_div) - 1'b1);
  // log_div==0 → tick every cycle, max log_div = 2^LOG_DIV_WIDTH - 1

  // ---- FSM ----
  localparam [1:0] S_IDLE = 2'd0, S_CAP = 2'd1, S_HOLD = 2'd2;
  reg [1:0] state;

  // ---- book-keeping ----
  reg  [ADDR_BITS:0] len_lat;                 // latched frame_len
  reg  [ADDR_BITS-1:0] last_idx;              // = frame_len-1 (safe, registered)
  wire                have_len = (len_lat != 0);
  wire                at_last  = (wr_idx == last_idx);

  // ---- pack one 128-bit sample ----
  wire [PACK_WIDTH-1:0] pack_data = {in7, in6, in5, in4, in3, in2, in1, in0};

  // ---- main seq ----
  always @(posedge clk) begin
    if (!rstn) begin
      state       <= S_IDLE;
      bram_addr   <= {ADDR_BITS{1'b0}};
      bram_din    <= {PACK_WIDTH{1'b0}};
      bram_en     <= 1'b0;
      bram_we     <= {BYTE_LANES{1'b0}};
      ready       <= 1'b0;
      seq         <= 8'd0;
      wr_idx      <= {ADDR_BITS{1'b0}};
      len_lat     <= {ADDR_BITS+1{1'b0}};
      last_idx    <= {ADDR_BITS{1'b0}};
      div_cnt     <= {DIV_COUNTER_BITS{1'b0}};
      sample_tick <= 1'b0;
    end else begin
      // defaults
      bram_en     <= 1'b0;
      bram_we     <= {BYTE_LANES{1'b0}};
      sample_tick <= 1'b0;

      // divider only when armed
      if (!arm) begin
        div_cnt <= {DIV_COUNTER_BITS{1'b0}};
      end else begin
        if (div_cnt == {DIV_COUNTER_BITS{1'b0}}) begin
          sample_tick <= 1'b1;
          div_cnt     <= div_reload;
        end else begin
          div_cnt     <= div_cnt - 1'b1;
        end
      end

      case (state)
        // ---------------- IDLE ----------------
        S_IDLE: begin
          ready <= 1'b0;
          if (arm) begin
            len_lat  <= frame_len;
            // compute last_idx safely (avoid arithmetic part-selects)
            if (frame_len > 0)
              last_idx <= frame_len[ADDR_BITS-1:0] - 1'b1;
            else
              last_idx <= {ADDR_BITS{1'b0}}; // unused when have_len=0
              wr_idx    <= {ADDR_BITS{1'b0}};
              bram_addr <= {ADDR_BITS{1'b0}};
              div_cnt   <= {DIV_COUNTER_BITS{1'b0}};   // deterministic first tick
              state     <= S_CAP;
          end
        end

        // ---------------- CAPTURE ----------------
        S_CAP: begin
          if (!arm) begin
            state <= S_IDLE;
          end else if (sample_tick && have_len) begin
            // write one sample
            bram_din  <= pack_data;
            bram_addr <= wr_idx;
            bram_en   <= 1'b1;
            bram_we   <= {BYTE_LANES{1'b1}};

            if (at_last) begin
              ready <= 1'b1;          // freeze buffer
              seq   <= seq + 8'd1;
              state <= S_HOLD;        // wait for ack
            end else begin
              wr_idx    <= wr_idx + 1'b1;
              bram_addr <= wr_idx + 1'b1;
            end
          end
        end

        // ---------------- HOLD (wait for ack) ----------------
        S_HOLD: begin
          if (!arm) begin
            state <= S_IDLE;
          end else if (ack_edge || ack_sync) begin
            ready     <= 1'b0;
            // (re)latch in case frame_len changed while we were holding
            len_lat   <= frame_len;
            if (frame_len > 0)
              last_idx <= frame_len[ADDR_BITS-1:0] - 1'b1;
            else
              last_idx <= {ADDR_BITS{1'b0}};
            wr_idx    <= {ADDR_BITS{1'b0}};
            bram_addr <= {ADDR_BITS{1'b0}};
            div_cnt   <= {DIV_COUNTER_BITS{1'b0}};   // restart divider phase
            state     <= S_CAP;
          end
        end

        default: state <= S_IDLE;
      endcase
    end
  end
endmodule
