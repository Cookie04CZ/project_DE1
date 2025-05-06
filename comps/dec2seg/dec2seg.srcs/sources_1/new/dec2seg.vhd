library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dec2seg is
    Port ( 
        rst : in STD_LOGIC;
        clear : in STD_LOGIC;
        dec_in : in integer;
        clk : in STD_LOGIC;
        seg : out STD_LOGIC_VECTOR (3 downto 0);
        dp : out STD_LOGIC_VECTOR (7 downto 0)
    );
end dec2seg;

architecture Behavioral of dec2seg is

    signal angle : integer := 0;
    signal dp_out : integer := 1; --2

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                angle <= 0;
                dp_out <= 1;
            else
                angle <= dec_in;
                if dp_out = 0 then
                    dp_out <= 1; --2
                else
                    dp_out <= dp_out - 1;
                end if;
            end if;

            case dp_out is
                --when 2 =>
                    --dp <= b"1111_1011";
                    --seg <= std_logic_vector(to_unsigned((angle / 100), 4));
                when 1 =>
                    dp <= b"1111_1101";
                    seg <= std_logic_vector(to_unsigned(((angle mod 100) / 10), 4));
                when 0 =>
                    dp <= b"1111_1110";
                    seg <= std_logic_vector(to_unsigned((angle mod 10), 4)); 
                when others =>
                    dp <= b"1111_1111";
                    seg <= (others => '0'); 
            end case;
        end if;
    end process;

end Behavioral;