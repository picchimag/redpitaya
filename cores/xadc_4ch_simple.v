// xadc_4ch_simple: Four independent single-channel XADC instances
// Based on proven aux_adc.v design for each channel
// Much more reliable than fighting with the automatic sequencer

module xadc_4ch_simple (
    input  wire        clk,
    input  wire        rst,

    // Channel inputs
    input  wire        vaux0_p, vaux0_n,
    input  wire        vaux1_p, vaux1_n, 
    input  wire        vaux8_p, vaux8_n,
    input  wire        vaux9_p, vaux9_n,

    // Data outputs
    output wire [15:0] out_vaux0,
    output wire [15:0] out_vaux1, 
    output wire [15:0] out_vaux8,
    output wire [15:0] out_vaux9,
    
    // Valid flags
    output wire        valid_vaux0,
    output wire        valid_vaux1,
    output wire        valid_vaux8, 
    output wire        valid_vaux9,

    // Debug outputs (from VAUX8 instance)
    output wire [4:0]  dbg_channel,
    output wire [15:0] dbg_raw,
    output wire [9:0]  dbg_cycles_per_sample,
    output wire        dbg_drdy
);

// VAUX0 instance (modify aux_adc to read VAUX0)
aux_adc_single #(.VAUX_CHANNEL(16'h0010), .INIT_48_VAL(16'h0001)) adc_vaux0 (
    .clk(clk), .rst(rst),
    .vaux_p(vaux0_p), .vaux_n(vaux0_n),
    .out_aux(out_vaux0), .valid(valid_vaux0)
);

// VAUX1 instance 
aux_adc_single #(.VAUX_CHANNEL(16'h0011), .INIT_48_VAL(16'h0002)) adc_vaux1 (
    .clk(clk), .rst(rst),
    .vaux_p(vaux1_p), .vaux_n(vaux1_n),
    .out_aux(out_vaux1), .valid(valid_vaux1)
);

// VAUX8 instance (with debug outputs)
aux_adc_single #(.VAUX_CHANNEL(16'h0018), .INIT_48_VAL(16'h0100)) adc_vaux8 (
    .clk(clk), .rst(rst),
    .vaux_p(vaux8_p), .vaux_n(vaux8_n),
    .out_aux(out_vaux8), .valid(valid_vaux8),
    .dbg_channel(dbg_channel), .dbg_raw(dbg_raw),
    .dbg_cycles_per_sample(dbg_cycles_per_sample), .dbg_drdy(dbg_drdy)
);

// VAUX9 instance
aux_adc_single #(.VAUX_CHANNEL(16'h0019), .INIT_48_VAL(16'h0200)) adc_vaux9 (
    .clk(clk), .rst(rst),
    .vaux_p(vaux9_p), .vaux_n(vaux9_n),
    .out_aux(out_vaux9), .valid(valid_vaux9)
);

endmodule

// Parameterized version of your working single-channel design
module aux_adc_single #(
    parameter [15:0] VAUX_CHANNEL = 16'h0018,  // Default to VAUX8
    parameter [15:0] INIT_48_VAL = 16'h0100    // Default to bit 8
) (
    input  wire        clk,
    input  wire        rst,
    input  wire        vaux_p,
    input  wire        vaux_n,
    output reg  [15:0] out_aux,
    output reg         valid,
    // Optional debug outputs (only connect for one instance)
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
    .INIT_40(VAUX_CHANNEL),      // Channel selection: parameterized
    .INIT_41(16'h3000),          // Single channel mode (proven to work)
    .INIT_42(16'h0500),          // DCLK divider = 5 -> 25 MHz
    .INIT_48(INIT_48_VAL)        // Enable this VAUX channel
) xadc (
    .DCLK(clk),
    .RESET(rst),
    .EOC(eoc),
    .DRDY(drdy),
    .CHANNEL(channel),
    .DEN(eoc),
    .DADDR(channel),
    .DO(data),
    .VP(1'b0), .VN(1'b0),
    .VAUXP({15'b0, vaux_p}),  // Single channel input
    .VAUXN({15'b0, vaux_n})
);

always @(posedge clk) begin
    valid <= 1'b0;
    if (dbg_drdy) dbg_drdy <= 1'b0;

    if (rst) begin
        out_aux <= 0;
        cycle_counter <= 0;
        if (dbg_cycles_per_sample) dbg_cycles_per_sample <= 0;
        if (dbg_channel) dbg_channel <= 0;
        if (dbg_raw) dbg_raw <= 0;
    end else begin
        cycle_counter <= cycle_counter + 1;

        if (drdy) begin
            if (dbg_drdy) dbg_drdy <= 1;
            if (dbg_channel) dbg_channel <= channel;
            if (dbg_raw) dbg_raw <= data;
            if (dbg_cycles_per_sample) dbg_cycles_per_sample <= cycle_counter;
            cycle_counter <= 0;
            
            if (channel == VAUX_CHANNEL[4:0]) begin
                out_aux <= data >> 2;
                valid <= 1;
            end
        end
    end
end

endmodule