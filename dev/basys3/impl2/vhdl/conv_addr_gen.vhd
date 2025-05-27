------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 4/24/2025
-- Module Name   : conv_addr_gen
-- Project Name  : RTIPCV
-- Target Device : Any FPGA with VGA or memory-mapped pixel buffer
-- Tool Versions : Vivado 2024.1
-- Description   : Generates sequential memory addresses during active
--                 video periods for reading pixel data. Resets on each
--                 vertical sync pulse. Max address range = 640 × 480.
--
-- Revision      : v1.0
-- Revision Date : 4/24/2025
-- Author        : Zack Mendez
-- Comments      : Address rolls over every frame. Compatible with dual-
--                 port RAMs for frame buffer access. Output is 19 bits
--                 wide to cover 307200 pixels (640x480).
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.vga_pkg.all;

entity conv_addr_gen is
  port (
    clk     : in std_logic; -- Pixel clock
    rst     : in std_logic;
    en      : in std_logic;
    addr : out std_logic_vector (18 downto 0)
  );
end conv_addr_gen;

architecture BHV of conv_addr_gen is

  signal count : std_logic_vector(18 downto 0) := (others => '0');

begin

  addr <= count;

  process (clk, rst)
  begin
    if (rst = '1') then
      count <= (others => '0');

    elsif rising_edge(clk) then
      if (en = '1') then
        count <= std_logic_vector(unsigned(count) + 1);

      end if;

      if (unsigned(count) = to_unsigned((H_D_END - 2) * (V_D_END - 2), 19)) then
        count <= (others => '0');
      end if;

    end if;

  end process;

end BHV;
