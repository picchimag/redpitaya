# Creating a New Project from a Template

Every design is defined by one file: `projects/<name>/bd.tcl` (the block-design
recipe), plus the shared `rtl/`, `cores/`, `constr/`. Everything under
`projects/<name>/build/` is generated and gitignored. So "make a new project
from an old one" = **copy the recipe, regenerate, edit, save the recipe back.**

Replace `<template>` (the project you're copying) and `<name>` (the new one).

## 1. Seed the recipe from a template

```bash
mkdir -p projects/<name>
cp projects/<template>/bd.tcl projects/<name>/bd.tcl
```

The recipe is portable — its block design is internally named `system`, not tied
to the template's project name — so the copy needs no editing.

## 2. Generate the Vivado project

```bash
vivado -mode batch -source scripts/make_project.tcl -tclargs <name>
```

This builds `projects/<name>/build/<name>.xpr` from the recipe (adds all of
`rtl/` + `cores/` + `constr/`, rebuilds the block design). At this point `<name>`
is an exact copy of `<template>`.

> `make_project.tcl` **only** rebuilds from an existing `bd.tcl`. If that file
> isn't there it errors out ("no recipe ... export it first") — it never copies
> a template or makes an empty project for you. Step 1 is what creates the seed.

## 3. Edit in the GUI

Open `projects/<name>/build/<name>.xpr` in Vivado. Add/remove modules, wire the
block design, set addresses in the Address Editor.

New `.v` files dropped in `rtl/` are picked up automatically on regenerate — you
just instantiate them as `create_bd_cell -type module -reference <module_name>`
(or via Add Module in the GUI).

## 4. Save your edits back to the recipe

The `build/` folder is disposable; your work isn't saved until the recipe is
rewritten. In the Vivado **Tcl console**:

```
write_bd_tcl -force -include_layout projects/<name>/bd.tcl
```

Commit that `bd.tcl` — it's the only tracked output. Until you run this, `<name>`
is byte-identical to the template in git.

## 5. Build and deploy

```bash
vivado -mode batch -source scripts/build.tcl -tclargs <name>
cp projects/<name>/<name>.bit ../redpitaya_control/bitfiles/
```

## Adding an existing hierarchy to a project

If you have a reusable hierarchy proc (e.g. in `scripts/hier_cdma_drain.tcl`),
add it **live in the GUI** — don't paste the call into `bd.tcl`.

With the block design open in Vivado, run in the **Tcl console**:

```
source C:/Users/magrini/Documents/programming/redpitaya_fpga/scripts/hier_cdma_drain.tcl
create_hier_cell_data_stream [current_bd_instance .] data_stream
```

Replace `create_hier_cell_data_stream` / `data_stream` with the proc and
instance name you need (e.g. `create_hier_cell_event_log` / `event_log`).

After the hierarchy appears, wire its boundary pins (clocks, resets, data)
in the GUI, then save the recipe as usual (step 4).

> **Why not paste the call into bd.tcl directly?** `make_project.tcl` runs
> `validate_bd_design` after sourcing the recipe. A hierarchy with unwired
> mandatory pins (e.g. `s_axi_aclk`) fails validation and the whole project
> generation aborts. Adding it live in the GUI lets you wire the pins before
> any validation runs.

## Notes

- **Round-trip check** for anything with CDMA / BRAM / smartconnect:
  `write_bd_tcl` occasionally mangles those IP configs. After exporting,
  regenerate from the recipe and diff the block design before trusting it.
- **Flaky batch runs:** a headless Vivado session can throw
  `Could not create slave interpreter 'rodin:slave0'` or an axi4 rule error.
  It's not a real defect — just re-run the same command once.
- **Alternative to steps 1–2:** regenerate the template, then Vivado
  **File → Save Project As → `<name>`**. Same result; steps 1–2 just do it
  headlessly.
