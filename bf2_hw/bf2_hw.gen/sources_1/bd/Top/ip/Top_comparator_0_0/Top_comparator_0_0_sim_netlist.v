// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Wed Jan 14 22:45:58 2026
// Host        : cansu-pc running 64-bit Ubuntu 20.04.6 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/cansu/project_32768/project_32768.gen/sources_1/bd/Top/ip/Top_comparator_0_0/Top_comparator_0_0_sim_netlist.v
// Design      : Top_comparator_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Top_comparator_0_0,comparator,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "comparator,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module Top_comparator_0_0
   (clk,
    rst_n,
    write_count,
    read_count,
    stall);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst_n;
  input [31:0]write_count;
  input [31:0]read_count;
  output stall;

  wire [31:0]read_count;
  wire stall;
  wire [31:0]write_count;

  Top_comparator_0_0_comparator inst
       (.read_count(read_count),
        .stall(stall),
        .write_count(write_count));
endmodule

(* ORIG_REF_NAME = "comparator" *) 
module Top_comparator_0_0_comparator
   (stall,
    read_count,
    write_count);
  output stall;
  input [31:0]read_count;
  input [31:0]write_count;

  wire [31:0]read_count;
  wire stall;
  wire stall0_carry__0_i_1_n_0;
  wire stall0_carry__0_i_2_n_0;
  wire stall0_carry__0_i_3_n_0;
  wire stall0_carry__0_i_4_n_0;
  wire stall0_carry__0_i_5_n_0;
  wire stall0_carry__0_i_6_n_0;
  wire stall0_carry__0_i_7_n_0;
  wire stall0_carry__0_i_8_n_0;
  wire stall0_carry__0_n_0;
  wire stall0_carry__0_n_1;
  wire stall0_carry__0_n_2;
  wire stall0_carry__0_n_3;
  wire stall0_carry__1_i_1_n_0;
  wire stall0_carry__1_i_2_n_0;
  wire stall0_carry__1_i_3_n_0;
  wire stall0_carry__1_i_4_n_0;
  wire stall0_carry__1_i_5_n_0;
  wire stall0_carry__1_i_6_n_0;
  wire stall0_carry__1_i_7_n_0;
  wire stall0_carry__1_i_8_n_0;
  wire stall0_carry__1_n_0;
  wire stall0_carry__1_n_1;
  wire stall0_carry__1_n_2;
  wire stall0_carry__1_n_3;
  wire stall0_carry__2_i_1_n_0;
  wire stall0_carry__2_i_2_n_0;
  wire stall0_carry__2_i_3_n_0;
  wire stall0_carry__2_i_4_n_0;
  wire stall0_carry__2_i_5_n_0;
  wire stall0_carry__2_i_6_n_0;
  wire stall0_carry__2_i_7_n_0;
  wire stall0_carry__2_i_8_n_0;
  wire stall0_carry__2_n_0;
  wire stall0_carry__2_n_1;
  wire stall0_carry__2_n_2;
  wire stall0_carry__2_n_3;
  wire stall0_carry_i_1_n_0;
  wire stall0_carry_i_2_n_0;
  wire stall0_carry_i_3_n_0;
  wire stall0_carry_i_4_n_0;
  wire stall0_carry_i_5_n_0;
  wire stall0_carry_i_6_n_0;
  wire stall0_carry_i_7_n_0;
  wire stall0_carry_i_8_n_0;
  wire stall0_carry_n_0;
  wire stall0_carry_n_1;
  wire stall0_carry_n_2;
  wire stall0_carry_n_3;
  wire stall1__93_carry__0_i_1_n_0;
  wire stall1__93_carry__0_i_2_n_0;
  wire stall1__93_carry__0_i_3_n_0;
  wire stall1__93_carry__0_i_4_n_0;
  wire stall1__93_carry__0_n_0;
  wire stall1__93_carry__0_n_1;
  wire stall1__93_carry__0_n_2;
  wire stall1__93_carry__0_n_3;
  wire stall1__93_carry__0_n_4;
  wire stall1__93_carry__0_n_5;
  wire stall1__93_carry__0_n_6;
  wire stall1__93_carry__0_n_7;
  wire stall1__93_carry__1_i_1_n_0;
  wire stall1__93_carry__1_n_0;
  wire stall1__93_carry__1_n_1;
  wire stall1__93_carry__1_n_2;
  wire stall1__93_carry__1_n_3;
  wire stall1__93_carry__1_n_4;
  wire stall1__93_carry__1_n_5;
  wire stall1__93_carry__1_n_6;
  wire stall1__93_carry__1_n_7;
  wire stall1__93_carry__2_n_0;
  wire stall1__93_carry__2_n_1;
  wire stall1__93_carry__2_n_2;
  wire stall1__93_carry__2_n_3;
  wire stall1__93_carry__2_n_4;
  wire stall1__93_carry__2_n_5;
  wire stall1__93_carry__2_n_6;
  wire stall1__93_carry__2_n_7;
  wire stall1__93_carry__3_n_0;
  wire stall1__93_carry__3_n_1;
  wire stall1__93_carry__3_n_2;
  wire stall1__93_carry__3_n_3;
  wire stall1__93_carry__3_n_4;
  wire stall1__93_carry__3_n_5;
  wire stall1__93_carry__3_n_6;
  wire stall1__93_carry__3_n_7;
  wire stall1__93_carry__4_n_0;
  wire stall1__93_carry__4_n_1;
  wire stall1__93_carry__4_n_2;
  wire stall1__93_carry__4_n_3;
  wire stall1__93_carry__4_n_4;
  wire stall1__93_carry__4_n_5;
  wire stall1__93_carry__4_n_6;
  wire stall1__93_carry__4_n_7;
  wire stall1__93_carry__5_n_0;
  wire stall1__93_carry__5_n_1;
  wire stall1__93_carry__5_n_2;
  wire stall1__93_carry__5_n_3;
  wire stall1__93_carry__5_n_4;
  wire stall1__93_carry__5_n_5;
  wire stall1__93_carry__5_n_6;
  wire stall1__93_carry__5_n_7;
  wire stall1__93_carry__6_n_2;
  wire stall1__93_carry__6_n_3;
  wire stall1__93_carry__6_n_5;
  wire stall1__93_carry__6_n_6;
  wire stall1__93_carry__6_n_7;
  wire stall1__93_carry_i_1_n_0;
  wire stall1__93_carry_i_2_n_0;
  wire stall1__93_carry_i_3_n_0;
  wire stall1__93_carry_n_0;
  wire stall1__93_carry_n_1;
  wire stall1__93_carry_n_2;
  wire stall1__93_carry_n_3;
  wire stall1__93_carry_n_4;
  wire stall1__93_carry_n_5;
  wire stall1__93_carry_n_6;
  wire stall1__93_carry_n_7;
  wire stall1_carry__0_i_1_n_0;
  wire stall1_carry__0_i_2_n_0;
  wire stall1_carry__0_i_3_n_0;
  wire stall1_carry__0_i_4_n_0;
  wire stall1_carry__0_n_0;
  wire stall1_carry__0_n_1;
  wire stall1_carry__0_n_2;
  wire stall1_carry__0_n_3;
  wire stall1_carry__0_n_4;
  wire stall1_carry__0_n_5;
  wire stall1_carry__0_n_6;
  wire stall1_carry__0_n_7;
  wire stall1_carry__1_i_1_n_0;
  wire stall1_carry__1_i_2_n_0;
  wire stall1_carry__1_i_3_n_0;
  wire stall1_carry__1_i_4_n_0;
  wire stall1_carry__1_n_0;
  wire stall1_carry__1_n_1;
  wire stall1_carry__1_n_2;
  wire stall1_carry__1_n_3;
  wire stall1_carry__1_n_4;
  wire stall1_carry__1_n_5;
  wire stall1_carry__1_n_6;
  wire stall1_carry__1_n_7;
  wire stall1_carry__2_i_1_n_0;
  wire stall1_carry__2_i_2_n_0;
  wire stall1_carry__2_i_3_n_0;
  wire stall1_carry__2_i_4_n_0;
  wire stall1_carry__2_n_0;
  wire stall1_carry__2_n_1;
  wire stall1_carry__2_n_2;
  wire stall1_carry__2_n_3;
  wire stall1_carry__2_n_4;
  wire stall1_carry__2_n_5;
  wire stall1_carry__2_n_6;
  wire stall1_carry__2_n_7;
  wire stall1_carry__3_i_1_n_0;
  wire stall1_carry__3_i_2_n_0;
  wire stall1_carry__3_i_3_n_0;
  wire stall1_carry__3_i_4_n_0;
  wire stall1_carry__3_n_0;
  wire stall1_carry__3_n_1;
  wire stall1_carry__3_n_2;
  wire stall1_carry__3_n_3;
  wire stall1_carry__3_n_4;
  wire stall1_carry__3_n_5;
  wire stall1_carry__3_n_6;
  wire stall1_carry__3_n_7;
  wire stall1_carry__4_i_1_n_0;
  wire stall1_carry__4_i_2_n_0;
  wire stall1_carry__4_i_3_n_0;
  wire stall1_carry__4_i_4_n_0;
  wire stall1_carry__4_n_0;
  wire stall1_carry__4_n_1;
  wire stall1_carry__4_n_2;
  wire stall1_carry__4_n_3;
  wire stall1_carry__4_n_4;
  wire stall1_carry__4_n_5;
  wire stall1_carry__4_n_6;
  wire stall1_carry__4_n_7;
  wire stall1_carry__5_i_1_n_0;
  wire stall1_carry__5_i_2_n_0;
  wire stall1_carry__5_i_3_n_0;
  wire stall1_carry__5_i_4_n_0;
  wire stall1_carry__5_n_0;
  wire stall1_carry__5_n_1;
  wire stall1_carry__5_n_2;
  wire stall1_carry__5_n_3;
  wire stall1_carry__5_n_4;
  wire stall1_carry__5_n_5;
  wire stall1_carry__5_n_6;
  wire stall1_carry__5_n_7;
  wire stall1_carry__6_i_1_n_0;
  wire stall1_carry__6_i_2_n_0;
  wire stall1_carry__6_i_3_n_0;
  wire stall1_carry__6_i_4_n_0;
  wire stall1_carry__6_n_1;
  wire stall1_carry__6_n_2;
  wire stall1_carry__6_n_3;
  wire stall1_carry__6_n_4;
  wire stall1_carry__6_n_5;
  wire stall1_carry__6_n_6;
  wire stall1_carry__6_n_7;
  wire stall1_carry_i_1_n_0;
  wire stall1_carry_i_2_n_0;
  wire stall1_carry_i_3_n_0;
  wire stall1_carry_i_4_n_0;
  wire stall1_carry_n_0;
  wire stall1_carry_n_1;
  wire stall1_carry_n_2;
  wire stall1_carry_n_3;
  wire stall1_carry_n_4;
  wire stall1_carry_n_5;
  wire stall1_carry_n_6;
  wire stall1_carry_n_7;
  wire stall_INST_0_i_1_n_0;
  wire stall_INST_0_i_2_n_0;
  wire stall_INST_0_i_3_n_0;
  wire stall_INST_0_i_4_n_0;
  wire stall_INST_0_i_5_n_0;
  wire stall_INST_0_i_6_n_0;
  wire [31:0]write_count;
  wire [3:0]NLW_stall0_carry_O_UNCONNECTED;
  wire [3:0]NLW_stall0_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_stall0_carry__1_O_UNCONNECTED;
  wire [3:0]NLW_stall0_carry__2_O_UNCONNECTED;
  wire [3:2]NLW_stall1__93_carry__6_CO_UNCONNECTED;
  wire [3:3]NLW_stall1__93_carry__6_O_UNCONNECTED;
  wire [3:3]NLW_stall1_carry__6_CO_UNCONNECTED;

  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 stall0_carry
       (.CI(1'b0),
        .CO({stall0_carry_n_0,stall0_carry_n_1,stall0_carry_n_2,stall0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({stall0_carry_i_1_n_0,stall0_carry_i_2_n_0,stall0_carry_i_3_n_0,stall0_carry_i_4_n_0}),
        .O(NLW_stall0_carry_O_UNCONNECTED[3:0]),
        .S({stall0_carry_i_5_n_0,stall0_carry_i_6_n_0,stall0_carry_i_7_n_0,stall0_carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 stall0_carry__0
       (.CI(stall0_carry_n_0),
        .CO({stall0_carry__0_n_0,stall0_carry__0_n_1,stall0_carry__0_n_2,stall0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({stall0_carry__0_i_1_n_0,stall0_carry__0_i_2_n_0,stall0_carry__0_i_3_n_0,stall0_carry__0_i_4_n_0}),
        .O(NLW_stall0_carry__0_O_UNCONNECTED[3:0]),
        .S({stall0_carry__0_i_5_n_0,stall0_carry__0_i_6_n_0,stall0_carry__0_i_7_n_0,stall0_carry__0_i_8_n_0}));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__0_i_1
       (.I0(write_count[15]),
        .I1(stall1__93_carry__2_n_5),
        .I2(write_count[14]),
        .I3(stall1__93_carry__2_n_6),
        .O(stall0_carry__0_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__0_i_2
       (.I0(write_count[13]),
        .I1(stall1__93_carry__2_n_7),
        .I2(write_count[12]),
        .I3(stall1__93_carry__1_n_4),
        .O(stall0_carry__0_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__0_i_3
       (.I0(write_count[11]),
        .I1(stall1__93_carry__1_n_5),
        .I2(write_count[10]),
        .I3(stall1__93_carry__1_n_6),
        .O(stall0_carry__0_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__0_i_4
       (.I0(write_count[9]),
        .I1(stall1__93_carry__1_n_7),
        .I2(write_count[8]),
        .I3(stall1__93_carry__0_n_4),
        .O(stall0_carry__0_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__0_i_5
       (.I0(stall1__93_carry__2_n_5),
        .I1(write_count[15]),
        .I2(stall1__93_carry__2_n_6),
        .I3(write_count[14]),
        .O(stall0_carry__0_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__0_i_6
       (.I0(stall1__93_carry__2_n_7),
        .I1(write_count[13]),
        .I2(stall1__93_carry__1_n_4),
        .I3(write_count[12]),
        .O(stall0_carry__0_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__0_i_7
       (.I0(stall1__93_carry__1_n_5),
        .I1(write_count[11]),
        .I2(stall1__93_carry__1_n_6),
        .I3(write_count[10]),
        .O(stall0_carry__0_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__0_i_8
       (.I0(stall1__93_carry__1_n_7),
        .I1(write_count[9]),
        .I2(stall1__93_carry__0_n_4),
        .I3(write_count[8]),
        .O(stall0_carry__0_i_8_n_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 stall0_carry__1
       (.CI(stall0_carry__0_n_0),
        .CO({stall0_carry__1_n_0,stall0_carry__1_n_1,stall0_carry__1_n_2,stall0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({stall0_carry__1_i_1_n_0,stall0_carry__1_i_2_n_0,stall0_carry__1_i_3_n_0,stall0_carry__1_i_4_n_0}),
        .O(NLW_stall0_carry__1_O_UNCONNECTED[3:0]),
        .S({stall0_carry__1_i_5_n_0,stall0_carry__1_i_6_n_0,stall0_carry__1_i_7_n_0,stall0_carry__1_i_8_n_0}));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__1_i_1
       (.I0(write_count[23]),
        .I1(stall1__93_carry__4_n_5),
        .I2(write_count[22]),
        .I3(stall1__93_carry__4_n_6),
        .O(stall0_carry__1_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__1_i_2
       (.I0(write_count[21]),
        .I1(stall1__93_carry__4_n_7),
        .I2(write_count[20]),
        .I3(stall1__93_carry__3_n_4),
        .O(stall0_carry__1_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__1_i_3
       (.I0(write_count[19]),
        .I1(stall1__93_carry__3_n_5),
        .I2(write_count[18]),
        .I3(stall1__93_carry__3_n_6),
        .O(stall0_carry__1_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__1_i_4
       (.I0(write_count[17]),
        .I1(stall1__93_carry__3_n_7),
        .I2(write_count[16]),
        .I3(stall1__93_carry__2_n_4),
        .O(stall0_carry__1_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__1_i_5
       (.I0(stall1__93_carry__4_n_5),
        .I1(write_count[23]),
        .I2(stall1__93_carry__4_n_6),
        .I3(write_count[22]),
        .O(stall0_carry__1_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__1_i_6
       (.I0(stall1__93_carry__4_n_7),
        .I1(write_count[21]),
        .I2(stall1__93_carry__3_n_4),
        .I3(write_count[20]),
        .O(stall0_carry__1_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__1_i_7
       (.I0(stall1__93_carry__3_n_5),
        .I1(write_count[19]),
        .I2(stall1__93_carry__3_n_6),
        .I3(write_count[18]),
        .O(stall0_carry__1_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__1_i_8
       (.I0(stall1__93_carry__3_n_7),
        .I1(write_count[17]),
        .I2(stall1__93_carry__2_n_4),
        .I3(write_count[16]),
        .O(stall0_carry__1_i_8_n_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 stall0_carry__2
       (.CI(stall0_carry__1_n_0),
        .CO({stall0_carry__2_n_0,stall0_carry__2_n_1,stall0_carry__2_n_2,stall0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({stall0_carry__2_i_1_n_0,stall0_carry__2_i_2_n_0,stall0_carry__2_i_3_n_0,stall0_carry__2_i_4_n_0}),
        .O(NLW_stall0_carry__2_O_UNCONNECTED[3:0]),
        .S({stall0_carry__2_i_5_n_0,stall0_carry__2_i_6_n_0,stall0_carry__2_i_7_n_0,stall0_carry__2_i_8_n_0}));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__2_i_1
       (.I0(write_count[31]),
        .I1(stall1__93_carry__6_n_5),
        .I2(write_count[30]),
        .I3(stall1__93_carry__6_n_6),
        .O(stall0_carry__2_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__2_i_2
       (.I0(write_count[29]),
        .I1(stall1__93_carry__6_n_7),
        .I2(write_count[28]),
        .I3(stall1__93_carry__5_n_4),
        .O(stall0_carry__2_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__2_i_3
       (.I0(write_count[27]),
        .I1(stall1__93_carry__5_n_5),
        .I2(write_count[26]),
        .I3(stall1__93_carry__5_n_6),
        .O(stall0_carry__2_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry__2_i_4
       (.I0(write_count[25]),
        .I1(stall1__93_carry__5_n_7),
        .I2(write_count[24]),
        .I3(stall1__93_carry__4_n_4),
        .O(stall0_carry__2_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__2_i_5
       (.I0(stall1__93_carry__6_n_5),
        .I1(write_count[31]),
        .I2(stall1__93_carry__6_n_6),
        .I3(write_count[30]),
        .O(stall0_carry__2_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__2_i_6
       (.I0(stall1__93_carry__6_n_7),
        .I1(write_count[29]),
        .I2(stall1__93_carry__5_n_4),
        .I3(write_count[28]),
        .O(stall0_carry__2_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__2_i_7
       (.I0(stall1__93_carry__5_n_5),
        .I1(write_count[27]),
        .I2(stall1__93_carry__5_n_6),
        .I3(write_count[26]),
        .O(stall0_carry__2_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry__2_i_8
       (.I0(stall1__93_carry__5_n_7),
        .I1(write_count[25]),
        .I2(stall1__93_carry__4_n_4),
        .I3(write_count[24]),
        .O(stall0_carry__2_i_8_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry_i_1
       (.I0(write_count[7]),
        .I1(stall1__93_carry__0_n_5),
        .I2(write_count[6]),
        .I3(stall1__93_carry__0_n_6),
        .O(stall0_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry_i_2
       (.I0(write_count[5]),
        .I1(stall1__93_carry__0_n_7),
        .I2(write_count[4]),
        .I3(stall1__93_carry_n_4),
        .O(stall0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    stall0_carry_i_3
       (.I0(write_count[3]),
        .I1(stall1__93_carry_n_5),
        .I2(write_count[2]),
        .I3(stall1__93_carry_n_6),
        .O(stall0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'hB222)) 
    stall0_carry_i_4
       (.I0(write_count[1]),
        .I1(stall1__93_carry_n_7),
        .I2(write_count[0]),
        .I3(read_count[0]),
        .O(stall0_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry_i_5
       (.I0(stall1__93_carry__0_n_5),
        .I1(write_count[7]),
        .I2(stall1__93_carry__0_n_6),
        .I3(write_count[6]),
        .O(stall0_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry_i_6
       (.I0(stall1__93_carry__0_n_7),
        .I1(write_count[5]),
        .I2(stall1__93_carry_n_4),
        .I3(write_count[4]),
        .O(stall0_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    stall0_carry_i_7
       (.I0(stall1__93_carry_n_5),
        .I1(write_count[3]),
        .I2(stall1__93_carry_n_6),
        .I3(write_count[2]),
        .O(stall0_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h6006)) 
    stall0_carry_i_8
       (.I0(write_count[0]),
        .I1(read_count[0]),
        .I2(stall1__93_carry_n_7),
        .I3(write_count[1]),
        .O(stall0_carry_i_8_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1__93_carry
       (.CI(1'b0),
        .CO({stall1__93_carry_n_0,stall1__93_carry_n_1,stall1__93_carry_n_2,stall1__93_carry_n_3}),
        .CYINIT(read_count[0]),
        .DI({read_count[4:2],1'b0}),
        .O({stall1__93_carry_n_4,stall1__93_carry_n_5,stall1__93_carry_n_6,stall1__93_carry_n_7}),
        .S({stall1__93_carry_i_1_n_0,stall1__93_carry_i_2_n_0,stall1__93_carry_i_3_n_0,read_count[1]}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1__93_carry__0
       (.CI(stall1__93_carry_n_0),
        .CO({stall1__93_carry__0_n_0,stall1__93_carry__0_n_1,stall1__93_carry__0_n_2,stall1__93_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(read_count[8:5]),
        .O({stall1__93_carry__0_n_4,stall1__93_carry__0_n_5,stall1__93_carry__0_n_6,stall1__93_carry__0_n_7}),
        .S({stall1__93_carry__0_i_1_n_0,stall1__93_carry__0_i_2_n_0,stall1__93_carry__0_i_3_n_0,stall1__93_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    stall1__93_carry__0_i_1
       (.I0(read_count[8]),
        .O(stall1__93_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    stall1__93_carry__0_i_2
       (.I0(read_count[7]),
        .O(stall1__93_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    stall1__93_carry__0_i_3
       (.I0(read_count[6]),
        .O(stall1__93_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    stall1__93_carry__0_i_4
       (.I0(read_count[5]),
        .O(stall1__93_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1__93_carry__1
       (.CI(stall1__93_carry__0_n_0),
        .CO({stall1__93_carry__1_n_0,stall1__93_carry__1_n_1,stall1__93_carry__1_n_2,stall1__93_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,read_count[9]}),
        .O({stall1__93_carry__1_n_4,stall1__93_carry__1_n_5,stall1__93_carry__1_n_6,stall1__93_carry__1_n_7}),
        .S({read_count[12:10],stall1__93_carry__1_i_1_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    stall1__93_carry__1_i_1
       (.I0(read_count[9]),
        .O(stall1__93_carry__1_i_1_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1__93_carry__2
       (.CI(stall1__93_carry__1_n_0),
        .CO({stall1__93_carry__2_n_0,stall1__93_carry__2_n_1,stall1__93_carry__2_n_2,stall1__93_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({stall1__93_carry__2_n_4,stall1__93_carry__2_n_5,stall1__93_carry__2_n_6,stall1__93_carry__2_n_7}),
        .S(read_count[16:13]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1__93_carry__3
       (.CI(stall1__93_carry__2_n_0),
        .CO({stall1__93_carry__3_n_0,stall1__93_carry__3_n_1,stall1__93_carry__3_n_2,stall1__93_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({stall1__93_carry__3_n_4,stall1__93_carry__3_n_5,stall1__93_carry__3_n_6,stall1__93_carry__3_n_7}),
        .S(read_count[20:17]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1__93_carry__4
       (.CI(stall1__93_carry__3_n_0),
        .CO({stall1__93_carry__4_n_0,stall1__93_carry__4_n_1,stall1__93_carry__4_n_2,stall1__93_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({stall1__93_carry__4_n_4,stall1__93_carry__4_n_5,stall1__93_carry__4_n_6,stall1__93_carry__4_n_7}),
        .S(read_count[24:21]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1__93_carry__5
       (.CI(stall1__93_carry__4_n_0),
        .CO({stall1__93_carry__5_n_0,stall1__93_carry__5_n_1,stall1__93_carry__5_n_2,stall1__93_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({stall1__93_carry__5_n_4,stall1__93_carry__5_n_5,stall1__93_carry__5_n_6,stall1__93_carry__5_n_7}),
        .S(read_count[28:25]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1__93_carry__6
       (.CI(stall1__93_carry__5_n_0),
        .CO({NLW_stall1__93_carry__6_CO_UNCONNECTED[3:2],stall1__93_carry__6_n_2,stall1__93_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_stall1__93_carry__6_O_UNCONNECTED[3],stall1__93_carry__6_n_5,stall1__93_carry__6_n_6,stall1__93_carry__6_n_7}),
        .S({1'b0,read_count[31:29]}));
  LUT1 #(
    .INIT(2'h1)) 
    stall1__93_carry_i_1
       (.I0(read_count[4]),
        .O(stall1__93_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    stall1__93_carry_i_2
       (.I0(read_count[3]),
        .O(stall1__93_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    stall1__93_carry_i_3
       (.I0(read_count[2]),
        .O(stall1__93_carry_i_3_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1_carry
       (.CI(1'b0),
        .CO({stall1_carry_n_0,stall1_carry_n_1,stall1_carry_n_2,stall1_carry_n_3}),
        .CYINIT(1'b1),
        .DI(read_count[3:0]),
        .O({stall1_carry_n_4,stall1_carry_n_5,stall1_carry_n_6,stall1_carry_n_7}),
        .S({stall1_carry_i_1_n_0,stall1_carry_i_2_n_0,stall1_carry_i_3_n_0,stall1_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1_carry__0
       (.CI(stall1_carry_n_0),
        .CO({stall1_carry__0_n_0,stall1_carry__0_n_1,stall1_carry__0_n_2,stall1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(read_count[7:4]),
        .O({stall1_carry__0_n_4,stall1_carry__0_n_5,stall1_carry__0_n_6,stall1_carry__0_n_7}),
        .S({stall1_carry__0_i_1_n_0,stall1_carry__0_i_2_n_0,stall1_carry__0_i_3_n_0,stall1_carry__0_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__0_i_1
       (.I0(read_count[7]),
        .I1(write_count[7]),
        .O(stall1_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__0_i_2
       (.I0(read_count[6]),
        .I1(write_count[6]),
        .O(stall1_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__0_i_3
       (.I0(read_count[5]),
        .I1(write_count[5]),
        .O(stall1_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__0_i_4
       (.I0(read_count[4]),
        .I1(write_count[4]),
        .O(stall1_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1_carry__1
       (.CI(stall1_carry__0_n_0),
        .CO({stall1_carry__1_n_0,stall1_carry__1_n_1,stall1_carry__1_n_2,stall1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(read_count[11:8]),
        .O({stall1_carry__1_n_4,stall1_carry__1_n_5,stall1_carry__1_n_6,stall1_carry__1_n_7}),
        .S({stall1_carry__1_i_1_n_0,stall1_carry__1_i_2_n_0,stall1_carry__1_i_3_n_0,stall1_carry__1_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__1_i_1
       (.I0(read_count[11]),
        .I1(write_count[11]),
        .O(stall1_carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__1_i_2
       (.I0(read_count[10]),
        .I1(write_count[10]),
        .O(stall1_carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__1_i_3
       (.I0(read_count[9]),
        .I1(write_count[9]),
        .O(stall1_carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__1_i_4
       (.I0(read_count[8]),
        .I1(write_count[8]),
        .O(stall1_carry__1_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1_carry__2
       (.CI(stall1_carry__1_n_0),
        .CO({stall1_carry__2_n_0,stall1_carry__2_n_1,stall1_carry__2_n_2,stall1_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI(read_count[15:12]),
        .O({stall1_carry__2_n_4,stall1_carry__2_n_5,stall1_carry__2_n_6,stall1_carry__2_n_7}),
        .S({stall1_carry__2_i_1_n_0,stall1_carry__2_i_2_n_0,stall1_carry__2_i_3_n_0,stall1_carry__2_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__2_i_1
       (.I0(read_count[15]),
        .I1(write_count[15]),
        .O(stall1_carry__2_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__2_i_2
       (.I0(read_count[14]),
        .I1(write_count[14]),
        .O(stall1_carry__2_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__2_i_3
       (.I0(read_count[13]),
        .I1(write_count[13]),
        .O(stall1_carry__2_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__2_i_4
       (.I0(read_count[12]),
        .I1(write_count[12]),
        .O(stall1_carry__2_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1_carry__3
       (.CI(stall1_carry__2_n_0),
        .CO({stall1_carry__3_n_0,stall1_carry__3_n_1,stall1_carry__3_n_2,stall1_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI(read_count[19:16]),
        .O({stall1_carry__3_n_4,stall1_carry__3_n_5,stall1_carry__3_n_6,stall1_carry__3_n_7}),
        .S({stall1_carry__3_i_1_n_0,stall1_carry__3_i_2_n_0,stall1_carry__3_i_3_n_0,stall1_carry__3_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__3_i_1
       (.I0(read_count[19]),
        .I1(write_count[19]),
        .O(stall1_carry__3_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__3_i_2
       (.I0(read_count[18]),
        .I1(write_count[18]),
        .O(stall1_carry__3_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__3_i_3
       (.I0(read_count[17]),
        .I1(write_count[17]),
        .O(stall1_carry__3_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__3_i_4
       (.I0(read_count[16]),
        .I1(write_count[16]),
        .O(stall1_carry__3_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1_carry__4
       (.CI(stall1_carry__3_n_0),
        .CO({stall1_carry__4_n_0,stall1_carry__4_n_1,stall1_carry__4_n_2,stall1_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI(read_count[23:20]),
        .O({stall1_carry__4_n_4,stall1_carry__4_n_5,stall1_carry__4_n_6,stall1_carry__4_n_7}),
        .S({stall1_carry__4_i_1_n_0,stall1_carry__4_i_2_n_0,stall1_carry__4_i_3_n_0,stall1_carry__4_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__4_i_1
       (.I0(read_count[23]),
        .I1(write_count[23]),
        .O(stall1_carry__4_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__4_i_2
       (.I0(read_count[22]),
        .I1(write_count[22]),
        .O(stall1_carry__4_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__4_i_3
       (.I0(read_count[21]),
        .I1(write_count[21]),
        .O(stall1_carry__4_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__4_i_4
       (.I0(read_count[20]),
        .I1(write_count[20]),
        .O(stall1_carry__4_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1_carry__5
       (.CI(stall1_carry__4_n_0),
        .CO({stall1_carry__5_n_0,stall1_carry__5_n_1,stall1_carry__5_n_2,stall1_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI(read_count[27:24]),
        .O({stall1_carry__5_n_4,stall1_carry__5_n_5,stall1_carry__5_n_6,stall1_carry__5_n_7}),
        .S({stall1_carry__5_i_1_n_0,stall1_carry__5_i_2_n_0,stall1_carry__5_i_3_n_0,stall1_carry__5_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__5_i_1
       (.I0(read_count[27]),
        .I1(write_count[27]),
        .O(stall1_carry__5_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__5_i_2
       (.I0(read_count[26]),
        .I1(write_count[26]),
        .O(stall1_carry__5_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__5_i_3
       (.I0(read_count[25]),
        .I1(write_count[25]),
        .O(stall1_carry__5_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__5_i_4
       (.I0(read_count[24]),
        .I1(write_count[24]),
        .O(stall1_carry__5_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 stall1_carry__6
       (.CI(stall1_carry__5_n_0),
        .CO({NLW_stall1_carry__6_CO_UNCONNECTED[3],stall1_carry__6_n_1,stall1_carry__6_n_2,stall1_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,read_count[30:28]}),
        .O({stall1_carry__6_n_4,stall1_carry__6_n_5,stall1_carry__6_n_6,stall1_carry__6_n_7}),
        .S({stall1_carry__6_i_1_n_0,stall1_carry__6_i_2_n_0,stall1_carry__6_i_3_n_0,stall1_carry__6_i_4_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__6_i_1
       (.I0(read_count[31]),
        .I1(write_count[31]),
        .O(stall1_carry__6_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__6_i_2
       (.I0(read_count[30]),
        .I1(write_count[30]),
        .O(stall1_carry__6_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__6_i_3
       (.I0(read_count[29]),
        .I1(write_count[29]),
        .O(stall1_carry__6_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry__6_i_4
       (.I0(read_count[28]),
        .I1(write_count[28]),
        .O(stall1_carry__6_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry_i_1
       (.I0(read_count[3]),
        .I1(write_count[3]),
        .O(stall1_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry_i_2
       (.I0(read_count[2]),
        .I1(write_count[2]),
        .O(stall1_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry_i_3
       (.I0(read_count[1]),
        .I1(write_count[1]),
        .O(stall1_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    stall1_carry_i_4
       (.I0(read_count[0]),
        .I1(write_count[0]),
        .O(stall1_carry_i_4_n_0));
  LUT3 #(
    .INIT(8'hF8)) 
    stall_INST_0
       (.I0(stall_INST_0_i_1_n_0),
        .I1(stall_INST_0_i_2_n_0),
        .I2(stall0_carry__2_n_0),
        .O(stall));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    stall_INST_0_i_1
       (.I0(stall1_carry__6_n_7),
        .I1(stall1_carry__6_n_6),
        .I2(stall1_carry__5_n_5),
        .I3(stall1_carry__5_n_4),
        .I4(stall1_carry__6_n_4),
        .I5(stall1_carry__6_n_5),
        .O(stall_INST_0_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    stall_INST_0_i_2
       (.I0(stall_INST_0_i_3_n_0),
        .I1(stall_INST_0_i_4_n_0),
        .I2(stall_INST_0_i_5_n_0),
        .I3(stall_INST_0_i_6_n_0),
        .I4(stall1_carry_n_6),
        .I5(stall1_carry_n_7),
        .O(stall_INST_0_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    stall_INST_0_i_3
       (.I0(stall1_carry__4_n_5),
        .I1(stall1_carry__4_n_4),
        .I2(stall1_carry__4_n_7),
        .I3(stall1_carry__4_n_6),
        .I4(stall1_carry__5_n_6),
        .I5(stall1_carry__5_n_7),
        .O(stall_INST_0_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    stall_INST_0_i_4
       (.I0(stall1_carry__3_n_7),
        .I1(stall1_carry__3_n_6),
        .I2(stall1_carry__2_n_5),
        .I3(stall1_carry__2_n_4),
        .I4(stall1_carry__3_n_4),
        .I5(stall1_carry__3_n_5),
        .O(stall_INST_0_i_4_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    stall_INST_0_i_5
       (.I0(stall1_carry__1_n_5),
        .I1(stall1_carry__1_n_4),
        .I2(stall1_carry__1_n_7),
        .I3(stall1_carry__1_n_6),
        .I4(stall1_carry__2_n_6),
        .I5(stall1_carry__2_n_7),
        .O(stall_INST_0_i_5_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    stall_INST_0_i_6
       (.I0(stall1_carry__0_n_7),
        .I1(stall1_carry__0_n_6),
        .I2(stall1_carry_n_5),
        .I3(stall1_carry_n_4),
        .I4(stall1_carry__0_n_4),
        .I5(stall1_carry__0_n_5),
        .O(stall_INST_0_i_6_n_0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
