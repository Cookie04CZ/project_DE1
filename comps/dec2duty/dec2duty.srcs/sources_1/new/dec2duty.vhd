library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use ieee.numeric_std.all;

entity dec2duty is
    Port ( dec_in : in integer;
           duty_out : out unsigned(20 downto 0)
           );
end dec2duty;

architecture Behavioral of dec2duty is

    signal temp : integer;
begin
    
    temp <= 100000 + (1111 * dec_in);
    duty_out <= to_unsigned(temp, 21);
end Behavioral;
