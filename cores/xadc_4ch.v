// xadc_4ch: XADC reading VAUX0, VAUX1, VAUX8, VAUX9
// Red Pitaya E2 mapping:
//   AI1 -> VAUX0  on C20/B20
//   AI2 -> VAUX1  on E17/D18
//   AI0 -> VAUX8  on B19/A20
//   AI3 -> VAUX9  on E18/E19

module xadc_4ch (
    input  wire        clk,
    input  wire        rst,

    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux0 V_P" *)
    input  wire        vaux0_p,
    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux0 V_N" *)
    input  wire        vaux0_n,

    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux1 V_P" *)
    input  wire        vaux1_p,
    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux1 V_N" *)
    input  wire        vaux1_n,

    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux8 V_P" *)
    input  wire        vaux8_p,
    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux8 V_N" *)
    input  wire        vaux8_n,

    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux9 V_P" *)
    input  wire        vaux9_p,
    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux9 V_N" *)
    input  wire        vaux9_n,

    // 16-bit outputs, useful 12-bit sample is [15:4]
    output reg  [15:0] out_aux_0,
    output reg  [15:0] out_aux_1,
    output reg  [15:0] out_aux_8,
    output reg  [15:0] out_aux_9,

    output reg         valid_0,
    output reg         valid_1,
    output reg         valid_8,
    output reg         valid_9,

    // debug
    output reg  [4:0]  dbg_channel,
    output reg  [15:0] dbg_raw,
    output reg  [9:0]  dbg_cycles_per_sample,
    output reg         dbg_drdy
);

wire [4:0]  channel;
wire [15:0] data;
wire        eoc;
wire        drdy;

reg  [9:0] cycle_counter = 0;

XADC #(
    .INIT_40(16'h0000),   // Not used in sequence mode
    .INIT_41(16'h21F0),   // SEQ[15:12]=0010 continuous, averaging=00, unipolar, disable all system channels
    .INIT_42(16'h0500),   // DCLK divider = 5 -> 25 MHz (proven setting)
    .INIT_48(16'h0303),   // Enable VAUX0,1,8,9 (bits 0,1,8,9)
    .INIT_49(16'hFFFF)    // Disable all calibration channels in INIT_49
) xadc (
    .DCLK(clk),
    .RESET(rst),

    .EOC(eoc),
    .DRDY(drdy),
    .CHANNEL(channel),

    .DEN(eoc),           // Simple EOC-triggered read like working design
    .DADDR(channel),     // Read the channel that just finished
    .DO(data),

    .VP(1'b0),
    .VN(1'b0),

    // bit 0 -> VAUX0
    // bit 1 -> VAUX1
    // bit 8 -> VAUX8
    // bit 9 -> VAUX9
    .VAUXP({6'b0, vaux9_p, vaux8_p, 6'b0, vaux1_p, vaux0_p}),
    .VAUXN({6'b0, vaux9_n, vaux8_n, 6'b0, vaux1_n, vaux0_n})
);

always @(posedge clk) begin
    valid_0  <= 1'b0;
    valid_1  <= 1'b0;
    valid_8  <= 1'b0;
    valid_9  <= 1'b0;
    dbg_drdy <= 1'b0;

    if (rst) begin
        out_aux_0 <= 16'd0;
        out_aux_1 <= 16'd0;
        out_aux_8 <= 16'd0;
        out_aux_9 <= 16'd0;

        dbg_channel <= 5'd0;
        dbg_raw     <= 16'd0;
        dbg_cycles_per_sample <= 10'd0;

        cycle_counter <= 10'd0;

    end else begin
        cycle_counter <= cycle_counter + 1'b1;

        // When read data is ready, store it based on the channel
        if (drdy) begin
            dbg_drdy <= 1'b1;
            dbg_channel <= channel;
            dbg_raw <= data;
            dbg_cycles_per_sample <= cycle_counter + 1'b1;
            cycle_counter <= 10'd0;

            case (channel)
                5'h10: begin  // VAUX0 (channel 0x10 = 16 decimal)
                    out_aux_0 <= data >> 2;
                    valid_0   <= 1'b1;
                end

                5'h11: begin  // VAUX1 (channel 0x11 = 17 decimal)
                    out_aux_1 <= data >> 2;  // shift to get 12-bit value in [15:4]
                    valid_1   <= 1'b1;
                end

                5'h18: begin  // VAUX8 (channel 0x18 = 24 decimal)
                    out_aux_8 <= data >> 2;  // shift to get 12-bit value in [15:4]
                    valid_8   <= 1'b1;
                end

                5'h19: begin  // VAUX9 (channel 0x19 = 25 decimal)
                    out_aux_9 <= data >> 2;
                    valid_9   <= 1'b1;
                end

                default: begin
                    // Ignore unknown channels (e.g., system channels)
                end
            endcase
        end
    end
end

endmodule