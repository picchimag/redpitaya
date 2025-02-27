import numpy as np

# Filter specifications
fs = 1 / 32e-9        # Sampling frequency (31.25 MHz)
f0 = 10e3             # Center frequency (10 kHz)
Q = 10                # Quality factor
coeff_width = 32      # Coefficient width
scale = 1 << 30       # Scale factor (2^30)

# Normalized angular frequency
w0 = 2 * np.pi * f0 / fs

# Calculate filter coefficients
alpha = np.sin(w0) / (2 * Q)
cos_w0 = np.cos(w0)

b0 = alpha
b1 = 0
b2 = -alpha
a0 = 1 + alpha
a1 = -2 * cos_w0
a2 = 1 - alpha

# Normalize coefficients (a0 should be 1)
b0 /= a0
b1 /= a0
b2 /= a0
a1 /= a0
a2 /= a0

# Scale coefficients to 32-bit signed integers
b0_scaled = int(np.round(b0 * scale))
b1_scaled = int(np.round(b1 * scale))
b2_scaled = int(np.round(b2 * scale))
a1_scaled = int(np.round(a1 * scale))
a2_scaled = int(np.round(a2 * scale))

# Set gain to maximize dynamic range (adjust as needed)
gain = scale  # Unity gain

# Display the coefficients
print("b0 =", b0_scaled)
print("b1 =", b1_scaled)
print("b2 =", b2_scaled)
print("a1 =", a1_scaled)
print("a2 =", a2_scaled)
print("gain =", gain)
