

## Vivado

- SmartConnect takes a lot of LUT, AXI Interconnect much less
- AXI Interconnect doesn't handle automatic word length, go to advanced options
- AXI Interconnectcant handle different size words on slave/master, choose. so if using that can have direct acces to bram, maybe.
- CDMA data path (BRAM ctrl + DDR) needs SmartConnect; control path (CDMA lite + module regs) can use the lighter AXI Interconnect. Mixing the two saves resources on the xc7z010.
- Timing failures on `axi_interconnect` crossbar: add register slices (`CONFIG.MXX_HAS_REGSLICE {1}`) or remove unused master ports to shrink the crossbar.
- Hierarchy procs (`create_hier_cell_*`) must be added live in the GUI via `source` + proc call — pasting the call into `bd.tcl` fails `validate_bd_design` because boundary pins (clocks, resets) aren't wired yet.

## Verilog

- Don't drive the same `reg` array from two `always` blocks (e.g. writable regs in one, read-only status in another). Synthesis silently drops one driver. Merge into a single `always` block.

