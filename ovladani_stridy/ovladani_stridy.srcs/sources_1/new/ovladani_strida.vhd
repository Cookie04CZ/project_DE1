library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entita s 21bitovým výstupem duty cycle
entity ovladani_strida is
    Port (
        clk         : in  STD_LOGIC;                  -- hodinový signál
        rst       : in  STD_LOGIC;                  -- synchronní reset
        in_sig      : in  STD_LOGIC;                  -- vstupní signál, jehož st?ídu m??íme
        out_sig  : out STD_LOGIC_VECTOR(20 downto 0)       -- výstup: st?ída jako pom?r (0 až 2^21-1)
    );
end ovladani_strida;

architecture Behavioral of ovladani_strida is
    signal period_counter     : unsigned(31 downto 0) := (others => '0');  -- ?íta? celé periody
    signal high_counter       : unsigned(31 downto 0) := (others => '0');  -- ?íta? takt? v log. 1
    signal in_sig_prev        : std_logic := '0';                          -- pam?? p?edchozího stavu signálu
    signal duty_cycle_reg     : std_logic_vector(20 downto 0) := (others => '0');  -- registr pro výstupní st?ídu
begin

    process(clk)
        -- Prom?nné pro výpo?et (52bitové, protože 32 + 20 bit?)
        variable temp_ratio : unsigned(51 downto 0);
        variable temp_div   : unsigned(51 downto 0);
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Nulování všech registr?
                period_counter   <= (others => '0');
                high_counter     <= (others => '0');
                in_sig_prev      <= '0';
                duty_cycle_reg   <= (others => '0');
            else
                -- Inkrementace celkové periody
                period_counter <= period_counter + 1;

                -- Po?et takt? v log. 1
                if in_sig = '1' then
                    high_counter <= high_counter + 1;
                end if;

                -- Detekce náb?žné hrany (low ? high)
                if (in_sig_prev = '0') and (in_sig = '1') then
                    if period_counter /= 0 then
                        -- Výpo?et st?ídy: (high_time * 2^20) / period_time
                        temp_ratio := resize(high_counter, 52) sll 20;
                        temp_div := temp_ratio / resize(period_counter, 52);
                        duty_cycle_reg <= std_logic_vector(temp_div(20 downto 0));  -- Výstup o?ezaný na 21 bit?
                    end if;

                    -- Reset ?íta?? pro novou periodu
                    period_counter <= (others => '0');
                    high_counter   <= (others => '0');
                end if;

                -- Uložení p?edchozího stavu
                in_sig_prev <= in_sig;
            end if;
        end if;
    end process;

    -- Výstupní signál
    out_sig <= duty_cycle_reg;

end Behavioral;
