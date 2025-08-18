"""
Red Pitaya Filter Control Package

This package provides tools for controlling Red Pitaya FPGA-based filters:
- RedPitaya: SSH-based control and coefficient loading
- ComputeCoeff: Filter coefficient calculation for various filter types
"""

__version__ = "1.0.0"
__author__ = "Red Pitaya Filter Team"

# Make main classes easily importable
from .load_coeff import RedPitaya
from .compute_coeff import ComputeCoeff

__all__ = ['RedPitaya', 'ComputeCoeff']
