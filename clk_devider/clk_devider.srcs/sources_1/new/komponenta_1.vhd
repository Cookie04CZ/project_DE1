library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 use ieee.std_logic_1164.all;


entity clk_devider is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clk_devider;

architecture Behavioral of clk_devider is
signal tmp: STD_LOGIC;
signal count: integer range 0 to 780 := 0; -- range 0 to X - zmenit podle frekvence serva
begin
freq_divider: process (rst, clk) begin
     if (rst ='1')then
        tmp <= '0';
        count <= 0;
        elsif rising_edge(clk) then
            if (count=780) then 
            tmp<= NOT(tmp);
            count <= 0;
        else
            count <= count + 1;
        end if;
     end if;
end process;
clk_out <= tmp;

end Behavioral;
  
                
