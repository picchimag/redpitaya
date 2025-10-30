from redpitaya_base import redpitaya_base
from compute_coeff import *
import os, json, time
import numpy as np


class redpitaya_dev():
    def __init__(self, host, config_file, user='root', pwd='root'):

        # Resolve bitfile path relative to redpitaya module directory
        module_dir = os.path.dirname(os.path.abspath(__file__))
        config_file = os.path.join(module_dir, config_file)
        
        with open(config_file, "r") as f:
            cfg = json.load(f)
       
        self.modules = cfg.get("modules",{})
        self.info = cfg.get("info", {})
        
        
        bit_file = cfg.get("bitfile", "")
        bit_file = os.path.join(module_dir, bit_file)

        self.base = redpitaya_base(host, bit_file, user, pwd)
        self.base.connect()

    def close(self):
        self.base.disconnect()

    def list_modules(self):
        return list(self.modules.keys())
    
    def list_registers(self, module):
        return list(self.modules[module]["registers"].keys())

    def get_register(self, module, register, raw=False):

        id  = self.modules[module]["registers"][register]
        reg = self.base.read_reg(id["base"], id["offset"], id["msb"], id["lsb"], id["signed"])

        if raw or ("log_scale" not in id):
            return reg
        else:
            return reg / (2**id["log_scale"])
        
    def set_register(self, module, register, value, raw=False):
        id  = self.modules[module]["registers"][register]
        if raw or ("log_scale" not in id):
            val = int(value)
        else:
            val = int(value * (2**id["log_scale"]))
        
        self.base.write_reg(id["base"], id["offset"], id["msb"], id["lsb"], val)

    def get_all_registers(self, module, raw=False):

        regs = {}
        for reg_name in self.modules[module]["registers"].keys():
            regs[reg_name] = self.get_register(module, reg_name, raw = raw)
        return regs
    
    def set_all_registers(self, module, values, raw=False, reset = False):   
        if reset:
            self.enable(module, False)
        for reg_name, val in values.items():
            self.set_register(module, reg_name, val, raw = raw)
        self.enable(module, True)
         
    
    def reset(self, module, register="reset"):
        self.set_register(module, register, 1, raw=True)
        time.sleep(0.001)
        self.set_register(module, register, 0, raw=True)

    def enable(self, module, enabled=True):
        if enabled:
            self.set_register(module, "reset", 0, raw=True)
        else:
            self.set_register(module, "reset", 1, raw=True)

    def zero_all_registers(self, module):
        for register in self.modules[module]["registers"].keys():
            self.set_register(module, register, 0, raw=True)

    def read_register_list(self, module, address_register, data_register, start_addr=0, end_addr=1023):

        num_addrs = end_addr - start_addr + 1
        data = np.zeros(num_addrs, dtype=np.uint32)
        
        for i, addr in enumerate(range(start_addr, end_addr + 1)):
            self.set_register(module, address_register, addr, raw=True)
            data[i] = self.get_register(module, data_register, raw=True)
            
        return data

    def read_sequential_axi_data(self, module, address_register, data_register, start_addr=0, end_addr=1023):
        """
        Fast sequential AXI data readout using existing SSH connection.
        Much faster than individual network register reads for large datasets.
        
        Args:
            module: Module name (e.g., "histogram")
            address_register: Register name for address selection (e.g., "read_address")
            data_register: Register name for data readout (e.g., "read_data")
            start_addr: Starting address (default 0)
            end_addr: Ending address (default 1023)
            
        Returns:
            numpy array of uint32 values
        """
        # Get register information
        addr_reg = self.modules[module]["registers"][address_register]
        data_reg = self.modules[module]["registers"][data_register]
        
        # Calculate full addresses
        addr_base = int(addr_reg["base"], 16)
        sel_off = addr_reg["offset"]
        data_off = data_reg["offset"]
        
        N = end_addr - start_addr + 1
        
        # Create Python script for remote execution
        script = f"""python3 -c "
import mmap, os, struct, sys
BASE={addr_base}
SPAN=0x1000
SEL_OFF={sel_off}
DATA_OFF={data_off}
N={N}
START_ADDR={start_addr}

try:
    fd=os.open('/dev/mem', os.O_RDWR|os.O_SYNC)
    m=mmap.mmap(fd, SPAN, mmap.MAP_SHARED, mmap.PROT_READ|mmap.PROT_WRITE, offset=BASE)
    
    def w32(off, val):
        m.seek(off); m.write(struct.pack('<I', val))
    
    def r32(off):
        m.seek(off); return struct.unpack('<I', m.read(4))[0]
    
    out = []
    for i in range(N):
        w32(SEL_OFF, START_ADDR + i)
        out.append(r32(DATA_OFF))
    
    print(','.join(str(v) for v in out))
    m.close(); os.close(fd)
except Exception as e:
    print('ERROR:', str(e), file=sys.stderr)
" """
        
        # Execute using existing SSH connection
        try:
            csv_output = self.base._sh(script)
            
            # Parse CSV results
            if csv_output and not csv_output.startswith('ERROR:'):
                values = [int(x) for x in csv_output.strip().split(',')]
                return np.array(values, dtype=np.uint32)
            else:
                print("Remote execution error:", csv_output)
                return None
                
        except Exception as e:
            print(f"SSH execution failed: {e}")
            return None
    

if __name__ == "__main__":
    # Simple MCA example
    import numpy as np
    import matplotlib.pyplot as plt
    
    # Connect to RedPitaya with MCA configuration
    dev = redpitaya_dev("171.64.56.120", "config/mca_simple.json")  # Change IP as needed
    
    print("Available modules:", dev.list_modules())
    
    # Configure the signal processing chain
    print("\n1. Configuring IIR1 (high-pass filter)...")
    dev.set_register("iir1", "b0", 0.99)      # High-pass coefficients
    dev.set_register("iir1", "b1", -0.99)
    dev.set_register("iir1", "a1", -0.98)
    
    print("2. Configuring FIR9 (shaping filter)...")
    # Gaussian-like shaping filter
    h_coeffs = [0.05, 0.1, 0.2, 0.3, 0.4, 0.3, 0.2, 0.1, 0.05]
    for i, h in enumerate(h_coeffs):
        dev.set_register("fir9", f"h{i}", h)
    
    print("3. Configuring peak detector...")
    dev.set_register("peak_detector", "invert_input", 0)     # 0=positive peaks, 1=negative peaks  
    dev.set_register("peak_detector", "trig_level", 1000)    # Trigger threshold
    dev.set_register("peak_detector", "base_return", 100)    # Baseline return
    dev.set_register("peak_detector", "dead_time", 1000)     # Dead time (samples)
    dev.set_register("peak_detector", "n_integration", 64)   # Integration window
    
    print("4. Configuring histogram...")
    dev.set_register("histogram", "offset", 0)               # No offset
    dev.set_register("histogram", "gain", 1)                 # No gain scaling
    dev.set_register("histogram", "band_low", 0)             # Accept all energies
    dev.set_register("histogram", "band_high", 32767)        # Max range
    
    # Clear histogram and start counting
    print("5. Starting measurement...")
    dev.set_register("histogram", "clear_bins", 1)           # Clear bins
    dev.set_register("histogram", "clear_bins", 0)
    dev.set_register("histogram", "counting_enable", 1)      # Enable counting
    
    # Wait for some data collection
    print("6. Collecting data for 10 seconds...")
    time.sleep(10)
    
    # Read histogram
    print("7. Reading histogram...")
    histogram = dev.read_register_list("histogram", "read_address", "read_data", 0, 1023)
    
    # Display results
    print(f"Total counts: {np.sum(histogram)}")
    print(f"Peak channel: {np.argmax(histogram)}")
    print(f"Max counts in peak: {np.max(histogram)}")
    
    # Plot histogram
    plt.figure(figsize=(10, 6))
    plt.plot(histogram)
    plt.xlabel('Channel')
    plt.ylabel('Counts')
    plt.title('Nuclear Spectroscopy Histogram')
    plt.grid(True)
    plt.show()
    
    # Check status
    print("\n8. System status:")
    print(f"Peak detector state: {dev.get_register('peak_detector', 'state_out', raw=True)}")
    print(f"Histogram overflow: {dev.get_register('histogram', 'overflow_flag', raw=True)}")
    print(f"Data ready: {dev.get_register('histogram', 'data_ready', raw=True)}")
    
   #dev.close()
    print("Done!")
