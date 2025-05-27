------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : ov7670_interface
-- Project Name  : RTIPCV
-- Target Device : OV7670 Camera + FPGA System
-- Tool Versions : Vivado 2024.1
-- Description   : Top-level wrapper module for OV7670 interface.
--                 Handles camera control, pixel capture, and grayscale
--                 conversion. Outputs VGA-ready 4-bit grayscale.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Integrates controller, capture logic, and RGB-to-gray
--                 converter. Directly maps XCLK from clk25.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ov7670_interface is
  port (

    -- controller signals
    clk50        : in std_logic;
    clk25        : in std_logic;
    reconfig_cam : in std_logic;
    done         : out std_logic;

    ov7670_xclk  : out std_logic;
    ov7670_sioc  : out std_logic;
    ov7670_siod  : inout std_logic;
    ov7670_reset : out std_logic;
    ov7670_pwdn  : out std_logic;

    -- capture signals
    rst_btn      : in std_logic;
    ov7670_pclk  : in std_logic;
    ov7670_vsync : in std_logic;
    ov7670_href  : in std_logic;
    ov7670_data  : in std_logic_vector(7 downto 0);

    reset_conv   : out std_logic;
    data_out     : out std_logic_vector(3 downto 0);
    pixels_valid : out std_logic
  );
end ov7670_interface;

architecture BHV of ov7670_interface is

  signal rgb_out : std_logic_vector(11 downto 0);

begin

  ov7670_xclk <= clk25;

  U_CAM_CTRL : entity work.ov7670_controller
    port map
    (
      clk      => clk50,
      rst      => reconfig_cam,
      done     => done,
      sioc     => ov7670_sioc,
      siod     => ov7670_siod,
      cam_rst  => ov7670_reset,
      cam_pwdn => ov7670_pwdn
    );

  U_CAM_CAPTURE : entity work.ov7670_pixel_capture
    port map
    (
      clk        => ov7670_pclk,
      rst        => rst_btn,
      v_sync     => ov7670_vsync,
      href       => ov7670_href,
      data_in    => ov7670_data,
      reset_conv => reset_conv,
      dout       => rgb_out,
      wr_en      => pixels_valid
    );

  U_RGB2GRAY : entity work.rgb_to_gray
    port map
    (
      data_in  => rgb_out,
      data_out => data_out
    );

end BHV;