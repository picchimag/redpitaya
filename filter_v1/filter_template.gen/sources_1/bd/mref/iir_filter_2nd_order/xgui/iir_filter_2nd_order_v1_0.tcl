# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "COEFF_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "GAIN_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IN_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LOG_DIV" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LOG_UNITY_GAIN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUT_DATA_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.COEFF_WIDTH { PARAM_VALUE.COEFF_WIDTH } {
	# Procedure called to update COEFF_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COEFF_WIDTH { PARAM_VALUE.COEFF_WIDTH } {
	# Procedure called to validate COEFF_WIDTH
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.GAIN_DATA_WIDTH { PARAM_VALUE.GAIN_DATA_WIDTH } {
	# Procedure called to update GAIN_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GAIN_DATA_WIDTH { PARAM_VALUE.GAIN_DATA_WIDTH } {
	# Procedure called to validate GAIN_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.IN_DATA_WIDTH { PARAM_VALUE.IN_DATA_WIDTH } {
	# Procedure called to update IN_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN_DATA_WIDTH { PARAM_VALUE.IN_DATA_WIDTH } {
	# Procedure called to validate IN_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.LOG_DIV { PARAM_VALUE.LOG_DIV } {
	# Procedure called to update LOG_DIV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LOG_DIV { PARAM_VALUE.LOG_DIV } {
	# Procedure called to validate LOG_DIV
	return true
}

proc update_PARAM_VALUE.LOG_UNITY_GAIN { PARAM_VALUE.LOG_UNITY_GAIN } {
	# Procedure called to update LOG_UNITY_GAIN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LOG_UNITY_GAIN { PARAM_VALUE.LOG_UNITY_GAIN } {
	# Procedure called to validate LOG_UNITY_GAIN
	return true
}

proc update_PARAM_VALUE.OUT_DATA_WIDTH { PARAM_VALUE.OUT_DATA_WIDTH } {
	# Procedure called to update OUT_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUT_DATA_WIDTH { PARAM_VALUE.OUT_DATA_WIDTH } {
	# Procedure called to validate OUT_DATA_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.IN_DATA_WIDTH { MODELPARAM_VALUE.IN_DATA_WIDTH PARAM_VALUE.IN_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN_DATA_WIDTH}] ${MODELPARAM_VALUE.IN_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.OUT_DATA_WIDTH { MODELPARAM_VALUE.OUT_DATA_WIDTH PARAM_VALUE.OUT_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUT_DATA_WIDTH}] ${MODELPARAM_VALUE.OUT_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.GAIN_DATA_WIDTH { MODELPARAM_VALUE.GAIN_DATA_WIDTH PARAM_VALUE.GAIN_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.GAIN_DATA_WIDTH}] ${MODELPARAM_VALUE.GAIN_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.COEFF_WIDTH { MODELPARAM_VALUE.COEFF_WIDTH PARAM_VALUE.COEFF_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COEFF_WIDTH}] ${MODELPARAM_VALUE.COEFF_WIDTH}
}

proc update_MODELPARAM_VALUE.LOG_DIV { MODELPARAM_VALUE.LOG_DIV PARAM_VALUE.LOG_DIV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LOG_DIV}] ${MODELPARAM_VALUE.LOG_DIV}
}

proc update_MODELPARAM_VALUE.LOG_UNITY_GAIN { MODELPARAM_VALUE.LOG_UNITY_GAIN PARAM_VALUE.LOG_UNITY_GAIN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LOG_UNITY_GAIN}] ${MODELPARAM_VALUE.LOG_UNITY_GAIN}
}

