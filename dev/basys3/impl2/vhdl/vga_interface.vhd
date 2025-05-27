------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : vga_interface
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA + VGA Output
-- Tool Versions : Vivado 2024.1
-- Description   : VGA display wrapper with pseudocolor mapping.
--                 Interfaces with framebuffer address generator,
--                 colorizer, and VGA sync signal generator.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Outputs RGB444 color from 4-bit grayscale using
--                 dynamic pseudocolor palette selection.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_interface is
  port (
    clk     : in std_logic;
    rst     : in std_logic;
    sel     : in std_logic_vector(1 downto 0);
    data_in : in std_logic_vector(3 downto 0);

    rd_addr : out std_logic_vector (18 downto 0);
    red     : out std_logic_vector(3 downto 0);
    green   : out std_logic_vector(3 downto 0);
    blue    : out std_logic_vector(3 downto 0);

    v_sync : out std_logic;
    h_sync : out std_logic
  );
end vga_interface;

architecture BHV of vga_interface is

  signal v_sync_net : std_logic;
  signal draw_en    : std_logic;
  signal pseudo_rgb : std_logic_vector(11 downto 0);

begin
  v_sync <= v_sync_net;

  U_ADDR_GEN : entity work.vga_addr_gen
    port map
    (
      clk    => clk,
      rst    => rst,
      en     => draw_en,
      v_sync => v_sync_net,
      addr   => rd_addr
    );

  U_VGA : entity work.VGA
    port map
    (
      clk     => clk,
      rst     => rst,
      h_sync  => h_sync,
      v_sync  => v_sync_net,
      draw_en => draw_en
    );

  U_PSEUDOCOLORIZER : entity work.pseudocolorizer
    port map
    (
      sel      => sel(1 downto 0),
      data_in  => data_in,
      data_out => pseudo_rgb
    );

  red   <= pseudo_rgb(11 downto 8);
  green <= pseudo_rgb(7 downto 4);
  blue  <= pseudo_rgb(3 downto 0);

end BHV;