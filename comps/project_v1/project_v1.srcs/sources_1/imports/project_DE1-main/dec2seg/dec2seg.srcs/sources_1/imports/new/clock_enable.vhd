library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_enable is
    generic (
        N_PERIODS : integer := 400_000
    );
    
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        pulse   : out STD_LOGIC
    );
end clock_enable;

architecture Behavioral of clock_enable is
    signal sig_cnt : integer range 0 to N_PERIODS-1;
begin
    --! Count the number of clock pulses from zero to N_PERIODS-1.
    p_clk_enable : process (clk) is
    begin

        -- Synchronous proces
        if (rising_edge(clk)) then
            -- if high-active reset then
            if rst = '1' then
                -- Clear integer counter
                sig_cnt <= 0;
            -- elsif sig_count is less than N_PERIODS-1 then
            elsif sig_cnt < N_PERIODS-1 then    
                -- Counting
                sig_cnt <= sig_cnt + 1;
            -- else reached the end of counter
            else 
                -- Clear integer counter
                sig_cnt <= 0;
            -- Each `if` must end by `end if`
            end if;
        end if;

    end process p_clk_enable;

    -- Generated pulse is always one clock long
    -- when sig_count = N_PERIODS-1
    pulse <= '1' when sig_cnt = N_PERIODS-1 else '0';

    

end Behavioral;
