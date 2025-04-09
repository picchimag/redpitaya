from load_coeff import RedPitaya
import numpy as np
from scipy.signal import iirfilter, freqz, bilinear, butter
import time


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
LOGDIV = 10
LOG_A0 =30
#LOG_A0 = 18
Q = 100

f0= 10

sf = 1/(2**LOGDIV*8e-9)  # Sampling frequency in Hz
nyq = sf / 2


omega_0 = 2 * np.pi * f0
num = np.array([omega_0**2])  # numerator: [omega_0^2]
den = np.array([1, omega_0 / Q, omega_0**2])*Q  # denominator: [1, 2 * zeta * omega_0, omega_0^2]
b, a = bilinear(num, den, sf)


omega_0 = 2 * np.pi * f0
num = np.array([0,omega_0,0])/Q*np.sqrt(2)  # numerator: [omega_0^2]
den = np.array([1, np.sqrt(2) * omega_0 /Q, omega_0**2])  # denominator: [1, 2 * zeta * omega_0, omega_0^2]
b, a = bilinear(num, den, sf)

## JUST BASIC CHECK ###
b=np.array([1,0,0])
a=np.array([0,0,0])


# Compute alpha and beta c1 and c2
alpha = -a[1] / 2
beta = np.sqrt(a[2] - (a[1]**2) / 4)
c = np.sqrt(1-2*a[2]+a[2]**2)

#LOG_A0 = 18



alpha = int(round(alpha * (1 << LOG_A0)))
beta = int(round(beta * (1 << LOG_A0)))
c = int(round(c * (1 << LOG_A0)))

b = np.round(b* (1 << LOG_A0)).astype('int32')
a = np.round(a* (1 << LOG_A0)).astype('int32')


iir_dict = {
    "iir_a1": a[1],
    "iir_a2": a[2],
    "iir_b0": b[0],
    "iir_b1": b[1],
    "iir_b2": b[2],
    "gain": 2**9
}

iir_dict_c = {
    "alpha": alpha,
    "beta": beta,
    "c": c*1000,
    "gainP": 2**20,
    "gainQ":0 # 2**10,
}

iir_dict_0 = {
    "iir_a1": 0,
    "iir_a2": 0,
    "iir_b0": 0,
    "iir_b1": 0,
    "iir_b2": 0,
    "gain": 0
}



print( a,b, '\n')

### LOAD COEFFICIENTS TO RED PITAYA ###

rp = RedPitaya("171.64.56.58", "root", "root")
#rp = RedPitaya("10.0.0.186", "root", "root")

rp.connect()
rp.enable('IIR1',False)
#time.sleep(1)
print(rp.get_params("IIR1"))
rp.set_params("IIR1", iir_dict)
print(rp.get_params("IIR1"))
rp.enable('IIR1',True)
rp.close()




 #scp /mnt/c/Users/magrini/Documents/programming/redpitaya/filter_v1/filter_template.runs/impl_1/system_wrapper.bit root@171.64.56.58:/root/filt42.bit