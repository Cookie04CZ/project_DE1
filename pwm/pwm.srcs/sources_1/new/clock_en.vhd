----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2025 01:32:21 PM
-- Design Name: 
-- Module Name: clock_en - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
  use ieee.std_logic_1164.all;

-------------------------------------------------

entity clock_en is
  generic (
    n_periods : integer := 3 --! Default number of clk periodes to generate one pulse
  );
  port (
    clk   : in    std_logic; --! Main clock
    rst   : in    std_logic; --! High-active synchronous reset
    pulse : out   std_logic  --! Clock enable pulse signal
  );
end entity clock_en;

-------------------------------------------------

architecture behavioral of clock_en is

  --! Local counter
  signal sig_count : integer range 0 to n_periods - 1;

begin

  --! Count the number of clock pulses from zero to N_PERIODS-1.
  p_clk_enable : process (clk) is
  begin

    if (rising_edge(clk)) then                   -- Synchronous process
      if (rst = '1') then                        -- High-active reset
        sig_count <= 0;

      -- Counting
      elsif (sig_count < (n_periods - 1)) then
        sig_count <= sig_count + 1;              -- Increment local counter

      -- End of counter reached
      else
        sig_count <= 0;
      end if;                                    -- Each `if` must end by `end if`
    end if;

  end process p_clk_enable;

  -- Generated pulse is always one clock long
  pulse <= '1' when (sig_count = n_periods - 1) else
           '0';

end architecture behavioral;