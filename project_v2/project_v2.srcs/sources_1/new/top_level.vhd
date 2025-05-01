----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2025 17:50:50
-- Design Name: 
-- Module Name: top_level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( SW : in STD_LOGIC_VECTOR (6 downto 0);
           SW_servo : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (6 downto 0);
           LED_servo : out std_logic;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           JB1 : out STD_LOGIC;
           JB2 : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is

    component pwm is 
    generic(max_count_bits : positive);
        Port (
            rst : in STD_LOGIC;
            clk : in STD_LOGIC;
            duty_in : in unsigned(max_count_bits -1 downto 0);
            pwm_out : out STD_LOGIC
        );
    end component;

    component bin2seg is 
        Port ( 
            bin : in STD_LOGIC_VECTOR (3 downto 0);
            seg : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;
    
    component clock_enable is 
        generic (
            N_PERIODS : integer
        );
    
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            pulse   : out STD_LOGIC
        );
    end component;
    
    component dec2duty is 
        Port ( 
            dec_in : in integer;
            duty_out : out unsigned(20 downto 0)
        );
    end component;
    
    component dec2seg is 
        Port ( 
            rst : in STD_LOGIC; --reset na 0
            servo : in std_logic; --vyber serva (prvni pozice)
            choice : in integer; --aktualni nastaveni spinacu
            dec_in : in integer; --aktualni nastaveni serva
            clk : in STD_LOGIC; --zpomalene hodiny
            outp : out STD_LOGIC_VECTOR (3 downto 0); --4 bit vystup cisla pro zobrazeni na displayi
            an : out STD_LOGIC_VECTOR (7 downto 0); --pozice 
            dp : out std_logic --desetinna carka (jenom na prvni pozici)
        );
    end component;
    
    component sw_input is 
        port (
            sw_in   : in    std_logic_vector(6 downto 0);
            ang_out : out   integer
        );
    end component;
    
    component buff is 
        port (
            rst : in STD_LOGIC; --reset button
            save : in STD_LOGIC; --save button
            choice : in STD_LOGIC; --spinac pro nastaveni ovladaneho servomotoru
            ang_in : integer; --vstupni uhel ze spinacu
            ang_out : out integer; -- vystupnio uhel pro zebrazeni aktualniho uhlu
            pwm1 : out integer; --vystup pro nastaveni pwm 1
            pwm2 : out integer --vystup pro nastaveni pwm 2
        );
    end component;
    
    signal ang : integer := 0;
    signal duty1 : unsigned (20 downto 0);
    signal duty2 : unsigned (20 downto 0);
    signal decpwm1 : integer := 0;
    signal decpwm2 : integer := 0;
    signal clk_disp : std_logic;
    signal display : std_logic_vector (3 downto 0);
    signal currentang : integer := 0;
    
begin
    
    pwm1 : pwm
        generic map( max_count_bits => 21)
        port map(
            rst => BTNR,
            clk => CLK100MHZ,
            duty_in => duty1,
            pwm_out => JB1
            );
     
    pwm2 : pwm
        generic map( max_count_bits => 21)
        port map(
            rst => BTNR,
            clk => CLK100MHZ,
            duty_in => duty2,
            pwm_out => JB2
            );
            
    switches_input : sw_input
        port map(
            sw_in => SW,
            ang_out => ang
            );
    
    decadicToDuty1 : dec2duty
        port map(
            dec_in => decpwm1,
            duty_out => duty1
            );
            
    decadicToDuty2 : dec2duty
        port map(
            dec_in => decpwm2,
            duty_out => duty2
            );
    
    clock_enabler : clock_enable
        generic map(N_PERIODS => 125_000)
        port map(
            rst => BTNR,
            clk => CLK100MHZ,
            pulse => clk_disp
            );
    
    decadicToSegment : dec2seg
        port map(
            servo => SW_servo,
            rst => BTNR,
            choice => currentang,
            dec_in => ang,
            clk => clk_disp,
            outp => display,
            an => AN,
            dp => DP
            );
    
    binaryToSegment : bin2seg
        port map(
            bin => display,
            seg(6) => CA,
            seg(5) => CB,
            seg(4) => CC,
            seg(3) => CD,
            seg(2) => CE,
            seg(1) => CF,
            seg(0) => CG
            );

    buff_in : buff
        port map(
            rst => BTNR,
            save => BTNC,
            choice => SW_servo,
            ang_in => ang,
            ang_out => currentang,
            pwm1 => decpwm1,
            pwm2 => decpwm2
            );

    LED <= SW;
    LED_servo <= SW_servo;

end Behavioral;
