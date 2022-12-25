library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pong_tb is
end pong_tb;

architecture testbench of pong_tb is

    signal clk : std_ulogic := '0';
    signal hsync_tb : std_ulogic;
    signal vsync_tb : std_ulogic;
    signal hreset_tb : std_ulogic;

    component pong is
        port(
            clk : in std_ulogic;
            hsync_out : out std_ulogic;
            vsync_out : out std_ulogic
        );
    end component;

    component hsync is
        port(
            clk : in std_ulogic;
            hsync_out : out std_ulogic;
            hreset_out : out std_ulogic
        );
    end component;

    component vsync is
        port(
            clk : in std_ulogic;
            vsync_out : out std_ulogic
        );
    end component;

begin

    -- uut : pong port map(
    --     clk => clk,
    --     hsync_out => hsync_tb,
    --     vsync_out => vsync_tb
    -- );

    hsync_test : hsync port map(
        clk => clk,
        hsync_out => hsync_tb,
        hreset_out => hreset_tb
    );

    vsync_test : vsync port map(
        clk => clk,
        vsync_out => vsync_tb
    );

    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

end testbench;