------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 4/26/2025
-- Module Name   : top_level
-- Project Name  : RTIPCV
-- Target Device : Artix-7 / Basys3 / FPGA with OV7670 + VGA
-- Tool Versions : Vivado 2024.1
-- Description   : Top-level design for capturing video from the OV7670
--                 camera, converting it to grayscale, applying optional
--                 pseudocolor transformations, and displaying the result
--                 on a VGA monitor. Includes manual register override,
--                 framebuffer decoupling, and dynamic color mode cycling.
--
-- Inputs:
--   clk100         - 100 MHz input clock
--   btnu           - Global reset
--   btnc
--   sw             - User configuration switches
--   ov7670_*       - Camera I/O signals
--
-- Outputs:
--   h_sync, v_sync - VGA sync signals
--   red, green, 
--   blue           - RGB444 VGA output
--   config_done    - High when camera configuration is complete
--
-- Revision      : v2.0
-- Revision Date : 4/26/2025
-- Author        : Zack Mendez
-- Comments      : Now includes pseudocolorizer core with 4 selectable
--                 LUT modes (gray, rainbow, heatmap, retro), toggled
--                 via the user button.
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
  port (
    clk100 : in std_logic;
    btnu   : in std_logic;
    btnc   : in std_logic;
    sw     : in std_logic_vector(15 downto 0);

    -- encoder signals
    enc_A   : in std_logic;
    enc_B   : in std_logic;
    enc_btn : in std_logic;
    enc_swt : in std_logic;

    -- vga port signals
    h_sync : out std_logic;
    v_sync : out std_logic;
    red    : out std_logic_vector(3 downto 0);
    green  : out std_logic_vector(3 downto 0);
    blue   : out std_logic_vector(3 downto 0);

    -- camera signals
    ov7670_pclk  : in std_logic;
    ov7670_xclk  : out std_logic;
    ov7670_vsync : in std_logic;
    ov7670_href  : in std_logic;
    ov7670_data  : in std_logic_vector(7 downto 0);
    ov7670_sioc  : out std_logic;
    ov7670_siod  : inout std_logic;
    ov7670_pwdn  : out std_logic;
    ov7670_reset : out std_logic;

    -- led
    done : out std_logic
  );

end top_level;

architecture BHV of top_level is

  component frame_buffer_1
    port (
      clka  : in std_logic;
      wea   : in std_logic_vector(0 downto 0);
      addra : in std_logic_vector(18 downto 0);
      dina  : in std_logic_vector(3 downto 0);
      clkb  : in std_logic;
      addrb : in std_logic_vector(18 downto 0);
      doutb : out std_logic_vector(3 downto 0)
    );
  end component;

  signal clk50 : std_logic;
  signal clk25 : std_logic;
  signal wren  : std_logic_vector(0 downto 0);

  signal buf_wr_addr : std_logic_vector(18 downto 0);
  signal buf_in      : std_logic_vector(3 downto 0);

  signal buf_rd_addr : std_logic_vector(18 downto 0);
  signal buf_out     : std_logic_vector(3 downto 0);

  signal rst_btn    : std_logic;
  signal resend_btn : std_logic;

  signal pixels_valid : std_logic;

  signal threshold  : std_logic_vector(3 downto 0);
  signal thresh_out : std_logic_vector(3 downto 0);

  signal conv_rst : std_logic;

begin

  U_IO_INTERFACE : entity work.io_interface
    port map
    (
      clk100 => clk100,
      clk50  => clk50,
      clk25  => clk25,

      rst     => btnu,
      btnc    => btnc,
      enc_A   => enc_A,
      enc_B   => enc_B,
      enc_btn => enc_btn,

      rst_btn    => rst_btn,
      resend_btn => resend_btn,

      threshold => threshold

    );

  U_OV7670_INTERFACE : entity work.ov7670_interface
    port map
    (
      clk50        => clk50,
      clk25        => clk25,
      reconfig_cam => resend_btn,
      done         => done,

      ov7670_xclk  => ov7670_xclk,
      ov7670_sioc  => ov7670_sioc,
      ov7670_siod  => ov7670_siod,
      ov7670_reset => ov7670_reset,
      ov7670_pwdn  => ov7670_pwdn,

      rst_btn      => rst_btn,
      ov7670_pclk  => ov7670_pclk,
      ov7670_vsync => ov7670_vsync,
      ov7670_href  => ov7670_href,
      ov7670_data  => ov7670_data,

      reset_conv   => conv_rst,
      data_out     => buf_in,
      pixels_valid => pixels_valid
    );

  U_FRAME_BUFFER_1 : frame_buffer_1
  port map
  (
    addrb => buf_rd_addr,
    clkb  => clk25,
    doutb => buf_out,

    clka  => ov7670_pclk,
    addra => buf_wr_addr,
    dina  => thresh_out,
    wea   => wren
  );

  U_PROCESSING_CORE : entity work.processing_core
    port map
    (
      clk        => ov7670_pclk,
      rst        => conv_rst,
      sel        => enc_swt,
      data_valid => pixels_valid,
      data_in    => buf_in,

      wr_en   => wren,
      wr_addr => buf_wr_addr,

      threshold => threshold,
      data_out  => thresh_out

    );

  U_VGA_INTERFACE : entity work.vga_interface
    port map
    (
      clk     => clk25,
      rst     => rst_btn,
      sel     => sw(1 downto 0),
      data_in => buf_out,

      rd_addr => buf_rd_addr,
      red     => red,
      green   => green,
      blue    => blue,

      v_sync => v_sync,
      h_sync => h_sync
    );

end BHV;
