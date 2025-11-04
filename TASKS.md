# Development Tasks

## MCA (Multi-Channel Analyzer) Tasks

### **HIGHEST PRIORITY - Timing Issue Root Cause**
- [ ] **CRITICAL: Timing issue is NOT in peak_detector, but in binning module!**
  - [ ] Vivado timing report blames `peak_value_out` register in peak_detector
  - [ ] However: compiling with NO binning module and `peak_value_out` connected directly to DAC works perfectly with good timing
  - [ ] **Root cause is likely at binning module input interface**
  - [ ] Consider adding input buffer/pipeline stage at binning module input
  - [ ] May need to add register stage for `peak_value_in` or `peak_valid_in` signals
  - [ ] Investigate if combinatorial path from peak_detector output through binning module is the actual critical path

### High Priority - Peak Height Binning
- [ ] Modify gain format in `peak_height_binning.v`:
  - [ ] Add parameter `GAIN_WIDTH = 16`
  - [ ] Add parameter `LOG_UNITY_GAIN = GAIN_WIDTH/2` (=8, so unity gain = 256 = 0x0100)
  - [ ] Allow gain range from 0 to 255 (with unity at 256)
  - [ ] After multiplication, select bits `[DATA_WIDTH+LOG_UNITY_GAIN -1: LOG_UNITY_GAIN]`
  - [ ] Add pipeline stage for multiplication to improve timing

### High Priority - Peak Detector
- [ ] Investigate timing issues in `peak_detector.v`
- [ ] Consider adding fixed shift for integral attenuation to help timing
- [ ] Evaluate if barrel shifter is causing timing problems

### Medium Priority
- [ ] Test MCA histogram accumulation and readout
- [ ] Verify gain scaling with different test signals
- [ ] Optimize BRAM access timing

## Python Interface To-Do List

### High Priority
### MED Priority
- [ ] Script to read timetraces when works in hardware

### Low Priority
- [ ] Create a GUI for filter configuration
- [ ] Add example Jupyter notebook for interactive filter design and testing
- [ ] Add real-time plotting of filter response
- [ ] Add support for multiple Red Pitaya devices
