// xadc_1ch: XADC reading VAUX8 (AI0 on Red Pitaya E2 header)
// Red Pitaya E2: AI0 -> VAUX8 (ch 0x18) on pins B19/A20
// Output: out_aux_0[11:0] = data[15:4], voltage = out_aux_0 / 4096 V

module xadc_1ch (
    input  wire        clk,
    input  wire        rst,

    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux8 V_P" *)
    input  wire        vaux8_p,
    (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux8 V_N" *)
    input  wire        vaux8_n,

    output reg  [15:0] out_aux_0,
    output reg         valid,

    // Debug outputs
    output reg  [4:0]  dbg_channel,
    output reg  [15:0] dbg_raw,
    output reg  [9:0]  dbg_cycles_per_sample,
    output reg         dbg_drdy
);

wire [4:0]  channel;
wire [15:0] data;
wire        eoc, drdy;
reg [9:0] cycle_counter = 0;

XADC #(
    .INIT_40(16'h0018),  // Channel selection: VP/VN : 0x00, VCCINT : 0x01, VCCAUX : 0x02, VAUX0 : 0x10, VAUX1 : 0x11, VAUX8 : 0x18, VAUX9 : 0x19
    .INIT_41(16'h3000),  // SEQ[15:12]=0011 (single channel), unipolar
    .INIT_42(16'h0500),  // DCLK divider = 5 -> 25 MHz from 125 MHz input. Divider 4, and 3 also, 2 doesnt anymore. will use 5 for safety.  
    .INIT_48(16'h0100)   // Enable VAUX8 in sequencer (bit 8)
) xadc (
    .DCLK(clk),
    .RESET(rst),

    .EOC(eoc),
    .DRDY(drdy),
    .CHANNEL(channel),

    .DEN(eoc),           // Re-enable EOC-triggered reads 
    .DADDR(7'h18),       // Read VAUX8 status register VP/VN = 0x00, VCCINT = 0x01, VCCAUX = 0x02, VAUX0 : 0x10, VAUX1 : 0x11, VAUX8 : 0x18, VAUX9 : 0x19
    .DO(data),

    .VP(1'b0),
    .VN(1'b0),

    .VAUXP({7'b0, vaux8_p, 8'b0}),  // VAUX8 is bit 8
    .VAUXN({7'b0, vaux8_n, 8'b0})
);

always @(posedge clk) begin
    valid    <= 1'b0;
    dbg_drdy <= 1'b0;

    if (rst) begin
        out_aux_0   <= 0;
        dbg_channel <= 0;
        dbg_raw     <= 0;
        cycle_counter <= 0;  // Start from 0 (conventional)
        dbg_cycles_per_sample <= 0;
        
    end else begin

        cycle_counter <= cycle_counter + 1;  // Always count clocks

        if (drdy) begin
            dbg_drdy    <= 1;
            dbg_channel <= channel;
            dbg_raw     <= data;
            dbg_cycles_per_sample <= cycle_counter + 1;  // +1 to get true cycle count
            cycle_counter <= 0;  // Reset to 0 at data ready
            
            if (channel == 5'h18) begin  // Only output valid data for VAUX8
                out_aux_0 <= data >> 2;
                valid     <= 1;
            end
        end
    end
end

endmodule