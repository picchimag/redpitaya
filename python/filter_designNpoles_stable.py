import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import iirfilter, sosfreqz, sosfilt

# Filter parameters
fs = 31e6  # Sampling frequency
f_center = 1e3  # Center frequency (1 kHz)
bw = 100  # Bandwidth (10 Hz)
num_poles = 4  # 4-pole filter

# Design filter in SOS form
nyquist = 0.5 * fs
low = (f_center - bw / 2) / nyquist
high = (f_center + bw / 2) / nyquist

sos = iirfilter(num_poles, [low, high], btype='band', ftype='butter', output='sos')

# Frequency response using SOS
w, h = sosfreqz(sos, worN=2**20, fs=fs)

# Plot the magnitude response
plt.figure(figsize=(12, 6))

# Magnitude response (log-log)
plt.subplot(2, 1, 1)
plt.loglog(w, np.abs(h))
plt.title(f"{num_poles}-Pole Bandpass Filter (SOS): Magnitude Response")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Magnitude")
plt.grid(True, which="both", ls="--")

# Phase response (semilogx)
plt.subplot(2, 1, 2)
plt.semilogx(w, np.angle(h))
plt.title(f"{num_poles}-Pole Bandpass Filter (SOS): Phase Response")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Phase (radians)")
plt.grid(True, which="both", ls="--")

plt.tight_layout()
plt.show()

# Apply the filter to a signal
x = np.random.randn(1000)
y = sosfilt(sos, x)

# Plot the filtered signal
plt.figure(figsize=(10, 4))
plt.plot(x, label='Input Signal')
plt.plot(y, label='Filtered Signal', linestyle='dashed')
plt.legend()
plt.title(f"{num_poles}-Pole Bandpass Filter (SOS) Input and Output")
plt.show()
