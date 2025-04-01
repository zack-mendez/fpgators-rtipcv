------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : ov7670_config_pkg
-- Project Name  : RTIPCV
-- Target Device : OV7670 Camera Module
-- Tool Versions : Vivado 2024.1
-- Description   : Predefined configuration constants for initializing the
--                OV7670 camera via SCCB/I2C. Each constant represents a
--                16-bit value composed of an 8-bit register address and
--                an 8-bit configuration value.
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Initial release. Sets RGB444 output, full-range RGB,
--                vertical and horizontal windowing, mirror/flip, and
--                enables AGC, AEC, AWB with histogram-based control.
------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

use work.ov7670_addr_pkg.all;

package ov7670_config_pkg is

  constant RESET   : std_logic_vector(15 downto 0) := COM7_addr & x"80"; -- Soft reset the camera
  constant COM7    : std_logic_vector(15 downto 0) := COM7_addr & x"04"; -- Set RGB output format and enable scaling
  constant CLKRC   : std_logic_vector(15 downto 0) := CLKRC_addr & x"00"; -- Run internal clock at full input clock speed (no prescaling)
  constant COM15   : std_logic_vector(15 downto 0) := COM15_addr & x"D0"; -- Output full RGB range (0–255) with RGB444 mode enabled
  constant RGB444  : std_logic_vector(15 downto 0) := RGB444_addr & x"02"; -- Enable RGB444 output with RG Bx format
  constant COM13   : std_logic_vector(15 downto 0) := COM13_addr & x"C0"; -- Enable gamma correction and automatic UV saturation adjustment
  constant COM3    : std_logic_vector(15 downto 0) := COM3_addr & x"00"; -- No downsampling/scaling, leave default, but adjustable.
  constant TSLB    : std_logic_vector(15 downto 0) := TSLB_addr & x"0D"; -- Enable negative image mode (for fun/testing)
  constant COM9    : std_logic_vector(15 downto 0) := COM9_addr & x"40";  -- Set AGC gain ceiling to 32x

  constant HSTART  : std_logic_vector(15 downto 0) := HSTART_addr & x"11"; -- Set horizontal image window start position
  constant HSTOP   : std_logic_vector(15 downto 0) := HSTOP_addr & x"61"; -- Set horizontal image window stop position
  constant HREF    : std_logic_vector(15 downto 0) := HREF_addr & x"3F"; -- Adjust low bits of HSTART/HSTOP and pixel alignment

  constant VSTRT   : std_logic_vector(15 downto 0) := VSTRT_addr & x"03"; -- Set vertical image window start position
  constant VSTOP   : std_logic_vector(15 downto 0) := VSTOP_addr & x"7B"; -- Set vertical image window stop position
  constant VREF    : std_logic_vector(15 downto 0) := VREF_addr & x"0A"; -- Set low bits of vertical start/stop for fine control

  constant MVFP    : std_logic_vector(15 downto 0) := MVFP_addr & x"34"; -- Flip image vertically and mirror it horizontally

  constant REG74   : std_logic_vector(15 downto 0) := REG74_addr & x"10"; -- Set digital gain manually to 1x (no extra gain)
  constant THL_ST  : std_logic_vector(15 downto 0) := THL_ST_addr & x"04"; -- Set target brightness for black level calibration
  constant THL_DLT : std_logic_vector(15 downto 0) := THL_DLT_addr & x"82"; -- Define brightness range allowed for black level calibration
  constant COM8    : std_logic_vector(15 downto 0) := COM8_addr & x"87"; -- Enable auto gain, auto exposure, and auto white balance
  constant AECH    : std_logic_vector(15 downto 0) := AECH_addr & x"00"; -- Set exposure value low (will be overridden by AEC)
  constant HAECC7  : std_logic_vector(15 downto 0) := HAECC7_addr & x"80"; -- Use histogram-based AEC algorithm for better lighting adjustment

end ov7670_config_pkg;
