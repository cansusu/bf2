transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {}
vlib activehdl/xilinx_vip
vlib activehdl/xpm
vlib activehdl/xlconstant_v1_1_7
vlib activehdl/xil_defaultlib
vlib activehdl/blk_mem_gen_v8_4_6
vlib activehdl/fifo_generator_v13_1_4
vlib activehdl/xdma_v4_1_23
vlib activehdl/generic_baseblocks_v2_1_0
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_register_slice_v2_1_28
vlib activehdl/fifo_generator_v13_2_8
vlib activehdl/axi_data_fifo_v2_1_27
vlib activehdl/axi_crossbar_v2_1_29
vlib activehdl/axi_bram_ctrl_v4_1_8
vlib activehdl/axi_lite_ipif_v3_0_4
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/interrupt_control_v3_1_4
vlib activehdl/axi_gpio_v2_0_30
vlib activehdl/proc_sys_reset_v5_0_13
vlib activehdl/util_vector_logic_v2_0_2
vlib activehdl/axi_clock_converter_v2_1_27

vlog -work xilinx_vip  -sv2k12 "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"/tools/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/tools/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"/tools/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xlconstant_v1_1_7  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/b0f2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_xlconstant_1_0_1/sim/Top_xlconstant_1_0.v" \

vcom -work xil_defaultlib -93  \
"../../../bd/Top/ip/Top_util_ds_buf_0_1/util_ds_buf.vhd" \
"../../../bd/Top/ip/Top_util_ds_buf_0_1/sim/Top_util_ds_buf_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pipe_clock.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pipe_eq.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pipe_drp.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pipe_rate.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pipe_reset.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pipe_sync.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gtp_pipe_rate.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gtp_pipe_drp.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gtp_pipe_reset.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pipe_user.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pipe_wrapper.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_qpll_drp.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_qpll_reset.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_qpll_wrapper.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_rxeq_scan.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie_top.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_core_top.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_axi_basic_rx_null_gen.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_axi_basic_rx_pipeline.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_axi_basic_rx.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_axi_basic_top.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_axi_basic_tx_pipeline.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_axi_basic_tx_thrtl_ctl.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_axi_basic_tx.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie_7x.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie_bram_7x.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie_bram_top_7x.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie_brams_7x.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie_pipe_lane.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie_pipe_misc.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie_pipe_pipeline.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gt_top.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gt_common.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gtp_cpllpd_ovrd.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gtx_cpllpd_ovrd.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gt_rx_valid_filter_7x.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_gt_wrapper.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/source/Top_xdma_0_0_pcie2_ip_pcie2_top.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_0/sim/Top_xdma_0_0_pcie2_ip.v" \

vlog -work blk_mem_gen_v8_4_6  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/bb55/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_1/sim/xdma_v4_1_23_blk_mem_64_reg_be.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_2/sim/xdma_v4_1_23_blk_mem_64_noreg_be.v" \

vlog -work fifo_generator_v13_1_4  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/e6d5/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_4 -93  \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/e6d5/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_4  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/e6d5/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_3/sim/pcie2_fifo_generator_dma_cpl.v" \
"../../../bd/Top/ip/Top_xdma_0_0_1/ip_4/sim/pcie2_fifo_generator_tgt_brdg.v" \

vlog -work xdma_v4_1_23  -sv2k12 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/xdma_v4_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_dma_cpl.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_dma_req.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_rx_destraddler.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_rx_demux.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_tgt_cpl.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_tgt_req.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_tx_mux.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_axi_stream_intf.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_cfg_sideband.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_pcie2_to_pcie3_wrapper.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_dma_bram_wrap.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_dma_bram_wrap_1024.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_dma_bram_wrap_2048.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/xdma_v4_1/hdl/verilog/Top_xdma_0_0_core_top.sv" \
"../../../bd/Top/ip/Top_xdma_0_0_1/sim/Top_xdma_0_0.sv" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_28  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/87d1/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_8  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/c97d/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_8 -93  \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/c97d/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_8  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/c97d/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_27  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/fab7/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_29  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/f8f3/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_xbar_1/sim/Top_xbar_1.v" \

vcom -work axi_bram_ctrl_v4_1_8 -93  \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/85f5/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../bd/Top/ip/Top_axi_bram_ctrl_0_0/sim/Top_axi_bram_ctrl_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_blk_mem_gen_0_1/sim/Top_blk_mem_gen_0_1.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93  \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work interrupt_control_v3_1_4 -93  \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/a040/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_30 -93  \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/18b7/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../bd/Top/ip/Top_axi_gpio_0_0/sim/Top_axi_gpio_0_0.vhd" \
"../../../bd/Top/ip/Top_axi_gpio_1_0/sim/Top_axi_gpio_1_0.vhd" \

vcom -work proc_sys_reset_v5_0_13 -93  \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../bd/Top/ip/Top_rst_clk_wiz_100M_0/sim/Top_rst_clk_wiz_100M_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_clk_wiz_1/Top_clk_wiz_1_clk_wiz.v" \
"../../../bd/Top/ip/Top_clk_wiz_1/Top_clk_wiz_1.v" \

vlog -work util_vector_logic_v2_0_2  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/3d84/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_util_vector_logic_0_0/sim/Top_util_vector_logic_0_0.v" \

vcom -work xil_defaultlib -93  \
"../../../bd/Top/ip/Top_axi_gpio_2_0/sim/Top_axi_gpio_2_0.vhd" \
"../../../bd/Top/ip/Top_axi_gpio_3_0/sim/Top_axi_gpio_3_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_xlconstant_0_0/sim/Top_xlconstant_0_0.v" \

vcom -work xil_defaultlib -93  \
"../../../bd/Top/ip/Top_axi_gpio_3_1/sim/Top_axi_gpio_3_1.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_comparator_0_0/sim/Top_comparator_0_0.v" \
"../../../bd/Top/ip/Top_multi_cores_top_0_0/sim/Top_multi_cores_top_0_0.v" \

vlog -work axi_clock_converter_v2_1_27  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../../project_4096.gen/sources_1/bd/Top/ipshared/29db/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/03b2/hdl/verilog" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/ec67/hdl" "+incdir+../../../../project_4096.gen/sources_1/bd/Top/ipshared/30ef" "+incdir+/tools/Xilinx/Vivado/2023.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlconstant_v1_1_7 -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l fifo_generator_v13_1_4 -l xdma_v4_1_23 -l generic_baseblocks_v2_1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_28 -l fifo_generator_v13_2_8 -l axi_data_fifo_v2_1_27 -l axi_crossbar_v2_1_29 -l axi_bram_ctrl_v4_1_8 -l axi_lite_ipif_v3_0_4 -l lib_cdc_v1_0_2 -l interrupt_control_v3_1_4 -l axi_gpio_v2_0_30 -l proc_sys_reset_v5_0_13 -l util_vector_logic_v2_0_2 -l axi_clock_converter_v2_1_27 \
"../../../bd/Top/ip/Top_auto_cc_0/sim/Top_auto_cc_0.v" \
"../../../bd/Top/ip/Top_auto_cc_1/sim/Top_auto_cc_1.v" \
"../../../bd/Top/sim/Top.v" \

vlog -work xil_defaultlib \
"glbl.v"

