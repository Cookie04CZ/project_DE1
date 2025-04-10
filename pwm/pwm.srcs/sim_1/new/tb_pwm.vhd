-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 10 Apr 2025 11:37:48 GMT
-- Request id : cfwk-fed377c2-67f7ad8c9c188

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
entity tb_pwm is
end tb_pwm;

architecture tb of tb_pwm is
   constant max_count_bits : positive:= 21;
    component pwm
        port (
              rst     : in std_logic;
              clk     : in std_logic;
              duty_in : in unsigned (max_count_bits -1 downto 0);
              pwm_out : out std_logic);
    end component;

    signal rst     : std_logic;
    signal clk     : std_logic;
    signal duty_in : unsigned (max_count_bits -1 downto 0);
    signal pwm_out : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : pwm
    port map (
              rst     => rst,
              clk     => clk,
              duty_in => duty_in,
              pwm_out => pwm_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed

        duty_in <= (others => '0');

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;
        

        -- ***EDIT*** Add stimuli here
        duty_in <= "000011001100110011010";
        wait for 100ms;
        
        
        duty_in <= "000011011111110011010";
        wait for 100ms;
        
        
        
        duty_in <= "000110011001100110011";
        wait for 100ms;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
