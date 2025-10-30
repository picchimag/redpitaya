# Relax timing for slow computations inside iir2nd_direct_0
set_multicycle_path 1000 -setup -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_direct_0*}]
set_multicycle_path 999  -hold  -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_direct_0*}]

# Relax timing for slow computations inside iir2nd_direct_0
set_multicycle_path 1000 -setup -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_direct_axi_0*}]
set_multicycle_path 999  -hold  -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_direct_axi_0*}]

# Relax timing for slow computations inside iir2nd_coupled_0 
set_multicycle_path 1000 -setup -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_coupled_0*}]
set_multicycle_path 999  -hold  -from [get_cells -hierarchical -filter {NAME =~ *iir2nd_coupled_0*}]

# Relax timing for slow computations inside iir2nd_coupled_0 
set_multicycle_path 1000 -setup -from [get_cells -hierarchical -filter {NAME =~ *pid_simple_axi_wrap_0*}]
set_multicycle_path 999  -hold  -from [get_cells -hierarchical -filter {NAME =~ *pid_simple_axi_wrap_0*}]


# Relax timing for slow computations inside iir2nd_coupled_0 
set_multicycle_path 2 -setup -from [get_cells -hierarchical -filter {NAME =~ *iir1st_minimal_axi_0*}]
set_multicycle_path 1  -hold  -from [get_cells -hierarchical -filter {NAME =~ *iir1st_minimal_axi_0*}]