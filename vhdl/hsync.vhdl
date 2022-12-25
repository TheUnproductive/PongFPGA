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

    signal hsync_count : unsigned(8 downto 0) := (others => '0');
    signal hsync_signal : std_ulogic := '0';
    signal hblanking : std_ulogic := '0';
    signal hblanking_n : std_ulogic;
    signal hreset_signal : std_ulogic := '0';
    signal hreset_n : std_ulogic;

    component rs_ff is
        Port(
            clk,r,s : in std_logic;
            Q: out std_logic;
            Qnot : out std_logic
        );
    end component;

    signal rs_reset : std_ulogic := '0';

begin

    hsync <= hsync_signal;

    hreset <= hreset_signal;
    hreset_n <= not hreset_signal;

    rs_reset <= (("10000" and hsync_count) nand ("1000000" and hsync_count));

    rs_ff_inst : rs_ff
        Port Map(
            clk => clk,
            r => rs_reset,
            s => hreset_n,
            Q => hblanking,
            Qnot => hblanking_n
        );

    hsync_signal <= hblanking nand ("100000" and hsync_count);

    process(clk)
    begin
        if (clk = '1' and clk'event) then
            if hsync_count = "111000110" then
                hsync_count <= (others => '0');
                hreset_signal <= '1';
            else
                hsync_count <= hsync_count + 1;
                hreset_signal <= '0';
            end if;
        end if;
    end process;

end sync;