# Reusable CDMA-drain hierarchies (subsystem library).
#
# Each proc builds a self-contained hierarchy: a Port-B writer module + BRAM +
# AXI BRAM Controller + CDMA + smartconnects. Boundary pins: S_AXI (regs in),
# M00_AXI (data out -> PS HP -> DDR), s_axi_aclk, s_axi_aresetn, plus the
# module's data inputs. Internally fully wired; you connect only the boundary.
#
# Usage in the Vivado Tcl console (with a block design open):
#   source .../scripts/hier_cdma_drain.tcl
#   create_hier_cell_data_stream [current_bd_instance .] my_stream     ;# 4ch stream
#   create_hier_cell_event_log   [current_bd_instance .] event_log     ;# event logger
# Then wire the boundary pins, validate, and Save Block Design.
#
# create_hier_cell_data_stream is copied verbatim from projects/stream_cdma_4ch
# (proven). create_hier_cell_event_log is derived from it -- verify on first
# regenerate; if a CONFIG/pin errors, that is the block to check.

# =====================================================================
# 4-channel stream drain (verbatim from stream_cdma_4ch/bd.tcl)
# =====================================================================
proc create_hier_cell_data_stream { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_data_stream() - Empty argument(s)!"}
     return
  }

  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  set oldCurInst [current_bd_instance .]
  current_bd_instance $parentObj

  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  # Create pins
  create_bd_pin -dir I -from 15 -to 0 in0
  create_bd_pin -dir I -from 15 -to 0 in1
  create_bd_pin -dir I -from 15 -to 0 in2
  create_bd_pin -dir I -from 15 -to 0 in3
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # axi_bram_ctrl_0
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [list \
    CONFIG.DATA_WIDTH {64} \
    CONFIG.SINGLE_PORT_BRAM {1} \
  ] $axi_bram_ctrl_0

  # axi_cdma_0
  set axi_cdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0 ]
  set_property -dict [list \
    CONFIG.C_INCLUDE_SG {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MAX_BURST_LEN {16} \
  ] $axi_cdma_0

  # bram_interface_0
  set block_name bram_interface
  set block_cell_name bram_interface_0
  if { [catch {set bram_interface_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $bram_interface_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }

  # stream4channel_axi_w_0
  set block_name stream4channel_axi_wrap
  set block_cell_name stream4channel_axi_w_0
  if { [catch {set stream4channel_axi_w_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $stream4channel_axi_w_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }

  # smartconnect_0 (control: PS GP -> {sc1, cdma lite, module regs})
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {3} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_0

  # smartconnect_1 (data: {sc0, cdma M_AXI} -> {DDR, bram ctrl})
  set smartconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_1 ]
  set_property CONFIG.NUM_MI {2} $smartconnect_1

  # Interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_cdma_0_M_AXI [get_bd_intf_pins axi_cdma_0/M_AXI] [get_bd_intf_pins smartconnect_1/S01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins smartconnect_0/M00_AXI] [get_bd_intf_pins smartconnect_1/S00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins smartconnect_0/M01_AXI] [get_bd_intf_pins axi_cdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net smartconnect_1_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins smartconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_1_M01_AXI [get_bd_intf_pins smartconnect_1/M01_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_2_M02_AXI [get_bd_intf_pins smartconnect_0/M02_AXI] [get_bd_intf_pins stream4channel_axi_w_0/s_axi]

  # Port connections
  connect_bd_net -net Net1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins stream4channel_axi_w_0/s_axi_aclk] [get_bd_pins axi_cdma_0/m_axi_aclk] [get_bd_pins axi_cdma_0/s_axi_lite_aclk] [get_bd_pins smartconnect_1/aclk] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net Net2 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins stream4channel_axi_w_0/s_axi_aresetn] [get_bd_pins axi_cdma_0/s_axi_lite_aresetn] [get_bd_pins smartconnect_1/aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net axi_bram_ctrl_0_bram_addr_a [get_bd_pins axi_bram_ctrl_0/bram_addr_a] [get_bd_pins bram_interface_0/addra_axi]
  connect_bd_net -net axi_bram_ctrl_0_bram_clk_a [get_bd_pins axi_bram_ctrl_0/bram_clk_a] [get_bd_pins bram_interface_0/clka] [get_bd_pins bram_interface_0/clkb]
  connect_bd_net -net axi_bram_ctrl_0_bram_en_a [get_bd_pins axi_bram_ctrl_0/bram_en_a] [get_bd_pins bram_interface_0/ena]
  connect_bd_net -net axi_bram_ctrl_0_bram_rst_a [get_bd_pins axi_bram_ctrl_0/bram_rst_a] [get_bd_pins bram_interface_0/rsta]
  connect_bd_net -net axi_bram_ctrl_0_bram_we_a [get_bd_pins axi_bram_ctrl_0/bram_we_a] [get_bd_pins bram_interface_0/wea]
  connect_bd_net -net axi_bram_ctrl_0_bram_wrdata_a [get_bd_pins axi_bram_ctrl_0/bram_wrdata_a] [get_bd_pins bram_interface_0/dina]
  connect_bd_net -net bram_interface_0_douta [get_bd_pins bram_interface_0/douta] [get_bd_pins axi_bram_ctrl_0/bram_rddata_a]
  connect_bd_net -net in0_1 [get_bd_pins in0] [get_bd_pins stream4channel_axi_w_0/in0]
  connect_bd_net -net in1_1 [get_bd_pins in1] [get_bd_pins stream4channel_axi_w_0/in1]
  connect_bd_net -net in2_1 [get_bd_pins in2] [get_bd_pins stream4channel_axi_w_0/in2]
  connect_bd_net -net in3_1 [get_bd_pins in3] [get_bd_pins stream4channel_axi_w_0/in3]
  connect_bd_net -net stream4channel_axi_w_0_bram_addr [get_bd_pins stream4channel_axi_w_0/bram_addr] [get_bd_pins bram_interface_0/addrb]
  connect_bd_net -net stream4channel_axi_w_0_bram_din [get_bd_pins stream4channel_axi_w_0/bram_din] [get_bd_pins bram_interface_0/dinb]
  connect_bd_net -net stream4channel_axi_w_0_bram_en [get_bd_pins stream4channel_axi_w_0/bram_en] [get_bd_pins bram_interface_0/enb]
  connect_bd_net -net stream4channel_axi_w_0_bram_we [get_bd_pins stream4channel_axi_w_0/bram_we] [get_bd_pins bram_interface_0/web]

  current_bd_instance $oldCurInst
}

# =====================================================================
# Event-logger drain (DERIVED from data_stream: module swapped to
# event_logger_axi_wrap; inputs are the peak strobe + energy + chB tag
# instead of 4 sample channels; BRAM is 8192 x 64-bit for the ping-pong).
# Verify on first regenerate.
# =====================================================================
proc create_hier_cell_event_log { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_event_log() - Empty argument(s)!"}
     return
  }

  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  set oldCurInst [current_bd_instance .]
  current_bd_instance $parentObj

  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Boundary pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_pin -dir I peak_detected
  create_bd_pin -dir I -from 15 -to 0 peak_value_in
  create_bd_pin -dir I -from 15 -to 0 chb_raw
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # axi_bram_ctrl_0 (64-bit)
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [list \
    CONFIG.DATA_WIDTH {64} \
    CONFIG.SINGLE_PORT_BRAM {1} \
  ] $axi_bram_ctrl_0

  # axi_cdma_0 (64-bit)
  set axi_cdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0 ]
  set_property -dict [list \
    CONFIG.C_INCLUDE_SG {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MAX_BURST_LEN {16} \
  ] $axi_cdma_0

  # bram_interface_0 (64-bit x 8192 => 2 x 4096-record ping-pong)
  set block_name bram_interface
  set block_cell_name bram_interface_0
  if { [catch {set bram_interface_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>."}
     return 1
   } elseif { $bram_interface_0 eq "" } {
     return 1
   }
  set_property -dict [list \
    CONFIG.DATA_WIDTH {64} \
    CONFIG.ADDR_BITS {13} \
    CONFIG.AXI_ADDR_BITS {16} \
  ] $bram_interface_0

  # event_logger_0
  set block_name event_logger_axi_wrap
  set block_cell_name event_logger_0
  if { [catch {set event_logger_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>."}
     return 1
   } elseif { $event_logger_0 eq "" } {
     return 1
   }

  # axi_interconnect_0 (control: PS GP -> {smartconnect_0, cdma lite, module regs})
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [list CONFIG.NUM_MI {3} CONFIG.NUM_SI {1} ] $axi_interconnect_0

  # smartconnect_0 (data: {interconnect_0, cdma M_AXI} -> {DDR, bram ctrl})
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [list CONFIG.NUM_MI {2} CONFIG.NUM_SI {2} ] $smartconnect_0

  # Interface connections
  connect_bd_intf_net [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net [get_bd_intf_pins axi_cdma_0/M_AXI] [get_bd_intf_pins smartconnect_0/S01_AXI]
  connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins axi_cdma_0/S_AXI_LITE]
  connect_bd_intf_net [get_bd_intf_pins M00_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net [get_bd_intf_pins smartconnect_0/M01_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins event_logger_0/s_axi]

  # Port connections
  connect_bd_net [get_bd_pins s_axi_aclk] \
    [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] \
    [get_bd_pins event_logger_0/s_axi_aclk] \
    [get_bd_pins axi_cdma_0/m_axi_aclk] \
    [get_bd_pins axi_cdma_0/s_axi_lite_aclk] \
    [get_bd_pins axi_interconnect_0/ACLK] \
    [get_bd_pins axi_interconnect_0/S00_ACLK] \
    [get_bd_pins axi_interconnect_0/M00_ACLK] \
    [get_bd_pins axi_interconnect_0/M01_ACLK] \
    [get_bd_pins axi_interconnect_0/M02_ACLK] \
    [get_bd_pins smartconnect_0/aclk]
  connect_bd_net [get_bd_pins s_axi_aresetn] \
    [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] \
    [get_bd_pins event_logger_0/s_axi_aresetn] \
    [get_bd_pins axi_cdma_0/s_axi_lite_aresetn] \
    [get_bd_pins axi_interconnect_0/ARESETN] \
    [get_bd_pins axi_interconnect_0/S00_ARESETN] \
    [get_bd_pins axi_interconnect_0/M00_ARESETN] \
    [get_bd_pins axi_interconnect_0/M01_ARESETN] \
    [get_bd_pins axi_interconnect_0/M02_ARESETN] \
    [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net [get_bd_pins axi_bram_ctrl_0/bram_addr_a] [get_bd_pins bram_interface_0/addra_axi]
  connect_bd_net [get_bd_pins axi_bram_ctrl_0/bram_clk_a] [get_bd_pins bram_interface_0/clka] [get_bd_pins bram_interface_0/clkb]
  connect_bd_net [get_bd_pins axi_bram_ctrl_0/bram_en_a] [get_bd_pins bram_interface_0/ena]
  connect_bd_net [get_bd_pins axi_bram_ctrl_0/bram_rst_a] [get_bd_pins bram_interface_0/rsta]
  connect_bd_net [get_bd_pins axi_bram_ctrl_0/bram_we_a] [get_bd_pins bram_interface_0/wea]
  connect_bd_net [get_bd_pins axi_bram_ctrl_0/bram_wrdata_a] [get_bd_pins bram_interface_0/dina]
  connect_bd_net [get_bd_pins bram_interface_0/douta] [get_bd_pins axi_bram_ctrl_0/bram_rddata_a]
  connect_bd_net [get_bd_pins peak_detected] [get_bd_pins event_logger_0/peak_detected]
  connect_bd_net [get_bd_pins peak_value_in] [get_bd_pins event_logger_0/peak_value_in]
  connect_bd_net [get_bd_pins chb_raw] [get_bd_pins event_logger_0/chb_raw]
  connect_bd_net [get_bd_pins event_logger_0/bram_addr] [get_bd_pins bram_interface_0/addrb]
  connect_bd_net [get_bd_pins event_logger_0/bram_din] [get_bd_pins bram_interface_0/dinb]
  connect_bd_net [get_bd_pins event_logger_0/bram_en] [get_bd_pins bram_interface_0/enb]
  connect_bd_net [get_bd_pins event_logger_0/bram_we] [get_bd_pins bram_interface_0/web]

  current_bd_instance $oldCurInst
}
