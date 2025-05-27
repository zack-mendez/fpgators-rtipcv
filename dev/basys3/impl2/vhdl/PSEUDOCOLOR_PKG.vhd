------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 4/1/2025
-- Package Name  : pseudocolor_pkg
-- Project Name  : RTIPCV
-- Target Device : Any VGA/display-compatible FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Contains RGB444 pseudocolor lookup tables for visualizing
--                 4-bit grayscale values. Includes multiple visual styles
--                 such as rainbow, heatmap, and retro color schemes.
--
-- Revision      : v1.0
-- Revision Date : 4/1/2025
-- Author        : Zack Mendez
-- Comments      : All color maps output 12-bit RGB (4 bits per channel),
--                 suitable for use with VGA DAC or display drivers.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package pseudocolor_pkg is
  type color_t is array (0 to 15) of std_logic_vector(11 downto 0);

  constant rainbow_lut : color_t := (
    0  => x"008", 1  => x"00C", 2  => x"00F", 3  => x"04F",
    4  => x"08F", 5  => x"0CF", 6  => x"0FF", 7  => x"0F8",
    8  => x"0F4", 9  => x"0F0", 10 => x"8F0", 11 => x"CC0",
    12 => x"F80", 13 => x"F40", 14 => x"F00", 15 => x"800"
  );

  constant heatmap_lut : color_t := (
    0  => x"000", 1  => x"400", 2  => x"600", 3  => x"800",
    4  => x"A20", 5  => x"C40", 6  => x"E60", 7  => x"F80",
    8  => x"FA0", 9  => x"FC0", 10 => x"FE0", 11 => x"FF4",
    12 => x"FF8", 13 => x"FFC", 14 => x"FFE", 15 => x"CFF"
  );

  constant fog_lut : color_t := (
    0  => x"204", 1  => x"315", 2  => x"426", 3  => x"537",
    4  => x"648", 5  => x"759", 6  => x"86A", 7  => x"97B",
    8  => x"A8C", 9  => x"B9D", 10 => x"CAD", 11 => x"DBF",
    12 => x"EDF", 13 => x"FEF", 14 => x"FFF", 15 => x"FFF"
  );

  constant retro_lut : color_t := (
    0  => x"000", 1  => x"400", 2  => x"800", 3  => x"C00",
    4  => x"F00", 5  => x"040", 6  => x"080", 7  => x"0C0",
    8  => x"0F0", 9  => x"004", 10 => x"008", 11 => x"00C",
    12 => x"00F", 13 => x"0FF", 14 => x"F0F", 15 => x"FFF"
  );

end package;
