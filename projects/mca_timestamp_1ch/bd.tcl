
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2024.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   if { [string compare $scripts_vivado_version $current_vivado_version] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2042 -severity "ERROR" " This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Sourcing the script failed since it was created with a future version of Vivado."}

   } else {
     catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   }

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# axis_red_pitaya_dac, axis_red_pitaya_adc, integrator, fir9_minimal_axi_wrap, iir1st_minimal_axi_wrap, peak_detector_axi_wrap, peak_height_binning_axi_wrap, signed_bitshift, bram_interface, event_logger_axi_wrap

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z010clg400-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:processing_system7:5.5\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:axi_cdma:4.1\
xilinx.com:ip:smartconnect:1.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
axis_red_pitaya_dac\
axis_red_pitaya_adc\
integrator\
fir9_minimal_axi_wrap\
iir1st_minimal_axi_wrap\
peak_detector_axi_wrap\
peak_height_binning_axi_wrap\
signed_bitshift\
bram_interface\
event_logger_axi_wrap\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: event_log
proc create_hier_cell_event_log { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_event_log() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I peak_detected
  create_bd_pin -dir I -from 15 -to 0 peak_value_in
  create_bd_pin -dir I -from 15 -to 0 chb_raw
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [list \
    CONFIG.DATA_WIDTH {64} \
    CONFIG.SINGLE_PORT_BRAM {1} \
  ] $axi_bram_ctrl_0


  # Create instance: axi_cdma_0, and set properties
  set axi_cdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0 ]
  set_property -dict [list \
    CONFIG.C_INCLUDE_SG {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MAX_BURST_LEN {16} \
  ] $axi_cdma_0


  # Create instance: bram_interface_0, and set properties
  set block_name bram_interface
  set block_cell_name bram_interface_0
  if { [catch {set bram_interface_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $bram_interface_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [list \
    CONFIG.ADDR_BITS {13} \
    CONFIG.AXI_ADDR_BITS {16} \
    CONFIG.DATA_WIDTH {64} \
  ] $bram_interface_0


  # Create instance: event_logger_0, and set properties
  set block_name event_logger_axi_wrap
  set block_cell_name event_logger_0
  if { [catch {set event_logger_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $event_logger_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {3} \
    CONFIG.NUM_SI {1} \
  ] $axi_interconnect_0


  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {2} \
    CONFIG.NUM_SI {2} \
  ] $smartconnect_0


  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_cdma_0_M_AXI [get_bd_intf_pins axi_cdma_0/M_AXI] [get_bd_intf_pins smartconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins axi_cdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins event_logger_0/s_axi]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins smartconnect_0/M01_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]

  # Create port connections
  connect_bd_net -net axi_bram_ctrl_0_bram_addr_a [get_bd_pins axi_bram_ctrl_0/bram_addr_a] [get_bd_pins bram_interface_0/addra_axi]
  connect_bd_net -net axi_bram_ctrl_0_bram_clk_a [get_bd_pins axi_bram_ctrl_0/bram_clk_a] [get_bd_pins bram_interface_0/clka] [get_bd_pins bram_interface_0/clkb]
  connect_bd_net -net axi_bram_ctrl_0_bram_en_a [get_bd_pins axi_bram_ctrl_0/bram_en_a] [get_bd_pins bram_interface_0/ena]
  connect_bd_net -net axi_bram_ctrl_0_bram_rst_a [get_bd_pins axi_bram_ctrl_0/bram_rst_a] [get_bd_pins bram_interface_0/rsta]
  connect_bd_net -net axi_bram_ctrl_0_bram_we_a [get_bd_pins axi_bram_ctrl_0/bram_we_a] [get_bd_pins bram_interface_0/wea]
  connect_bd_net -net axi_bram_ctrl_0_bram_wrdata_a [get_bd_pins axi_bram_ctrl_0/bram_wrdata_a] [get_bd_pins bram_interface_0/dina]
  connect_bd_net -net bram_interface_0_douta [get_bd_pins bram_interface_0/douta] [get_bd_pins axi_bram_ctrl_0/bram_rddata_a]
  connect_bd_net -net chb_raw_1 [get_bd_pins chb_raw] [get_bd_pins event_logger_0/chb_raw]
  connect_bd_net -net event_logger_0_bram_addr [get_bd_pins event_logger_0/bram_addr] [get_bd_pins bram_interface_0/addrb]
  connect_bd_net -net event_logger_0_bram_din [get_bd_pins event_logger_0/bram_din] [get_bd_pins bram_interface_0/dinb]
  connect_bd_net -net event_logger_0_bram_en [get_bd_pins event_logger_0/bram_en] [get_bd_pins bram_interface_0/enb]
  connect_bd_net -net event_logger_0_bram_we [get_bd_pins event_logger_0/bram_we] [get_bd_pins bram_interface_0/web]
  connect_bd_net -net peak_detected_1 [get_bd_pins peak_detected] [get_bd_pins event_logger_0/peak_detected]
  connect_bd_net -net peak_value_in_1 [get_bd_pins peak_value_in] [get_bd_pins event_logger_0/peak_value_in]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins event_logger_0/s_axi_aclk] [get_bd_pins axi_cdma_0/m_axi_aclk] [get_bd_pins axi_cdma_0/s_axi_lite_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins event_logger_0/s_axi_aresetn] [get_bd_pins axi_cdma_0/s_axi_lite_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins smartconnect_0/aresetn]

  # Perform GUI Layout
  regenerate_bd_layout -hierarchy [get_bd_cells /event_log] -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"1.43996",
   "Default View_TopLeft":"-172,-126",
   "ExpandedHierarchyInLayout":"",
   "guistr":"# # String gsaved with Nlview 7.7.1 2023-07-26 3bc4126617 VDI=43 GEI=38 GUI=JA:21.0
#  -string -flagsOSRD
preplace port M00_AXI -pg 1 -lvl 6 -x 1730 -y 340 -defaultsOSRD
preplace port S_AXI -pg 1 -lvl 0 -x -20 -y 250 -defaultsOSRD
preplace port port-id_peak_detected -pg 1 -lvl 0 -x -20 -y 560 -defaultsOSRD
preplace port port-id_s_axi_aclk -pg 1 -lvl 0 -x -20 -y 270 -defaultsOSRD
preplace port port-id_s_axi_aresetn -pg 1 -lvl 0 -x -20 -y 290 -defaultsOSRD
preplace portBus peak_value_in -pg 1 -lvl 0 -x -20 -y 580 -defaultsOSRD
preplace portBus chb_raw -pg 1 -lvl 0 -x -20 -y 600 -defaultsOSRD
preplace inst axi_bram_ctrl_0 -pg 1 -lvl 4 -x 1180 -y 120 -defaultsOSRD
preplace inst axi_cdma_0 -pg 1 -lvl 2 -x 500 -y 350 -defaultsOSRD
preplace inst bram_interface_0 -pg 1 -lvl 5 -x 1550 -y 180 -defaultsOSRD
preplace inst event_logger_0 -pg 1 -lvl 2 -x 500 -y 550 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 1 -x 160 -y 190 -defaultsOSRD
preplace inst smartconnect_0 -pg 1 -lvl 3 -x 830 -y 90 -defaultsOSRD
preplace netloc s_axi_aclk_1 1 0 4 10 350 330 260 690 260 960J
preplace netloc s_axi_aresetn_1 1 0 4 20 360 300 440 700 440 970J
preplace netloc axi_bram_ctrl_0_bram_addr_a 1 4 1 1390 70n
preplace netloc axi_bram_ctrl_0_bram_clk_a 1 4 1 1400 80n
preplace netloc axi_bram_ctrl_0_bram_en_a 1 4 1 1360 120n
preplace netloc axi_bram_ctrl_0_bram_rst_a 1 4 1 1350 100n
preplace netloc axi_bram_ctrl_0_bram_we_a 1 4 1 1380 140n
preplace netloc axi_bram_ctrl_0_bram_wrdata_a 1 4 1 1370 110n
preplace netloc bram_interface_0_douta 1 4 2 1340 20 1700
preplace netloc peak_detected_1 1 0 2 NJ 560 NJ
preplace netloc peak_value_in_1 1 0 2 NJ 580 NJ
preplace netloc chb_raw_1 1 0 2 NJ 600 NJ
preplace netloc event_logger_0_bram_addr 1 2 3 N 520 1010J 270 1400J
preplace netloc event_logger_0_bram_din 1 2 3 N 540 1020J 280 NJ
preplace netloc event_logger_0_bram_en 1 2 3 670 450 980J 250 1340J
preplace netloc event_logger_0_bram_we 1 2 3 690 460 1000J 260 1360J
preplace netloc S_AXI_1 1 0 1 0J 90n
preplace netloc axi_cdma_0_M_AXI 1 2 1 670 80n
preplace netloc axi_interconnect_0_M00_AXI 1 1 2 330 -20 670J
preplace netloc axi_interconnect_0_M01_AXI 1 1 1 320 190n
preplace netloc smartconnect_0_M00_AXI 1 3 3 990J 340 NJ 340 N
preplace netloc smartconnect_0_M01_AXI 1 3 1 N 100
preplace netloc axi_interconnect_0_M02_AXI 1 1 1 310 210n
levelinfo -pg 1 -20 160 500 830 1180 1550 1730
pagesize -pg 1 -db -bbox -sgen -210 -70 1830 650
"
}

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: MCA1
proc create_hier_cell_MCA1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_MCA1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi3


  # Create pins
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -from 15 -to 0 x_in
  create_bd_pin -dir O -from 15 -to 0 y_out
  create_bd_pin -dir O -from 15 -to 0 x_in_filtered
  create_bd_pin -dir O peak_detected_out
  create_bd_pin -dir O -from 15 -to 0 peak_value_out

  # Create instance: integrator_0, and set properties
  set block_name integrator
  set block_cell_name integrator_0
  if { [catch {set integrator_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $integrator_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [list \
    CONFIG.LOG_DIV {1} \
    CONFIG.OUT_DATA_WIDTH {18} \
  ] $integrator_0


  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_0


  # Create instance: fir9_minimal_axi_wrap_0, and set properties
  set block_name fir9_minimal_axi_wrap
  set block_cell_name fir9_minimal_axi_wrap_0
  if { [catch {set fir9_minimal_axi_wrap_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $fir9_minimal_axi_wrap_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: iir1st_minimal_axi_0, and set properties
  set block_name iir1st_minimal_axi_wrap
  set block_cell_name iir1st_minimal_axi_0
  if { [catch {set iir1st_minimal_axi_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $iir1st_minimal_axi_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property CONFIG.OUT_DATA_WIDTH {16} $iir1st_minimal_axi_0


  # Create instance: peak_detector_axi_wr_0, and set properties
  set block_name peak_detector_axi_wrap
  set block_cell_name peak_detector_axi_wr_0
  if { [catch {set peak_detector_axi_wr_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $peak_detector_axi_wr_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: peak_height_binning_0, and set properties
  set block_name peak_height_binning_axi_wrap
  set block_cell_name peak_height_binning_0
  if { [catch {set peak_height_binning_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $peak_height_binning_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: signed_bitshift_0, and set properties
  set block_name signed_bitshift
  set block_cell_name signed_bitshift_0
  if { [catch {set signed_bitshift_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signed_bitshift_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins fir9_minimal_axi_wrap_0/s_axi] [get_bd_intf_pins s_axi]
  connect_bd_intf_net -intf_net S_AXI1_1 [get_bd_intf_pins S_AXI1] [get_bd_intf_pins iir1st_minimal_axi_0/s_axi]
  connect_bd_intf_net -intf_net s_axi2_1 [get_bd_intf_pins s_axi2] [get_bd_intf_pins peak_detector_axi_wr_0/s_axi]
  connect_bd_intf_net -intf_net s_axi3_1 [get_bd_intf_pins s_axi3] [get_bd_intf_pins peak_height_binning_0/s_axi]

  # Create port connections
  connect_bd_net -net fir9_minimal_axi_wrap_0_y_out [get_bd_pins fir9_minimal_axi_wrap_0/y_out] [get_bd_pins signed_bitshift_0/din] [get_bd_pins peak_detector_axi_wr_0/x_in]
  connect_bd_net -net iir1st_minimal_axi_w_0_y_out [get_bd_pins iir1st_minimal_axi_0/y_out] [get_bd_pins fir9_minimal_axi_wrap_0/x_in]
  connect_bd_net -net integrator_0_counter_clk [get_bd_pins integrator_0/counter_clk] [get_bd_pins iir1st_minimal_axi_0/slow_clk] [get_bd_pins peak_detector_axi_wr_0/slow_clk] [get_bd_pins peak_height_binning_0/slow_clk] [get_bd_pins fir9_minimal_axi_wrap_0/slow_clk]
  connect_bd_net -net integrator_0_x_out [get_bd_pins integrator_0/x_out] [get_bd_pins iir1st_minimal_axi_0/x_in]
  connect_bd_net -net peak_detector_axi_wr_0_peak_detected [get_bd_pins peak_detector_axi_wr_0/peak_detected_out] [get_bd_pins peak_detected_out] [get_bd_pins peak_height_binning_0/peak_detected]
  connect_bd_net -net peak_detector_axi_wr_0_peak_value_out [get_bd_pins peak_detector_axi_wr_0/peak_value_out] [get_bd_pins peak_value_out] [get_bd_pins peak_height_binning_0/peak_value_in]
  connect_bd_net -net peak_height_binning_0_band_detected [get_bd_pins peak_height_binning_0/band_detected] [get_bd_pins y_out]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins integrator_0/clk] [get_bd_pins iir1st_minimal_axi_0/s_axi_aclk] [get_bd_pins peak_detector_axi_wr_0/s_axi_aclk] [get_bd_pins peak_height_binning_0/s_axi_aclk] [get_bd_pins fir9_minimal_axi_wrap_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins iir1st_minimal_axi_0/s_axi_aresetn] [get_bd_pins peak_detector_axi_wr_0/s_axi_aresetn] [get_bd_pins peak_height_binning_0/s_axi_aresetn] [get_bd_pins fir9_minimal_axi_wrap_0/s_axi_aresetn]
  connect_bd_net -net signed_bitshift_0_dout [get_bd_pins signed_bitshift_0/dout] [get_bd_pins x_in_filtered]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins util_vector_logic_0/Res] [get_bd_pins integrator_0/rst]
  connect_bd_net -net x_in_1 [get_bd_pins x_in] [get_bd_pins integrator_0/x_in]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: adc
proc create_hier_cell_adc { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_adc() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 15 -to 0 Dout0
  create_bd_pin -dir O -from 15 -to 0 Dout1
  create_bd_pin -dir O m_axis_tvalid
  create_bd_pin -dir I -from 15 -to 0 adc_dat_b_i
  create_bd_pin -dir I -from 15 -to 0 adc_dat_a_i
  create_bd_pin -dir O adc_csn_o
  create_bd_pin -dir I -type clk aclk

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {15} \
    CONFIG.DIN_TO {0} \
  ] $xlslice_0


  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {31} \
    CONFIG.DIN_TO {16} \
  ] $xlslice_1


  # Create instance: axis_red_pitaya_adc_0, and set properties
  set block_name axis_red_pitaya_adc
  set block_cell_name axis_red_pitaya_adc_0
  if { [catch {set axis_red_pitaya_adc_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axis_red_pitaya_adc_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_red_pitaya_adc_0/aclk]
  connect_bd_net -net adc_0_m_axis_tdata [get_bd_pins axis_red_pitaya_adc_0/m_axis_tdata] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net adc_dat_a_i_1 [get_bd_pins adc_dat_a_i] [get_bd_pins axis_red_pitaya_adc_0/adc_dat_a]
  connect_bd_net -net adc_dat_b_i_1 [get_bd_pins adc_dat_b_i] [get_bd_pins axis_red_pitaya_adc_0/adc_dat_b]
  connect_bd_net -net axis_red_pitaya_adc_0_adc_csn [get_bd_pins axis_red_pitaya_adc_0/adc_csn] [get_bd_pins adc_csn_o]
  connect_bd_net -net axis_red_pitaya_adc_0_m_axis_tvalid [get_bd_pins axis_red_pitaya_adc_0/m_axis_tvalid] [get_bd_pins m_axis_tvalid]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins Dout0]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins xlslice_1/Dout] [get_bd_pins Dout1]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: dac
proc create_hier_cell_dac { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_dac() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I s_axis_tvalid
  create_bd_pin -dir O -from 13 -to 0 dac_dat_o
  create_bd_pin -dir O -type clk dac_clk_o
  create_bd_pin -dir O -type rst dac_rst_o
  create_bd_pin -dir O dac_wrt_o
  create_bd_pin -dir O dac_sel_o
  create_bd_pin -dir I locked
  create_bd_pin -dir I -type clk wrt_clk
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type clk ddr_clk
  create_bd_pin -dir I -from 15 -to 0 In1
  create_bd_pin -dir I -from 15 -to 0 In0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [list \
    CONFIG.IN0_WIDTH {16} \
    CONFIG.IN1_WIDTH {16} \
  ] $xlconcat_0


  # Create instance: axis_red_pitaya_dac_0, and set properties
  set block_name axis_red_pitaya_dac
  set block_cell_name axis_red_pitaya_dac_0
  if { [catch {set axis_red_pitaya_dac_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axis_red_pitaya_dac_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net In0_1 [get_bd_pins In0] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net In1_1 [get_bd_pins In1] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_red_pitaya_dac_0/aclk]
  connect_bd_net -net axis_red_pitaya_dac_1_dac_clk [get_bd_pins axis_red_pitaya_dac_0/dac_clk] [get_bd_pins dac_clk_o]
  connect_bd_net -net axis_red_pitaya_dac_1_dac_dat [get_bd_pins axis_red_pitaya_dac_0/dac_dat] [get_bd_pins dac_dat_o]
  connect_bd_net -net axis_red_pitaya_dac_1_dac_rst [get_bd_pins axis_red_pitaya_dac_0/dac_rst] [get_bd_pins dac_rst_o]
  connect_bd_net -net axis_red_pitaya_dac_1_dac_sel [get_bd_pins axis_red_pitaya_dac_0/dac_sel] [get_bd_pins dac_sel_o]
  connect_bd_net -net axis_red_pitaya_dac_1_dac_wrt [get_bd_pins axis_red_pitaya_dac_0/dac_wrt] [get_bd_pins dac_wrt_o]
  connect_bd_net -net ddr_clk_1 [get_bd_pins ddr_clk] [get_bd_pins axis_red_pitaya_dac_0/ddr_clk]
  connect_bd_net -net locked_1 [get_bd_pins locked] [get_bd_pins axis_red_pitaya_dac_0/locked]
  connect_bd_net -net s_axis_tvalid_1 [get_bd_pins s_axis_tvalid] [get_bd_pins axis_red_pitaya_dac_0/s_axis_tvalid]
  connect_bd_net -net wrt_clk_1 [get_bd_pins wrt_clk] [get_bd_pins axis_red_pitaya_dac_0/wrt_clk]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins xlconcat_0/dout] [get_bd_pins axis_red_pitaya_dac_0/s_axis_tdata]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: soc
proc create_hier_cell_soc { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_soc() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI


  # Create pins
  create_bd_pin -dir I -type clk M_AXI_GP0_ACLK
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn

  # Create instance: ps_0, and set properties
  set ps_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 ps_0 ]
  set_property -dict [list \
    CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {666.666687} \
    CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
    CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
    CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {50.000000} \
    CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
    CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {100.000000} \
    CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
    CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {166.666672} \
    CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
    CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
    CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
    CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
    CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
    CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
    CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
    CONFIG.PCW_ACT_TTC_PERIPHERAL_FREQMHZ {50} \
    CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {100.000000} \
    CONFIG.PCW_ACT_USB0_PERIPHERAL_FREQMHZ {60} \
    CONFIG.PCW_ACT_USB1_PERIPHERAL_FREQMHZ {60} \
    CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {111.111115} \
    CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} \
    CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {666.666666} \
    CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC {External} \
    CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC {External} \
    CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_CAN_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_CAN_PERIPHERAL_VALID {0} \
    CONFIG.PCW_CLK0_FREQ {50000000} \
    CONFIG.PCW_CLK1_FREQ {10000000} \
    CONFIG.PCW_CLK2_FREQ {10000000} \
    CONFIG.PCW_CLK3_FREQ {10000000} \
    CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE {667} \
    CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
    CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} \
    CONFIG.PCW_DCI_PERIPHERAL_CLKSRC {DDR PLL} \
    CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ {10.159} \
    CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} \
    CONFIG.PCW_DDR_RAM_HIGHADDR {0x1FFFFFFF} \
    CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
    CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
    CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
    CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
    CONFIG.PCW_ENET0_RESET_ENABLE {0} \
    CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_ENET_RESET_ENABLE {1} \
    CONFIG.PCW_ENET_RESET_POLARITY {Active Low} \
    CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
    CONFIG.PCW_EN_4K_TIMER {0} \
    CONFIG.PCW_EN_CAN0 {0} \
    CONFIG.PCW_EN_CAN1 {0} \
    CONFIG.PCW_EN_CLK0_PORT {1} \
    CONFIG.PCW_EN_CLK1_PORT {0} \
    CONFIG.PCW_EN_CLK2_PORT {0} \
    CONFIG.PCW_EN_CLK3_PORT {0} \
    CONFIG.PCW_EN_DDR {1} \
    CONFIG.PCW_EN_EMIO_CAN0 {0} \
    CONFIG.PCW_EN_EMIO_CAN1 {0} \
    CONFIG.PCW_EN_EMIO_CD_SDIO0 {0} \
    CONFIG.PCW_EN_EMIO_CD_SDIO1 {0} \
    CONFIG.PCW_EN_EMIO_ENET0 {0} \
    CONFIG.PCW_EN_EMIO_ENET1 {0} \
    CONFIG.PCW_EN_EMIO_GPIO {1} \
    CONFIG.PCW_EN_EMIO_I2C0 {0} \
    CONFIG.PCW_EN_EMIO_I2C1 {0} \
    CONFIG.PCW_EN_EMIO_MODEM_UART0 {0} \
    CONFIG.PCW_EN_EMIO_MODEM_UART1 {0} \
    CONFIG.PCW_EN_EMIO_PJTAG {0} \
    CONFIG.PCW_EN_EMIO_SDIO0 {0} \
    CONFIG.PCW_EN_EMIO_SDIO1 {0} \
    CONFIG.PCW_EN_EMIO_SPI0 {1} \
    CONFIG.PCW_EN_EMIO_SPI1 {0} \
    CONFIG.PCW_EN_EMIO_SRAM_INT {0} \
    CONFIG.PCW_EN_EMIO_TRACE {0} \
    CONFIG.PCW_EN_EMIO_TTC0 {0} \
    CONFIG.PCW_EN_EMIO_TTC1 {0} \
    CONFIG.PCW_EN_EMIO_UART0 {0} \
    CONFIG.PCW_EN_EMIO_UART1 {0} \
    CONFIG.PCW_EN_EMIO_WDT {0} \
    CONFIG.PCW_EN_EMIO_WP_SDIO0 {0} \
    CONFIG.PCW_EN_EMIO_WP_SDIO1 {0} \
    CONFIG.PCW_EN_ENET0 {1} \
    CONFIG.PCW_EN_ENET1 {0} \
    CONFIG.PCW_EN_GPIO {1} \
    CONFIG.PCW_EN_I2C0 {1} \
    CONFIG.PCW_EN_I2C1 {0} \
    CONFIG.PCW_EN_MODEM_UART0 {0} \
    CONFIG.PCW_EN_MODEM_UART1 {0} \
    CONFIG.PCW_EN_PJTAG {0} \
    CONFIG.PCW_EN_QSPI {0} \
    CONFIG.PCW_EN_SDIO0 {1} \
    CONFIG.PCW_EN_SDIO1 {0} \
    CONFIG.PCW_EN_SMC {0} \
    CONFIG.PCW_EN_SPI0 {1} \
    CONFIG.PCW_EN_SPI1 {1} \
    CONFIG.PCW_EN_TRACE {0} \
    CONFIG.PCW_EN_TTC0 {0} \
    CONFIG.PCW_EN_TTC1 {0} \
    CONFIG.PCW_EN_UART0 {1} \
    CONFIG.PCW_EN_UART1 {1} \
    CONFIG.PCW_EN_USB0 {1} \
    CONFIG.PCW_EN_USB1 {0} \
    CONFIG.PCW_EN_WDT {0} \
    CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_FCLK_CLK0_BUF {TRUE} \
    CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {50} \
    CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {50} \
    CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {50} \
    CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {50} \
    CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
    CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
    CONFIG.PCW_GPIO_EMIO_GPIO_IO {64} \
    CONFIG.PCW_GPIO_EMIO_GPIO_WIDTH {64} \
    CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
    CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
    CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} \
    CONFIG.PCW_I2C0_I2C0_IO {MIO 50 .. 51} \
    CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_I2C0_RESET_ENABLE {0} \
    CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {111.111115} \
    CONFIG.PCW_I2C_RESET_ENABLE {1} \
    CONFIG.PCW_I2C_RESET_POLARITY {Active Low} \
    CONFIG.PCW_I2C_RESET_SELECT {Share reset pin} \
    CONFIG.PCW_IMPORT_BOARD_PRESET {cfg/red_pitaya.xml} \
    CONFIG.PCW_IRQ_F2P_MODE {DIRECT} \
    CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_0_PULLUP {disabled} \
    CONFIG.PCW_MIO_0_SLEW {slow} \
    CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_10_PULLUP {enabled} \
    CONFIG.PCW_MIO_10_SLEW {slow} \
    CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_11_PULLUP {enabled} \
    CONFIG.PCW_MIO_11_SLEW {slow} \
    CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_12_PULLUP {enabled} \
    CONFIG.PCW_MIO_12_SLEW {slow} \
    CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_13_PULLUP {enabled} \
    CONFIG.PCW_MIO_13_SLEW {slow} \
    CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_14_PULLUP {enabled} \
    CONFIG.PCW_MIO_14_SLEW {slow} \
    CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_15_PULLUP {enabled} \
    CONFIG.PCW_MIO_15_SLEW {slow} \
    CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_16_PULLUP {disabled} \
    CONFIG.PCW_MIO_16_SLEW {fast} \
    CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_17_PULLUP {disabled} \
    CONFIG.PCW_MIO_17_SLEW {fast} \
    CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_18_PULLUP {disabled} \
    CONFIG.PCW_MIO_18_SLEW {fast} \
    CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_19_PULLUP {disabled} \
    CONFIG.PCW_MIO_19_SLEW {fast} \
    CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_1_PULLUP {enabled} \
    CONFIG.PCW_MIO_1_SLEW {slow} \
    CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_20_PULLUP {disabled} \
    CONFIG.PCW_MIO_20_SLEW {fast} \
    CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_21_PULLUP {disabled} \
    CONFIG.PCW_MIO_21_SLEW {fast} \
    CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_22_PULLUP {disabled} \
    CONFIG.PCW_MIO_22_SLEW {fast} \
    CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_23_PULLUP {disabled} \
    CONFIG.PCW_MIO_23_SLEW {fast} \
    CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_24_PULLUP {disabled} \
    CONFIG.PCW_MIO_24_SLEW {fast} \
    CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_25_PULLUP {disabled} \
    CONFIG.PCW_MIO_25_SLEW {fast} \
    CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_26_PULLUP {disabled} \
    CONFIG.PCW_MIO_26_SLEW {fast} \
    CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_27_PULLUP {disabled} \
    CONFIG.PCW_MIO_27_SLEW {fast} \
    CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_28_PULLUP {enabled} \
    CONFIG.PCW_MIO_28_SLEW {fast} \
    CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_29_PULLUP {enabled} \
    CONFIG.PCW_MIO_29_SLEW {fast} \
    CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_2_SLEW {slow} \
    CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_30_PULLUP {enabled} \
    CONFIG.PCW_MIO_30_SLEW {fast} \
    CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_31_PULLUP {enabled} \
    CONFIG.PCW_MIO_31_SLEW {fast} \
    CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_32_PULLUP {enabled} \
    CONFIG.PCW_MIO_32_SLEW {fast} \
    CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_33_PULLUP {enabled} \
    CONFIG.PCW_MIO_33_SLEW {fast} \
    CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_34_PULLUP {enabled} \
    CONFIG.PCW_MIO_34_SLEW {fast} \
    CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_35_PULLUP {enabled} \
    CONFIG.PCW_MIO_35_SLEW {fast} \
    CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_36_PULLUP {enabled} \
    CONFIG.PCW_MIO_36_SLEW {fast} \
    CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_37_PULLUP {enabled} \
    CONFIG.PCW_MIO_37_SLEW {fast} \
    CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_38_PULLUP {enabled} \
    CONFIG.PCW_MIO_38_SLEW {fast} \
    CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_39_PULLUP {enabled} \
    CONFIG.PCW_MIO_39_SLEW {fast} \
    CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_3_SLEW {slow} \
    CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_40_PULLUP {enabled} \
    CONFIG.PCW_MIO_40_SLEW {slow} \
    CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_41_PULLUP {enabled} \
    CONFIG.PCW_MIO_41_SLEW {slow} \
    CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_42_PULLUP {enabled} \
    CONFIG.PCW_MIO_42_SLEW {slow} \
    CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_43_PULLUP {enabled} \
    CONFIG.PCW_MIO_43_SLEW {slow} \
    CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_44_PULLUP {enabled} \
    CONFIG.PCW_MIO_44_SLEW {slow} \
    CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_45_PULLUP {enabled} \
    CONFIG.PCW_MIO_45_SLEW {slow} \
    CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_46_PULLUP {enabled} \
    CONFIG.PCW_MIO_46_SLEW {slow} \
    CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_47_PULLUP {enabled} \
    CONFIG.PCW_MIO_47_SLEW {slow} \
    CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_48_PULLUP {enabled} \
    CONFIG.PCW_MIO_48_SLEW {slow} \
    CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_49_PULLUP {enabled} \
    CONFIG.PCW_MIO_49_SLEW {slow} \
    CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_4_SLEW {slow} \
    CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_50_PULLUP {enabled} \
    CONFIG.PCW_MIO_50_SLEW {slow} \
    CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_51_PULLUP {enabled} \
    CONFIG.PCW_MIO_51_SLEW {slow} \
    CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_52_PULLUP {enabled} \
    CONFIG.PCW_MIO_52_SLEW {slow} \
    CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 2.5V} \
    CONFIG.PCW_MIO_53_PULLUP {enabled} \
    CONFIG.PCW_MIO_53_SLEW {slow} \
    CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_5_SLEW {slow} \
    CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_6_SLEW {slow} \
    CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_7_SLEW {slow} \
    CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_8_SLEW {slow} \
    CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
    CONFIG.PCW_MIO_9_PULLUP {enabled} \
    CONFIG.PCW_MIO_9_SLEW {slow} \
    CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#UART 1#UART 1#SPI 1#SPI 1#SPI 1#SPI 1#UART 0#UART 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet\
0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#USB Reset#GPIO#I2C 0#I2C 0#Enet 0#Enet 0} \
    CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#gpio[1]#gpio[2]#gpio[3]#gpio[4]#gpio[5]#gpio[6]#gpio[7]#tx#rx#mosi#miso#sclk#ss[0]#rx#tx#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#cd#wp#reset#gpio[49]#scl#sda#mdc#mdio}\
\
    CONFIG.PCW_NAND_CYCLES_T_AR {1} \
    CONFIG.PCW_NAND_CYCLES_T_CLR {1} \
    CONFIG.PCW_NAND_CYCLES_T_RC {11} \
    CONFIG.PCW_NAND_CYCLES_T_REA {1} \
    CONFIG.PCW_NAND_CYCLES_T_RR {1} \
    CONFIG.PCW_NAND_CYCLES_T_WC {11} \
    CONFIG.PCW_NAND_CYCLES_T_WP {1} \
    CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_NOR_CS0_T_CEOE {1} \
    CONFIG.PCW_NOR_CS0_T_PC {1} \
    CONFIG.PCW_NOR_CS0_T_RC {11} \
    CONFIG.PCW_NOR_CS0_T_TR {1} \
    CONFIG.PCW_NOR_CS0_T_WC {11} \
    CONFIG.PCW_NOR_CS0_T_WP {1} \
    CONFIG.PCW_NOR_CS0_WE_TIME {0} \
    CONFIG.PCW_NOR_CS1_T_CEOE {1} \
    CONFIG.PCW_NOR_CS1_T_PC {1} \
    CONFIG.PCW_NOR_CS1_T_RC {11} \
    CONFIG.PCW_NOR_CS1_T_TR {1} \
    CONFIG.PCW_NOR_CS1_T_WC {11} \
    CONFIG.PCW_NOR_CS1_T_WP {1} \
    CONFIG.PCW_NOR_CS1_WE_TIME {0} \
    CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_NOR_SRAM_CS0_T_CEOE {1} \
    CONFIG.PCW_NOR_SRAM_CS0_T_PC {1} \
    CONFIG.PCW_NOR_SRAM_CS0_T_RC {11} \
    CONFIG.PCW_NOR_SRAM_CS0_T_TR {1} \
    CONFIG.PCW_NOR_SRAM_CS0_T_WC {11} \
    CONFIG.PCW_NOR_SRAM_CS0_T_WP {1} \
    CONFIG.PCW_NOR_SRAM_CS0_WE_TIME {0} \
    CONFIG.PCW_NOR_SRAM_CS1_T_CEOE {1} \
    CONFIG.PCW_NOR_SRAM_CS1_T_PC {1} \
    CONFIG.PCW_NOR_SRAM_CS1_T_RC {11} \
    CONFIG.PCW_NOR_SRAM_CS1_T_TR {1} \
    CONFIG.PCW_NOR_SRAM_CS1_T_WC {11} \
    CONFIG.PCW_NOR_SRAM_CS1_T_WP {1} \
    CONFIG.PCW_NOR_SRAM_CS1_WE_TIME {0} \
    CONFIG.PCW_OVERRIDE_BASIC_CLOCK {0} \
    CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.080} \
    CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.063} \
    CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.057} \
    CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.068} \
    CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {-0.047} \
    CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {-0.025} \
    CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {-0.006} \
    CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {-0.017} \
    CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ {200} \
    CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_PLL_BYPASSMODE_ENABLE {0} \
    CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
    CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 2.5V} \
    CONFIG.PCW_QSPI_INTERNAL_HIGHADDRESS {0xFCFFFFFF} \
    CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
    CONFIG.PCW_SD0_GRP_CD_IO {MIO 46} \
    CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
    CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
    CONFIG.PCW_SD0_GRP_WP_IO {MIO 47} \
    CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
    CONFIG.PCW_SD1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {100} \
    CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
    CONFIG.PCW_SMC_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_SMC_PERIPHERAL_VALID {0} \
    CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_SPI0_SPI0_IO {EMIO} \
    CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} \
    CONFIG.PCW_SPI1_GRP_SS2_ENABLE {0} \
    CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_SPI1_SPI1_IO {MIO 10 .. 15} \
    CONFIG.PCW_SPI_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ {166.666666} \
    CONFIG.PCW_SPI_PERIPHERAL_VALID {1} \
    CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {64} \
    CONFIG.PCW_S_AXI_HP1_DATA_WIDTH {64} \
    CONFIG.PCW_S_AXI_HP2_DATA_WIDTH {64} \
    CONFIG.PCW_S_AXI_HP3_DATA_WIDTH {64} \
    CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC {External} \
    CONFIG.PCW_TRACE_INTERNAL_WIDTH {2} \
    CONFIG.PCW_TRACE_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
    CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0 {1} \
    CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
    CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0 {1} \
    CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
    CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0 {1} \
    CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
    CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0 {1} \
    CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
    CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0 {1} \
    CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
    CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0 {1} \
    CONFIG.PCW_TTC1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_UART0_BAUD_RATE {115200} \
    CONFIG.PCW_UART0_GRP_FULL_ENABLE {0} \
    CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_UART0_UART0_IO {MIO 14 .. 15} \
    CONFIG.PCW_UART1_BAUD_RATE {115200} \
    CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
    CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_UART1_UART1_IO {MIO 8 .. 9} \
    CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} \
    CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {100} \
    CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
    CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
    CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {0} \
    CONFIG.PCW_UIPARAM_DDR_AL {0} \
    CONFIG.PCW_UIPARAM_DDR_BL {8} \
    CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.25} \
    CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.25} \
    CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.25} \
    CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.25} \
    CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {16 Bit} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {54.563} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {54.563} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {54.563} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {54.563} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN {0} \
    CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {101.239} \
    CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {79.5025} \
    CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {60.536} \
    CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {71.7715} \
    CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.0} \
    CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.0} \
    CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.0} \
    CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.0} \
    CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {104.5365} \
    CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {70.676} \
    CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {59.1615} \
    CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {0} \
    CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {81.319} \
    CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY {160} \
    CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
    CONFIG.PCW_UIPARAM_DDR_ENABLE {1} \
    CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533.333333} \
    CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP {Normal (0-85)} \
    CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} \
    CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J256M16 RE-125} \
    CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
    CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
    CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
    CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {0} \
    CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_USB0_RESET_ENABLE {1} \
    CONFIG.PCW_USB0_RESET_IO {MIO 48} \
    CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
    CONFIG.PCW_USB1_PERIPHERAL_ENABLE {0} \
    CONFIG.PCW_USB_RESET_ENABLE {1} \
    CONFIG.PCW_USB_RESET_POLARITY {Active Low} \
    CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
    CONFIG.PCW_USE_AXI_NONSECURE {0} \
    CONFIG.PCW_USE_CROSS_TRIGGER {0} \
    CONFIG.PCW_USE_S_AXI_HP0 {1} \
    CONFIG.PCW_WDT_PERIPHERAL_CLKSRC {CPU_1X} \
    CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0 {1} \
    CONFIG.PCW_WDT_PERIPHERAL_ENABLE {0} \
  ] $ps_0


  # Create instance: rst_0, and set properties
  set rst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_0 ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [list \
    CONFIG.M00_HAS_REGSLICE {1} \
    CONFIG.M01_HAS_REGSLICE {1} \
    CONFIG.M02_HAS_REGSLICE {1} \
    CONFIG.M03_HAS_REGSLICE {1} \
    CONFIG.M04_HAS_REGSLICE {1} \
    CONFIG.NUM_MI {5} \
    CONFIG.S00_HAS_REGSLICE {1} \
  ] $axi_interconnect_0


  # Create instance: const_0, and set properties
  set const_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins ps_0/DDR] [get_bd_intf_pins DDR]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins ps_0/FIXED_IO] [get_bd_intf_pins FIXED_IO]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins M01_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins ps_0/S_AXI_HP0] [get_bd_intf_pins S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins M02_AXI] [get_bd_intf_pins axi_interconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins M03_AXI] [get_bd_intf_pins axi_interconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins M04_AXI] [get_bd_intf_pins axi_interconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net ps_0_M_AXI_GP0 [get_bd_intf_pins ps_0/M_AXI_GP0] [get_bd_intf_pins axi_interconnect_0/S00_AXI]

  # Create port connections
  connect_bd_net -net M_AXI_GP0_ACLK_1 [get_bd_pins M_AXI_GP0_ACLK] [get_bd_pins ps_0/M_AXI_GP0_ACLK] [get_bd_pins rst_0/slowest_sync_clk] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins ps_0/S_AXI_HP0_ACLK] [get_bd_pins axi_interconnect_0/M04_ACLK]
  connect_bd_net -net const_0_dout [get_bd_pins const_0/dout] [get_bd_pins rst_0/ext_reset_in]
  connect_bd_net -net dcm_locked_1 [get_bd_pins dcm_locked] [get_bd_pins rst_0/dcm_locked]
  connect_bd_net -net rst_0_interconnect_aresetn [get_bd_pins rst_0/interconnect_aresetn] [get_bd_pins axi_interconnect_0/ARESETN]
  connect_bd_net -net rst_0_peripheral_aresetn [get_bd_pins rst_0/peripheral_aresetn] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins peripheral_aresetn] [get_bd_pins axi_interconnect_0/M04_ARESETN]

  # Perform GUI Layout
  regenerate_bd_layout -hierarchy [get_bd_cells /soc] -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"1.35744",
   "Default View_TopLeft":"-542,-7",
   "ExpandedHierarchyInLayout":"",
   "guistr":"# # String gsaved with Nlview 7.7.1 2023-07-26 3bc4126617 VDI=43 GEI=38 GUI=JA:21.0
#  -string -flagsOSRD
preplace port DDR -pg 1 -lvl 4 -x 940 -y 60 -defaultsOSRD
preplace port FIXED_IO -pg 1 -lvl 4 -x 940 -y 90 -defaultsOSRD
preplace port M00_AXI -pg 1 -lvl 4 -x 940 -y 550 -defaultsOSRD
preplace port M01_AXI -pg 1 -lvl 4 -x 940 -y 580 -defaultsOSRD
preplace port M02_AXI -pg 1 -lvl 4 -x 940 -y 610 -defaultsOSRD
preplace port M03_AXI -pg 1 -lvl 4 -x 940 -y 640 -defaultsOSRD
preplace port S_AXI_HP0 -pg 1 -lvl 0 -x 0 -y 90 -defaultsOSRD
preplace port M04_AXI -pg 1 -lvl 4 -x 940 -y 520 -defaultsOSRD
preplace port port-id_M_AXI_GP0_ACLK -pg 1 -lvl 0 -x 0 -y 120 -defaultsOSRD
preplace port port-id_dcm_locked -pg 1 -lvl 0 -x 0 -y 390 -defaultsOSRD
preplace portBus peripheral_aresetn -pg 1 -lvl 4 -x 940 -y 270 -defaultsOSRD
preplace inst ps_0 -pg 1 -lvl 2 -x 390 -y 120 -defaultsOSRD
preplace inst rst_0 -pg 1 -lvl 2 -x 390 -y 350 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 3 -x 760 -y 770 -defaultsOSRD
preplace inst const_0 -pg 1 -lvl 1 -x 100 -y 330 -defaultsOSRD
preplace netloc M_AXI_GP0_ACLK_1 1 0 3 NJ 120 180 250 610
preplace netloc const_0_dout 1 1 1 NJ 330
preplace netloc dcm_locked_1 1 0 2 NJ 390 NJ
preplace netloc rst_0_interconnect_aresetn 1 2 1 N 370
preplace netloc rst_0_peripheral_aresetn 1 2 2 600 270 NJ
preplace netloc Conn1 1 2 2 NJ 70 900J
preplace netloc Conn2 1 2 2 NJ 90 NJ
preplace netloc Conn3 1 3 1 920J 580n
preplace netloc Conn4 1 0 2 20J 100 180J
preplace netloc Conn5 1 3 1 910 520n
preplace netloc axi_interconnect_0_M00_AXI 1 3 1 900J 550n
preplace netloc axi_interconnect_0_M02_AXI 1 3 1 920J 610n
preplace netloc axi_interconnect_0_M03_AXI 1 3 1 NJ 640
preplace netloc ps_0_M_AXI_GP0 1 2 1 620 150n
levelinfo -pg 1 0 100 390 760 940
pagesize -pg 1 -db -bbox -sgen -160 -10 1140 1270
"
}

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set Vp_Vn [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 Vp_Vn ]

  set Vaux0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux0 ]

  set Vaux1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux1 ]

  set Vaux9 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux9 ]

  set Vaux8 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 Vaux8 ]

  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]

  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]


  # Create ports
  set adc_dat_a_i [ create_bd_port -dir I -from 15 -to 0 adc_dat_a_i ]
  set adc_dat_b_i [ create_bd_port -dir I -from 15 -to 0 adc_dat_b_i ]
  set adc_clk_p_i [ create_bd_port -dir I adc_clk_p_i ]
  set adc_clk_n_i [ create_bd_port -dir I adc_clk_n_i ]
  set adc_enc_p_o [ create_bd_port -dir O adc_enc_p_o ]
  set adc_enc_n_o [ create_bd_port -dir O adc_enc_n_o ]
  set adc_csn_o [ create_bd_port -dir O adc_csn_o ]
  set dac_dat_o [ create_bd_port -dir O -from 13 -to 0 dac_dat_o ]
  set dac_clk_o [ create_bd_port -dir O dac_clk_o ]
  set dac_rst_o [ create_bd_port -dir O dac_rst_o ]
  set dac_sel_o [ create_bd_port -dir O dac_sel_o ]
  set dac_wrt_o [ create_bd_port -dir O dac_wrt_o ]
  set dac_pwm_o [ create_bd_port -dir O -from 3 -to 0 dac_pwm_o ]
  set exp_p_tri_io [ create_bd_port -dir IO -from 7 -to 0 exp_p_tri_io ]
  set exp_n_tri_io [ create_bd_port -dir IO -from 7 -to 0 exp_n_tri_io ]
  set led_o [ create_bd_port -dir O -from 7 -to 0 led_o ]

  # Create instance: pll_0, and set properties
  set pll_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 pll_0 ]
  set_property -dict [list \
    CONFIG.CLKIN1_JITTER_PS {80.0} \
    CONFIG.CLKOUT1_DRIVES {BUFG} \
    CONFIG.CLKOUT1_JITTER {119.348} \
    CONFIG.CLKOUT1_PHASE_ERROR {96.948} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125.0} \
    CONFIG.CLKOUT1_USED {true} \
    CONFIG.CLKOUT2_DRIVES {BUFG} \
    CONFIG.CLKOUT2_JITTER {104.759} \
    CONFIG.CLKOUT2_PHASE_ERROR {96.948} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {250.0} \
    CONFIG.CLKOUT2_REQUESTED_PHASE {157.5} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.CLKOUT3_DRIVES {BUFG} \
    CONFIG.CLKOUT3_JITTER {104.759} \
    CONFIG.CLKOUT3_PHASE_ERROR {96.948} \
    CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {250.0} \
    CONFIG.CLKOUT3_REQUESTED_PHASE {202.5} \
    CONFIG.CLKOUT3_USED {true} \
    CONFIG.CLKOUT4_DRIVES {BUFG} \
    CONFIG.CLKOUT4_JITTER {158.331} \
    CONFIG.CLKOUT4_PHASE_ERROR {96.948} \
    CONFIG.CLKOUT4_USED {true} \
    CONFIG.CLKOUT5_DRIVES {BUFG} \
    CONFIG.CLKOUT6_DRIVES {BUFG} \
    CONFIG.CLKOUT7_DRIVES {BUFG} \
    CONFIG.CLK_OUT1_PORT {clk_out1} \
    CONFIG.CLK_OUT4_PORT {clk_out4} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {8} \
    CONFIG.MMCM_CLKIN1_PERIOD {8.000} \
    CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {8} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {4} \
    CONFIG.MMCM_CLKOUT1_PHASE {157.500} \
    CONFIG.MMCM_CLKOUT2_DIVIDE {4} \
    CONFIG.MMCM_CLKOUT2_PHASE {202.500} \
    CONFIG.MMCM_CLKOUT3_DIVIDE {10} \
    CONFIG.NUM_OUT_CLKS {4} \
    CONFIG.PLL_CLKIN_PERIOD {8.000} \
    CONFIG.PRIMITIVE {PLL} \
    CONFIG.PRIM_IN_FREQ {125.0} \
    CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
    CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
    CONFIG.USE_PHASE_ALIGNMENT {true} \
    CONFIG.USE_RESET {false} \
  ] $pll_0


  # Create instance: soc
  create_hier_cell_soc [current_bd_instance .] soc

  # Create instance: dac
  create_hier_cell_dac [current_bd_instance .] dac

  # Create instance: adc
  create_hier_cell_adc [current_bd_instance .] adc

  # Create instance: MCA1
  create_hier_cell_MCA1 [current_bd_instance .] MCA1

  # Create instance: event_log
  create_hier_cell_event_log [current_bd_instance .] event_log

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins event_log/S_AXI] [get_bd_intf_pins soc/M04_AXI]
  connect_bd_intf_net -intf_net S_AXI_HP0_1 [get_bd_intf_pins soc/S_AXI_HP0] [get_bd_intf_pins event_log/M00_AXI]
  connect_bd_intf_net -intf_net soc_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins soc/DDR]
  connect_bd_intf_net -intf_net soc_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins soc/FIXED_IO]
  connect_bd_intf_net -intf_net soc_M00_AXI [get_bd_intf_pins soc/M00_AXI] [get_bd_intf_pins MCA1/S_AXI1]
  connect_bd_intf_net -intf_net soc_M01_AXI [get_bd_intf_pins soc/M01_AXI] [get_bd_intf_pins MCA1/s_axi]
  connect_bd_intf_net -intf_net soc_M02_AXI [get_bd_intf_pins soc/M02_AXI] [get_bd_intf_pins MCA1/s_axi2]
  connect_bd_intf_net -intf_net soc_M03_AXI [get_bd_intf_pins soc/M03_AXI] [get_bd_intf_pins MCA1/s_axi3]

  # Create port connections
  connect_bd_net -net In1_1 [get_bd_pins MCA1/x_in_filtered] [get_bd_pins dac/In1]
  connect_bd_net -net MCA1_peak_detected_out [get_bd_pins MCA1/peak_detected_out] [get_bd_pins event_log/peak_detected]
  connect_bd_net -net adc_adc_csn_o [get_bd_pins adc/adc_csn_o] [get_bd_ports adc_csn_o]
  connect_bd_net -net adc_clk_n_i_1 [get_bd_ports adc_clk_n_i] [get_bd_pins pll_0/clk_in1_n]
  connect_bd_net -net adc_clk_p_i_1 [get_bd_ports adc_clk_p_i] [get_bd_pins pll_0/clk_in1_p]
  connect_bd_net -net adc_dat_a_i_1 [get_bd_ports adc_dat_a_i] [get_bd_pins adc/adc_dat_a_i]
  connect_bd_net -net adc_dat_b_i_1 [get_bd_ports adc_dat_b_i] [get_bd_pins adc/adc_dat_b_i]
  connect_bd_net -net adc_m_axis_tvalid [get_bd_pins adc/m_axis_tvalid] [get_bd_pins dac/s_axis_tvalid]
  connect_bd_net -net chb_raw_1 [get_bd_pins adc/Dout1] [get_bd_pins event_log/chb_raw]
  connect_bd_net -net dac_dac_clk_o [get_bd_pins dac/dac_clk_o] [get_bd_ports dac_clk_o]
  connect_bd_net -net dac_dac_dat_o [get_bd_pins dac/dac_dat_o] [get_bd_ports dac_dat_o]
  connect_bd_net -net dac_dac_rst_o [get_bd_pins dac/dac_rst_o] [get_bd_ports dac_rst_o]
  connect_bd_net -net dac_dac_sel_o [get_bd_pins dac/dac_sel_o] [get_bd_ports dac_sel_o]
  connect_bd_net -net dac_dac_wrt_o [get_bd_pins dac/dac_wrt_o] [get_bd_ports dac_wrt_o]
  connect_bd_net -net iir2nd_y_out [get_bd_pins MCA1/y_out] [get_bd_pins dac/In0]
  connect_bd_net -net peak_value_in_1 [get_bd_pins MCA1/peak_value_out] [get_bd_pins event_log/peak_value_in]
  connect_bd_net -net pll_0_clk_out1_125 [get_bd_pins pll_0/clk_out1] [get_bd_pins soc/M_AXI_GP0_ACLK] [get_bd_pins dac/aclk] [get_bd_pins adc/aclk] [get_bd_pins MCA1/s_axi_aclk] [get_bd_pins event_log/s_axi_aclk]
  connect_bd_net -net pll_0_clk_out2 [get_bd_pins pll_0/clk_out2] [get_bd_pins dac/ddr_clk]
  connect_bd_net -net pll_0_clk_out3 [get_bd_pins pll_0/clk_out3] [get_bd_pins dac/wrt_clk]
  connect_bd_net -net pll_0_locked [get_bd_pins pll_0/locked] [get_bd_pins soc/dcm_locked] [get_bd_pins dac/locked]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins soc/peripheral_aresetn] [get_bd_pins MCA1/s_axi_aresetn] [get_bd_pins event_log/s_axi_aresetn]
  connect_bd_net -net x_in_1 [get_bd_pins adc/Dout0] [get_bd_pins MCA1/x_in]

  # Create address segments
  assign_bd_address -offset 0x41000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces soc/ps_0/Data] [get_bd_addr_segs event_log/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x7E200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces soc/ps_0/Data] [get_bd_addr_segs event_log/axi_cdma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x40004000 -range 0x00001000 -target_address_space [get_bd_addr_spaces soc/ps_0/Data] [get_bd_addr_segs event_log/event_logger_0/s_axi/reg0] -force
  assign_bd_address -offset 0x40000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces soc/ps_0/Data] [get_bd_addr_segs MCA1/fir9_minimal_axi_wrap_0/s_axi/reg0] -force
  assign_bd_address -offset 0x40001000 -range 0x00001000 -target_address_space [get_bd_addr_spaces soc/ps_0/Data] [get_bd_addr_segs MCA1/iir1st_minimal_axi_0/s_axi/reg0] -force
  assign_bd_address -offset 0x40002000 -range 0x00001000 -target_address_space [get_bd_addr_spaces soc/ps_0/Data] [get_bd_addr_segs MCA1/peak_detector_axi_wr_0/s_axi/reg0] -force
  assign_bd_address -offset 0x40003000 -range 0x00001000 -target_address_space [get_bd_addr_spaces soc/ps_0/Data] [get_bd_addr_segs MCA1/peak_height_binning_0/s_axi/reg0] -force
  assign_bd_address -offset 0x41000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces event_log/axi_cdma_0/Data] [get_bd_addr_segs event_log/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces event_log/axi_cdma_0/Data] [get_bd_addr_segs soc/ps_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces soc/ps_0/Data] [get_bd_addr_segs soc/ps_0/S_AXI_HP0/HP0_DDR_LOWOCM]

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"1.35416",
   "Default View_TopLeft":"-179,174",
   "ExpandedHierarchyInLayout":"/soc",
   "guistr":"# # String gsaved with Nlview 7.7.1 2023-07-26 3bc4126617 VDI=43 GEI=38 GUI=JA:21.0 threadsafe
#  -string -flagsOSRD
preplace port Vp_Vn -pg 1 -lvl 0 -x -20 -y 110 -defaultsOSRD
preplace port Vaux0 -pg 1 -lvl 0 -x -20 -y -10 -defaultsOSRD
preplace port Vaux1 -pg 1 -lvl 0 -x -20 -y 20 -defaultsOSRD
preplace port Vaux9 -pg 1 -lvl 0 -x -20 -y 80 -defaultsOSRD
preplace port Vaux8 -pg 1 -lvl 0 -x -20 -y 50 -defaultsOSRD
preplace port DDR -pg 1 -lvl 5 -x 2580 -y 20 -defaultsOSRD
preplace port FIXED_IO -pg 1 -lvl 5 -x 2580 -y 50 -defaultsOSRD
preplace port port-id_adc_clk_p_i -pg 1 -lvl 0 -x -20 -y 560 -defaultsOSRD
preplace port port-id_adc_clk_n_i -pg 1 -lvl 0 -x -20 -y 530 -defaultsOSRD
preplace port port-id_adc_enc_p_o -pg 1 -lvl 5 -x 2580 -y 200 -defaultsOSRD
preplace port port-id_adc_enc_n_o -pg 1 -lvl 5 -x 2580 -y 170 -defaultsOSRD
preplace port port-id_adc_csn_o -pg 1 -lvl 5 -x 2580 -y 470 -defaultsOSRD
preplace port port-id_dac_clk_o -pg 1 -lvl 5 -x 2580 -y 310 -defaultsOSRD
preplace port port-id_dac_rst_o -pg 1 -lvl 5 -x 2580 -y 340 -defaultsOSRD
preplace port port-id_dac_sel_o -pg 1 -lvl 5 -x 2580 -y 400 -defaultsOSRD
preplace port port-id_dac_wrt_o -pg 1 -lvl 5 -x 2580 -y 370 -defaultsOSRD
preplace portBus adc_dat_a_i -pg 1 -lvl 0 -x -20 -y 640 -defaultsOSRD
preplace portBus adc_dat_b_i -pg 1 -lvl 0 -x -20 -y 420 -defaultsOSRD
preplace portBus dac_dat_o -pg 1 -lvl 5 -x 2580 -y 280 -defaultsOSRD
preplace portBus dac_pwm_o -pg 1 -lvl 5 -x 2580 -y -10 -defaultsOSRD
preplace portBus exp_p_tri_io -pg 1 -lvl 5 -x 2580 -y 110 -defaultsOSRD
preplace portBus exp_n_tri_io -pg 1 -lvl 5 -x 2580 -y 80 -defaultsOSRD
preplace portBus led_o -pg 1 -lvl 5 -x 2580 -y 140 -defaultsOSRD
preplace inst pll_0 -pg 1 -lvl 1 -x 240 -y 540 -defaultsOSRD
preplace inst soc -pg 1 -lvl 2 -x 710 -y 100 -defaultsOSRD
preplace inst dac -pg 1 -lvl 4 -x 2411 -y 360 -defaultsOSRD
preplace inst adc -pg 1 -lvl 2 -x 710 -y 1544 -defaultsOSRD
preplace inst MCA1 -pg 1 -lvl 3 -x 2033 -y 190 -defaultsOSRD
preplace inst event_log -pg 1 -lvl 1 -x 240 -y 0 -defaultsOSRD
preplace inst soc|ps_0 -pg 1 -lvl 2 -x 990 -y 310 -defaultsOSRD
preplace inst soc|rst_0 -pg 1 -lvl 2 -x 990 -y 100 -defaultsOSRD
preplace inst soc|axi_interconnect_0 -pg 1 -lvl 3 -x 1370 -y 790 -defaultsOSRD
preplace inst soc|const_0 -pg 1 -lvl 1 -x 690 -y 80 -defaultsOSRD
preplace netloc In1_1 1 3 1 2200 180n
preplace netloc adc_adc_csn_o 1 2 3 1893J 470 NJ 470 NJ
preplace netloc adc_clk_n_i_1 1 0 1 30J 530n
preplace netloc adc_clk_p_i_1 1 0 1 NJ 560
preplace netloc adc_dat_a_i_1 1 0 2 NJ 640 370J
preplace netloc adc_dat_b_i_1 1 0 2 NJ 420 390J
preplace netloc adc_m_axis_tvalid 1 2 2 1883 300 NJ
preplace netloc dac_dac_clk_o 1 4 1 2550J 310n
preplace netloc dac_dac_dat_o 1 4 1 2540J 280n
preplace netloc dac_dac_rst_o 1 4 1 2560J 340n
preplace netloc dac_dac_sel_o 1 4 1 NJ 400
preplace netloc dac_dac_wrt_o 1 4 1 2540J 370n
preplace netloc iir2nd_y_out 1 3 1 2210 160n
preplace netloc pll_0_clk_out1_125 1 0 4 100 110 450 -40 1853 360 NJ
preplace netloc pll_0_clk_out2 1 1 3 370 -70 NJ -70 2240J
preplace netloc pll_0_clk_out3 1 1 3 380 -60 NJ -60 2230J
preplace netloc pll_0_locked 1 1 3 430 -50 NJ -50 2220J
preplace netloc s_axi_aresetn_1 1 0 3 110 100 390 -30 1700
preplace netloc x_in_1 1 2 1 1873 250n
preplace netloc peak_value_in_1 1 0 4 110 -110 NJ -110 NJ -110 2180
preplace netloc MCA1_peak_detected_out 1 0 4 90 -130 NJ -130 NJ -130 2190
preplace netloc chb_raw_1 1 0 3 100 -120 NJ -120 1660
preplace netloc soc_DDR 1 2 3 1680J 20 NJ 20 NJ
preplace netloc soc_FIXED_IO 1 2 3 1690J 50 NJ 50 NJ
preplace netloc soc_M00_AXI 1 2 1 1710 130n
preplace netloc soc_M01_AXI 1 2 1 1720 150n
preplace netloc soc_M02_AXI 1 2 1 1730 170n
preplace netloc soc_M03_AXI 1 2 1 1863 190n
preplace netloc S_AXI_1 1 0 3 80 -140 NJ -140 1670
preplace netloc S_AXI_HP0_1 1 1 1 440 0n
preplace netloc soc|M_AXI_GP0_ACLK_1 1 0 3 NJ 320 780 440 1200
preplace netloc soc|const_0_dout 1 1 1 NJ 80
preplace netloc soc|dcm_locked_1 1 0 2 610J 140 N
preplace netloc soc|rst_0_interconnect_aresetn 1 2 1 1230 120n
preplace netloc soc|rst_0_peripheral_aresetn 1 2 2 1210 990 NJ
preplace netloc soc|Conn1 1 2 2 N 260 NJ
preplace netloc soc|Conn2 1 2 2 N 280 NJ
preplace netloc soc|Conn3 1 3 1 N 770
preplace netloc soc|Conn4 1 0 2 NJ 300 N
preplace netloc soc|axi_interconnect_0_M00_AXI 1 3 1 N 750
preplace netloc soc|axi_interconnect_0_M02_AXI 1 3 1 N 790
preplace netloc soc|axi_interconnect_0_M03_AXI 1 3 1 N 810
preplace netloc soc|ps_0_M_AXI_GP0 1 2 1 1220 340n
preplace netloc soc|axi_interconnect_0_M04_AXI 1 3 1 N 830
levelinfo -pg 1 -20 240 710 2033 2411 2580
levelinfo -hier soc * 690 990 1370 *
pagesize -pg 1 -db -bbox -sgen -200 -280 3980 1640
pagesize -hier soc -db -bbox -sgen 580 0 1540 1000
"
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


common::send_gid_msg -ssname BD::TCL -id 2053 -severity "WARNING" "This Tcl script was generated from a block design that has not been validated. It is possible that design <$design_name> may result in errors during validation."

