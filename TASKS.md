# Development Tasks

## Python Interface To-Do List

### High Priority
- [ ] Script to load bitstream onto Red Pitaya (`load_bitfile.py` or extend `redpitaya_filter.py`)
- [ ] Script to write filter coefficients via AXI GPIO (or future axi_hub) (`load_coeff.py`)
- [] Script to write coefficients via AXI4 no GPIO (when axi wrapper is done)



### MED Priority
 - [] Script to read timetraces when works in hardware
- [ ] Script to read back filter state or output for verification

### Low Priority
- [ ] Create a GUI for filter configuration
- [ ] Add example Jupyter notebook for interactive filter design and testing
- [ ] Add real-time plotting of filter response
- [ ] Add support for multiple Red Pitaya devices

## Hardware/RTL Tasks

### Current
- [ ] make axi hub wrapper for filters, so that no need of setting many gpios
- [] make code for reading out timetracers from in and out, ... save data to registers? ram? use scope from pavel denim?

 
### Future

- [ ] Add PID controller modules
- [ ] Add FIR filter options
- [ ] Optimize timing constraints for higher sample rates
- [ ] Add support for dual-channel filtering

## Documentation
- [ ] Add detailed setup instructions for Red Pitaya environment
- [ ] Document filter coefficient calculation methods
- [ ] Add example filter designs and test cases
- [ ] Create getting started tutorial