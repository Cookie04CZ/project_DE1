----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2025 02:22:44 PM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( BTNC : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           JB1 : out STD_LOGIC);
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
component duty_counter is
    Port ( rst: in STD_logic;
           clk : in STD_LOGIC;
           en_down : in STD_LOGIC;
           en_up : in STD_LOGIC;
           duty : out unsigned (20 downto 0));
end component;

component clock_en is
  generic (
    n_periods : integer := 3 --! Default number of clk periodes to generate one pulse
  );
  port (
    clk   : in    std_logic; --! Main clock
    rst   : in    std_logic; --! High-active synchronous reset
    pulse : out   std_logic  --! Clock enable pulse signal
  );
end component;
signal sig_duty : unsigned(20 downto 0);
signal sig_clk : std_logic;
begin

pwm_servo : pwm
    generic map( max_count_bits => 21)
    port map(
        rst => BTNC,
        clk => CLK100MHZ,
        duty_in => sig_duty,
        pwm_out => JB1);
duty_count : duty_counter
    port map(
        rst => BTNC,
        clk => sig_clk,
        en_down => BTNL,
        en_up => BTNR,
        duty => sig_duty);
 clk_en : clock_en
    generic map( n_periods => 1000)
    port map(
        rst => BTNC,
        clk => CLK100MHZ,
        pulse => sig_clk);

end Behavioral;
