------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : convolution_3x3
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Performs 3x3 convolution with support for multiple
--                 kernel modes (DEBUG, SOBEL_X, SOBEL_Y). Computes
--                 absolute sum of weighted window and clips result
--                 to 4-bit grayscale output.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Output is OR'd combination of SOBEL_X and SOBEL_Y
--                 when `kernel_sel` is high; otherwise uses DEBUG kernel.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.kernel_pkg.all;

entity convolution_3x3 is
  port (
    window_valid : in std_logic;
    kernel_sel   : in std_logic;

    p00, p01, p02 : in std_logic_vector(3 downto 0);
    p10, p11, p12 : in std_logic_vector(3 downto 0);
    p20, p21, p22 : in std_logic_vector(3 downto 0);

    valid_out : out std_logic;
    conv_out  : out std_logic_vector(3 downto 0)
  );
end entity;

architecture BHV of convolution_3x3 is

  signal conv_debug_acc  : signed(15 downto 0);
  signal conv_sobelx_acc : signed(15 downto 0);
  signal conv_sobely_acc : signed(15 downto 0);

  signal conv_debug_abs  : signed(15 downto 0);
  signal conv_sobelx_abs : signed(15 downto 0);
  signal conv_sobely_abs : signed(15 downto 0);

  signal clipped_debug  : std_logic_vector(3 downto 0);
  signal clipped_sobelx : std_logic_vector(3 downto 0);
  signal clipped_sobely : std_logic_vector(3 downto 0);

begin

  conv_debug_acc <=
    signed(resize(unsigned(p00), 8)) * to_signed(DEBUG(0, 0), 8) +
    signed(resize(unsigned(p01), 8)) * to_signed(DEBUG(0, 1), 8) +
    signed(resize(unsigned(p02), 8)) * to_signed(DEBUG(0, 2), 8) +
    signed(resize(unsigned(p10), 8)) * to_signed(DEBUG(1, 0), 8) +
    signed(resize(unsigned(p11), 8)) * to_signed(DEBUG(1, 1), 8) +
    signed(resize(unsigned(p12), 8)) * to_signed(DEBUG(1, 2), 8) +
    signed(resize(unsigned(p20), 8)) * to_signed(DEBUG(2, 0), 8) +
    signed(resize(unsigned(p21), 8)) * to_signed(DEBUG(2, 1), 8) +
    signed(resize(unsigned(p22), 8)) * to_signed(DEBUG(2, 2), 8);

  conv_sobelx_acc <=
    signed(resize(unsigned(p00), 8)) * to_signed(SOBEL_X(0, 0), 8) +
    signed(resize(unsigned(p01), 8)) * to_signed(SOBEL_X(0, 1), 8) +
    signed(resize(unsigned(p02), 8)) * to_signed(SOBEL_X(0, 2), 8) +
    signed(resize(unsigned(p10), 8)) * to_signed(SOBEL_X(1, 0), 8) +
    signed(resize(unsigned(p11), 8)) * to_signed(SOBEL_X(1, 1), 8) +
    signed(resize(unsigned(p12), 8)) * to_signed(SOBEL_X(1, 2), 8) +
    signed(resize(unsigned(p20), 8)) * to_signed(SOBEL_X(2, 0), 8) +
    signed(resize(unsigned(p21), 8)) * to_signed(SOBEL_X(2, 1), 8) +
    signed(resize(unsigned(p22), 8)) * to_signed(SOBEL_X(2, 2), 8);

  conv_sobely_acc <=
    signed(resize(unsigned(p00), 8)) * to_signed(SOBEL_Y(0, 0), 8) +
    signed(resize(unsigned(p01), 8)) * to_signed(SOBEL_Y(0, 1), 8) +
    signed(resize(unsigned(p02), 8)) * to_signed(SOBEL_Y(0, 2), 8) +
    signed(resize(unsigned(p10), 8)) * to_signed(SOBEL_Y(1, 0), 8) +
    signed(resize(unsigned(p11), 8)) * to_signed(SOBEL_Y(1, 1), 8) +
    signed(resize(unsigned(p12), 8)) * to_signed(SOBEL_Y(1, 2), 8) +
    signed(resize(unsigned(p20), 8)) * to_signed(SOBEL_Y(2, 0), 8) +
    signed(resize(unsigned(p21), 8)) * to_signed(SOBEL_Y(2, 1), 8) +
    signed(resize(unsigned(p22), 8)) * to_signed(SOBEL_Y(2, 2), 8);

  conv_debug_abs  <= abs(conv_debug_acc);
  conv_sobelx_abs <= abs(conv_sobelx_acc);
  conv_sobely_abs <= abs(conv_sobely_acc);

  clipped_debug <= "1111" when conv_debug_abs > 15 else
    std_logic_vector(conv_debug_abs(3 downto 0));
  clipped_sobelx <= "1111" when conv_sobelx_abs > 15 else
    std_logic_vector(conv_sobelx_abs(3 downto 0));
  clipped_sobely <= "1111" when conv_sobely_abs > 15 else
    std_logic_vector(conv_sobely_abs(3 downto 0));

  process (kernel_sel, clipped_debug, clipped_sobelx, clipped_sobely)
  begin
    if kernel_sel = '0' then
      conv_out <= clipped_debug;
    else
      conv_out <= clipped_sobelx or clipped_sobely;
    end if;
  end process;

  valid_out <= window_valid;

end architecture BHV;
