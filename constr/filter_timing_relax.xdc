# Relax timing for slow computations inside iir2nd_direct_0
set_multicycle_path 1000 -setup -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_direct_0*}]
set_multicycle_path 999  -hold  -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_direct_0*}]

# Relax timing for slow computations inside iir2nd_coupled_0 
set_multicycle_path 1000 -setup -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_coupled_0*}]
set_multicycle_path 999  -hold  -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_coupled_0*}]

