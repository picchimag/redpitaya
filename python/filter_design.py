import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import firwin, freqz,iirfilter

# Define parameters
sampling_freq = 31.125e2  # Sampling frequency in Hz
center_freq = 500  # Center frequency in Hz
bandwidth = 500  # Bandwidth in Hz

# Calculate the Nyquist frequency
nyquist_freq = sampling_freq / 2

# Calculate the lower and upper cutoff frequencies
lower_cutoff = (center_freq - bandwidth / 2) / nyquist_freq
upper_cutoff = (center_freq + bandwidth / 2) / nyquist_freq

# Design the FIR filter using the firwin function
num_taps = 101  # Number of filter taps (adjust as needed)
filter_coeffs = firwin(num_taps, [lower_cutoff, upper_cutoff], pass_zero=False)
wf, hf = freqz(filter_coeffs, worN=8000)

# Design the IIR filter using the iirfilter function
order = 2  # Filter order (adjust as needed)
b, a = iirfilter(order, [lower_cutoff, upper_cutoff], btype='band', ftype='butter')
b,a = iirfilter(order, [lower_cutoff, upper_cutoff], btype='band', ftype='ellip', rp=1, rs=40)

wi, hi = freqz(b, a, worN=8000)


# Plot the magnitude response
plt.figure()
plt.subplot(2, 1, 1)
plt.plot(0.5 * sampling_freq * wf / np.pi, np.abs(hf), 'b')
plt.plot(0.5 * sampling_freq * wi / np.pi, np.abs(hi), 'r')
plt.axvline(center_freq, color = 'gray')

plt.title('FIR Band-Pass Filter Frequency Response')
plt.xlabel('Frequency (Hz)')
plt.ylabel('Gain')
#plt.xlim(0,1000)
plt.xscale('log')
plt.yscale('log')
plt.grid()


# Plot the phase response
plt.subplot(2, 1, 2)
angles = np.degrees(np.unwrap(np.angle(hf)))
plt.plot(0.5 * sampling_freq * wf / np.pi, angles, 'b')

angles = np.degrees(np.unwrap(np.angle(hi)))
plt.plot(0.5 * sampling_freq * wi / np.pi, angles, 'r')


plt.axvline(center_freq, color = 'gray')

plt.xlabel('Frequency (Hz)')
plt.ylabel('Phase (deg)')
plt.grid()
#plt.xlim(0,1000)
plt.xscale('log')
plt.tight_layout()
plt.show()

plt.show()