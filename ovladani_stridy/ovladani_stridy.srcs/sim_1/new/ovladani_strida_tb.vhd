-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 10 Apr 2025 11:44:14 GMT
-- Request id : cfwk-fed377c2-67f7af0ebf1cf

library ieee;
use ieee.std_logic_1164.all;

entity tb_ovladani_strida is
end tb_ovladani_strida;

architecture tb of tb_ovladani_strida is

    component ovladani_strida
        port (clk     : in std_logic;
              rst     : in std_logic;
              in_sig  : in std_logic;
              out_sig : out std_logic_vector (20 downto 0));
    end component;

    signal clk     : std_logic;
    signal rst     : std_logic;
    signal in_sig  : std_logic;
    signal out_sig : std_logic_vector (20 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ovladani_strida
    port map (clk     => clk,
              rst     => rst,
              in_sig  => in_sig,
              out_sig => out_sig);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        in_sig <= '0';

        -- Inicializace
        rst <= '1';
        wait for 20 ns;  -- Po?kej na reset

        -- Vypnutí resetu
        rst <= '0';

        -- Test 1: St?ída 25% (in_sig je 25% ?asu na '1')
        -- Signál in_sig bude na 1 po dobu 1 us, a pak na 0 po dobu 3 us, opakovat.
        in_sig <= '1';
        wait for 1 ns;
        in_sig <= '0';
        wait for 3 ns;
        
        -- Test 2: St?ída 50% (in_sig je 50% ?asu na '1')
        in_sig <= '1';
        wait for 2 ns;
        in_sig <= '0';
        wait for 2 ns;

        -- Test 3: St?ída 75% (in_sig je 75% ?asu na '1')
        in_sig <= '1';
        wait for 3 ns;
        in_sig <= '0';
        wait for 1 ns;

        -- Test 4: 100% st?ída (in_sig je stále na '1')
        in_sig <= '1';
        wait for 4 ns;

        -- Test 5: 0% st?ída (in_sig je stále na '0')
        in_sig <= '0';
        wait for 4 ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ovladani_strida of tb_ovladani_strida is
    for tb
    end for;
end cfg_tb_ovladani_strida;