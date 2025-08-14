# Red Pitaya Custom Filter Project

## Overview

This repository is a streamlined Red Pitaya filter design environment, based on Pavel Demin's "template" project. It enables rapid prototyping and deployment of custom digital filters (IIR, FIR, integrator, etc.) on the Red Pitaya Zynq 7010 platform.

### Key Features

- **Vivado Block Design**: Start from the `template` XPR project, save as your new project, and modify as needed.
- **Custom RTL**: All new Verilog modules (filters, integrators, etc.) are in `rtl/`. ADC/DAC modules are copied from Pavel's repo into `cores/` and added as source files, not prebuilt IP.
- **Constraints**: Custom timing and pin constraints are in `constr/`.
- **Python Interface**: Scripts in `python/` allow you to load bitstreams, set filter coefficients, and interact with the Red Pitaya from your PC.

### Directory Structure

```
cores/      # ADC/DAC/top-level modules (Verilog)
rtl/        # Custom filter/integrator modules (Verilog)
verilog/    # Reference and experimental Verilog modules
constr/     # Custom XDC constraints
projects/   # Vivado project folders (copy template, rename, edit)
python/     # Scripts for bitstream loading, coefficient control, etc.
temp_python/# Experimental Python scripts/notebooks
temp_verilog# Experimental Verilog modules
```

## Workflow

1. **Vivado Design**
   - Open the XPR project in `projects/template` or the closest match.
   - Save as your new project name (e.g., `iir2nd_direct_gpio`).
   - Add/modify RTL modules from `rtl/` and `cores/`.
   - Add constraints from `constr/`.
   - Build the bitstream.

2. **Python Control**
   - Use scripts in `python/` to load the bitstream, set coefficients, and interact with the filter hardware.

## Getting Started

1. Clone this repository
2. Open Vivado and load an existing project from `projects/` as a starting point
3. Save the project with your new name
4. Modify the block design and add your custom RTL from `rtl/`
5. Build and deploy to Red Pitaya
6. Use Python scripts to control and test your design

See `TASKS.md` for current development tasks and Python interface to-do items.