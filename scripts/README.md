# Build scripts

Vivado projects are treated as disposable build output. The single source of
truth for each project is `projects/<name>/bd.tcl` (the block-design recipe),
together with the shared `rtl/`, `cores/` and `constr/` directories. Everything
else under `projects/<name>/` is generated and gitignored.

All scripts run headless: `vivado -mode batch -source scripts/<script>.tcl -tclargs <project_name>`.

## One-time: capture a legacy project into git

```
vivado -mode batch -source scripts/export_bd.tcl -tclargs mca_simple_1ch
```

Opens the existing `projects/mca_simple_1ch/mca_simple_1ch.xpr`, writes
`projects/mca_simple_1ch/bd.tcl`, and closes. Commit that file. Repeat per
project. Validate the round-trip (below) for at least the tricky designs before
trusting it.

## Regenerate a project from its recipe

```
vivado -mode batch -source scripts/make_project.tcl -tclargs mca_simple_1ch
```

Creates `projects/mca_simple_1ch/build/mca_simple_1ch.xpr` from scratch: adds
`rtl/` + `cores/` + `constr/`, rebuilds the block design from `bd.tcl`,
generates and imports the wrapper, sets it as top. Open that `.xpr` in the GUI
to work as usual.

## Build a bitstream

```
vivado -mode batch -source scripts/build.tcl -tclargs mca_simple_1ch
```

Runs implementation to `write_bitstream` and stages the result at
`projects/mca_simple_1ch/mca_simple_1ch.bit`. Copy that into the
`redpitaya_control` repo's `bitfiles/` directory.

## Validate a round-trip

After exporting, confirm the recipe reproduces the design:

```
vivado -mode batch -source scripts/make_project.tcl -tclargs mca_simple_1ch
```

Open the regenerated project, compare the block design against the original,
and (ideally) build and diff the bitstream. `write_bd_tcl` occasionally mangles
unusual IP configuration, so this check matters most for the streaming (CDMA /
BRAM) and z_control_v* projects.

## Everyday workflow

- **New design:** regenerate (or GUI Save As) a starting project, edit the block
  design and add modules in the GUI, build. When done, in the Tcl console run
  `write_bd_tcl -force -include_layout projects/<name>/bd.tcl` and commit.
- **Modify a design:** open the regenerated project, edit, rebuild, then re-run
  `write_bd_tcl -force` and commit the diff.
