------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : ov7670_init_ctrl
-- Project Name  : RTIPCV
-- Target Device : OV7670 Camera Module
-- Tool Versions : Vivado 2024.1
-- Description   : Sequentially outputs configuration data to program the
--                 OV7670 camera over SCCB/I2C. Pulls from ov7670_config_pkg.
--
-- Revision      : v1.1
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Removed run-time configurability via `config` pin.
--                 Now outputs fixed sequence only from the config package.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ov7670_config_pkg.all;

entity ov7670_init_ctrl is
  port (
    clk : in std_logic;
    rst : in std_logic;
    en  : in std_logic;

    d_out : out std_logic_vector(15 downto 0);
    done  : out std_logic
  );
end ov7670_init_ctrl;

architecture BHV of ov7670_init_ctrl is
  signal out_r  : std_logic_vector(15 downto 0);
  signal addr_r : std_logic_vector(7 downto 0) := (others => '0');

begin

  d_out <= out_r;

  -------------------------------------------- 

  process (out_r)
  begin

    done <= '0';

    if (out_r = x"FFFF") then
      done <= '1';

    end if;

  end process;

  --------------------------------------------

  process (clk)
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        addr_r <= (others => '0');
        out_r  <= (others => '0');

      elsif (en = '1') then
        addr_r <= std_logic_vector(unsigned(addr_r) + 1);

      end if;

      case (addr_r) is
          -- To edit, add more assignments to this case statement.
          -- See the config_pkg for setting up the registers.

        when x"00" => out_r <= RESET;
        when x"01" => out_r <= RESET;
        when x"02" => out_r <= COM7;
        when x"03" => out_r <= CLKRC;
        when x"04" => out_r <= COM15;
        when x"05" => out_r <= RGB444;
        when x"06" => out_r <= COM13;
        when x"07" => out_r <= COM3;
        when x"08" => out_r <= TSLB;
        when x"09" => out_r <= COM9;

        when x"0A" => out_r <= HSTART;
        when x"0B" => out_r <= HSTOP;
        when x"0C" => out_r <= HREF;

        when x"0D" => out_r <= VSTRT;
        when x"0E" => out_r <= VSTOP;
        when x"0F" => out_r <= VREF;

        when x"10" => out_r <= MVFP;
        when x"11" => out_r <= REG74;
        when x"12" => out_r <= THL_ST;
        when x"13" => out_r <= THL_DLT;
        when x"14" => out_r <= COM8;
        when x"15" => out_r <= AECH;
        when x"16" => out_r <= HAECC7;

        when others => out_r <= x"FFFF";

      end case;

    end if;

  end process;

end BHV;
