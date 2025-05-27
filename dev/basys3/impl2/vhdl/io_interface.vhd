------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : io_interface
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : I/O wrapper module for rotary encoder, clocking, and
--                 debounce logic. Instantiates PLL, debouncer, and
--                 rotary counter to provide stable threshold control
--                 from physical inputs.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Encapsulates control logic for IO.
------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity io_interface is
  port (
    clk100 : in std_logic;
    clk50  : out std_logic;
    clk25  : out std_logic;

    rst     : in std_logic;
    btnc    : in std_logic;
    enc_A   : in std_logic;
    enc_b   : in std_logic;
    enc_btn : in std_logic;

    rst_btn    : out std_logic;
    resend_btn : out std_logic;

    threshold : out std_logic_vector(3 downto 0)

  );
end io_interface;

architecture BHV of io_interface is

  component clk_wiz_0
    port (
      clk_out1 : out std_logic;
      clk_out2 : out std_logic;
      clk_in1  : in std_logic
    );
  end component;

  signal btn_in_bus  : std_logic_vector(4 downto 0);
  signal btn_out_bus : std_logic_vector(4 downto 0);

  signal clk25_temp : std_logic;

  signal enc_rst : std_logic;
  signal A_true  : std_logic;
  signal B_true  : std_logic;

begin

  clk25 <= clk25_temp;

  btn_in_bus <= enc_btn & not enc_B & not enc_A & btnc & rst;

  rst_btn    <= btn_out_bus(0);
  resend_btn <= btn_out_bus(1);
  A_true     <= btn_out_bus(2);
  B_true     <= btn_out_bus(3);
  enc_rst    <= btn_out_bus(4);

  U_PLL : clk_wiz_0
  port map
  (
    clk_out1 => clk50,
    clk_out2 => clk25_temp,
    clk_in1  => clk100
  );

  U_DEBOUNCER : entity work.debouncer
    generic map(
      DEBNC_CLOCKS => 2 ** 18,
      PORT_WIDTH   => 5
    )
    port map
    (
      SIGNAL_I => btn_in_bus,
      CLK_I    => clk25_temp,
      SIGNAL_O => btn_out_bus
    );

  U_ROTARY_COUNTER : entity work.rotary_counter
    port map
    (
      clk       => clk25_temp,
      rst       => enc_rst,
      A         => A_true,
      B         => B_true,
      threshold => threshold
    );

end BHV;