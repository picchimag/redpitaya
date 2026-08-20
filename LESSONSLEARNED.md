

## Vivado

- SmartConnect takes a lot of LUT, AXI Interconnect much less
- AXI Interconnect doesn't handle automatic word length, go to advanced options
- AXI Interconnectcant handle different size words on slave/master, choose. so if using that can have direct acces to bram, maybe.
- CDMA data path (BRAM ctrl + DDR) needs SmartConnect; control path (CDMA lite + module regs) can use the lighter AXI Interconnect. Mixing the two saves resources on the xc7z010.
- Timing failures on `axi_interconnect` crossbar: add register slices (`CONFIG.MXX_HAS_REGSLICE {1}`) or remove unused master ports to shrink the crossbar.
- Hierarchy procs (`create_hier_cell_*`) must be added live in the GUI via `source` + proc call — pasting the call into `bd.tcl` fails `validate_bd_design` because boundary pins (clocks, resets) aren't wired yet.
- **Editing an `rtl/*.v` behind a module-reference block does NOT invalidate that block's out-of-context synthesis run.** `build.tcl` (`reset_run impl_1`) re-runs the top synth, which then just black-boxes the module-reference stub and links the *stale* `.dcp` — you get a bitstream mixing new top-level logic with an old module, silently. Re-run `make_project.tcl` (it wipes `build/`) before `build.tcl` after any RTL edit. To check an existing build, compare mtimes of `build/<proj>.runs/synth_1/` against `build/<proj>.runs/system_<module>_0_0_synth_1/`; the latter being older means the bitstream is stale. Bit us on the event_logger veto change (2026-08-20): the shipped `.bit` had the pre-veto record layout, which showed up on the host as chB appearing where the veto bit should be and an energy axis off by 2×.

## Verilog

- Don't drive the same `reg` array from two `always` blocks (e.g. writable regs in one, read-only status in another). Synthesis silently drops one driver. Merge into a single `always` block.

