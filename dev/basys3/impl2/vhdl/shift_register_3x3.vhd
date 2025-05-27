------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : shift_register_3x3
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Sliding window generator for 3x3 convolution.
--                 Shifts pixel columns from three buffered rows,
--                 producing stable 3x3 pixel grids for filtering.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Includes flush/reset handling and a three-cycle delay
--                 to validate output. Feeds convolution kernel inputs.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_register_3x3 is
  port (
    clk          : in std_logic;
    rst          : in std_logic;
    flush        : in std_logic;
    window_valid : in std_logic;
    row0_in      : in std_logic_vector(3 downto 0);
    row1_in      : in std_logic_vector(3 downto 0);
    row2_in      : in std_logic_vector(3 downto 0);

    valid_out     : out std_logic;
    p00, p01, p02 : out std_logic_vector(3 downto 0);
    p10, p11, p12 : out std_logic_vector(3 downto 0);
    p20, p21, p22 : out std_logic_vector(3 downto 0)
  );
end entity;

architecture BHV of shift_register_3x3 is

  type shift_reg_t is array(0 to 2) of std_logic_vector(3 downto 0);

  signal row0_sr : shift_reg_t;
  signal row2_sr : shift_reg_t;
  signal row1_sr : shift_reg_t;

  signal valid_counter : unsigned(2 downto 0) := (others => '0');
  signal valid_out_r   : std_logic            := '0';

begin

  process (clk, rst)
  begin
    if (rst = '1') then
      row0_sr(2) <= (others => '0');
      row0_sr(1) <= (others => '0');
      row0_sr(0) <= (others => '0');

      row1_sr(2) <= (others => '0');
      row1_sr(1) <= (others => '0');
      row1_sr(0) <= (others => '0');

      row2_sr(2) <= (others => '0');
      row2_sr(1) <= (others => '0');
      row2_sr(0) <= (others => '0');

      valid_counter <= (others => '0');
      valid_out_r   <= '0';

    elsif rising_edge(clk) then

      if window_valid = '1' then
        if valid_counter < 3 then
          valid_counter <= valid_counter + 1;
        end if;

        row0_sr(2) <= row0_sr(1);
        row0_sr(1) <= row0_sr(0);
        row0_sr(0) <= row0_in;

        row1_sr(2) <= row1_sr(1);
        row1_sr(1) <= row1_sr(0);
        row1_sr(0) <= row1_in;

        row2_sr(2) <= row2_sr(1);
        row2_sr(1) <= row2_sr(0);
        row2_sr(0) <= row2_in;

      end if;

      if valid_counter = 3 then
        valid_out_r   <= '1';
        valid_counter <= valid_counter - 1;
      else
        valid_out_r <= '0';
      end if;

      if (flush = '1') then
        valid_counter <= (others => '0');
      end if;

    end if;
  end process;

  valid_out <= valid_out_r;

  p00 <= row0_sr(2);
  p01 <= row0_sr(1);
  p02 <= row0_sr(0);
  p10 <= row1_sr(2);
  p11 <= row1_sr(1);
  p12 <= row1_sr(0);
  p20 <= row2_sr(2);
  p21 <= row2_sr(1);
  p22 <= row2_sr(0);

end BHV;
