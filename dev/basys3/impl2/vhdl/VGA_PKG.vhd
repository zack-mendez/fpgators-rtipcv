------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : VGA_PKG
-- Project Name  : RTIPCV
-- Target Device : Any FPGA with VGA output
-- Tool Versions : Vivado 2024.1
-- Description   : Defines horizontal and vertical timing parameters for
--                 640x480 @ 60Hz VGA output. Includes display window,
--                 front/back porch, sync pulse widths, and full scan range.
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Timings are based on standard 25.175 MHz VGA pixel clock.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package VGA_PKG is

  constant H_MAX   : integer := 799;
  constant H_D_END : integer := 640;
  constant H_FP    : integer := 16;
  constant H_BP    : integer := 48;
  constant H_T     : integer := 96;

  constant V_MAX   : integer := 524;
  constant V_D_END : integer := 480;
  constant V_FP    : integer := 10;
  constant V_BP    : integer := 33;
  constant V_T     : integer := 2;
  
end VGA_PKG;