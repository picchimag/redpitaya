from load_coeff import RedPitaya
import numpy as np
from scipy.signal import iirfilter, freqz, bilinear, butter



### FIRST ORDER BAND PASS FILTER ###
iir_dict = {}
scale_factor = 2**23
sf = 1/(8e-9*4)
nyq = sf/2
f0 = 1000000
Q = 10


w0 = 2 * np.pi * f0 / sf
alpha = np.sin(w0) / (2 * Q)
cos_w0 = np.cos(w0)

b  = np.array([alpha, 0, -alpha]) 
a = np.array([1 + alpha, -2 * cos_w0, 1 - alpha])





## JUST BASIC CHECK ###
b=np.array([1,0,0])
a=np.array([0,0,0])





### FIRST ORDER BAND PASS FILTER ###
iir_dict = {}
scale_factor = 2**23
sf = 1/(4*8e-9)
nyq = sf/2
f0 = 10e3
Q = 10
w0 = 2 * np.pi * f0 / sf
alpha = np.sin(w0) / (2 * Q)
cos_w0 = np.cos(w0)
b  = np.array([alpha, 0, -alpha])/100
a = np.array([1 + alpha, -2 * cos_w0, 1 - alpha])

#b, a = iirfilter(1, [f0/nyq-f0/Q/nyq,f0/nyq+f0/Q/nyq], btype='band', ftype='butter')

#zeta = 0.1  # Bandwidth in Hz



### FIRST ORDER LOW PASS FILTER ###

zeta = 0.1  # Bandwidth in Hz
#b, a = iirfilter(1, [f0/nyq-f0*zeta/nyq,f0/nyq+f0*zeta/nyq], btype='band', ftype='butter', analog=False)



### FIRST ORDER LOW PASS FILTER ###
#b, a = butter(1, 1000e3/nyq, btype='low', analog=False)

iir_dict = {}
LOGDIV = 12
scale_factor = 2**23

Q = 30
f0= 200

sf = 1/(2**LOGDIV*8e-9)  # Sampling frequency in Hz
nyq = sf / 2


omega_0 = 2 * np.pi * f0
num = np.array([omega_0**2])  # numerator: [omega_0^2]
den = np.array([1, omega_0 / Q, omega_0**2])*Q  # denominator: [1, 2 * zeta * omega_0, omega_0^2]
b, a = bilinear(num, den, sf)


omega_0 = 2 * np.pi * f0
num = np.array([0,omega_0,0])/Q*np.sqrt(2)  # numerator: [omega_0^2]
den = np.array([1, np.sqrt(2) * omega_0 /Q, omega_0**2])  # denominator: [1, 2 * zeta * omega_0, omega_0^2]
#b, a = bilinear(num, den, sf)

## JUST BASIC CHECK ###
#b=np.array([1,0,0])
#a=np.array([0,0,0])



delta_b = 2**7
b = b*delta_b


print(a,b, '\n')

if max(abs(b)) > 2: print('!!!!!!!!!!!!!!!!!!!!!!!!!ATTENTION: b is too big !!!!!!!!!!!!!!!!!!!!!!!!!\n')


b = np.round(b *scale_factor).astype('int32')
a = np.round(a* scale_factor).astype('int32')

_, iir_dict['iir_a1'],iir_dict['iir_a2'] = np.pad(a, (0, 3 - len(a)), 'constant')
iir_dict['iir_b0'], iir_dict['iir_b1'],iir_dict['iir_b2'] = np.pad(b, (0, 3 - len(b)), 'constant')
#ir_dict['gain'] = 2**16

print( a,b, '\n')

### LOAD COEFFICIENTS TO RED PITAYA ###

rp = RedPitaya("171.64.56.58", "root", "root")
#rp = RedPitaya("10.0.0.186", "root", "root")

rp.connect()
rp.set_params("IIR1", iir_dict)
print(rp.get_params("IIR1"))
rp.close()
