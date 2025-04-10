library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entita s 21bitov�m v�stupem duty cycle
entity ovladani_strida is
    Port (
        clk         : in  STD_LOGIC;                  -- hodinov� sign�l
        rst       : in  STD_LOGIC;                  -- synchronn� reset
        in_sig      : in  STD_LOGIC;                  -- vstupn� sign�l, jeho� st?�du m??�me
        out_sig  : out STD_LOGIC_VECTOR(20 downto 0)       -- v�stup: st?�da jako pom?r (0 a� 2^21-1)
    );
end ovladani_strida;

architecture Behavioral of ovladani_strida is
    signal period_counter     : unsigned(31 downto 0) := (others => '0');  -- ?�ta? cel� periody
    signal high_counter       : unsigned(31 downto 0) := (others => '0');  -- ?�ta? takt? v log. 1
    signal in_sig_prev        : std_logic := '0';                          -- pam?? p?edchoz�ho stavu sign�lu
    signal duty_cycle_reg     : std_logic_vector(20 downto 0) := (others => '0');  -- registr pro v�stupn� st?�du
begin

    process(clk)
        -- Prom?nn� pro v�po?et (52bitov�, proto�e 32 + 20 bit?)
        variable temp_ratio : unsigned(51 downto 0);
        variable temp_div   : unsigned(51 downto 0);
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Nulov�n� v�ech registr?
                period_counter   <= (others => '0');
                high_counter     <= (others => '0');
                in_sig_prev      <= '0';
                duty_cycle_reg   <= (others => '0');
            else
                -- Inkrementace celkov� periody
                period_counter <= period_counter + 1;

                -- Po?et takt? v log. 1
                if in_sig = '1' then
                    high_counter <= high_counter + 1;
                end if;

                -- Detekce n�b?�n� hrany (low ? high)
                if (in_sig_prev = '0') and (in_sig = '1') then
                    if period_counter /= 0 then
                        -- V�po?et st?�dy: (high_time * 2^20) / period_time
                        temp_ratio := resize(high_counter, 52) sll 20;
                        temp_div := temp_ratio / resize(period_counter, 52);
                        duty_cycle_reg <= std_logic_vector(temp_div(20 downto 0));  -- V�stup o?ezan� na 21 bit?
                    end if;

                    -- Reset ?�ta?? pro novou periodu
                    period_counter <= (others => '0');
                    high_counter   <= (others => '0');
                end if;

                -- Ulo�en� p?edchoz�ho stavu
                in_sig_prev <= in_sig;
            end if;
        end if;
    end process;

    -- V�stupn� sign�l
    out_sig <= duty_cycle_reg;

end Behavioral;
