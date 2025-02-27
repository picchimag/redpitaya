# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: imports/cfg/clocks.xdc

# XDC: imports/cfg/ports.xdc

# Block Designs: bd/system/system.bd
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system || ORIG_REF_NAME==system} -quiet] -quiet

# IP: bd/system/ip/system_pll_0_0/system_pll_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_pll_0_0 || ORIG_REF_NAME==system_pll_0_0} -quiet] -quiet

# IP: bd/system/ip/system_ps_0_0/system_ps_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_ps_0_0 || ORIG_REF_NAME==system_ps_0_0} -quiet] -quiet

# IP: bd/system/ip/system_rst_0_0/system_rst_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_rst_0_0 || ORIG_REF_NAME==system_rst_0_0} -quiet] -quiet

# IP: bd/system/ip/system_xbar_0/system_xbar_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_xbar_0 || ORIG_REF_NAME==system_xbar_0} -quiet] -quiet

# IP: bd/system/ip/system_auto_pc_3/system_auto_pc_3.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_auto_pc_3 || ORIG_REF_NAME==system_auto_pc_3} -quiet] -quiet

# IP: bd/system/ip/system_auto_pc_0/system_auto_pc_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_auto_pc_0 || ORIG_REF_NAME==system_auto_pc_0} -quiet] -quiet

# IP: bd/system/ip/system_auto_pc_1/system_auto_pc_1.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_auto_pc_1 || ORIG_REF_NAME==system_auto_pc_1} -quiet] -quiet

# IP: bd/system/ip/system_auto_pc_2/system_auto_pc_2.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_auto_pc_2 || ORIG_REF_NAME==system_auto_pc_2} -quiet] -quiet

# IP: bd/system/ip/system_axi_interconnect_0_0/system_axi_interconnect_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_axi_interconnect_0_0 || ORIG_REF_NAME==system_axi_interconnect_0_0} -quiet] -quiet

# IP: bd/system/ip/system_const_0_0/system_const_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_const_0_0 || ORIG_REF_NAME==system_const_0_0} -quiet] -quiet

# IP: bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_0 || ORIG_REF_NAME==system_axi_gpio_0_0} -quiet] -quiet

# IP: bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_1 || ORIG_REF_NAME==system_axi_gpio_0_1} -quiet] -quiet

# IP: bd/system/ip/system_axi_gpio_0_2/system_axi_gpio_0_2.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_2 || ORIG_REF_NAME==system_axi_gpio_0_2} -quiet] -quiet

# IP: bd/system/ip/system_xlconstant_0_0/system_xlconstant_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_xlconstant_0_0 || ORIG_REF_NAME==system_xlconstant_0_0} -quiet] -quiet

# IP: bd/system/ip/system_iir_filter_2nd_order_0_0/system_iir_filter_2nd_order_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_iir_filter_2nd_order_0_0 || ORIG_REF_NAME==system_iir_filter_2nd_order_0_0} -quiet] -quiet

# IP: bd/system/ip/system_dac_0_0/system_dac_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_dac_0_0 || ORIG_REF_NAME==system_dac_0_0} -quiet] -quiet

# IP: bd/system/ip/system_xlconcat_0_0/system_xlconcat_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_xlconcat_0_0 || ORIG_REF_NAME==system_xlconcat_0_0} -quiet] -quiet

# IP: bd/system/ip/system_adc_0_0/system_adc_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_adc_0_0 || ORIG_REF_NAME==system_adc_0_0} -quiet] -quiet

# IP: bd/system/ip/system_xlslice_0_0/system_xlslice_0_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_xlslice_0_0 || ORIG_REF_NAME==system_xlslice_0_0} -quiet] -quiet

# IP: bd/system/ip/system_xlslice_1_0/system_xlslice_1_0.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==system_xlslice_1_0 || ORIG_REF_NAME==system_xlslice_1_0} -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0_board.xdc
set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_pll_0_0 || ORIG_REF_NAME==system_pll_0_0} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0.xdc
#dup# set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_pll_0_0 || ORIG_REF_NAME==system_pll_0_0} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0_ooc.xdc

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_ps_0_0/system_ps_0_0.xdc
set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_ps_0_0 || ORIG_REF_NAME==system_ps_0_0} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0_board.xdc
set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_rst_0_0 || ORIG_REF_NAME==system_rst_0_0} -quiet] {/U0 } ]/U0 ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0.xdc
#dup# set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_rst_0_0 || ORIG_REF_NAME==system_rst_0_0} -quiet] {/U0 } ]/U0 ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_3/system_auto_pc_3_ooc.xdc

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_0/system_auto_pc_0_ooc.xdc

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_1/system_auto_pc_1_ooc.xdc

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_2/system_auto_pc_2_ooc.xdc

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0_board.xdc
set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_0 || ORIG_REF_NAME==system_axi_gpio_0_0} -quiet] {/U0 } ]/U0 ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0_ooc.xdc

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0.xdc
#dup# set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_0 || ORIG_REF_NAME==system_axi_gpio_0_0} -quiet] {/U0 } ]/U0 ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1_board.xdc
set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_1 || ORIG_REF_NAME==system_axi_gpio_0_1} -quiet] {/U0 } ]/U0 ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1_ooc.xdc

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1.xdc
#dup# set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_1 || ORIG_REF_NAME==system_axi_gpio_0_1} -quiet] {/U0 } ]/U0 ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/system_axi_gpio_0_2_board.xdc
set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_2 || ORIG_REF_NAME==system_axi_gpio_0_2} -quiet] {/U0 } ]/U0 ] -quiet] -quiet

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/system_axi_gpio_0_2_ooc.xdc

# XDC: c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/system_axi_gpio_0_2.xdc
#dup# set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_gpio_0_2 || ORIG_REF_NAME==system_axi_gpio_0_2} -quiet] {/U0 } ]/U0 ] -quiet] -quiet

# XDC: C:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/system_ooc.xdc
