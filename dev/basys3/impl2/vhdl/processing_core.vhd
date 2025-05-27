------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : processing_core
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Image processing pipeline for grayscale video stream.
--                 Integrates convolution filtering, thresholding, and
--                 address generation for writing to framebuffer.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Uses dynamic kernel selection and rotary-controlled
--                 thresholding. Operates on OV7670 PCLK domain.
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processing_core is
  port (
    clk        : in std_logic;
    rst        : in std_logic;
    sel        : in std_logic;
    data_valid : in std_logic;
    data_in    : in std_logic_vector(3 downto 0);

    wr_en   : out std_logic_vector(0 downto 0);
    wr_addr : out std_logic_vector(18 downto 0);

    threshold : in std_logic_vector(3 downto 0);
    data_out  : out std_logic_vector(3 downto 0)

  );

end processing_core;

architecture BHV of processing_core is

  signal conv_out   : std_logic_vector(3 downto 0);
  signal conv_valid : std_logic_vector(0 downto 0);

begin

  wr_en <= conv_valid;

  U_CONVOLUTION_SOBEL : entity work.convolution_core
    generic map(
      X_MAX => 640,
      Y_MAX => 480
    )
    port map
    (
      clk        => clk,
      rst        => rst,
      kernel_sel => sel,
      valid_in   => data_valid,
      pixel_in   => data_in,

      valid_out => conv_valid,
      pixel_out => conv_out
    );

  U_THRESHOLDER : entity work.thresholder

    port map
    (
      en        => sel,
      pixel_in  => conv_out,
      threshold => threshold,
      pixel_out => data_out
    );

  U_CONV_ADDR_GEN : entity work.conv_addr_gen
    port map
    (
      clk  => clk,
      rst  => rst,
      en   => conv_valid(0),
      addr => wr_addr
    );

end BHV;