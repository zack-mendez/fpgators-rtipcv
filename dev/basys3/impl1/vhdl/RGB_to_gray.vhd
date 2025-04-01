------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : RGB_to_gray
-- Project Name  : RTIPCV
-- Target Device : Any FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Converts 12-bit RGB444 input to 4-bit grayscale output
--                 using luminance weights approximated in fixed-point.
--                 The formula applied is:
--                 Gray ≈ 0.299*R + 0.587*G + 0.114*B
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Weights are implemented using unsigned 8-bit constants:
--                 a0 = 0.299 * 256 ≈ 77   (01001101)
--                 a1 = 0.587 * 256 ≈ 150  (10010110)
--                 a2 = 0.114 * 256 ≈ 29   (00011101)
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RGB_to_gray is
  port (
    data_in  : in std_logic_vector(11 downto 0); -- RGB444 input: R[11:8], G[7:4], B[3:0]
    data_out : out std_logic_vector(3 downto 0)
  );
end RGB_to_gray;

architecture BHV of RGB_to_gray is

  signal red   : unsigned(3 downto 0);
  signal green : unsigned(3 downto 0);
  signal blue  : unsigned(3 downto 0);

  signal temp : unsigned(11 downto 0);

  constant a0 : unsigned(7 downto 0) := "01001101";
  constant a1 : unsigned(7 downto 0) := "10010110";
  constant a2 : unsigned(7 downto 0) := "00011101";

begin

  red   <= unsigned(data_in(11 downto 8));
  green <= unsigned(data_in(7 downto 4));
  blue  <= unsigned(data_in(3 downto 0));

  temp <= (a0 * red) + (a1 * green) + (a2 * blue);

  data_out <= std_logic_vector(temp(11 downto 8));

end BHV;