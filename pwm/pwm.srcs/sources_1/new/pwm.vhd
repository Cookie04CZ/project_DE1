library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity pwm is
    generic( position_bits : positive := 8);
    Port ( en : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           pwm_in : in STD_LOGIC_vector(position_bits -1 downto 0);
           pwm_out : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is
signal sig_count : std_logic_vector(position_bits -1 downto 0);
signal sig_pwm_out : std_logic;
begin

p_pwm : process (clk) is
begin
if(rising_edge(clk)) then

    if(rst ='1') then
        sig_pwm_out <= '0';
        sig_count <=  (others => '0');
    elsif(en='1') then
        if(




    end if;
end if;

end process;

end Behavioral;
