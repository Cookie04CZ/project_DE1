library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dec2seg is
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
end dec2seg;

architecture Behavioral of dec2seg is

    signal currentangle : integer := 0;
    signal servoangle : integer := 0;
    signal dp_out : integer := 4;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                currentangle <= 0;
                servoangle <= 0;
                dp_out <= 4;
            else
                currentangle <= dec_in;
                servoangle <= choice;
                if dp_out = 0 then
                    dp_out <= 4;
                else
                    dp_out <= dp_out - 1;
                end if;
            end if;

            case dp_out is
                when 4 =>
                    an <= b"0111_1111";
                    dp <= '0';
                    if servo = '0' then
                        outp <= x"1";
                    else
                        outp <= x"2";
                    end if;
                when 3 =>
                    an <= b"1101_1111";
                    dp <= '1';
                    outp <= std_logic_vector(to_unsigned(((servoangle mod 100) / 10), 4));
                when 2 =>
                    an <= b"1110_1111";
                    dp <= '1';
                    outp <= std_logic_vector(to_unsigned((servoangle mod 10), 4)); 
                when 1 =>
                    dp <= '1';
                    an <= b"1111_1101";
                    outp <= std_logic_vector(to_unsigned(((currentangle mod 100) / 10), 4));
                when 0 =>
                    an <= b"1111_1110";
                    dp <= '1';
                    outp <= std_logic_vector(to_unsigned((currentangle mod 10), 4)); 
                when others =>
                    an <= b"1111_1111";
                    dp <= '1';
                    outp <= (others => '0'); 
            end case;
            
           
        end if;
    end process;

end Behavioral;