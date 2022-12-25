library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hsync is
    Port(
        clk: in std_ulogic;
        hsync_out: out std_ulogic;
        hreset_out: out std_ulogic
    );
end hsync;

-- implement a hsync signal generator
architecture hsync_gen of hsync is

    signal hcount: unsigned(9 downto 0) := (others => '0');
    signal hsync: std_ulogic := '0';
    signal hreset: std_ulogic := '0';

begin

    -- hsync generator
    hsync <= '1' when hcount = "0000000000" else '0';
    hreset <= '1' when hcount = "0000000000" else '0';

    -- hcount
    process(clk)
    begin
        if rising_edge(clk) then
            if hcount = "1111111111" then
                hcount <= (others => '0');
            else
                hcount <= hcount + 1;
            end if;
        end if;
    end process;

    -- output
    hsync_out <= hsync;
    hreset_out <= hreset;

end hsync_gen;