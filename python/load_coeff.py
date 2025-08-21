import paramiko
import numpy as np
import time
import json
import os

class RedPitaya:
    
    def __init__(self, hostname, config_file=None, username='root', password='root'):
        """Initialize with connection parameters and optional config file."""
        self.hostname = hostname
        self.username = username
        self.password = password
        self.ssh = None
        self.registers = {}
        self.parameters = {}
        
        if config_file:
            self.load_config(config_file)
    
    def load_config(self, config_file):
        """Load register map and parameters from JSON config file."""
        self.config_file = config_file
        with open(config_file, 'r') as f:
            config = json.load(f)
        
        self.registers = config.get('registers', {})
        self.parameters = config.get('parameters', {})
        self.bitfile = config.get('bitfile', '')
        
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

    def load_bitfile(self):
        """Load the bitfile specified in the config to the Red Pitaya."""
        config_dir = os.path.dirname(os.path.abspath(self.config_file))
        bitfile_path = os.path.normpath(os.path.join(config_dir, self.bitfile))
        
        # Copy bitfile to Red Pitaya
        sftp = self.ssh.open_sftp()
        remote_path = f"/tmp/{self.bitfile}"
        sftp.put(bitfile_path, remote_path)
        sftp.close()
        
        # Load bitfile
        command = f"cat {remote_path} > /dev/xdevcfg"
        stdin, stdout, stderr = self.ssh.exec_command(command)
        time.sleep(0.1)  # Wait for the bitfile to load

    def enable(self, enabled=True):
        """Enable or disable the filter using reset."""
        if enabled:
            self.set_param('reset', 0)
        else:
            self.set_param('reset', 1)

    def reset(self):
        """Reset the filter - enable, wait, disable."""
        self.set_param('reset', 1)
        time.sleep(0.001)
        self.set_param('reset', 0)

    def set_param(self, param_name, param_value):
        """Set a single parameter."""
        if param_name not in self.registers:
            print(f"Parameter {param_name} not found.")
            return
            
        param_info = self.registers[param_name]
        base_address = int(param_info['base_address'], 16)
        reg_offset = param_info['offset']
        msb = param_info['msb']
        lsb = param_info['lsb']
        address = base_address + reg_offset
        
        stdout, stderr = self.execute_monitor_command(hex(address))
        current_value = int(stdout.strip(), 16) if stdout.strip() else 0
        
        mask = ((1 << (msb - lsb + 1)) - 1) << lsb
        current_value = (current_value & ~mask) | ((param_value << lsb) & mask)
        
        self.execute_monitor_command(hex(address), hex(current_value))

    def set_params(self, params_dict):
        """Set multiple parameters."""
        for param_name, param_value in params_dict.items():
            self.set_param(param_name, param_value)

    def get_param(self, param_name):
        """Get a single parameter."""
        if param_name not in self.registers:
            print(f"Parameter {param_name} not found.")
            return None
            
        param_info = self.registers[param_name]
        base_address = int(param_info['base_address'], 16)
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

        return param_value

    def get_params(self):
        """Get all parameters."""
        params = {}
        for param_name in self.registers.keys():
            params[param_name] = self.get_param(param_name)
        return params

# Example Usage
if __name__ == "__main__":

    from scipy.signal import bilinear
    import os
    from compute_coeff import ComputeCoeff

    
    # Load filter configuration
    config_file = "../bitfiles/iir2nd_direct_gpio.json"
    config_file = "../bitfiles/iir2nd_coupled_gpio.json"
    rp = RedPitaya("171.64.56.58", config_file)

    coeff_calc = ComputeCoeff(config_file) 

    ho_coeffs = coeff_calc.harmonic_oscillator(frequency=200, Q=50, gain=1, response='position')
    ho_coeffs = coeff_calc.harmonic_oscillator_coupled(frequency=200, Q=50, gainP=-0.1, gainQ=0)
    #ho_coeffs = coeff_calc.harmonic_oscillator_coupled(frequency=200, Q=50, gainP=-0.03, gainQ=0)



    rp.connect()
    rp.load_bitfile()
    
    rp.enable(False)
    #print("Current parameters:", rp.get_params())
    rp.set_params(ho_coeffs)
    #print("Updated parameters:", rp.get_params())
    rp.enable(True)
    rp.close()



    """"
    # Get parameters from loaded config
    LOG_DIV = rp.parameters.get('LOG_DIV')
    LOG_A0 = rp.parameters.get('LOG_A0')
    LOG_UNITY_GAIN = rp.parameters.get('LOG_UNITY_GAIN', 9)
    
    sf = 1/rp.parameters.get('filter_sampling_interval_s') 

    # Variable parameters for filter design
    Q = 50
    f0 = 200
    gain = 1

    # Compute filter coefficients
    omega_0 = 2 * np.pi * f0
    num = np.array([0, omega_0, 0])/Q*np.sqrt(2)  # harmonic oscillator v
    den = np.array([1, np.sqrt(2) * omega_0 /Q, omega_0**2])
    b, a = bilinear(num, den, sf)

    # Rescale coefficients to fit into 32 bits
    b = np.round(b * (1 << LOG_A0)).astype('int32')
    a = np.round(a * (1 << LOG_A0)).astype('int32')

    # Create coefficient dictionary
    coeffs = {
        "b0": b[0],
        "b1": b[1], 
        "b2": b[2],
        "a1": a[1],
        "a2": a[2],
        "gain": int(gain*2**LOG_UNITY_GAIN)
    }
    """
    ### LOAD COEFFICIENTS TO RED PITAYA ###

    # Reset filter and load coefficients

    
   
   
