------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : ov7670_pixel_capture
-- Project Name  : RTIPCV
-- Target Device : OV7670 Camera + FPGA with RAM framebuffer
-- Tool Versions : Vivado 2024.1
-- Description   : Captures pixel data from the OV7670 camera and stores it
--                 into a frame buffer. Uses HREF to sync horizontal data and
--                 VSYNC to reset frame capture. Outputs a 12-bit RGB444 value.
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Supports RGB444 format with flexible testing for R, G, B.
--                 Handles byte pair buffering with HREF and sync resets.
--
-- References    : https://www.fpga4student.com/
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ov7670_pixel_capture is
  port (
    clk     : in std_logic; -- Pixel clock from camera (PCLK)
    rst     : in std_logic;
    v_sync  : in std_logic;
    href    : in std_logic;
    data_in : in std_logic_vector (7 downto 0);

    addr : out std_logic_vector (18 downto 0);
    dout : out std_logic_vector (11 downto 0);
    we   : out std_logic);
end ov7670_pixel_capture;

architecture BHV of ov7670_pixel_capture is
  signal data_r : std_logic_vector(15 downto 0) := (others => '0');
  signal addr_r : std_logic_vector(18 downto 0) := (others => '0');
  signal we_r   : std_logic                     := '0';

  signal byte_r       : std_logic_vector (7 downto 0) := (others => '0');
  signal href_r       : std_logic                     := '0';
  signal href_valid_r : std_logic                     := '0';

  signal v_sync_r : std_logic := '0';

begin

  -- Output RGB format (default: RGB444)
  -- Alternative debug/test formats are preserved below

  --dout <= data_r(15 downto 12) & data_r(10 downto 7) & data_r(4 downto 1); -- normal RGB565
  dout <= data_r(11 downto 8) & data_r(7 downto 4) & data_r(3 downto 0); -- normal RGB444
  --dout <= "1111" & data_r(8 downto 5) & data_r(3 downto 0); -- red test
  --dout <= data_r(14 downto 11) & "1111" & data_r(3 downto 0); -- green test
  --dout <= data_r(14 downto 11) & data_r(8 downto 5) & "1111"; -- blue test

  addr <= addr_r;
  we   <= we_r;

  process (clk, rst)
  begin
    if (rst = '1') then
      byte_r   <= (others => '0');
      href_r   <= '0';
      v_sync_r <= '0';

      data_r <= (others => '0');
      addr_r <= (others => '0');
      we_r   <= '0';

    elsif rising_edge(clk) then

      byte_r   <= data_in;
      href_r   <= href;
      v_sync_r <= v_sync;

      we_r <= '0';

      if we_r = '1' then
        addr_r <= std_logic_vector(unsigned(addr_r) + 1);

      end if;

      -- Concatenate bytes on HREF (2 bytes per pixel)
      if href_r = '1' then
        data_r <= data_r(7 downto 0) & byte_r;

      end if;

      if v_sync_r = '1' then
        addr_r       <= (others => '0');
        href_valid_r <= '0';

      else
        if (href_valid_r = '1') then
          we_r         <= '1'; -- Set we high when data_r is filled with 16-bit value
          href_valid_r <= '0';

        else
          href_valid_r <= '1' and href_r; -- Set hold flag on first byte

        end if;

      end if;

    end if;

  end process;
end BHV;
