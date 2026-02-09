-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
-- Date        : Mon Feb  9 18:08:41 2026
-- Host        : cansu-pc running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/cansu/bf2_hw/bf2_hw.gen/sources_1/bd/Top/ip/Top_comparator_0_0/Top_comparator_0_0_sim_netlist.vhdl
-- Design      : Top_comparator_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a200tfbg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Top_comparator_0_0_comparator is
  port (
    stall : out STD_LOGIC;
    read_count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    write_count : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of Top_comparator_0_0_comparator : entity is "comparator";
end Top_comparator_0_0_comparator;

architecture STRUCTURE of Top_comparator_0_0_comparator is
  signal \stall0_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_n_0\ : STD_LOGIC;
  signal \stall0_carry__0_n_1\ : STD_LOGIC;
  signal \stall0_carry__0_n_2\ : STD_LOGIC;
  signal \stall0_carry__0_n_3\ : STD_LOGIC;
  signal \stall0_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_i_5_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_i_6_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_i_7_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_i_8_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_n_0\ : STD_LOGIC;
  signal \stall0_carry__1_n_1\ : STD_LOGIC;
  signal \stall0_carry__1_n_2\ : STD_LOGIC;
  signal \stall0_carry__1_n_3\ : STD_LOGIC;
  signal \stall0_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_i_5_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_i_6_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_i_7_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_i_8_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_n_0\ : STD_LOGIC;
  signal \stall0_carry__2_n_1\ : STD_LOGIC;
  signal \stall0_carry__2_n_2\ : STD_LOGIC;
  signal \stall0_carry__2_n_3\ : STD_LOGIC;
  signal stall0_carry_i_1_n_0 : STD_LOGIC;
  signal stall0_carry_i_2_n_0 : STD_LOGIC;
  signal stall0_carry_i_3_n_0 : STD_LOGIC;
  signal stall0_carry_i_4_n_0 : STD_LOGIC;
  signal stall0_carry_i_5_n_0 : STD_LOGIC;
  signal stall0_carry_i_6_n_0 : STD_LOGIC;
  signal stall0_carry_i_7_n_0 : STD_LOGIC;
  signal stall0_carry_i_8_n_0 : STD_LOGIC;
  signal stall0_carry_n_0 : STD_LOGIC;
  signal stall0_carry_n_1 : STD_LOGIC;
  signal stall0_carry_n_2 : STD_LOGIC;
  signal stall0_carry_n_3 : STD_LOGIC;
  signal \stall1__93_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__0_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__0_n_1\ : STD_LOGIC;
  signal \stall1__93_carry__0_n_2\ : STD_LOGIC;
  signal \stall1__93_carry__0_n_3\ : STD_LOGIC;
  signal \stall1__93_carry__0_n_4\ : STD_LOGIC;
  signal \stall1__93_carry__0_n_5\ : STD_LOGIC;
  signal \stall1__93_carry__0_n_6\ : STD_LOGIC;
  signal \stall1__93_carry__0_n_7\ : STD_LOGIC;
  signal \stall1__93_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__1_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__1_n_1\ : STD_LOGIC;
  signal \stall1__93_carry__1_n_2\ : STD_LOGIC;
  signal \stall1__93_carry__1_n_3\ : STD_LOGIC;
  signal \stall1__93_carry__1_n_4\ : STD_LOGIC;
  signal \stall1__93_carry__1_n_5\ : STD_LOGIC;
  signal \stall1__93_carry__1_n_6\ : STD_LOGIC;
  signal \stall1__93_carry__1_n_7\ : STD_LOGIC;
  signal \stall1__93_carry__2_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__2_n_1\ : STD_LOGIC;
  signal \stall1__93_carry__2_n_2\ : STD_LOGIC;
  signal \stall1__93_carry__2_n_3\ : STD_LOGIC;
  signal \stall1__93_carry__2_n_4\ : STD_LOGIC;
  signal \stall1__93_carry__2_n_5\ : STD_LOGIC;
  signal \stall1__93_carry__2_n_6\ : STD_LOGIC;
  signal \stall1__93_carry__2_n_7\ : STD_LOGIC;
  signal \stall1__93_carry__3_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__3_n_1\ : STD_LOGIC;
  signal \stall1__93_carry__3_n_2\ : STD_LOGIC;
  signal \stall1__93_carry__3_n_3\ : STD_LOGIC;
  signal \stall1__93_carry__3_n_4\ : STD_LOGIC;
  signal \stall1__93_carry__3_n_5\ : STD_LOGIC;
  signal \stall1__93_carry__3_n_6\ : STD_LOGIC;
  signal \stall1__93_carry__3_n_7\ : STD_LOGIC;
  signal \stall1__93_carry__4_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__4_n_1\ : STD_LOGIC;
  signal \stall1__93_carry__4_n_2\ : STD_LOGIC;
  signal \stall1__93_carry__4_n_3\ : STD_LOGIC;
  signal \stall1__93_carry__4_n_4\ : STD_LOGIC;
  signal \stall1__93_carry__4_n_5\ : STD_LOGIC;
  signal \stall1__93_carry__4_n_6\ : STD_LOGIC;
  signal \stall1__93_carry__4_n_7\ : STD_LOGIC;
  signal \stall1__93_carry__5_n_0\ : STD_LOGIC;
  signal \stall1__93_carry__5_n_1\ : STD_LOGIC;
  signal \stall1__93_carry__5_n_2\ : STD_LOGIC;
  signal \stall1__93_carry__5_n_3\ : STD_LOGIC;
  signal \stall1__93_carry__5_n_4\ : STD_LOGIC;
  signal \stall1__93_carry__5_n_5\ : STD_LOGIC;
  signal \stall1__93_carry__5_n_6\ : STD_LOGIC;
  signal \stall1__93_carry__5_n_7\ : STD_LOGIC;
  signal \stall1__93_carry__6_n_2\ : STD_LOGIC;
  signal \stall1__93_carry__6_n_3\ : STD_LOGIC;
  signal \stall1__93_carry__6_n_5\ : STD_LOGIC;
  signal \stall1__93_carry__6_n_6\ : STD_LOGIC;
  signal \stall1__93_carry__6_n_7\ : STD_LOGIC;
  signal \stall1__93_carry_i_1_n_0\ : STD_LOGIC;
  signal \stall1__93_carry_i_2_n_0\ : STD_LOGIC;
  signal \stall1__93_carry_i_3_n_0\ : STD_LOGIC;
  signal \stall1__93_carry_n_0\ : STD_LOGIC;
  signal \stall1__93_carry_n_1\ : STD_LOGIC;
  signal \stall1__93_carry_n_2\ : STD_LOGIC;
  signal \stall1__93_carry_n_3\ : STD_LOGIC;
  signal \stall1__93_carry_n_4\ : STD_LOGIC;
  signal \stall1__93_carry_n_5\ : STD_LOGIC;
  signal \stall1__93_carry_n_6\ : STD_LOGIC;
  signal \stall1__93_carry_n_7\ : STD_LOGIC;
  signal \stall1_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \stall1_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \stall1_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \stall1_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \stall1_carry__0_n_0\ : STD_LOGIC;
  signal \stall1_carry__0_n_1\ : STD_LOGIC;
  signal \stall1_carry__0_n_2\ : STD_LOGIC;
  signal \stall1_carry__0_n_3\ : STD_LOGIC;
  signal \stall1_carry__0_n_4\ : STD_LOGIC;
  signal \stall1_carry__0_n_5\ : STD_LOGIC;
  signal \stall1_carry__0_n_6\ : STD_LOGIC;
  signal \stall1_carry__0_n_7\ : STD_LOGIC;
  signal \stall1_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \stall1_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \stall1_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \stall1_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \stall1_carry__1_n_0\ : STD_LOGIC;
  signal \stall1_carry__1_n_1\ : STD_LOGIC;
  signal \stall1_carry__1_n_2\ : STD_LOGIC;
  signal \stall1_carry__1_n_3\ : STD_LOGIC;
  signal \stall1_carry__1_n_4\ : STD_LOGIC;
  signal \stall1_carry__1_n_5\ : STD_LOGIC;
  signal \stall1_carry__1_n_6\ : STD_LOGIC;
  signal \stall1_carry__1_n_7\ : STD_LOGIC;
  signal \stall1_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \stall1_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \stall1_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \stall1_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \stall1_carry__2_n_0\ : STD_LOGIC;
  signal \stall1_carry__2_n_1\ : STD_LOGIC;
  signal \stall1_carry__2_n_2\ : STD_LOGIC;
  signal \stall1_carry__2_n_3\ : STD_LOGIC;
  signal \stall1_carry__2_n_4\ : STD_LOGIC;
  signal \stall1_carry__2_n_5\ : STD_LOGIC;
  signal \stall1_carry__2_n_6\ : STD_LOGIC;
  signal \stall1_carry__2_n_7\ : STD_LOGIC;
  signal \stall1_carry__3_i_1_n_0\ : STD_LOGIC;
  signal \stall1_carry__3_i_2_n_0\ : STD_LOGIC;
  signal \stall1_carry__3_i_3_n_0\ : STD_LOGIC;
  signal \stall1_carry__3_i_4_n_0\ : STD_LOGIC;
  signal \stall1_carry__3_n_0\ : STD_LOGIC;
  signal \stall1_carry__3_n_1\ : STD_LOGIC;
  signal \stall1_carry__3_n_2\ : STD_LOGIC;
  signal \stall1_carry__3_n_3\ : STD_LOGIC;
  signal \stall1_carry__3_n_4\ : STD_LOGIC;
  signal \stall1_carry__3_n_5\ : STD_LOGIC;
  signal \stall1_carry__3_n_6\ : STD_LOGIC;
  signal \stall1_carry__3_n_7\ : STD_LOGIC;
  signal \stall1_carry__4_i_1_n_0\ : STD_LOGIC;
  signal \stall1_carry__4_i_2_n_0\ : STD_LOGIC;
  signal \stall1_carry__4_i_3_n_0\ : STD_LOGIC;
  signal \stall1_carry__4_i_4_n_0\ : STD_LOGIC;
  signal \stall1_carry__4_n_0\ : STD_LOGIC;
  signal \stall1_carry__4_n_1\ : STD_LOGIC;
  signal \stall1_carry__4_n_2\ : STD_LOGIC;
  signal \stall1_carry__4_n_3\ : STD_LOGIC;
  signal \stall1_carry__4_n_4\ : STD_LOGIC;
  signal \stall1_carry__4_n_5\ : STD_LOGIC;
  signal \stall1_carry__4_n_6\ : STD_LOGIC;
  signal \stall1_carry__4_n_7\ : STD_LOGIC;
  signal \stall1_carry__5_i_1_n_0\ : STD_LOGIC;
  signal \stall1_carry__5_i_2_n_0\ : STD_LOGIC;
  signal \stall1_carry__5_i_3_n_0\ : STD_LOGIC;
  signal \stall1_carry__5_i_4_n_0\ : STD_LOGIC;
  signal \stall1_carry__5_n_0\ : STD_LOGIC;
  signal \stall1_carry__5_n_1\ : STD_LOGIC;
  signal \stall1_carry__5_n_2\ : STD_LOGIC;
  signal \stall1_carry__5_n_3\ : STD_LOGIC;
  signal \stall1_carry__5_n_4\ : STD_LOGIC;
  signal \stall1_carry__5_n_5\ : STD_LOGIC;
  signal \stall1_carry__5_n_6\ : STD_LOGIC;
  signal \stall1_carry__5_n_7\ : STD_LOGIC;
  signal \stall1_carry__6_i_1_n_0\ : STD_LOGIC;
  signal \stall1_carry__6_i_2_n_0\ : STD_LOGIC;
  signal \stall1_carry__6_i_3_n_0\ : STD_LOGIC;
  signal \stall1_carry__6_i_4_n_0\ : STD_LOGIC;
  signal \stall1_carry__6_n_1\ : STD_LOGIC;
  signal \stall1_carry__6_n_2\ : STD_LOGIC;
  signal \stall1_carry__6_n_3\ : STD_LOGIC;
  signal \stall1_carry__6_n_4\ : STD_LOGIC;
  signal \stall1_carry__6_n_5\ : STD_LOGIC;
  signal \stall1_carry__6_n_6\ : STD_LOGIC;
  signal \stall1_carry__6_n_7\ : STD_LOGIC;
  signal stall1_carry_i_1_n_0 : STD_LOGIC;
  signal stall1_carry_i_2_n_0 : STD_LOGIC;
  signal stall1_carry_i_3_n_0 : STD_LOGIC;
  signal stall1_carry_i_4_n_0 : STD_LOGIC;
  signal stall1_carry_n_0 : STD_LOGIC;
  signal stall1_carry_n_1 : STD_LOGIC;
  signal stall1_carry_n_2 : STD_LOGIC;
  signal stall1_carry_n_3 : STD_LOGIC;
  signal stall1_carry_n_4 : STD_LOGIC;
  signal stall1_carry_n_5 : STD_LOGIC;
  signal stall1_carry_n_6 : STD_LOGIC;
  signal stall1_carry_n_7 : STD_LOGIC;
  signal stall_INST_0_i_1_n_0 : STD_LOGIC;
  signal stall_INST_0_i_2_n_0 : STD_LOGIC;
  signal stall_INST_0_i_3_n_0 : STD_LOGIC;
  signal stall_INST_0_i_4_n_0 : STD_LOGIC;
  signal stall_INST_0_i_5_n_0 : STD_LOGIC;
  signal stall_INST_0_i_6_n_0 : STD_LOGIC;
  signal NLW_stall0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_stall0_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_stall0_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_stall0_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_stall1__93_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_stall1__93_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_stall1_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of stall0_carry : label is 11;
  attribute COMPARATOR_THRESHOLD of \stall0_carry__0\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \stall0_carry__1\ : label is 11;
  attribute COMPARATOR_THRESHOLD of \stall0_carry__2\ : label is 11;
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \stall1__93_carry\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1__93_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1__93_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1__93_carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1__93_carry__3\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1__93_carry__4\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1__93_carry__5\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1__93_carry__6\ : label is 35;
  attribute ADDER_THRESHOLD of stall1_carry : label is 35;
  attribute ADDER_THRESHOLD of \stall1_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1_carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1_carry__3\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1_carry__4\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1_carry__5\ : label is 35;
  attribute ADDER_THRESHOLD of \stall1_carry__6\ : label is 35;
begin
stall0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => stall0_carry_n_0,
      CO(2) => stall0_carry_n_1,
      CO(1) => stall0_carry_n_2,
      CO(0) => stall0_carry_n_3,
      CYINIT => '1',
      DI(3) => stall0_carry_i_1_n_0,
      DI(2) => stall0_carry_i_2_n_0,
      DI(1) => stall0_carry_i_3_n_0,
      DI(0) => stall0_carry_i_4_n_0,
      O(3 downto 0) => NLW_stall0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => stall0_carry_i_5_n_0,
      S(2) => stall0_carry_i_6_n_0,
      S(1) => stall0_carry_i_7_n_0,
      S(0) => stall0_carry_i_8_n_0
    );
\stall0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => stall0_carry_n_0,
      CO(3) => \stall0_carry__0_n_0\,
      CO(2) => \stall0_carry__0_n_1\,
      CO(1) => \stall0_carry__0_n_2\,
      CO(0) => \stall0_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \stall0_carry__0_i_1_n_0\,
      DI(2) => \stall0_carry__0_i_2_n_0\,
      DI(1) => \stall0_carry__0_i_3_n_0\,
      DI(0) => \stall0_carry__0_i_4_n_0\,
      O(3 downto 0) => \NLW_stall0_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \stall0_carry__0_i_5_n_0\,
      S(2) => \stall0_carry__0_i_6_n_0\,
      S(1) => \stall0_carry__0_i_7_n_0\,
      S(0) => \stall0_carry__0_i_8_n_0\
    );
\stall0_carry__0_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(15),
      I1 => \stall1__93_carry__2_n_5\,
      I2 => write_count(14),
      I3 => \stall1__93_carry__2_n_6\,
      O => \stall0_carry__0_i_1_n_0\
    );
\stall0_carry__0_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(13),
      I1 => \stall1__93_carry__2_n_7\,
      I2 => write_count(12),
      I3 => \stall1__93_carry__1_n_4\,
      O => \stall0_carry__0_i_2_n_0\
    );
\stall0_carry__0_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(11),
      I1 => \stall1__93_carry__1_n_5\,
      I2 => write_count(10),
      I3 => \stall1__93_carry__1_n_6\,
      O => \stall0_carry__0_i_3_n_0\
    );
\stall0_carry__0_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(9),
      I1 => \stall1__93_carry__1_n_7\,
      I2 => write_count(8),
      I3 => \stall1__93_carry__0_n_4\,
      O => \stall0_carry__0_i_4_n_0\
    );
\stall0_carry__0_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__2_n_5\,
      I1 => write_count(15),
      I2 => \stall1__93_carry__2_n_6\,
      I3 => write_count(14),
      O => \stall0_carry__0_i_5_n_0\
    );
\stall0_carry__0_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__2_n_7\,
      I1 => write_count(13),
      I2 => \stall1__93_carry__1_n_4\,
      I3 => write_count(12),
      O => \stall0_carry__0_i_6_n_0\
    );
\stall0_carry__0_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__1_n_5\,
      I1 => write_count(11),
      I2 => \stall1__93_carry__1_n_6\,
      I3 => write_count(10),
      O => \stall0_carry__0_i_7_n_0\
    );
\stall0_carry__0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__1_n_7\,
      I1 => write_count(9),
      I2 => \stall1__93_carry__0_n_4\,
      I3 => write_count(8),
      O => \stall0_carry__0_i_8_n_0\
    );
\stall0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall0_carry__0_n_0\,
      CO(3) => \stall0_carry__1_n_0\,
      CO(2) => \stall0_carry__1_n_1\,
      CO(1) => \stall0_carry__1_n_2\,
      CO(0) => \stall0_carry__1_n_3\,
      CYINIT => '0',
      DI(3) => \stall0_carry__1_i_1_n_0\,
      DI(2) => \stall0_carry__1_i_2_n_0\,
      DI(1) => \stall0_carry__1_i_3_n_0\,
      DI(0) => \stall0_carry__1_i_4_n_0\,
      O(3 downto 0) => \NLW_stall0_carry__1_O_UNCONNECTED\(3 downto 0),
      S(3) => \stall0_carry__1_i_5_n_0\,
      S(2) => \stall0_carry__1_i_6_n_0\,
      S(1) => \stall0_carry__1_i_7_n_0\,
      S(0) => \stall0_carry__1_i_8_n_0\
    );
\stall0_carry__1_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(23),
      I1 => \stall1__93_carry__4_n_5\,
      I2 => write_count(22),
      I3 => \stall1__93_carry__4_n_6\,
      O => \stall0_carry__1_i_1_n_0\
    );
\stall0_carry__1_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(21),
      I1 => \stall1__93_carry__4_n_7\,
      I2 => write_count(20),
      I3 => \stall1__93_carry__3_n_4\,
      O => \stall0_carry__1_i_2_n_0\
    );
\stall0_carry__1_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(19),
      I1 => \stall1__93_carry__3_n_5\,
      I2 => write_count(18),
      I3 => \stall1__93_carry__3_n_6\,
      O => \stall0_carry__1_i_3_n_0\
    );
\stall0_carry__1_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(17),
      I1 => \stall1__93_carry__3_n_7\,
      I2 => write_count(16),
      I3 => \stall1__93_carry__2_n_4\,
      O => \stall0_carry__1_i_4_n_0\
    );
\stall0_carry__1_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__4_n_5\,
      I1 => write_count(23),
      I2 => \stall1__93_carry__4_n_6\,
      I3 => write_count(22),
      O => \stall0_carry__1_i_5_n_0\
    );
\stall0_carry__1_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__4_n_7\,
      I1 => write_count(21),
      I2 => \stall1__93_carry__3_n_4\,
      I3 => write_count(20),
      O => \stall0_carry__1_i_6_n_0\
    );
\stall0_carry__1_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__3_n_5\,
      I1 => write_count(19),
      I2 => \stall1__93_carry__3_n_6\,
      I3 => write_count(18),
      O => \stall0_carry__1_i_7_n_0\
    );
\stall0_carry__1_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__3_n_7\,
      I1 => write_count(17),
      I2 => \stall1__93_carry__2_n_4\,
      I3 => write_count(16),
      O => \stall0_carry__1_i_8_n_0\
    );
\stall0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall0_carry__1_n_0\,
      CO(3) => \stall0_carry__2_n_0\,
      CO(2) => \stall0_carry__2_n_1\,
      CO(1) => \stall0_carry__2_n_2\,
      CO(0) => \stall0_carry__2_n_3\,
      CYINIT => '0',
      DI(3) => \stall0_carry__2_i_1_n_0\,
      DI(2) => \stall0_carry__2_i_2_n_0\,
      DI(1) => \stall0_carry__2_i_3_n_0\,
      DI(0) => \stall0_carry__2_i_4_n_0\,
      O(3 downto 0) => \NLW_stall0_carry__2_O_UNCONNECTED\(3 downto 0),
      S(3) => \stall0_carry__2_i_5_n_0\,
      S(2) => \stall0_carry__2_i_6_n_0\,
      S(1) => \stall0_carry__2_i_7_n_0\,
      S(0) => \stall0_carry__2_i_8_n_0\
    );
\stall0_carry__2_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(31),
      I1 => \stall1__93_carry__6_n_5\,
      I2 => write_count(30),
      I3 => \stall1__93_carry__6_n_6\,
      O => \stall0_carry__2_i_1_n_0\
    );
\stall0_carry__2_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(29),
      I1 => \stall1__93_carry__6_n_7\,
      I2 => write_count(28),
      I3 => \stall1__93_carry__5_n_4\,
      O => \stall0_carry__2_i_2_n_0\
    );
\stall0_carry__2_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(27),
      I1 => \stall1__93_carry__5_n_5\,
      I2 => write_count(26),
      I3 => \stall1__93_carry__5_n_6\,
      O => \stall0_carry__2_i_3_n_0\
    );
\stall0_carry__2_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(25),
      I1 => \stall1__93_carry__5_n_7\,
      I2 => write_count(24),
      I3 => \stall1__93_carry__4_n_4\,
      O => \stall0_carry__2_i_4_n_0\
    );
\stall0_carry__2_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__6_n_5\,
      I1 => write_count(31),
      I2 => \stall1__93_carry__6_n_6\,
      I3 => write_count(30),
      O => \stall0_carry__2_i_5_n_0\
    );
\stall0_carry__2_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__6_n_7\,
      I1 => write_count(29),
      I2 => \stall1__93_carry__5_n_4\,
      I3 => write_count(28),
      O => \stall0_carry__2_i_6_n_0\
    );
\stall0_carry__2_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__5_n_5\,
      I1 => write_count(27),
      I2 => \stall1__93_carry__5_n_6\,
      I3 => write_count(26),
      O => \stall0_carry__2_i_7_n_0\
    );
\stall0_carry__2_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__5_n_7\,
      I1 => write_count(25),
      I2 => \stall1__93_carry__4_n_4\,
      I3 => write_count(24),
      O => \stall0_carry__2_i_8_n_0\
    );
stall0_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(7),
      I1 => \stall1__93_carry__0_n_5\,
      I2 => write_count(6),
      I3 => \stall1__93_carry__0_n_6\,
      O => stall0_carry_i_1_n_0
    );
stall0_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(5),
      I1 => \stall1__93_carry__0_n_7\,
      I2 => write_count(4),
      I3 => \stall1__93_carry_n_4\,
      O => stall0_carry_i_2_n_0
    );
stall0_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => write_count(3),
      I1 => \stall1__93_carry_n_5\,
      I2 => write_count(2),
      I3 => \stall1__93_carry_n_6\,
      O => stall0_carry_i_3_n_0
    );
stall0_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B222"
    )
        port map (
      I0 => write_count(1),
      I1 => \stall1__93_carry_n_7\,
      I2 => write_count(0),
      I3 => read_count(0),
      O => stall0_carry_i_4_n_0
    );
stall0_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__0_n_5\,
      I1 => write_count(7),
      I2 => \stall1__93_carry__0_n_6\,
      I3 => write_count(6),
      O => stall0_carry_i_5_n_0
    );
stall0_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry__0_n_7\,
      I1 => write_count(5),
      I2 => \stall1__93_carry_n_4\,
      I3 => write_count(4),
      O => stall0_carry_i_6_n_0
    );
stall0_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \stall1__93_carry_n_5\,
      I1 => write_count(3),
      I2 => \stall1__93_carry_n_6\,
      I3 => write_count(2),
      O => stall0_carry_i_7_n_0
    );
stall0_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6006"
    )
        port map (
      I0 => write_count(0),
      I1 => read_count(0),
      I2 => \stall1__93_carry_n_7\,
      I3 => write_count(1),
      O => stall0_carry_i_8_n_0
    );
\stall1__93_carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \stall1__93_carry_n_0\,
      CO(2) => \stall1__93_carry_n_1\,
      CO(1) => \stall1__93_carry_n_2\,
      CO(0) => \stall1__93_carry_n_3\,
      CYINIT => read_count(0),
      DI(3 downto 1) => read_count(4 downto 2),
      DI(0) => '0',
      O(3) => \stall1__93_carry_n_4\,
      O(2) => \stall1__93_carry_n_5\,
      O(1) => \stall1__93_carry_n_6\,
      O(0) => \stall1__93_carry_n_7\,
      S(3) => \stall1__93_carry_i_1_n_0\,
      S(2) => \stall1__93_carry_i_2_n_0\,
      S(1) => \stall1__93_carry_i_3_n_0\,
      S(0) => read_count(1)
    );
\stall1__93_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1__93_carry_n_0\,
      CO(3) => \stall1__93_carry__0_n_0\,
      CO(2) => \stall1__93_carry__0_n_1\,
      CO(1) => \stall1__93_carry__0_n_2\,
      CO(0) => \stall1__93_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => read_count(8 downto 5),
      O(3) => \stall1__93_carry__0_n_4\,
      O(2) => \stall1__93_carry__0_n_5\,
      O(1) => \stall1__93_carry__0_n_6\,
      O(0) => \stall1__93_carry__0_n_7\,
      S(3) => \stall1__93_carry__0_i_1_n_0\,
      S(2) => \stall1__93_carry__0_i_2_n_0\,
      S(1) => \stall1__93_carry__0_i_3_n_0\,
      S(0) => \stall1__93_carry__0_i_4_n_0\
    );
\stall1__93_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => read_count(8),
      O => \stall1__93_carry__0_i_1_n_0\
    );
\stall1__93_carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => read_count(7),
      O => \stall1__93_carry__0_i_2_n_0\
    );
\stall1__93_carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => read_count(6),
      O => \stall1__93_carry__0_i_3_n_0\
    );
\stall1__93_carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => read_count(5),
      O => \stall1__93_carry__0_i_4_n_0\
    );
\stall1__93_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1__93_carry__0_n_0\,
      CO(3) => \stall1__93_carry__1_n_0\,
      CO(2) => \stall1__93_carry__1_n_1\,
      CO(1) => \stall1__93_carry__1_n_2\,
      CO(0) => \stall1__93_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => read_count(9),
      O(3) => \stall1__93_carry__1_n_4\,
      O(2) => \stall1__93_carry__1_n_5\,
      O(1) => \stall1__93_carry__1_n_6\,
      O(0) => \stall1__93_carry__1_n_7\,
      S(3 downto 1) => read_count(12 downto 10),
      S(0) => \stall1__93_carry__1_i_1_n_0\
    );
\stall1__93_carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => read_count(9),
      O => \stall1__93_carry__1_i_1_n_0\
    );
\stall1__93_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1__93_carry__1_n_0\,
      CO(3) => \stall1__93_carry__2_n_0\,
      CO(2) => \stall1__93_carry__2_n_1\,
      CO(1) => \stall1__93_carry__2_n_2\,
      CO(0) => \stall1__93_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \stall1__93_carry__2_n_4\,
      O(2) => \stall1__93_carry__2_n_5\,
      O(1) => \stall1__93_carry__2_n_6\,
      O(0) => \stall1__93_carry__2_n_7\,
      S(3 downto 0) => read_count(16 downto 13)
    );
\stall1__93_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1__93_carry__2_n_0\,
      CO(3) => \stall1__93_carry__3_n_0\,
      CO(2) => \stall1__93_carry__3_n_1\,
      CO(1) => \stall1__93_carry__3_n_2\,
      CO(0) => \stall1__93_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \stall1__93_carry__3_n_4\,
      O(2) => \stall1__93_carry__3_n_5\,
      O(1) => \stall1__93_carry__3_n_6\,
      O(0) => \stall1__93_carry__3_n_7\,
      S(3 downto 0) => read_count(20 downto 17)
    );
\stall1__93_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1__93_carry__3_n_0\,
      CO(3) => \stall1__93_carry__4_n_0\,
      CO(2) => \stall1__93_carry__4_n_1\,
      CO(1) => \stall1__93_carry__4_n_2\,
      CO(0) => \stall1__93_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \stall1__93_carry__4_n_4\,
      O(2) => \stall1__93_carry__4_n_5\,
      O(1) => \stall1__93_carry__4_n_6\,
      O(0) => \stall1__93_carry__4_n_7\,
      S(3 downto 0) => read_count(24 downto 21)
    );
\stall1__93_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1__93_carry__4_n_0\,
      CO(3) => \stall1__93_carry__5_n_0\,
      CO(2) => \stall1__93_carry__5_n_1\,
      CO(1) => \stall1__93_carry__5_n_2\,
      CO(0) => \stall1__93_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \stall1__93_carry__5_n_4\,
      O(2) => \stall1__93_carry__5_n_5\,
      O(1) => \stall1__93_carry__5_n_6\,
      O(0) => \stall1__93_carry__5_n_7\,
      S(3 downto 0) => read_count(28 downto 25)
    );
\stall1__93_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1__93_carry__5_n_0\,
      CO(3 downto 2) => \NLW_stall1__93_carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \stall1__93_carry__6_n_2\,
      CO(0) => \stall1__93_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_stall1__93_carry__6_O_UNCONNECTED\(3),
      O(2) => \stall1__93_carry__6_n_5\,
      O(1) => \stall1__93_carry__6_n_6\,
      O(0) => \stall1__93_carry__6_n_7\,
      S(3) => '0',
      S(2 downto 0) => read_count(31 downto 29)
    );
\stall1__93_carry_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => read_count(4),
      O => \stall1__93_carry_i_1_n_0\
    );
\stall1__93_carry_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => read_count(3),
      O => \stall1__93_carry_i_2_n_0\
    );
\stall1__93_carry_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => read_count(2),
      O => \stall1__93_carry_i_3_n_0\
    );
stall1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => stall1_carry_n_0,
      CO(2) => stall1_carry_n_1,
      CO(1) => stall1_carry_n_2,
      CO(0) => stall1_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => read_count(3 downto 0),
      O(3) => stall1_carry_n_4,
      O(2) => stall1_carry_n_5,
      O(1) => stall1_carry_n_6,
      O(0) => stall1_carry_n_7,
      S(3) => stall1_carry_i_1_n_0,
      S(2) => stall1_carry_i_2_n_0,
      S(1) => stall1_carry_i_3_n_0,
      S(0) => stall1_carry_i_4_n_0
    );
\stall1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => stall1_carry_n_0,
      CO(3) => \stall1_carry__0_n_0\,
      CO(2) => \stall1_carry__0_n_1\,
      CO(1) => \stall1_carry__0_n_2\,
      CO(0) => \stall1_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => read_count(7 downto 4),
      O(3) => \stall1_carry__0_n_4\,
      O(2) => \stall1_carry__0_n_5\,
      O(1) => \stall1_carry__0_n_6\,
      O(0) => \stall1_carry__0_n_7\,
      S(3) => \stall1_carry__0_i_1_n_0\,
      S(2) => \stall1_carry__0_i_2_n_0\,
      S(1) => \stall1_carry__0_i_3_n_0\,
      S(0) => \stall1_carry__0_i_4_n_0\
    );
\stall1_carry__0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(7),
      I1 => write_count(7),
      O => \stall1_carry__0_i_1_n_0\
    );
\stall1_carry__0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(6),
      I1 => write_count(6),
      O => \stall1_carry__0_i_2_n_0\
    );
\stall1_carry__0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(5),
      I1 => write_count(5),
      O => \stall1_carry__0_i_3_n_0\
    );
\stall1_carry__0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(4),
      I1 => write_count(4),
      O => \stall1_carry__0_i_4_n_0\
    );
\stall1_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1_carry__0_n_0\,
      CO(3) => \stall1_carry__1_n_0\,
      CO(2) => \stall1_carry__1_n_1\,
      CO(1) => \stall1_carry__1_n_2\,
      CO(0) => \stall1_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => read_count(11 downto 8),
      O(3) => \stall1_carry__1_n_4\,
      O(2) => \stall1_carry__1_n_5\,
      O(1) => \stall1_carry__1_n_6\,
      O(0) => \stall1_carry__1_n_7\,
      S(3) => \stall1_carry__1_i_1_n_0\,
      S(2) => \stall1_carry__1_i_2_n_0\,
      S(1) => \stall1_carry__1_i_3_n_0\,
      S(0) => \stall1_carry__1_i_4_n_0\
    );
\stall1_carry__1_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(11),
      I1 => write_count(11),
      O => \stall1_carry__1_i_1_n_0\
    );
\stall1_carry__1_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(10),
      I1 => write_count(10),
      O => \stall1_carry__1_i_2_n_0\
    );
\stall1_carry__1_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(9),
      I1 => write_count(9),
      O => \stall1_carry__1_i_3_n_0\
    );
\stall1_carry__1_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(8),
      I1 => write_count(8),
      O => \stall1_carry__1_i_4_n_0\
    );
\stall1_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1_carry__1_n_0\,
      CO(3) => \stall1_carry__2_n_0\,
      CO(2) => \stall1_carry__2_n_1\,
      CO(1) => \stall1_carry__2_n_2\,
      CO(0) => \stall1_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => read_count(15 downto 12),
      O(3) => \stall1_carry__2_n_4\,
      O(2) => \stall1_carry__2_n_5\,
      O(1) => \stall1_carry__2_n_6\,
      O(0) => \stall1_carry__2_n_7\,
      S(3) => \stall1_carry__2_i_1_n_0\,
      S(2) => \stall1_carry__2_i_2_n_0\,
      S(1) => \stall1_carry__2_i_3_n_0\,
      S(0) => \stall1_carry__2_i_4_n_0\
    );
\stall1_carry__2_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(15),
      I1 => write_count(15),
      O => \stall1_carry__2_i_1_n_0\
    );
\stall1_carry__2_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(14),
      I1 => write_count(14),
      O => \stall1_carry__2_i_2_n_0\
    );
\stall1_carry__2_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(13),
      I1 => write_count(13),
      O => \stall1_carry__2_i_3_n_0\
    );
\stall1_carry__2_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(12),
      I1 => write_count(12),
      O => \stall1_carry__2_i_4_n_0\
    );
\stall1_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1_carry__2_n_0\,
      CO(3) => \stall1_carry__3_n_0\,
      CO(2) => \stall1_carry__3_n_1\,
      CO(1) => \stall1_carry__3_n_2\,
      CO(0) => \stall1_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => read_count(19 downto 16),
      O(3) => \stall1_carry__3_n_4\,
      O(2) => \stall1_carry__3_n_5\,
      O(1) => \stall1_carry__3_n_6\,
      O(0) => \stall1_carry__3_n_7\,
      S(3) => \stall1_carry__3_i_1_n_0\,
      S(2) => \stall1_carry__3_i_2_n_0\,
      S(1) => \stall1_carry__3_i_3_n_0\,
      S(0) => \stall1_carry__3_i_4_n_0\
    );
\stall1_carry__3_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(19),
      I1 => write_count(19),
      O => \stall1_carry__3_i_1_n_0\
    );
\stall1_carry__3_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(18),
      I1 => write_count(18),
      O => \stall1_carry__3_i_2_n_0\
    );
\stall1_carry__3_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(17),
      I1 => write_count(17),
      O => \stall1_carry__3_i_3_n_0\
    );
\stall1_carry__3_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(16),
      I1 => write_count(16),
      O => \stall1_carry__3_i_4_n_0\
    );
\stall1_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1_carry__3_n_0\,
      CO(3) => \stall1_carry__4_n_0\,
      CO(2) => \stall1_carry__4_n_1\,
      CO(1) => \stall1_carry__4_n_2\,
      CO(0) => \stall1_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => read_count(23 downto 20),
      O(3) => \stall1_carry__4_n_4\,
      O(2) => \stall1_carry__4_n_5\,
      O(1) => \stall1_carry__4_n_6\,
      O(0) => \stall1_carry__4_n_7\,
      S(3) => \stall1_carry__4_i_1_n_0\,
      S(2) => \stall1_carry__4_i_2_n_0\,
      S(1) => \stall1_carry__4_i_3_n_0\,
      S(0) => \stall1_carry__4_i_4_n_0\
    );
\stall1_carry__4_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(23),
      I1 => write_count(23),
      O => \stall1_carry__4_i_1_n_0\
    );
\stall1_carry__4_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(22),
      I1 => write_count(22),
      O => \stall1_carry__4_i_2_n_0\
    );
\stall1_carry__4_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(21),
      I1 => write_count(21),
      O => \stall1_carry__4_i_3_n_0\
    );
\stall1_carry__4_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(20),
      I1 => write_count(20),
      O => \stall1_carry__4_i_4_n_0\
    );
\stall1_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1_carry__4_n_0\,
      CO(3) => \stall1_carry__5_n_0\,
      CO(2) => \stall1_carry__5_n_1\,
      CO(1) => \stall1_carry__5_n_2\,
      CO(0) => \stall1_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => read_count(27 downto 24),
      O(3) => \stall1_carry__5_n_4\,
      O(2) => \stall1_carry__5_n_5\,
      O(1) => \stall1_carry__5_n_6\,
      O(0) => \stall1_carry__5_n_7\,
      S(3) => \stall1_carry__5_i_1_n_0\,
      S(2) => \stall1_carry__5_i_2_n_0\,
      S(1) => \stall1_carry__5_i_3_n_0\,
      S(0) => \stall1_carry__5_i_4_n_0\
    );
\stall1_carry__5_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(27),
      I1 => write_count(27),
      O => \stall1_carry__5_i_1_n_0\
    );
\stall1_carry__5_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(26),
      I1 => write_count(26),
      O => \stall1_carry__5_i_2_n_0\
    );
\stall1_carry__5_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(25),
      I1 => write_count(25),
      O => \stall1_carry__5_i_3_n_0\
    );
\stall1_carry__5_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(24),
      I1 => write_count(24),
      O => \stall1_carry__5_i_4_n_0\
    );
\stall1_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \stall1_carry__5_n_0\,
      CO(3) => \NLW_stall1_carry__6_CO_UNCONNECTED\(3),
      CO(2) => \stall1_carry__6_n_1\,
      CO(1) => \stall1_carry__6_n_2\,
      CO(0) => \stall1_carry__6_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => read_count(30 downto 28),
      O(3) => \stall1_carry__6_n_4\,
      O(2) => \stall1_carry__6_n_5\,
      O(1) => \stall1_carry__6_n_6\,
      O(0) => \stall1_carry__6_n_7\,
      S(3) => \stall1_carry__6_i_1_n_0\,
      S(2) => \stall1_carry__6_i_2_n_0\,
      S(1) => \stall1_carry__6_i_3_n_0\,
      S(0) => \stall1_carry__6_i_4_n_0\
    );
\stall1_carry__6_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(31),
      I1 => write_count(31),
      O => \stall1_carry__6_i_1_n_0\
    );
\stall1_carry__6_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(30),
      I1 => write_count(30),
      O => \stall1_carry__6_i_2_n_0\
    );
\stall1_carry__6_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(29),
      I1 => write_count(29),
      O => \stall1_carry__6_i_3_n_0\
    );
\stall1_carry__6_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(28),
      I1 => write_count(28),
      O => \stall1_carry__6_i_4_n_0\
    );
stall1_carry_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(3),
      I1 => write_count(3),
      O => stall1_carry_i_1_n_0
    );
stall1_carry_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(2),
      I1 => write_count(2),
      O => stall1_carry_i_2_n_0
    );
stall1_carry_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(1),
      I1 => write_count(1),
      O => stall1_carry_i_3_n_0
    );
stall1_carry_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => read_count(0),
      I1 => write_count(0),
      O => stall1_carry_i_4_n_0
    );
stall_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F8"
    )
        port map (
      I0 => stall_INST_0_i_1_n_0,
      I1 => stall_INST_0_i_2_n_0,
      I2 => \stall0_carry__2_n_0\,
      O => stall
    );
stall_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \stall1_carry__6_n_7\,
      I1 => \stall1_carry__6_n_6\,
      I2 => \stall1_carry__5_n_5\,
      I3 => \stall1_carry__5_n_4\,
      I4 => \stall1_carry__6_n_4\,
      I5 => \stall1_carry__6_n_5\,
      O => stall_INST_0_i_1_n_0
    );
stall_INST_0_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000080000000"
    )
        port map (
      I0 => stall_INST_0_i_3_n_0,
      I1 => stall_INST_0_i_4_n_0,
      I2 => stall_INST_0_i_5_n_0,
      I3 => stall_INST_0_i_6_n_0,
      I4 => stall1_carry_n_6,
      I5 => stall1_carry_n_7,
      O => stall_INST_0_i_2_n_0
    );
stall_INST_0_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \stall1_carry__4_n_5\,
      I1 => \stall1_carry__4_n_4\,
      I2 => \stall1_carry__4_n_7\,
      I3 => \stall1_carry__4_n_6\,
      I4 => \stall1_carry__5_n_6\,
      I5 => \stall1_carry__5_n_7\,
      O => stall_INST_0_i_3_n_0
    );
stall_INST_0_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \stall1_carry__3_n_7\,
      I1 => \stall1_carry__3_n_6\,
      I2 => \stall1_carry__2_n_5\,
      I3 => \stall1_carry__2_n_4\,
      I4 => \stall1_carry__3_n_4\,
      I5 => \stall1_carry__3_n_5\,
      O => stall_INST_0_i_4_n_0
    );
stall_INST_0_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \stall1_carry__1_n_5\,
      I1 => \stall1_carry__1_n_4\,
      I2 => \stall1_carry__1_n_7\,
      I3 => \stall1_carry__1_n_6\,
      I4 => \stall1_carry__2_n_6\,
      I5 => \stall1_carry__2_n_7\,
      O => stall_INST_0_i_5_n_0
    );
stall_INST_0_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \stall1_carry__0_n_7\,
      I1 => \stall1_carry__0_n_6\,
      I2 => stall1_carry_n_5,
      I3 => stall1_carry_n_4,
      I4 => \stall1_carry__0_n_4\,
      I5 => \stall1_carry__0_n_5\,
      O => stall_INST_0_i_6_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Top_comparator_0_0 is
  port (
    clk : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    write_count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    read_count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    stall : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Top_comparator_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of Top_comparator_0_0 : entity is "Top_comparator_0_0,comparator,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of Top_comparator_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of Top_comparator_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of Top_comparator_0_0 : entity is "comparator,Vivado 2023.1";
end Top_comparator_0_0;

architecture STRUCTURE of Top_comparator_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.Top_comparator_0_0_comparator
     port map (
      read_count(31 downto 0) => read_count(31 downto 0),
      stall => stall,
      write_count(31 downto 0) => write_count(31 downto 0)
    );
end STRUCTURE;
