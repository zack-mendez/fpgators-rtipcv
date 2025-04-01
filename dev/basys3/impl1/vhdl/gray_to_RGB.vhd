------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : gray_to_RGB
-- Project Name  : RTIPCV
-- Target Device : Any VGA/display-compatible FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Converts 4-bit grayscale intensity to VGA-style output.
--                 When draw_en is asserted, the grayscale value is broadcast
--                 equally across R, G, and B for display. When not enabled,
--                 all channels output black (0).
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Designed to support grayscale VGA output.
--                 Assumes downstream module expects 4-bit RGB inputs.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gray_to_RGB is
  port (
    data    : in std_logic_vector(3 downto 0);
    draw_en : in std_logic;
    R       : out std_logic_vector(3 downto 0);
    G       : out std_logic_vector(3 downto 0);
    B       : out std_logic_vector(3 downto 0)
  );
end gray_to_RGB;

architecture BHV of gray_to_RGB is

begin

  R <= data when (draw_en = '1') else (others => '0');
  G <= data when (draw_en = '1') else (others => '0');
  B <= data when (draw_en = '1') else (others => '0');

end BHV;
