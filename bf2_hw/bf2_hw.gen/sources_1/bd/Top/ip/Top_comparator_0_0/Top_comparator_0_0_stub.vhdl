-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
-- Date        : Mon Feb  9 18:08:41 2026
-- Host        : cansu-pc running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/cansu/bf2_hw/bf2_hw.gen/sources_1/bd/Top/ip/Top_comparator_0_0/Top_comparator_0_0_stub.vhdl
-- Design      : Top_comparator_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_comparator_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    write_count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    read_count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    stall : out STD_LOGIC
  );

end Top_comparator_0_0;

architecture stub of Top_comparator_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst_n,write_count[31:0],read_count[31:0],stall";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "comparator,Vivado 2023.1";
begin
end;
