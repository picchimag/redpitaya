from load_coeff import RedPitaya
from load_bitfile import load_bitfile
from scipy.signal import iirfilter, freqz, bilinear, butter
import numpy as np

bitfile_path = "C:/Users/magrini/Documents/programming/redpitaya/projects/iir2nd_direct_gpio/iir2nd_direct_gpio.runs/impl_1/system_wrapper.bit"
ip = "171.64.56.58"
#load_bitfile(bitfile_path, remote_ip = ip )



#Fixed parameters, depend on the filter design
LOGDIV = 10
LOG_A0 = 30
LOG_UNITY_GAIN  = 9

sf = 1/(2**LOGDIV*8e-9)  # Sampling frequency in Hz 8ns is the clock of the red pitaya

#Variable parameters, controlled by GPIOs
Q = 50
f0= 200
gain = 100000

#Compute filter coefficients
omega_0 = 2 * np.pi * f0
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
"iir_b2": b[2]
}

### LOAD COEFFICIENTS TO RED PITAYA ###

rp = RedPitaya("171.64.56.58", "root", "root")

rp.connect()
rp.enable('IIR1',False)
print(rp.get_params("IIR1"))
rp.set_params("IIR1", iir_dict)
rp.set_params("IIR1", {'gain': int(gain*2**LOG_UNITY_GAIN)})
print(rp.get_params("IIR1"))
rp.enable('IIR1',True)
rp.close()
