import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import iirfilter, freqz, bilinear, butter

a = [2**26,-134210945,  67102117]
b = [ 67461,  0, -67461]

sf = 1/(8e-9*4)
nyq = sf/2
f0 = 50000
Q = 50
w0 = 2 * np.pi * f0 / sf
alpha = np.sin(w0) / (2 * Q)
cos_w0 = np.cos(w0)
b  = np.array([alpha, 0, -alpha]) 
a = np.array([1 + alpha, -2 * cos_w0, 1 - alpha])

b = (b*10)
a = (a*10)



#############################


numerator_coeffs = [b[0]/a[0], b[1]/a[0], b[2]/a[0]]
denominator_coeffs = [a[0]/a[0], a[1]/a[0], a[2]/a[0]]




w, h = freqz(numerator_coeffs, denominator_coeffs, worN=np.logspace(1,7,1000)/sf)
angles = np.degrees(np.unwrap(np.angle(h)))

plt.subplot(2, 1, 1)
plt.plot(0.5 * sf * w / np.pi, np.abs(h), 'b', label='lp')
#plt.yscale('log')
plt.xscale('log')
plt.subplot(2, 1, 2)
plt.plot(0.5 * sf * w / np.pi, angles, 'b', label='lp')
plt.xscale('log')