import paramiko
import numpy as np
import time

class RedPitaya:
    
    modules = {

        'FIR': {
                'fir_c0': {'base_address': 0x41230000, 'offset': 0, 'msb': 31, 'lsb': 16},  #GPIO 3 0
                'fir_c1': {'base_address': 0x41230000, 'offset': 0, 'msb': 15, 'lsb': 0},   #GPIO 3 0
                'fir_c2': {'base_address': 0x41230000, 'offset': 8, 'msb': 31, 'lsb': 16},  #GPIO 3 1
                'fir_c3': {'base_address': 0x41230000, 'offset': 8, 'msb': 15, 'lsb': 0}    #GPIO 3 1
            },


        'IIR1': {
                'iir_b0': {'base_address': 0x41200000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 0 1
                'iir_b1': {'base_address': 0x41200000, 'offset': 8, 'msb': 31, 'lsb': 0},    #GPIO 0 2
                'iir_b2': {'base_address': 0x41210000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 1 1
                'iir_a1': {'base_address': 0x41210000, 'offset': 8, 'msb': 31, 'lsb': 0},    #GPIO 1 2
                'iir_a2': {'base_address': 0x41220000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 2 1
                'gain'  : {'base_address': 0x41220000, 'offset': 8, 'msb': 17,'lsb': 0},     #GPIO 2 2
                'reset' : {'base_address': 0x41220000, 'offset': 8, 'msb': 31, 'lsb': 31}
            },


        'IIR2': {
            'alpha' : {'base_address': 0x41200000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 0 1
            'beta'  : {'base_address': 0x41200000, 'offset': 8, 'msb': 31, 'lsb': 0},    #GPIO 0 2
            'c'     : {'base_address': 0x41210000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 1 1
            'gainP' : {'base_address': 0x41210000, 'offset': 8, 'msb': 31, 'lsb': 0},    #GPIO 1 2
            'gainQ' : {'base_address': 0x41220000, 'offset': 0, 'msb': 31, 'lsb': 0},    #GPIO 2 1
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

    def enable(self, module_name, enabled=True):
        if 'reset' not in self.modules[module_name]:
                    print(f"Module {module_name} does not have reset capability.")
                    return
        
        if enabled:
            self.set_params(module_name, {'reset': 0})
        else:
            self.set_params(module_name, {'reset': 1})

    def reset(self, module_name):
        """Reset a given module."""
        if 'reset' not in self.modules[module_name]:
            print(f"Module {module_name} does not have reset capability.")
            return
            
        # Assert reset by setting reset bit to 1
        self.set_params(module_name, {'reset': 1})
        
        # De-assert reset by setting reset bit back to 0
        self.set_params(module_name, {'reset': 0})

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


    iir_dict = {}
    
    #Fixed parameters, depend on the filter design
    LOGDIV = 10
    LOG_A0 =30
    LOG_UNITY_GAIN  = 9

    sf = 1/(2**LOGDIV*8e-9)  # Sampling frequency in Hz 8ns is the clock of the red pitaya

    #Variable parameters, controlled by GPIOs
    Q = 100
    f0= 10

    


    #Compute filter coefficients
    omega_0 = 2 * np.pi * f0
    #num = np.array([omega_0**2])/Q*np.sqrt(2) # harmonic oscillator x
    num = np.array([0,omega_0,0])/Q*np.sqrt(2) # harmonic oscillator v
    den = np.array([1, np.sqrt(2) * omega_0 /Q, omega_0**2])  # denominator: [1, 2 * zeta * omega_0, omega_0^2]
    b, a = bilinear(num, den, sf)

    # Rescale coefficients to fit into 32 bits
    b = np.round(b* (1 << LOG_A0)).astype('int32')
    a = np.round(a* (1 << LOG_A0)).astype('int32')


    iir_dict = {
        "iir_a1": a[1],
        "iir_a2": a[2],
        "iir_b0": b[0],
        "iir_b1": b[1],
        "iir_b2": b[2],
        "gain": 2**LOG_UNITY_GAIN
    }

    ### LOAD COEFFICIENTS TO RED PITAYA ###

    rp = RedPitaya("171.64.56.58", "root", "root")
    #rp = RedPitaya("10.0.0.186", "root", "root")

    rp.connect()
    rp.enable('IIR1',False)
    print(rp.get_params("IIR1"))
    rp.set_params("IIR1", iir_dict)
    print(rp.get_params("IIR1"))
    rp.enable('IIR1',True)
    rp.close()



#scp /mnt/c/Users/magrini/Documents/programming/redpitaya/filter_v1/filter_template.runs/impl_1/system_wrapper.bit root@171.64.56.58:/root/filt42.bit