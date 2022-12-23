library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vsync is
    Port(
        clk : in std_ulogic;
        vsync : out std_ulogic
    );
end vsync;

architecture sync of vsync is

    signal vsync_count: unsigned(7 downto 0);

begin

    vsync <= '0';
    
    process(clk)
    begin
        if (clk = '1' and clk'event) then
            if vsync_count = "11111111" then
                vsync_count <= (others => '0');
                vsync <= '1';
            else
                vsync_count <= vsync_count + 1;
                vsync <= '0';
            end if;
        end if;
    end process;

end sync;