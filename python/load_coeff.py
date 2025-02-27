import paramiko
import numpy as np

class RedPitaya:

    
    modules = {

        'FIR': {
                'fir_c0': {'base_address': 0x41230000, 'offset': 0, 'msb': 31, 'lsb': 16},  #GPIO 3 0
                'fir_c1': {'base_address': 0x41230000, 'offset': 0, 'msb': 15, 'lsb': 0},   #GPIO 3 0
                'fir_c2': {'base_address': 0x41230000, 'offset': 8, 'msb': 31, 'lsb': 16},  #GPIO 3 1
                'fir_c3': {'base_address': 0x41230000, 'offset': 8, 'msb': 15, 'lsb': 0}    #GPIO 3 1
            },

        'MULT': {
            'c1': {'base_address': 0x41230000, 'offset': 0, 'msb': 31, 'lsb': 0},  #GPIO 3 0
            'c2': {'base_address': 0x41230000, 'offset': 8, 'msb': 31, 'lsb': 0},  #GPIO 3 0
        },

        'GPIO1': {
                    'in1': {'base_address': 0x41200000, 'offset': 0, 'msb': 31, 'lsb': 16},  #GPIO 3 0
                    'in2': {'base_address': 0x41200000, 'offset': 8, 'msb': 15, 'lsb': 0},  #GPIO 3 0
                    'out1': {'base_address': 0x41200000, 'offset': 8, 'msb': 31, 'lsb': 16},  #GPIO 3 0
                    'out2': {'base_address': 0x41200000, 'offset': 8, 'msb': 15, 'lsb': 0},  #GPIO 3 0
                },



       # 'IIR1': {
       #         'iir_a1': {'base_address': 0x41200000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 0 1
       #         'iir_a2': {'base_address': 0x41200000, 'offset': 8, 'msb': 31, 'lsb': 0},    #GPIO 0 2
       #         'iir_b0': {'base_address': 0x41210000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 1 1
       #         'iir_b1': {'base_address': 0x41210000, 'offset': 8, 'msb': 31, 'lsb': 0},    #GPIO 1 2
       #         'iir_b2': {'base_address': 0x41220000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 2 1
       #         'gain'  : {'base_address': 0x41220000, 'offset': 8, 'msb': 31, 'lsb': 0}     #GPIO 2 2    
       #     }

        'IIR1': {
                'iir_b0': {'base_address': 0x41200000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 0 1
                'iir_b1': {'base_address': 0x41200000, 'offset': 8, 'msb': 31, 'lsb': 0},    #GPIO 0 2
                'iir_b2': {'base_address': 0x41210000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 1 1
                'iir_a1': {'base_address': 0x41210000, 'offset': 8, 'msb': 31, 'lsb': 0},    #GPIO 1 2
                'iir_a2': {'base_address': 0x41220000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 2 1
                'gain'  : {'base_address': 0x41220000, 'offset': 8, 'msb': 30,'lsb': 0},    #GPIO 2 2
                'reset' : {'base_address': 0x41220000, 'offset': 8, 'msb': 31, 'lsb': 31}
            }



        }



    def __init__(self, hostname, username = 'root', password = 'root'):
        """Initialize with connection parameters."""
        self.hostname = hostname
        self.username = username
        self.password = password
        self.ssh = None
    
    def connect(self):
        """Establish an SSH connection to the Red Pitaya."""

        self.ssh = paramiko.SSHClient()
        self.ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        self.ssh.connect(self.hostname, username=self.username, password=self.password)
        print(f"Connected to {self.hostname}")

    
    def execute_monitor_command(self, address, value=None):
        """Execute a monitor command to control registers."""
        if value is None:
            command = f'/opt/redpitaya/bin/monitor {address}'
        else:
            command = f'/opt/redpitaya/bin/monitor {address} {value}'
        stdin, stdout, stderr = self.ssh.exec_command(command)
        # Capture output
        stdout_output = stdout.read().decode('utf-8')
        stderr_output = stderr.read().decode('utf-8')
        # Close the channel to prevent memory leaks
        stdout.channel.close()
        return stdout_output, stderr_output

    
    def close(self):
        """Close the SSH connection."""
        if self.ssh:
            self.ssh.close()
            print(f"Connection to {self.hostname} closed.")



    def set_params(self, module_name, params):
        """Set parameters for a given module."""
        if module_name not in self.modules:
            print(f"Module {module_name} not found.")
            return
        
        param_dict = self.modules[module_name]
        
        for param_name, param_value in params.items():
            
            param_info = param_dict[param_name]
            base_address = param_info['base_address']
            reg_offset = param_info['offset']
            msb = param_info['msb']
            lsb = param_info['lsb']
            address = base_address + reg_offset
            
            stdout, stderr = self.execute_monitor_command(hex(address))
           
            current_value = int(stdout, 16)
            
            mask = ((1 << (msb - lsb + 1)) - 1) << lsb
            current_value = (current_value & ~mask) | ((param_value << lsb) & mask)
            
            self.execute_monitor_command(hex(address), hex(current_value))


    def get_params(self, module_name):
        """Get parameters for a given module."""
        
        param_dict = self.modules[module_name]
        
        params = {}
        for param_name, param_info in param_dict.items():
            base_address = param_info['base_address']
            reg_offset = param_info['offset']
            msb = param_info['msb']
            lsb = param_info['lsb']
            address = base_address + reg_offset
            
            stdout, stderr = self.execute_monitor_command(hex(address))
            current_value = int(stdout, 16)
            
            mask = ((1 << (msb - lsb + 1)) - 1) << lsb
            param_value = (current_value & mask) >> lsb

            # Adjust for signed integers
            num_bits = msb - lsb + 1
            if param_value & (1 << (num_bits - 1)):
                param_value -= 1 << num_bits

            params[param_name] = param_value
        
        return params

# Example Usage
if __name__ == "__main__":
    from scipy.signal import iirfilter, freqz, bilinear, butter

    """
    sf = 1/(8e-9*4)  # Sampling frequency in Hz
    f0 = 10000  # Center frequency in Hz
    zeta = 0.1  # Bandwidth in Hz
    nyq = sf/2
    b, a = iirfilter(1, [f0/nyq-f0*zeta/nyq,f0/nyq+f0*zeta/nyq], btype='band', ftype='butter', analog=False)
    b, a = butter(1, 5000/nyq, btype='low', analog=False)
    print(a,b)
    # Convert to fixed-point representation by scaling coefficients
    scale_factor =2**31  # Scaling factor to avoid underflow/overflow in fixed-point arithmetic
    

    print(a/a[0],b/a[0])

    b = np.round(b * scale_factor).astype(int)
    a = np.round(a* scale_factor).astype(int)
    print(a/2**31, b/2**31)
    
    #iir_dict = {'iir_a1': 1, 'iir_a2': 1, 'iir_b0': 1, 'iir_b1': 2**31, 'iir_b2': 1, 'gain': 1}
    
    
    _, iir_dict['iir_a1'] = a
    iir_dict['iir_b0'], iir_dict['iir_b1'] = b
    iir_dict['gain'] = 2**16
    #_, iir_dict['iir_a1'],iir_dict['iir_a2'] = a
    #iir_dict['iir_b0'], iir_dict['iir_b1'],iir_dict['iir_b2'] = b
    #print(iir_dict)
    """

    ### ARBITRARY 2ND ORDER FILTER ###
    iir_dict = {'iir_a1': -2147263441, 
                'iir_a2': 1073525957, 
                'iir_b0': 107933,
                'iir_b1': 0, 
                'iir_b2': -107933, 
                'gain': 2**10
                }

    ### FIRST ORDER BAND PASS FILTER ###
    iir_dict = {}
    scale_factor = 2**30
    sf = 1/(8e-9*4)
    nyq = sf/2
    f0 = 5000
    Q = 10
    w0 = 2 * np.pi * f0 / sf
    alpha = np.sin(w0) / (2 * Q)
    cos_w0 = np.cos(w0)
    b  = [alpha, 0, -alpha] 
    a = [1 + alpha, -2 * cos_w0, 1 - alpha]
    b = np.round(b * scale_factor).astype(int)
    a = np.round(a* scale_factor).astype(int)
    _, iir_dict['iir_a1'],iir_dict['iir_a2'] = a
    iir_dict['iir_b0'], iir_dict['iir_b1'],iir_dict['iir_b2'] = b
    iir_dict['gain'] = 2**16

    

    ### FIRST ORDER HIGH PASS FILTER ###
    iir_dict = {}  
    scale_factor = 2**30
    sf = 1/(8e-9*4)
    nyq = sf/2
    b, a = butter(1, 5000/nyq, btype='high', analog=False)
    b = np.round(b * scale_factor).astype(int)
    a = np.round(a* scale_factor).astype(int)
    _, iir_dict['iir_a1'] = a
    iir_dict['iir_b0'], iir_dict['iir_b1'] = b
    iir_dict['gain'] = 2**16    


  

    ### FIRST ORDER HIGH PASS FILTER ###
    iir_dict = {}  
    scale_factor = 2**30
    sf = 1/(8e-9*4)
    nyq = sf/2
    b, a = butter(1, 5000/nyq, btype='high', analog=False)
    b = np.round(b * scale_factor).astype(int)
    a = np.round(a* scale_factor).astype(int)
    _, iir_dict['iir_a1'] = a
    iir_dict['iir_b0'], iir_dict['iir_b1'] = b
    iir_dict['gain'] = 2**16 


    


    ### FIRST ORDER BAND PASS FILTER ###
    iir_dict = {}
    scale_factor = 2**29
    sf = 1/(8e-9*4)
    nyq = sf/2
    f0 = 5000
    Q = 10
    w0 = 2 * np.pi * f0 / sf
    alpha = np.sin(w0) / (2 * Q)
    cos_w0 = np.cos(w0)
    b  = [alpha, 0, -alpha] 
    a = [1 + alpha, -2 * cos_w0, 1 - alpha]

    b_i = np.round(b * scale_factor).astype(int)
    a_i = np.round(a* scale_factor).astype(int)
    _, iir_dict['iir_a1'],iir_dict['iir_a2'] = a_i
    iir_dict['iir_b0'], iir_dict['iir_b1'],iir_dict['iir_b2'] = b_i
    iir_dict['gain'] = 2**22

    


 ### FIRST ORDER LOW PASS FILTER ###
  #  iir_dict = {}
  #  scale_factor = 2**29
  #  sf = 1/(8e-9*4)
  #  nyq = sf/2
  #  b, a = butter(1, 5000/nyq, btype='low', analog=False)
  #  b = np.round(b * scale_factor).astype(int)
    a = np.round(a* scale_factor).astype(int)
    _, iir_dict['iir_a1'] = a
    iir_dict['iir_b0'], iir_dict['iir_b1'] = b
   #iir_dict['gain'] = 2**22


   ### LOAD COEFFICIENTS TO RED PITAYA ###



    ### FIRST ORDER LOW PASS FILTER ###
    iir_dict = {}
    scale_factor = 2**30
    sf = 1/(8e-9*4)
    nyq = sf/2
    b, a = butter(1, 5000/nyq, btype='low', analog=False)
    b = np.round(b * scale_factor).astype(int)
    a = np.round(a* scale_factor).astype(int)


    _, iir_dict['iir_a1'] = a
    iir_dict['iir_b0'], iir_dict['iir_b1'] = b
    iir_dict['gain'] = 2**14

    #rp = RedPitaya("171.64.56.58", "root", "root")
    rp = RedPitaya("10.0.0.186", "root", "root")
    rp.connect()
    rp.set_params("IIR1", iir_dict)
    print(rp.get_params("IIR1"))
    rp.close()
