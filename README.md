# Red Pitaya Custom DSP FPGA

Custom digital-signal-processing designs for the Red Pitaya (Zynq **xc7z010clg400-1**,
Vivado **2024.1**), based on Pavel Demin's template flow. Filters (IIR/FIR),
PID, integrator, multichannel-analyzer (peak finder + histogram) and streaming
front-ends, each built as a Vivado block design around shared RTL.

Python control, bitfiles and register maps live in the companion repo
**redpitaya_control**.

## Structure

```
cores/     Foundational Verilog: ADC, DAC, XADC, BRAM interface (mostly Pavel Demin's)
rtl/       Custom modules + their AXI wrappers: filters, PID, integrator,
           MCA (peak_detector, peak_height_binning), streaming (stream4/8channel)
constr/    XDC constraints: pin map (ports), clocks, timing relaxation
projects/  One folder per design. Only projects/<name>/bd.tcl is tracked -- the
           block-design recipe. All Vivado-generated files are gitignored.
scripts/   Headless Tcl to export / regenerate / build projects (see scripts/README.md)
```

## Source of truth

A design is fully described by four tracked things: `rtl/` + `cores/` + `constr/`
+ its `projects/<name>/bd.tcl`. Everything else under `projects/<name>/` (the
`.xpr`, `.gen`, `.runs`, caches, bitstream) is generated and rebuilt on demand,
so it is gitignored. This means any design can be reconstructed from git on any
machine — no Vivado project directory needs to be committed or backed up.

The block design (`system.bd`) is the single file behind everything you see in
the Vivado GUI: block wiring lives in its `nets` sections, and the Address
Editor assignments live in its `address_spaces`/`segments`. `bd.tcl` is a text
recipe that regenerates it.

## Workflow

See [scripts/README.md](scripts/README.md) for the full commands. In short:

1. **Capture** a project into git once: `export_bd.tcl` writes `projects/<name>/bd.tcl`.
2. **Regenerate** the Vivado project anytime: `make_project.tcl` rebuilds it from the recipe.
3. **Edit** in the GUI as usual; when done, re-run `write_bd_tcl` and commit the diff.
4. **Build**: `build.tcl` produces the bitstream; copy it into `redpitaya_control/bitfiles/`.

## Notes

- `bd/` at the repo root is a legacy hand-committed copy of one design's block
  design; it is superseded by the per-project `bd.tcl` recipes and will be removed
  once that project is captured.
- The register addresses in each block design's Address Editor are the source
  of the `base` addresses in the `redpitaya_control` JSON configs — keep the two
  in sync when you move a register.

See `TASKS.md` and `LESSONSLEARNED.md` for ongoing work and gotchas.
