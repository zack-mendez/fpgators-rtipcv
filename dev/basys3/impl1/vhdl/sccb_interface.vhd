------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : sccb_interface
-- Project Name  : RTIPCV
-- Target Device : OV7670 Camera Module
-- Tool Versions : Vivado 2024.1
-- Description   : Bit-banged SCCB (I2C-compatible) interface that builds
--                 and sends 32-bit command packets to configure the OV7670.
--                 Takes 16-bit input (register address & data), and transmits
--                 it as a full SCCB write operation with appropriate timing.
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Assumes 100 kHz SCCB interface speed using clock divider.
--                 Uses state-based transmission with tristate handling for SIOD.
--
-- References    : https://www.fpga4student.com/
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ov7670_addr_pkg.all;

entity sccb_interface is
  port (
    clk  : in std_logic;
    en   : in std_logic;
    d_in : in std_logic_vector (15 downto 0); -- MSB = reg addr, LSB = data

    sioc   : out std_logic; -- SCCB clock
    siod   : inout std_logic; -- SCCB data (bidirectional)
    reg_en : out std_logic -- High when new register transaction is ready
  );
end sccb_interface;

architecture BHV of sccb_interface is

  signal dc          : std_logic;
  signal trans_start : std_logic_vector(2 downto 0);
  signal ip_addr     : std_logic_vector(7 downto 0);
  signal sub_addr    : std_logic_vector(7 downto 0);
  signal data        : std_logic_vector(7 downto 0);
  signal trans_end   : std_logic_vector(1 downto 0);

  signal div : unsigned (7 downto 0) := "00000001";

  signal dummy_sr : std_logic_vector(31 downto 0) := (others => '0');
  signal data_sr  : std_logic_vector(31 downto 0) := (others => '1');

begin

  ---------------------------------------------------- packet signals

  dc          <= '0'; 
  trans_start <= "100";

  ip_addr  <= OV7670_I2C_WRITE_ADDR;
  sub_addr <= d_in(15 downto 8);
  data     <= d_in(7 downto 0);

  trans_end <= "01";

  -----------------------------------------------------

  process (dummy_sr, data_sr(31))
  begin
    if dummy_sr(11 downto 10) = "10" or
      dummy_sr(20 downto 19) = "10" or
      dummy_sr(29 downto 28) = "10" then
      siod <= 'Z';

    else
      siod <= data_sr(31);
    end if;
  end process;

  process (clk)
  begin
    if rising_edge(clk) then
      reg_en <= '0';

      if dummy_sr(31) = '0' then
        sioc <= '1';

        if en = '1' then
          if (div = "00000000") then
            data_sr  <= trans_start & ip_addr & dc & sub_addr & dc & data & dc & trans_end; -- build packet
            dummy_sr <= "111" & "111111111" & "111111111" & "111111111" & "11";
            reg_en   <= '1';

          else
            div <= div + 1;

          end if;

        end if;

      else

        -- CLOCK TOGGLING

        case dummy_sr(32 - 1 downto 32 - 3) & dummy_sr(2 downto 0) is

          -- Start bit phase
          when "111" & "111" => sioc <= '1';
          when "111" & "110" => sioc <= '1';
          when "111" & "100" => sioc <= '0'; -- Drive clock low to start

          -- Address + data bit transmissio
          when "110" & "000" => -- 1100 0000 0000 0000 0000 0000 0000 0000
            case div(7 downto 6) is
              when "00"   => sioc   <= '0';
              when "01"   => sioc   <= '1';
              when "10"   => sioc   <= '1';
              when others => sioc <= '1';
            end case;

          -- Final stop bit  
          when "100" & "000" => sioc <= '1'; -- 1000 0000 0000 0000 0000 0000 0000 0000

          -- Bus idle (end of packet)
          when "000" & "000" => sioc <= '1';

          -- Default bit toggling logic
          when others =>
            case div(7 downto 6) is
              when "00"   => sioc   <= '0';
              when "01"   => sioc   <= '1';
              when "10"   => sioc   <= '1';
              when "11"   => sioc   <= '0';
              when others => sioc <= '0';

            end case;
        end case;

        -- Shift registers and timing divider
        if div = "11111111" then
          dummy_sr <= dummy_sr(30 downto 0) & '0';
          data_sr  <= data_sr(30 downto 0) & '0';
          div      <= (others => '0');

        else
          div <= div + 1;

        end if;

      end if;

    end if;

  end process;

end BHV;
