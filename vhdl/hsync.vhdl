library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hsync is
    Port(
        clk: in std_logic;
        hsync: out std_logic;
        hreset: out std_logic
    );
end hsync;

architecture sync of hsync is

    signal hsync_count: unsigned(7 downto 0);

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if hsync_count = "11111111" then
                hsync_count <= (others => '0');
            else
                hsync_count <= hsync_count + 1;
            end if;
        end if;
    end process;

    hreset <= '1' when hsync_count = "00000000" else '0';
    hsync <= '1' when hsync_count = "00000000" else '0';

end sync;