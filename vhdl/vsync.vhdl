library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vsync is
    Port(
        clk : in std_logic;
        vsync : out std_logic
    );
end vsync;

architecture sync of vsync is

    signal vsync_count: unsigned(7 downto 0);

begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if vsync_count = "11111111" then
                vsync_count <= (others => '0');
            else
                vsync_count <= vsync_count + 1;
            end if;
        end if;
    end process;

    vsync <= vsync_count(7);

end sync;