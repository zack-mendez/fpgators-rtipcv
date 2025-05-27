------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : thresholder
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Applies thresholding to 4-bit grayscale pixel input.
--                 When enabled, passes pixel through if it meets or exceeds
--                 the threshold; otherwise outputs black.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Pass-through logic when disabled. Outputs original pixel
--                 or zero depending on threshold comparison.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity thresholder is
  port (
    en        : in std_logic;
    pixel_in  : in std_logic_vector(3 downto 0);
    threshold : in std_logic_vector(3 downto 0);
    pixel_out : out std_logic_vector(3 downto 0)
  );
end entity;

architecture BHV of thresholder is
begin

  process (pixel_in, threshold, en)
  begin
    if (en = '1') then
      if unsigned(pixel_in) >= unsigned(threshold) then
        pixel_out <= pixel_in; --"1111"
      else
        pixel_out <= "0000";
      end if;
    else
      pixel_out <= pixel_in;
    end if;
  end process;

end BHV;
