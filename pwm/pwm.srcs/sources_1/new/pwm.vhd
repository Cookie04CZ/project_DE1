library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity pwm is
    generic(max_count_bits : positive := 21);
    Port (rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           duty_in : in unsigned(max_count_bits -1 downto 0);
           pwm_out : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is
signal sig_count : unsigned(max_count_bits -1 downto 0);
signal sig_pwm_out : std_logic;
begin

p_pwm : process (clk) is
begin
if(rising_edge(clk)) then

    if(rst ='1') then
        sig_pwm_out <= '0';
        sig_count <=  "000011001100110011010";
    else
        sig_count <= sig_count + 1;
        sig_pwm_out <= '0';
        if sig_count < duty_in then
            sig_pwm_out <= '1';
        end if;
    end if;
end if;

pwm_out <= sig_pwm_out;
end process;

end Behavioral;
