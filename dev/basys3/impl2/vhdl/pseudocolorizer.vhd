------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 4/1/2025
-- Module Name   : pseudocolorizer
-- Project Name  : RTIPCV
-- Target Device : Any VGA/display-compatible FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Maps 4-bit grayscale input to RGB444 VGA output using
--                 selectable pseudocolor LUTs. Supports direct grayscale,
--                 rainbow, heatmap, and retro color modes.
--
-- Revision      : v1.0
-- Revision Date : 4/1/2025
-- Author        : Zack Mendez
-- Comments      : Modular pseudocolor core using LUTs from pseudocolor_pkg.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pseudocolor_pkg.all;

entity pseudocolorizer is
  port (
    sel      : in std_logic_vector(1 downto 0);
    data_in  : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(11 downto 0)
  );
end entity;

architecture BHV of pseudocolorizer is

begin
  process (data_in, sel)
  begin
    case sel is
      when "00" =>
        data_out <= data_in & data_in & data_in;
      when "01" =>
        data_out <= rainbow_lut(to_integer(unsigned(data_in)));
      when "10" =>
        data_out <= heatmap_lut(to_integer(unsigned(data_in)));
      when "11" =>
        data_out <= retro_lut(to_integer(unsigned(data_in)));
      when others =>
        data_out <= data_in;
    end case;

  end process;

end BHV;
