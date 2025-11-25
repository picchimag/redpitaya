

## Live streaming

### Verilog module

- [ ] Optimize BRAM access timing
- [ ] use dma for faster stream

### Python Interface To-Do List

- [ ] Script to read timetraces when works in hardware
- [x] CDMA-based fast acquisition working (8-9 Hz with live plot, 21 Hz raw)
- [ ] Create optimized redpitaya_base functions:
  - [ ] `read_cdma_frame`: Arm capture, smart wait (only if acquisition_time > 1ms), CDMA transfer via base64/SSH, return data
  - [ ] `setup_cdma(sampling_frequency, frame_len, n_of_frames)`: Configure CDMA once, calculate/return actual sampling freq & frame time based on log_div quantization
- [ ] make little app that plots live timetrace and spectrum, allows setting of scale, sampling rate, averaging...
  - [ ] Enhanced live plot with PSD:
    - Top: 4-channel time-domain (with matplotlib blitting for speed)
    - Bottom: Power Spectral Density with averaging over N frames
    - Controls: averaging window, frequency zoom, save data/screenshots
  - [ ] Simple GUI app:
    - Start/Stop acquisition, sampling frequency selector, frame length selector
    - Live plot display (time + PSD), frame rate indicator
    - Save configuration/data options
    - Consider tkinter (simple) or PyQt (more features)



## Noise performance improvement

### Verilog Module
 - [ ] make CIC decimator (3rd order, LOG_DIV)
 - [ ] make CIC interpolator


  
PS C:\Users\magrini\Documents\programming\redpitaya> git commit -m "Added mca, works; Added sreaming functionality through dma on feedbacks, works; fixe saturation of filers and pid outputs, now works (as long as the internal state does not saturate!); restructured the python module, now its installable, "