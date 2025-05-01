library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_level is
-- Testbench nemá žádné porty
end tb_top_level;

architecture behavior of tb_top_level is

    -- Signály pro propojení s instancí top_level
    signal SW         : std_logic_vector(6 downto 0) := (others => '0');
    signal SW_servo   : std_logic := '0';
    signal BTNR       : std_logic := '0';
    signal BTNC       : std_logic := '0';
    signal CLK100MHZ  : std_logic := '0';
    signal LED        : std_logic_vector(6 downto 0);
    signal DP         : std_logic;
    signal AN         : std_logic_vector(7 downto 0);
    signal CA, CB, CC, CD, CE, CF, CG : std_logic;
    signal JB1        : std_logic;
    signal JB2        : std_logic;

    -- Konstanty
    constant CLK_PERIOD : time := 10 ns;  -- 100MHz -> perioda 10ns

begin

    -- Instanciace testovaného návrhu (UUT - Unit Under Test)
    uut: entity work.top_level
        port map (
            SW      => SW,
            SW_servo=> SW_servo,
            BTNR    => BTNR,
            BTNC    => BTNC,
            CLK100MHZ => CLK100MHZ,
            LED     => LED,
            DP      => DP,
            AN      => AN,
            CA      => CA,
            CB      => CB,
            CC      => CC,
            CD      => CD,
            CE      => CE,
            CF      => CF,
            CG      => CG,
            JB1     => JB1,
            JB2     => JB2
        );

    -- Hodinový generátor
    clk_process : process
    begin
        while true loop
            CLK100MHZ <= '0';
            wait for CLK_PERIOD/10;
            CLK100MHZ <= '1';
            wait for CLK_PERIOD/10;
        end loop;
    end process;

    -- Stimulační proces
    stim_proc: process
    begin
        -- Inicializace
        SW <= "1100000";
        SW_servo <= '0';
        BTNR <= '0';
        BTNC <= '0';

        wait for 100 ns;  -- počkej na stabilizaci

        -- Simulace resetu
        BTNR <= '1';
        wait for 50 ns;
        BTNR <= '0';
        wait for 100 ns;
       
        -- Stisk "save" tlačítka pro uložení úhlu
        BTNC <= '1';
        wait for 50 ns;
        BTNC <= '0';
        wait for 100 ns;

        -- Přepnutí na jiné servo
        SW_servo <= '1';
        wait for 100 ns;

        -- Další nastavení úhlu pro druhé servo
        SW <= "0000101"; -- například 5 stupňů
        wait for 5 ns;
        BTNC <= '1';
        wait for 50 ns;
        BTNC <= '0';
        wait for 50 ns;
        SW_servo <= '0';
        -- Simulace dalšího resetu
        wait for 50 ns;
        BTNR <= '1';
        wait for 50 ns;
        BTNR <= '0';
        wait for 50 ns;
        SW_servo <= '1';
        
        
        -- Ukončení simulace
        wait for 5 us;
        assert false report "End of Simulation" severity failure;
    end process;

end behavior;
