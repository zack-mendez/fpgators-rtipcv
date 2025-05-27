------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 4/1/2025
-- Module Name   : counter
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : 2-bit up-counter with synchronous enable and async reset.
--
-- Revision      : v1.0
-- Revision Date : 4/1/2025
-- Author        : Zack Mendez
-- Comments      : Used for LUT selection
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  port (
    clk : in std_logic;
    rst : in std_logic;
    en  : in std_logic;

    count_out : out std_logic_vector(1 downto 0)
  );
end entity;

architecture BHV of counter is

  signal count_r : std_logic_vector(1 downto 0) := (others => '0');

begin

  count_out <= count_r;

  process (clk, rst)
  begin
    if (rst = '1') then
      count_r <= (others => '0');

    elsif rising_edge(clk) then
      if (en = '1') then
        count_r <= std_logic_vector(unsigned(count_r) + 1);

      end if;

    end if;

  end process;

end BHV;
