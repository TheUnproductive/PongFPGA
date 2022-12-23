library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hsync is
    Port(
        clk: in std_ulogic;
        hsync: out std_ulogic;
        hreset: out std_ulogic
    );
end hsync;

architecture sync of hsync is

    signal hsync_count: unsigned(7 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if (clk = '1' and clk'event) then
            if hsync_count = "11111111" then
                hsync_count <= (others => '0');
                hsync <= '1';
                hreset <= '1';
            else
                hsync_count <= hsync_count + 1;
                hsync <= '0';
                hreset <= '0';
            end if;
        end if;
    end process;

end sync;