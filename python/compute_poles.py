import numpy as np
import matplotlib.pyplot as plt

# Filter specifications (same as before)
fs = 1 / 32e-9        # Sampling frequency (31.25 MHz)
f0 = 10e3             # Center frequency (10 kHz)
Q = 10                # Quality factor

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

# Form the numerator and denominator polynomials
numerator_coeffs = [b0, b1, b2]
denominator_coeffs = [1, a1, a2]

# Scale factor (same as in compute_coefficients.py)
scale = 1 << 31  # 2^31

# Calculate scaled coefficients (quantization to 32 bits)
b0_scaled = int(np.round(b0 * scale))
b1_scaled = int(np.round(b1 * scale))
b2_scaled = int(np.round(b2 * scale))
a1_scaled = int(np.round(a1 * scale))
a2_scaled = int(np.round(a2 * scale))

# Convert scaled integers back to floating-point coefficients
b0_quantized = b0_scaled / scale
b1_quantized = b1_scaled / scale
b2_quantized = b2_scaled / scale
a1_quantized = a1_scaled / scale
a2_quantized = a2_scaled / scale

# Form the numerator and denominator polynomials with quantized coefficients
numerator_coeffs = [b0_quantized, b1_quantized, b2_quantized]
denominator_coeffs = [1, a1_quantized, a2_quantized]

# Find the zeros and poles using quantized coefficients
zeros = np.roots(numerator_coeffs)
poles = np.roots(denominator_coeffs)

# Calculate the magnitudes of the poles and zeros
pole_magnitudes = np.abs(poles)
zero_magnitudes = np.abs(zeros)

# Display the results
print("Poles of the filter:")
for idx, pole in enumerate(poles, 1):
    print(f"Pole {idx}: {pole}, Magnitude: {pole_magnitudes[idx-1]}")

print("\nZeros of the filter:")
for idx, zero in enumerate(zeros, 1):
    print(f"Zero {idx}: {zero}, Magnitude: {zero_magnitudes[idx-1]}")

# Check stability
if np.all(pole_magnitudes < 1):
    print("\nThe filter is stable (all poles are inside the unit circle).")
else:
    print("\nThe filter is unstable (one or more poles are outside the unit circle).")

# Plot the unit circle and poles/zeros
plt.figure(figsize=(6, 6))
ax = plt.subplot(1,1,1)

# Draw unit circle
uc = plt.Circle((0,0), radius=1, fill=False, linestyle='--', color='black')
ax.add_artist(uc)

# Plot zeros
plt.plot(np.real(zeros), np.imag(zeros), 'go', label='Zeros')

# Plot poles
plt.plot(np.real(poles), np.imag(poles), 'rx', label='Poles')

# Set plot limits and labels
plt.title('Pole-Zero Plot')
plt.xlabel('Real Part')
plt.ylabel('Imaginary Part')
plt.legend()
plt.grid(True)
plt.axis('equal')

plt.show()
