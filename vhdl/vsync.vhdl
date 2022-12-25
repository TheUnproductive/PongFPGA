library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vsync is
    Port(
        clk : in std_ulogic;
        vsync_out : out std_ulogic
    );
end vsync;

-- implement a vsync signal generator 
architecture vsync_gen of vsync is

    signal vsync_cnt : unsigned(7 downto 0) := (others => '0');

begin

    -- generate vsync signal
    process(clk)
    begin
        if rising_edge(clk) then
            if vsync_cnt = "11111111" then
                vsync_cnt <= (others => '0');
            else
                vsync_cnt <= vsync_cnt + 1;
            end if;
        end if;
    end process;

    -- vsync signal
    vsync_out <= vsync_cnt(7);

end vsync_gen;