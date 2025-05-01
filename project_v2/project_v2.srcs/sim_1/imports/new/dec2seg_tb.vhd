library ieee;
use ieee.std_logic_1164.all;

entity tb_dec2seg is
end tb_dec2seg;

architecture tb of tb_dec2seg is

    component dec2seg
        port (  rst : in STD_LOGIC; --reset na 0
                servo : in std_logic; --vyber serva (prvni pozice)
                choice : in integer; --aktualni nastaveni spinacu
                dec_in : in integer; --aktualni nastaveni serva
                clk : in STD_LOGIC; --zpomalene hodiny
                outp : out STD_LOGIC_VECTOR (3 downto 0); --4 bit vystup cisla pro zobrazeni na displayi
                an : out STD_LOGIC_VECTOR (7 downto 0); --pozice 
                dp : out std_logic --desetinna carka (jenom na prvni pozici)
                );
              
    end component;

    signal rst    : std_logic;
    signal servo  : std_logic;
    signal choice : integer;
    signal dec_in : integer;
    signal clk    : std_logic;
    signal outp    : std_logic_vector (3 downto 0);
    signal an     : std_logic_vector (7 downto 0);
    signal dp     : std_logic;
    
    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : dec2seg
    port map (  rst    => rst,
                servo  => servo,
                choice => choice,
                dec_in => dec_in,
                clk    => clk,
                outp    => outp,
                an     => an,
                dp     => dp
              
              );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        dec_in <= 0;
        choice <= 0;
        servo <= '0';
        

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 10 ns;

        -- ***EDIT*** Add stimuli here
        dec_in <= 0;
        wait for 10 * TbPeriod;
        dec_in <= 10;
        wait for 10 * TbPeriod;
        dec_in <= 45;
        choice <= 45;
        wait for 10 * TbPeriod;
        dec_in <= 50;
        servo <= '1';
        choice <= 50;
        wait for 10 * TbPeriod;
        dec_in <= 90;
        wait for 10 * TbPeriod;
        servo <= '0';
        wait for 1000 * TbPeriod;
        
        

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_dec2seg of tb_dec2seg is
    for tb
    end for;
end cfg_tb_dec2seg;