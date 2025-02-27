import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import freqz, lfilter

def design_bandpass_filter(fs, f_center, bw, num_poles):
    # Normalized frequency parameters
    r = 1 - bw / fs  # Radial distance in z-plane
    theta = 2 * np.pi * f_center / fs  # Angular frequency in radians (normalized)

    # Initialize filter coefficients (feedforward and feedback)
    b = [1]  # Feedforward coefficients (bandpass filters typically start with [1])
    a = [1]  # Feedback coefficients (start with 1 for IIR)

    for _ in range(num_poles // 2):  # Add pairs of conjugate poles
        a1 = -2 * r * np.cos(theta)  # Coefficient for poles
        a2 = r ** 2  # Radial distance squared
        a = np.convolve(a, [1, a1, a2])  # Convolve to add poles to the filter

    # Zeroes remain the same for bandpass (zeros at DC and Nyquist)
    b = [1] + [0] * (len(a) - 2) + [-1]  # Bandpass filter zeros

    return b, a

# Filter parameters
fs = 31e6  # Sampling frequency
f_center = 1e3  # Center frequency (1 kHz)
bw = 500  # Bandwidth (10 Hz)
num_poles = 4  # Number of poles (order of filter)

# Design filter
b, a = design_bandpass_filter(fs, f_center, bw, num_poles)

# Display filter coefficients
print("Filter Coefficients:")
print("b:", b)
print("a:", a)

# Frequency response
w, h = freqz(b, a, worN=2**20, fs=fs)

# Plot the magnitude and phase response
plt.figure(figsize=(12, 6))

# Magnitude response (log-log scale)
plt.subplot(2, 1, 1)
plt.loglog(w, np.abs(h))
plt.title(f"{num_poles}-Pole Bandpass Filter: Magnitude Response (Log-Log)")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Magnitude")
plt.grid(True, which="both", ls="--")

# Phase response (semilogx)
plt.subplot(2, 1, 2)
plt.semilogx(w, np.angle(h))
plt.title(f"{num_poles}-Pole Bandpass Filter: Phase Response (Semilog-x)")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Phase (radians)")
plt.grid(True, which="both", ls="--")

plt.tight_layout()
plt.show()

# Apply the filter to a signal (e.g., white noise)
x = np.random.randn(1000)
y = lfilter(b, a, x)

# Plot the original and filtered signal
plt.figure(figsize=(10, 4))
plt.plot(x, label='Input Signal')
plt.plot(y, label='Filtered Signal', linestyle='dashed')
plt.legend()
plt.title(f"{num_poles}-Pole Bandpass Filter Input and Output")
plt.show()
