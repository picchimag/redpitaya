`timescale 1 ns / 1 ps

// XPM library directive
(* DONT_TOUCH = "TRUE" *)

module bram_interface #(
  parameter integer DATA_WIDTH = 64,       // Data width in bits
  parameter integer ADDR_BITS = 12,    // depth per port = 2^ADDR_BITS words
  parameter integer AXI_ADDR_BITS = 15    // AXI byte address width 2^ADDR_BITS * DATAWIDTH/8 (2048 words × 8 bytes = 16KB)

)(
  // ---------------- Port A (to AXI BRAM Controller) ----------------
  input  wire                     clka,
  input  wire                     rsta,
  input  wire                     ena,
  input  wire [DATA_WIDTH/8-1:0]  wea,      // byte write enable
  input  wire [AXI_ADDR_BITS-1:0] addra_axi, // AXI byte address
  input  wire [DATA_WIDTH-1:0]    dina,
  output wire [DATA_WIDTH-1:0]    douta,

  // ---------------- Port B (to your stream module) ----------------
  input  wire                     clkb,
  input  wire                     enb,
  input  wire [DATA_WIDTH/8-1:0]  web,      // byte write enable
  input  wire [ADDR_BITS-1:0]     addrb,
  input  wire [DATA_WIDTH-1:0]    dinb,
  output wire [DATA_WIDTH-1:0]    doutb
);

  // Calculate byte width and address shift
  localparam integer BYTE_WIDTH = DATA_WIDTH / 8;
  localparam integer ADDR_SHIFT = $clog2(BYTE_WIDTH);  // = 3 for 64-bit (8 bytes)
  
  // Convert AXI byte address to word address by shifting
  wire [ADDR_BITS-1:0] addra = addra_axi[ADDR_SHIFT +: ADDR_BITS];  // Take bits [13:3]

  localparam integer MEM_BITS = (1 << ADDR_BITS) * DATA_WIDTH;
  
  

  // XPM true dual-port block RAM
  xpm_memory_tdpram #(
    .MEMORY_SIZE        (MEM_BITS),      // bits
    .MEMORY_PRIMITIVE   ("block"),
    .CLOCKING_MODE      ("independent_clock"),
    .WRITE_MODE_A       ("no_change"),
    .WRITE_MODE_B       ("no_change"),
    .USE_MEM_INIT       (0),
    .MEMORY_INIT_FILE   ("none"),
    .MEMORY_INIT_PARAM  ("0"),
    .ECC_MODE           ("no_ecc"),
    .AUTO_SLEEP_TIME    (0),
    .WRITE_PROTECT      (1),
    .READ_RESET_VALUE_A ("0"),
    .READ_RESET_VALUE_B ("0"),
    .READ_LATENCY_A     (1),
    .READ_LATENCY_B     (1),

    .ADDR_WIDTH_A       (ADDR_BITS),
    .ADDR_WIDTH_B       (ADDR_BITS),
    .READ_DATA_WIDTH_A  (DATA_WIDTH),
    .WRITE_DATA_WIDTH_A (DATA_WIDTH),
    .READ_DATA_WIDTH_B  (DATA_WIDTH),
    .WRITE_DATA_WIDTH_B (DATA_WIDTH),
    .BYTE_WRITE_WIDTH_A (8),
    .BYTE_WRITE_WIDTH_B (8)
  ) u_ram (
    // Port A
    .clka   (clka),
    .rsta   (1'b0),
    .ena    (ena),
    .wea    (wea),
    .addra  (addra),
    .dina   (dina),
    .douta  (douta),
    .regcea (1'b1),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),

    // Port B
    .clkb   (clkb),
    .rstb   (1'b0),
    .enb    (enb),
    .web    (web),
    .addrb  (addrb),
    .dinb   (dinb),
    .doutb  (doutb),
    .regceb (1'b1),
    .injectsbiterrb (1'b0),
    .injectdbiterrb (1'b0),
    .sleep  (1'b0),

    // Unused parity signals
    .dbiterrb(), .sbiterrb(), .dbiterra(), .sbiterra()
  );

endmodule
