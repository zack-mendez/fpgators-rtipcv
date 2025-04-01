------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : VGA
-- Project Name  : RTIPCV
-- Target Device : Any FPGA with VGA output
-- Tool Versions : Vivado 2024.1
-- Description   : VGA sync signal generator for 640x480 @ 60Hz.
--                 Drives h_sync, v_sync, and draw_en signals based
--                 on horizontal and vertical counters.
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Uses parameters from VGA_PKG.
--                 draw_en is high only during active video region.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.vga_pkg.all;

entity VGA is
  port (
    clk     : in std_logic; -- Pixel clock (25 MHz)
    rst     : in std_logic;
    h_sync  : out std_logic;
    v_sync  : out std_logic;
    draw_en : out std_logic
  );
end VGA;

architecture BHV of VGA is

  signal h_count : unsigned(9 downto 0) := (others => '0');
  signal v_count : unsigned(9 downto 0) := "1000001000"; -- preload to simulate vertical blank

begin

  ----------------------------------------------------------------
  -- H/V Counter and Draw Enable Logic
  ----------------------------------------------------------------

  process (clk, rst)
  begin
    if (rst = '1') then

      h_count <= (others => '0');
      v_count <= (others => '0');
      draw_en <= '0';

    elsif (rising_edge(clk)) then
      if (h_count = H_MAX) then
        h_count <= (others => '0');

        if (v_count = V_MAX) then
          v_count <= (others => '0');
          draw_en <= '1';

        else
          if (v_count < V_D_END - 1) then
            draw_en <= '1';
          end if;

          v_count <= v_count + 1;

        end if;

      else
        if (h_count = H_D_END - 1) then
          draw_en <= '0';
        end if;

        h_count <= h_count + 1;

      end if;
    end if;
  end process;

  ----------------------------------------------------------------
  -- Horizontal Sync Pulse Generator
  ----------------------------------------------------------------

  process (clk, rst)
  begin
    if (rst = '1') then
      h_sync <= '0';
    elsif (rising_edge(clk)) then
      if (h_count > (H_D_END + H_FP + 3) and h_count < (H_D_END + H_FP + H_T + 3)) then --- h_count >= 656 and h_count <= 751
        h_sync <= '0';
      else
        h_sync <= '1';
      end if;
    end if;
  end process;

  ----------------------------------------------------------------
  -- Vertical Sync Pulse Generator
  ----------------------------------------------------------------

  process (clk, rst)
  begin
    if (rst = '1') then
      v_sync <= '0';
    elsif (rising_edge(clk)) then
      if (v_count > (V_D_END + V_FP + 1) and v_count < (V_D_END + V_FP + V_T + 2)) then ---v_count >= 490 and v_count<= 491
        v_sync <= '0';
      else
        v_sync <= '1';
      end if;
    end if;
  end process;

end BHV;
