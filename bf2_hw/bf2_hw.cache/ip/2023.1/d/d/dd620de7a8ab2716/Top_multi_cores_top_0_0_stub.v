// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Mon Feb  9 18:16:47 2026
// Host        : cansu-pc running 64-bit Ubuntu 20.04.6 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Top_multi_cores_top_0_0_stub.v
// Design      : Top_multi_cores_top_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "multi_cores_top,Vivado 2023.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk_i, rst_n, start_i, host_ready, 
  number_of_hashes, prog_data_i, prog_done_o, bram_addrb, bram_dinb, bram_web, write_count)
/* synthesis syn_black_box black_box_pad_pin="rst_n,start_i,host_ready,number_of_hashes[3:0],prog_data_i[31:0],prog_done_o,bram_addrb[31:0],bram_dinb[127:0],bram_web[15:0],write_count[31:0]" */
/* synthesis syn_force_seq_prim="clk_i" */;
  input clk_i /* synthesis syn_isclock = 1 */;
  input rst_n;
  input start_i;
  input host_ready;
  input [3:0]number_of_hashes;
  input [31:0]prog_data_i;
  output prog_done_o;
  output [31:0]bram_addrb;
  output [127:0]bram_dinb;
  output [15:0]bram_web;
  output [31:0]write_count;
endmodule
