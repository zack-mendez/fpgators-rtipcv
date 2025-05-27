------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : convolution_core
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Top-level 3x3 convolution system. Handles windowing,
--                 and kernel-based processing. Includes line buffer,
--                 3x3 shift register, and dynamic kernel selection.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Accepts streaming grayscale pixels and outputs filtered
--                 results based on the selected kernel (e.g., Sobel).
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.kernel_pkg.all;

entity convolution_core is
  generic (
    X_MAX : positive := 640;
    Y_MAX : positive := 480
  );
  port (
    clk        : in std_logic;
    rst        : in std_logic;
    kernel_sel : in std_logic;
    valid_in   : in std_logic;
    pixel_in   : in std_logic_vector(3 downto 0);

    valid_out : out std_logic_vector(0 downto 0);
    pixel_out : out std_logic_vector(3 downto 0)
  );
end entity;

architecture BHV of convolution_core is

  signal row0, row1, row2                       : std_logic_vector(3 downto 0);
  signal p00, p01, p02                          : std_logic_vector(3 downto 0);
  signal p10, p11, p12                          : std_logic_vector(3 downto 0);
  signal p20, p21, p22                          : std_logic_vector(3 downto 0);
  signal window_valid, sr_valid_out, conv_valid : std_logic;
  signal flush, shift_reset                     : std_logic;

  signal pixel_out_conv : std_logic_vector(3 downto 0);

begin

  U_LINE_BUFFER : entity work.line_buffer
    generic map(
      X_MAX => X_MAX,
      Y_MAX => Y_MAX
    )
    port map
    (
      clk      => clk,
      rst      => rst,
      valid_in => valid_in,
      pixel_in => pixel_in,

      flush        => flush,
      window_valid => window_valid,
      row0_out     => row0,
      row1_out     => row1,
      row2_out     => row2
    );

  U_SHIFT_REG : entity work.shift_register_3x3
    port map
    (
      clk          => clk,
      rst          => rst,
      flush        => flush,
      window_valid => window_valid,
      row0_in      => row0,
      row1_in      => row1,
      row2_in      => row2,

      valid_out => sr_valid_out,
      p00 => p00, p01 => p01, p02 => p02,
      p10 => p10, p11 => p11, p12 => p12,
      p20 => p20, p21 => p21, p22 => p22
    );

  U_CONV : entity work.convolution_3x3
    port map
    (
      window_valid => sr_valid_out,
      kernel_sel   => kernel_sel,

      p00 => p00, p01 => p01, p02 => p02,
      p10 => p10, p11 => p11, p12 => p12,
      p20 => p20, p21 => p21, p22 => p22,

      valid_out => conv_valid,
      conv_out  => pixel_out
    );

  valid_out(0) <= conv_valid;

end BHV;