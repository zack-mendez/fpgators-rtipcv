------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : rotary_counter
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : 4-bit rotary encoder counter with direction sensing.
--                 Increments or decrements threshold based on rotation
--                 direction, with asynchronous reset.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : 
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rotary_counter is
  port (
    clk       : in std_logic;
    rst       : in std_logic;
    A         : in std_logic;
    B         : in std_logic;
    threshold : out std_logic_vector(3 downto 0)
  );
end entity;

architecture BHV of rotary_counter is
  signal threshold_reg : unsigned(3 downto 0) := (others => '0');
  signal prev_A        : std_logic            := '0';
begin

  process (clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        threshold_reg <= (others => '0');
      else
        prev_A <= A;

        if (prev_A = '0' and A = '1') then
          if B = '1' then
            if threshold_reg < 15 then
              threshold_reg <= threshold_reg + 1;
            end if;
          else
            if threshold_reg > 0 then
              threshold_reg <= threshold_reg - 1;
            end if;
          end if;
        end if;
      end if;
    end if;
  end process;

  threshold <= std_logic_vector(threshold_reg);

end BHV;
