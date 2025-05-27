------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : ov7670_controller
-- Project Name  : RTIPCV
-- Target Device : OV7670 Camera Module
-- Tool Versions : Vivado 2024.1
-- Description   : Top-level controller for initializing the OV7670 camera.
--                 Connects the register configuration sequencer to the SCCB
--                 transmission logic, and manages the reset and power-down
--                 signals for the camera.
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Automatically begins initialization on power-up.
--                 Exposes `done` when all config writes are completed.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ov7670_controller is
  port (
    clk  : in std_logic;
    rst  : in std_logic;
    done : out std_logic;

    sioc     : out std_logic;
    siod     : inout std_logic;
    cam_rst  : out std_logic;
    cam_pwdn : out std_logic
  );
end ov7670_controller;

architecture BHV of ov7670_controller is
  signal data   : std_logic_vector(15 downto 0);
  signal done_s : std_logic;
  signal reg_en : std_logic;
  signal send   : std_logic;

begin

  done <= done_s;
  send <= not(done_s);

  cam_rst  <= '1';
  cam_pwdn <= '0';

  U_SCCB_TX : entity work.sccb_interface
    port map
    (
      clk    => clk,
      en     => send,
      d_in   => data,
      sioc   => sioc,
      siod   => siod,
      reg_en => reg_en
    );

  U_CAM_INIT_CTRL : entity work.ov7670_init_ctrl
    port map
    (
      clk   => clk,
      rst   => rst,
      en    => reg_en,
      d_out => data,
      done  => done_s
    );

end BHV;
