------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 5/26/2025
-- Module Name   : line_buffer
-- Project Name  : RTIPCV
-- Target Device : Generic FPGA
-- Tool Versions : Vivado 2024.1
-- Description   : Triple-line buffering system for 3x3 window generation.
--                 Stores pixel rows for use in convolution-based filtering.
--                 Includes internal FSM for row cycling and flush handling.
--
-- Revision      : v1.0
-- Revision Date : 5/26/2025
-- Author        : Zack Mendez
-- Comments      : Dynamically rotates active line buffers to feed 3x3
--                 kernel inputs. Valid signal ensures output is stable.
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity line_buffer is
  generic (
    X_MAX : positive := 640;
    Y_MAX : positive := 480
  );
  port (
    clk      : in std_logic;
    rst      : in std_logic;
    valid_in : in std_logic;
    pixel_in : in std_logic_vector(3 downto 0);

    flush        : out std_logic;
    window_valid : out std_logic;
    row0_out     : out std_logic_vector(3 downto 0);
    row1_out     : out std_logic_vector(3 downto 0);
    row2_out     : out std_logic_vector(3 downto 0)
  );
end entity;

architecture BHV of line_buffer is

  type state_t is (IDLE, MAIN);
  signal state_r, next_state : state_t;

  signal x_count_r, next_x_count       : unsigned(9 downto 0)         := (others => '0');
  signal y_count_r, next_y_count       : unsigned(8 downto 0)         := (others => '0');
  signal row_select_r, next_row_select : std_logic_vector(1 downto 0) := (others => '0');

  type line_buf_t is array (0 to X_MAX - 1) of std_logic_vector(3 downto 0);
  signal line_buf_0, line_buf_1, line_buf_2 : line_buf_t;

  signal x_count      : unsigned(9 downto 0) := (others => '0');
  signal y_count      : unsigned(8 downto 0) := (others => '0');

  signal row0_sel, row1_sel, row2_sel : line_buf_t;

  signal window_valid_r : std_logic := '0';


begin

  x_count <= x_count_r;
  y_count <= y_count_r;

  process (clk, rst)
  begin
    if rst = '1' then
      x_count_r    <= (others => '0');
      y_count_r    <= (others => '0');
      row_select_r <= (others => '0');
      state_r      <= IDLE;
    elsif rising_edge(clk) then
      x_count_r    <= next_x_count;
      y_count_r    <= next_y_count;
      row_select_r <= next_row_select;
      state_r      <= next_state;
    end if;
  end process;

  process (valid_in, x_count_r, y_count_r, row_select_r, state_r)
  begin
    next_x_count    <= x_count_r;
    next_y_count    <= y_count_r;
    next_row_select <= row_select_r;
    flush      <= '0';
    next_state      <= state_r;

    case state_r is

        -------------------------------------------------------------------------
      when IDLE =>
        flush <= '1';
        if valid_in = '1' then
          flush <= '0';
          next_state <= MAIN;
        end if;

        -------------------------------------------------------------------------
      when MAIN =>
        flush <= '0';
        if valid_in = '1' then

          if x_count_r = X_MAX - 1 then
            flush   <= '1';
            next_x_count <= (others => '0');

            if y_count_r = Y_MAX - 1 then
              next_y_count <= (others => '0');
              next_state   <= IDLE;
            else
              next_y_count <= y_count_r + 1;
            end if;

            if row_select_r = "10" then
              next_row_select <= "00";
            else
              next_row_select <= std_logic_vector(unsigned(row_select_r) + 1);
            end if;

          else
            next_x_count <= x_count_r + 1;
          end if;
        end if;

        -------------------------------------------------------------------------
      when others =>
        next_state <= IDLE;

    end case;
  end process;

  -------------------------------------------------------------------
  -- PIXEL WRITE LOGIC
  -------------------------------------------------------------------
  process (clk)
  begin
    if rising_edge(clk) then
      if valid_in = '1' then
        case next_row_select is
          when "00"   => line_buf_0(to_integer(next_x_count)) <= pixel_in;
          when "01"   => line_buf_1(to_integer(next_x_count)) <= pixel_in;
          when "10"   => line_buf_2(to_integer(next_x_count)) <= pixel_in;
          when others => null;
        end case;
      end if;
    end if;
  end process;

  -------------------------------------------------------------------
  -- WINDOW VALID CALCULATION
  -------------------------------------------------------------------
  process (clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        window_valid_r <= '0';
      else
        if valid_in = '1' then
          if (next_x_count < (X_MAX) and next_y_count >= 2) then
            window_valid_r <= '1';
          else
            window_valid_r <= '0';
          end if;
        else
          window_valid_r <= '0';
        end if;

      end if;
    end if;
  end process;

  -------------------------------------------------------------------
  -- BUFFER ROTATION LOGIC
  -------------------------------------------------------------------
  with next_row_select select
    row0_sel <= line_buf_1 when "00",
    line_buf_2 when "01",
    line_buf_0 when "10",
    line_buf_1 when others;

  with next_row_select select
    row1_sel <= line_buf_2 when "00",
    line_buf_0 when "01",
    line_buf_1 when "10",
    line_buf_2 when others;

  with next_row_select select
    row2_sel <= line_buf_0 when "00",
    line_buf_1 when "01",
    line_buf_2 when "10",
    line_buf_0 when others;

  -------------------------------------------------------------------
  -- OUTPUT TO KERNEL
  -------------------------------------------------------------------

  row0_out <= row0_sel(to_integer(next_x_count)) when window_valid_r = '1' else
    (others => '0');
  row1_out <= row1_sel(to_integer(next_x_count)) when window_valid_r = '1' else
    (others => '0');
  row2_out <= row2_sel(to_integer(next_x_count)) when window_valid_r = '1' else
    (others => '0');

  window_valid <= window_valid_r;

end BHV;
