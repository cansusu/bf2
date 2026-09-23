# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BF_BITS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BF_WORD_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BRAM_DEPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "EXP_PWD_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_CORES" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PWD_SIZE" -parent ${Page_0}


}

proc update_PARAM_VALUE.BF_BITS { PARAM_VALUE.BF_BITS } {
	# Procedure called to update BF_BITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BF_BITS { PARAM_VALUE.BF_BITS } {
	# Procedure called to validate BF_BITS
	return true
}

proc update_PARAM_VALUE.BF_WORD_WIDTH { PARAM_VALUE.BF_WORD_WIDTH } {
	# Procedure called to update BF_WORD_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BF_WORD_WIDTH { PARAM_VALUE.BF_WORD_WIDTH } {
	# Procedure called to validate BF_WORD_WIDTH
	return true
}

proc update_PARAM_VALUE.BRAM_DEPTH { PARAM_VALUE.BRAM_DEPTH } {
	# Procedure called to update BRAM_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BRAM_DEPTH { PARAM_VALUE.BRAM_DEPTH } {
	# Procedure called to validate BRAM_DEPTH
	return true
}

proc update_PARAM_VALUE.EXP_PWD_SIZE { PARAM_VALUE.EXP_PWD_SIZE } {
	# Procedure called to update EXP_PWD_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.EXP_PWD_SIZE { PARAM_VALUE.EXP_PWD_SIZE } {
	# Procedure called to validate EXP_PWD_SIZE
	return true
}

proc update_PARAM_VALUE.NUM_CORES { PARAM_VALUE.NUM_CORES } {
	# Procedure called to update NUM_CORES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_CORES { PARAM_VALUE.NUM_CORES } {
	# Procedure called to validate NUM_CORES
	return true
}

proc update_PARAM_VALUE.PWD_SIZE { PARAM_VALUE.PWD_SIZE } {
	# Procedure called to update PWD_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PWD_SIZE { PARAM_VALUE.PWD_SIZE } {
	# Procedure called to validate PWD_SIZE
	return true
}


proc update_MODELPARAM_VALUE.PWD_SIZE { MODELPARAM_VALUE.PWD_SIZE PARAM_VALUE.PWD_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PWD_SIZE}] ${MODELPARAM_VALUE.PWD_SIZE}
}

proc update_MODELPARAM_VALUE.EXP_PWD_SIZE { MODELPARAM_VALUE.EXP_PWD_SIZE PARAM_VALUE.EXP_PWD_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.EXP_PWD_SIZE}] ${MODELPARAM_VALUE.EXP_PWD_SIZE}
}

proc update_MODELPARAM_VALUE.NUM_CORES { MODELPARAM_VALUE.NUM_CORES PARAM_VALUE.NUM_CORES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_CORES}] ${MODELPARAM_VALUE.NUM_CORES}
}

proc update_MODELPARAM_VALUE.BRAM_DEPTH { MODELPARAM_VALUE.BRAM_DEPTH PARAM_VALUE.BRAM_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BRAM_DEPTH}] ${MODELPARAM_VALUE.BRAM_DEPTH}
}

proc update_MODELPARAM_VALUE.BF_BITS { MODELPARAM_VALUE.BF_BITS PARAM_VALUE.BF_BITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BF_BITS}] ${MODELPARAM_VALUE.BF_BITS}
}

proc update_MODELPARAM_VALUE.BF_WORD_WIDTH { MODELPARAM_VALUE.BF_WORD_WIDTH PARAM_VALUE.BF_WORD_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BF_WORD_WIDTH}] ${MODELPARAM_VALUE.BF_WORD_WIDTH}
}

