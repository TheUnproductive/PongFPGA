library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is 
port (
    clk: in std_ulogic;
    reset: in std_ulogic;
    count: out std_ulogic_vector(3 downto 0)
);
end counter;

architecture Behavioral of counter is

    signal count_reg: std_ulogic_vector(3 downto 0) := "0000";

begin

    count <= count_reg;

    process(clk, reset)
    begin
        if (reset = '1') then
            count_reg <= "0000";
        elsif (clk'event and clk = '1') then
            if (count_reg = "1111") then
                count_reg <= "0000";
            else
                count_reg <= std_ulogic_vector( unsigned(count_reg) + 1);
            end if;
        end if;
    end process;

end Behavioral;