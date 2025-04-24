library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port ( SW : in STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0);
           JB1 : out STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTND : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end top_level;

architecture Behavioral of top_level is

component pwm is 
generic(max_count_bits : positive);
    Port (
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           duty_in : in unsigned(max_count_bits -1 downto 0);
           pwm_out : out STD_LOGIC);
end component;

component bin2seg is 
    Port ( clear : in STD_LOGIC;
           bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
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
    Port ( dec_in : in integer;
           duty_out : out unsigned(20 downto 0)
           );
end component;

component dec2seg is 
    Port ( 
        rst : in STD_LOGIC;
        clear : in STD_LOGIC;
        dec_in : in integer;
        clk : in STD_LOGIC;
        seg : out STD_LOGIC_VECTOR (3 downto 0);
        an : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

component sw_input is 
    port (
        sw_in   : in    std_logic_vector(7 downto 0);
        ang_out : out   integer
    );
end component;

signal ang : integer;
signal duty : unsigned (20 downto 0);
signal clk_disp : std_logic;
signal display : std_logic_vector (3 downto 0);

begin

pwm_servp : pwm
    generic map( max_count_bits => 21)
    port map(
        rst => BTND,
        clk => CLK100MHZ,
        duty_in => duty,
        pwm_out => JB1
        );
        
switches_input : sw_input
    port map(
        sw_in => SW,
        ang_out => ang
        );

decadicToDuty : dec2duty
    port map(
        dec_in => ang,
        duty_out => duty
        );

clkock_enabler : clock_enable
    generic map(N_PERIODS => 100_000)
    port map(
        rst => BTND,
        clk => CLK100MHZ,
        pulse => clk_disp
        );

decadicToSegment : dec2seg
    port map(
        rst => BTND,
        clear => BTNC,
        dec_in => ang,
        clk => clk_disp,
        seg => display,
        an => AN
        );

binaryToSegment : bin2seg
    port map(
        clear => BTNC,
        bin => display,
        seg(6) => CA,
        seg(5) => CB,
        seg(4) => CC,
        seg(3) => CD,
        seg(2) => CE,
        seg(1) => CF,
        seg(0) => CG
        );

    DP <= '1';
    LED <= SW;
end Behavioral;
