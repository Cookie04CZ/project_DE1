----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2025 14:46:15
-- Design Name: 
-- Module Name: buff - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity buff is
    Port ( rst : in STD_LOGIC; --reset button
           save : in STD_LOGIC; --save button
           choice : in STD_LOGIC; --spinac pro nastaveni ovladaneho servomotoru
           ang_in : integer; --vstupni uhel ze spinacu
           ang_out : out integer; -- vystupnio uhel pro zebrazeni aktualniho uhlu
           pwm1 : out integer; --vystup pro nastaveni pwm 1
           pwm2 : out integer); --vystup pro nastaveni pwm 2
end buff;

architecture Behavioral of buff is

    signal setangle1 : integer := 0;
    signal setangle2 : integer := 0;

begin
    
    process(save, rst, choice)
    begin
        if save = '1' then --ukladaci sekvence
            if choice = '0' then --nastaveni prvniho pwm a zobrazovaciho signalu aktualniho uhlu
                pwm1 <= ang_in;
                setangle1 <= ang_in;
            else --nastaveni druheho pwm a zobrazovaciho signalu aktualniho uhlu
                pwm2 <= ang_in;
                setangle2 <= ang_in;
            end if;
        end if;
        
        if choice = '0' then --vyobrazeni aktualne nastaveneho uhlu
                ang_out <= setangle1;
            else
                ang_out <= setangle2;
        end if;

        if rst = '1' then --celkovy reset
            pwm1 <= 0;
            pwm2 <= 0;
            ang_out <= 0;
        end if;
    end process;

end Behavioral;
