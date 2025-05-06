-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 17 Apr 2025 12:05:37 GMT
-- Request id : cfwk-fed377c2-6800ee91b48d2

library ieee;
use ieee.std_logic_1164.all;

entity tb_sw_input is
end tb_sw_input;

architecture tb of tb_sw_input is

    component sw_input
        port (sw_in   : in std_logic_vector (7 downto 0);
              ang_out : out std_logic_vector (7 downto 0));
    end component;

    signal sw_in   : std_logic_vector (7 downto 0);
    signal ang_out : std_logic_vector (7 downto 0);

begin

    dut : sw_input
    port map (sw_in   => sw_in,
              ang_out => ang_out);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        sw_in <= (others => '0');

        -- ***EDIT*** Add stimuli here
        
        sw_in <= "00000001";
        wait for 100ns;
        sw_in <= "11111111";
        wait for 100ns;
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sw_input of tb_sw_input is
    for tb
    end for;
end cfg_tb_sw_input;