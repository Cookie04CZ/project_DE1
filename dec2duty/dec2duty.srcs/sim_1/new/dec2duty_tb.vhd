library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity tb_dec2duty is
end tb_dec2duty;

architecture tb of tb_dec2duty is

    component dec2duty
        port (dec_in   : in integer;
              duty_out : out unsigned (20 downto 0));
    end component;

    signal dec_in   : integer;
    signal duty_out : unsigned (20 downto 0);

begin

    dut : dec2duty
    port map (dec_in   => dec_in,
              duty_out => duty_out);

    stimuli : process
    begin

        -- ***EDIT*** Add stimuli here
        dec_in <= 0;
        wait for 100 ns;
        dec_in <= 45;
        wait for 100 ns;
        dec_in <= 90;
        wait for 100 ns; 
       
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_dec2duty of tb_dec2duty is
    for tb
    end for;
end cfg_tb_dec2duty;