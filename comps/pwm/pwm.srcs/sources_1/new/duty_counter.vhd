----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2025 01:25:48 PM
-- Design Name: 
-- Module Name: duty_counter - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity duty_counter is
    Port ( rst: in STD_logic;
           clk : in STD_LOGIC;
           en_down : in STD_LOGIC;
           en_up : in STD_LOGIC;
           duty : out unsigned (20 downto 0));
end duty_counter;

architecture Behavioral of duty_counter is
    signal sig_duty : unsigned (20 downto 0);
begin
 p_counter : process (clk) is
  begin

    if (rising_edge(clk)) then
     
      if (rst = '1') then
        sig_duty <= "000100100100111110000";

      
      elsif (en_down = '1') then
        
        if (sig_duty>"000011000011010011111") then
          sig_duty <= sig_duty - 1;
        end if;
      elsif(en_up = '1') then
        if(sig_duty<"000110000110101000001")then
          sig_duty <= sig_duty + 1;
     
        end if;
      end if;
    end if;
  duty <= sig_duty;
  end process p_counter;

end Behavioral;
