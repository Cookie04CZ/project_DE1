library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

-------------------------------------------------

entity sw_input is
    port (
        sw_in   : in    std_logic_vector(7 downto 0);
        ang_out : out   integer
    );
end entity sw_input;

-------------------------------------------------

architecture behavioral of sw_input is
begin
    process(sw_in)
    variable bin : integer range 0 to 255;
    begin
        -- converting bin to dec
        bin := to_integer(unsigned(sw_in));
        
        -- Capped at 90
        if bin > 90 then
            bin := 90;
        end if;
        
        -- Output the decimal value as an 8-bit binary
        ang_out <= to_integer(to_unsigned(bin, 8)); 
    end process;
end architecture behavioral;