import numpy as np
from scipy.signal import bilinear, butter, ss2tf, iirfilter
from scipy.linalg import solve_continuous_are



class ComputeCoeff:
    """
    Compute filter coefficients for various filter types.
    Returns coefficient dictionary compatible with register map.
    """
    
    def __init__(self, config_file=None):
        """Initialize with optional config file for parameter scaling."""
        self.LOG_A0 = 30  # Default coefficient scaling
        self.LOG_UNITY_GAIN = 9  # Default gain scaling
        self.sampling_interval = 8.192e-6  # Default filter sampling interval
        
        if config_file:
            self.load_config(config_file)
    
    def load_config(self, config_file):
        """Load scaling parameters from JSON config file."""
        import json
        with open(config_file, 'r') as f:
            config = json.load(f)
        
        params = config.get('parameters', {})
        self.LOG_A0 = params.get('LOG_A0', 30)
        self.LOG_UNITY_GAIN = params.get('LOG_UNITY_GAIN', 9)
        self.sampling_interval = params.get('filter_sampling_interval_s', 8.192e-6)
    
    def harmonic_oscillator(self, frequency, Q, gain=1, response='velocity'):
        """
        Design harmonic oscillator filter.
        
        Args:
            frequency: Resonant frequency in Hz
            Q: Quality factor
            gain: Output gain (linear scale)
            response: 'position' or 'velocity'
            
        Returns:
            dict: Coefficient dictionary for register map
        """
        sf = 1 / self.sampling_interval
        omega_0 = 2 * np.pi * frequency
        
        if response == 'velocity':
            num = np.array([0, omega_0, 0]) / Q * np.sqrt(2)
        else:  # velocity
            num = np.array([omega_0**2]) / Q * np.sqrt(2)
                 
        den = np.array([1, np.sqrt(2) * omega_0 / Q, omega_0**2])
        
        # Convert to digital filter
        b, a = bilinear(num, den, sf)
        
        return self._format_iir_coeffs(b, a, gain)
    
    def harmonic_oscillator_coupled(self, frequency, Q, gainP=1, gainQ=1):

        sf = 1 / self.sampling_interval
        
        omega = 2 * np.pi * frequency / sf
        r = np.exp(-np.pi * frequency / (Q * sf))  # decay factor

        alpha = r * np.cos(omega)
        beta = r * np.sin(omega)

        print(r, omega, alpha, beta)

        c1 = gainP / np.sqrt(1 - r**2)
        c2 = gainQ / np.sqrt(1 - r**2)

        c1 = gainP
        c2 = gainQ
        
        
        return self._format_iir_coeffs_coupled(alpha, beta, c1, c2)
    

    def harmonic_oscillator_kalman(self, frequency, Q, qa_psd, ry_psd,
                                gain=1.0, response='position',
                                gamma_factor=np.sqrt(2),
                                norm='unity_at_f0'):
        """
        Steady-state Kalman observer (position measured). Returns ONE IIR like your other function.
        response: 'position' -> x̂, 'velocity' -> v̂
        norm: 'unity_at_f0' | 'dc_unity' | None
        """

        fs  = 1.0 / self.sampling_interval
        w0  = 2*np.pi*frequency
        gamma = gamma_factor * w0 / Q

        # Continuous-time plant
        A = np.array([[0.0,    1.0],
                    [-w0**2, -gamma]])
        C = np.array([[1.0, 0.0]])          # measuring position
        Qc = np.zeros((2,2)); Qc[1,1] = qa_psd   # white accel noise on v̇
        R  = np.array([[ry_psd]])

        # Steady-state Kalman gain (dual CARE)
        P = solve_continuous_are(A.T, C.T, Qc, R)
        L = (P @ C.T) / R                   # shape (2,1)
        L1, L2 = float(L[0,0]), float(L[1,0])

        # Closed-form continuous-time TFs y->x̂ and y->v̂
        # Denominator Δ(s) = s^2 + (γ+L1)s + (ω0^2 + L2 + γ L1)
        den_c = np.array([1.0, (gamma+L1), (w0**2 + L2 + gamma*L1)])

        if response == 'position':
            # Hx(s) = (L1*s + (L1*γ + L2)) / Δ(s)
            num_c = np.array([L1, (L1*gamma + L2)])
        else:
            # Hv(s) = (L2*s - L1*ω0^2) / Δ(s)
            num_c = np.array([L2, -L1*w0**2])

        # Bilinear (Tustin). This returns length-3 b,a even if num_c is order-1.
        b, a = bilinear(num_c, den_c, fs=fs)

        # Optional normalization to avoid tiny numerators in fixed-point
        if norm is not None:
            if norm == 'dc_unity':
                H0 = (b[0] + b[1] + b[2]) / (a[0] + a[1] + a[2])
                if H0 != 0:
                    b = b / H0
            elif norm == 'unity_at_f0':
                Om = 2*np.pi*frequency / fs
                z = np.exp(1j*Om)
                Hf0 = (b[0] + b[1]/z + b[2]/(z*z)) / (a[0] + a[1]/z + a[2]/(z*z))
                mag = np.abs(Hf0)
                if mag != 0:
                    b = b / mag
            # else: leave as-is

        return self._format_iir_coeffs(b, a, gain)

    
         
    def lowpass(self, frequency, order=2, gain=1):
        """
        Design lowpass Butterworth filter.
        
        Args:
            frequency: Cutoff frequency in Hz
            order: Filter order
            gain: Output gain (linear scale)
            
        Returns:
            dict: Coefficient dictionary for register map
        """
        sf = 1 / self.sampling_interval
        nyquist = sf / 2
        
        b, a = butter(order, frequency / nyquist, btype='low')
        
        return self._format_iir_coeffs(b, a, gain)
    
    def highpass(self, frequency, order=2, gain=1):
        """
        Design highpass Butterworth filter.
        
        Args:
            frequency: Cutoff frequency in Hz
            order: Filter order
            gain: Output gain (linear scale)
            
        Returns:
            dict: Coefficient dictionary for register map
        """
        sf = 1 / self.sampling_interval
        nyquist = sf / 2
        
        b, a = butter(order, frequency / nyquist, btype='high')
        
        return self._format_iir_coeffs(b, a, gain)
    
    def bandpass(self, center_frequency, bandwidth, order=2, gain=1):
        """
        Design bandpass Butterworth filter.
        
        Args:
            center_frequency: Center frequency in Hz
            bandwidth: Bandwidth in Hz
            order: Filter order
            gain: Output gain (linear scale)
            
        Returns:
            dict: Coefficient dictionary for register map
        """
        sf = 1 / self.sampling_interval
        nyquist = sf / 2
        
        low_freq = center_frequency - bandwidth / 2
        high_freq = center_frequency + bandwidth / 2
        
        b, a = butter(order, [low_freq / nyquist, high_freq / nyquist], btype='band')
        
        return self._format_iir_coeffs(b, a, gain)
    
    def notch(self, frequency, Q, gain=1):
        """
        Design notch filter.
        
        Args:
            frequency: Notch frequency in Hz
            Q: Quality factor
            gain: Output gain (linear scale)
            
        Returns:
            dict: Coefficient dictionary for register map
        """
        sf = 1 / self.sampling_interval
        omega_0 = 2 * np.pi * frequency
        
        # Notch filter transfer function
        num = np.array([1, 0, omega_0**2])
        den = np.array([1, omega_0/Q, omega_0**2])
        
        # Convert to digital filter
        b, a = bilinear(num, den, sf)
        
        return self._format_iir_coeffs(b, a, gain)
    
    def _format_iir_coeffs(self, b, a, gain):
        """
        Format coefficients for 2nd order IIR register map.
        
        Args:
            b: Numerator coefficients
            a: Denominator coefficients  
            gain: Linear gain value
            
        Returns:
            dict: Coefficient dictionary compatible with register map
        """
        # Pad or truncate to 2nd order
        if len(b) < 3:
            b = np.pad(b, (0, 3 - len(b)))
        if len(a) < 3:
            a = np.pad(a, (0, 3 - len(a)))
            
        b = b[:3]
        a = a[:3]
        
        # Scale coefficients for fixed-point representation
        b_scaled = np.round(b * (1 << self.LOG_A0)).astype('int32')
        a_scaled = np.round(a * (1 << self.LOG_A0)).astype('int32')
        gain_scaled = int(gain * (1 << self.LOG_UNITY_GAIN))
        
        return {
            "b0": int(b_scaled[0]),
            "b1": int(b_scaled[1]),
            "b2": int(b_scaled[2]),
            "a1": int(a_scaled[1]),  # a0 is normalized to 1
            "a2": int(a_scaled[2]),
            "gain": gain_scaled
        }

    def _format_iir_coeffs_coupled(self, alpha, beta, gainP, gainQ ) :   
        """
        Format coefficients for coupled IIR register map.
        
        Args:
            alpha: Coupling coefficient alpha
            beta: Coupling coefficient beta
            gainP: Gain for P channel
            gainQ: Gain for Q channel
            
        Returns:
            dict: Coefficient dictionary compatible with register map
        """
        alpha_scaled = int(alpha * (1 << self.LOG_A0))
        beta_scaled = int(beta * (1 << self.LOG_A0))
        gainP_scaled = int(gainP * (1 << self.LOG_UNITY_GAIN))
        gainQ_scaled = int(gainQ * (1 << self.LOG_UNITY_GAIN))
        
        return {
            "alpha": alpha_scaled,
            "beta": beta_scaled,
            "gainP": gainP_scaled,
            "gainQ": gainQ_scaled
        }
    

# Example usage
if __name__ == "__main__":
    
    # Initialize with config file
    coeff_calc = ComputeCoeff("../bitfiles/iir2nd_direct_gpio.json")
    
    # Design various filters
    
    # Harmonic oscillator (velocity response)
    ho_coeffs = coeff_calc.harmonic_oscillator(frequency=200, Q=50, gain=1)
    print("Harmonic Oscillator coefficients:", ho_coeffs)
    
    # Lowpass filter
    lp_coeffs = coeff_calc.lowpass(frequency=1000, gain=2)
    print("Lowpass coefficients:", lp_coeffs)
    
    # Bandpass filter
    bp_coeffs = coeff_calc.bandpass(center_frequency=500, bandwidth=100, gain=1)
    print("Bandpass coefficients:", bp_coeffs)
    
    # Notch filter
    notch_coeffs = coeff_calc.notch(frequency=60, Q=10, gain=1)
    print("Notch coefficients:", notch_coeffs)
