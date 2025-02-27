transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xilinx_vip
vlib activehdl/xpm
vlib activehdl/xil_defaultlib
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_vip_v1_1_17
vlib activehdl/processing_system7_vip_v1_0_19
vlib activehdl/xlconstant_v1_1_9
vlib activehdl/lib_cdc_v1_0_3
vlib activehdl/proc_sys_reset_v5_0_15

vmap xilinx_vip activehdl/xilinx_vip
vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 activehdl/axi_vip_v1_1_17
vmap processing_system7_vip_v1_0_19 activehdl/processing_system7_vip_v1_0_19
vmap xlconstant_v1_1_9 activehdl/xlconstant_v1_1_9
vmap lib_cdc_v1_0_3 activehdl/lib_cdc_v1_0_3
vmap proc_sys_reset_v5_0_15 activehdl/proc_sys_reset_v5_0_15

vlog -work xilinx_vip  -sv2k12 "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"../../../bd/system/ip/system_pll_0_0/system_pll_0_0_clk_wiz.v" \
"../../../bd/system/ip/system_pll_0_0/system_pll_0_0.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17  -sv2k12 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"../../../../template1.gen/sources_1/bd/system/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_19  -sv2k12 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"../../../bd/system/ip/system_ps_0_0/sim/system_ps_0_0.v" \

vlog -work xlconstant_v1_1_9  -v2k5 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"../../../../template1.gen/sources_1/bd/system/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"../../../bd/system/ip/system_const_0_0/sim/system_const_0_0.v" \

vcom -work lib_cdc_v1_0_3 -93  \
"../../../../template1.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_15 -93  \
"../../../../template1.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../bd/system/ip/system_rst_0_0/sim/system_rst_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/3242" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../template1.gen/sources_1/bd/system/ipshared/b28c/hdl" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l processing_system7_vip_v1_0_19 -l xlconstant_v1_1_9 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_15 \
"../../../bd/system/ipshared/5641/8e04/inout_buffer.v" \
"../../../bd/system/ipshared/5641/8e04/input_buffer.v" \
"../../../bd/system/ipshared/5641/8e04/output_buffer.v" \
"../../../bd/system/ipshared/5641/56ac/axi_hub.v" \
"../../../bd/system/ip/system_hub_0_0/sim/system_hub_0_0.v" \
"../../../bd/system/ipshared/6dd9/56ac/axis_red_pitaya_adc.v" \
"../../../bd/system/ip/system_adc_0_0/sim/system_adc_0_0.v" \
"../../../bd/system/ipshared/67aa/56ac/axis_red_pitaya_dac.v" \
"../../../bd/system/ip/system_dac_0_0/sim/system_dac_0_0.v" \
"../../../bd/system/sim/system.v" \

vlog -work xil_defaultlib \
"glbl.v"

