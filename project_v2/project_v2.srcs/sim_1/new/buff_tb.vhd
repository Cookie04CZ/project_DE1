-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Mon, 28 Apr 2025 13:15:25 GMT
-- Request id : cfwk-fed377c2-680f7f6db1643

library ieee;
use ieee.std_logic_1164.all;

entity tb_buff is
end tb_buff;

architecture tb of tb_buff is

    component buff
        port (rst     : in std_logic;
              save    : in std_logic;
              choice  : in std_logic;
              ang_in : integer;
              ang_out : out integer;
              pwm1    : out integer;
              pwm2    : out integer);
    end component;

    signal rst     : std_logic;
    signal save    : std_logic;
    signal choice  : std_logic;
    signal ang_in  : integer;
    signal ang_out : integer;
    signal pwm1    : integer;
    signal pwm2    : integer;

begin

    dut : buff
    port map (rst     => rst,
              save    => save,
              choice  => choice,
              ang_out => ang_out,
              pwm1    => pwm1,
              pwm2    => pwm2,
              ang_in  => ang_in);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        save <= '0';
        choice <= '0';
        ang_in <= 45;

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- ***EDIT*** Add stimuli here
        save <= '1';
        wait for 10 ns;
        save <= '0';
        wait for 10 ns;
        ang_in <= 90;
        wait for 10 ns;
        choice <= '1';
        wait for 10 ns;
        save <= '1';
        wait for 10 ns;
        save <= '0';
        wait for 30 ns;
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_buff of tb_buff is
    for tb
    end for;
end cfg_tb_buff;