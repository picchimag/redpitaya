import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import lfilter, freqz

# Filter parameters
fs = 31e6  # Sampling frequency in Hz
f_center = 1e3  # Center frequency (100 kHz)
bw = 1e1  # Bandwidth (1 kHz)

# Normalized frequency parameters
r = 1 - bw / fs  # Radial distance in z-plane
theta = 2 * np.pi * f_center / fs  # Angular frequency in radians

# Bandpass filter coefficients
b0 = 1.0
a1 = -2 * r * np.cos(theta)  # Coefficient for the poles
a2 = r ** 2  # Second coefficient related to pole radius

# Feedforward coefficients for bandpass filter (with zeros at 0 Hz and Nyquist)
b = [1, 0, -1]  # Zeros at 0 Hz and Nyquist
a = [1, a1, a2]  # Poles based on r and theta

# Display the filter coefficients
print("Filter Coefficients:")
print("b:", b)
print("a:", a)

# Frequency response of the filter
w, h = freqz(b, a, worN=2**20, fs=fs)

# Plot the magnitude and phase response
plt.figure(figsize=(12, 6))

# Magnitude response in log-log scale
plt.subplot(2, 1, 1)
plt.loglog(w, np.abs(h))
plt.title("Magnitude Response (Log-Log Scale)")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Magnitude")
plt.grid(True, which="both", ls="--")

# Phase response in semilogx scale
plt.subplot(2, 1, 2)
plt.semilogx(w, np.angle(h))
plt.title("Phase Response (Semilog-x Scale)")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Phase (radians)")
plt.grid(True, which="both", ls="--")

plt.tight_layout()
plt.show()

# Apply the filter to a signal (for example, a white noise signal)
x = np.random.randn(1000)  # Example input signal
y = lfilter(b, a, x)  # Apply IIR filter

# Plot the original and filtered signals
plt.figure(figsize=(10, 4))
plt.plot(x, label='Input Signal')
plt.plot(y, label='Filtered Signal', linestyle='dashed')
plt.legend()
plt.title('IIR Bandpass Filter Input and Output')
plt.show()
