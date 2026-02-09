-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
-- Date        : Mon Feb  9 18:16:48 2026
-- Host        : cansu-pc running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Top_multi_cores_top_0_0_stub.vhdl
-- Design      : Top_multi_cores_top_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    clk_i : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    start_i : in STD_LOGIC;
    host_ready : in STD_LOGIC;
    number_of_hashes : in STD_LOGIC_VECTOR ( 3 downto 0 );
    prog_data_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    prog_done_o : out STD_LOGIC;
    bram_addrb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_dinb : out STD_LOGIC_VECTOR ( 127 downto 0 );
    bram_web : out STD_LOGIC_VECTOR ( 15 downto 0 );
    write_count : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_i,rst_n,start_i,host_ready,number_of_hashes[3:0],prog_data_i[31:0],prog_done_o,bram_addrb[31:0],bram_dinb[127:0],bram_web[15:0],write_count[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "multi_cores_top,Vivado 2023.1";
begin
end;
