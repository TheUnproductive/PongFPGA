library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture test of testbench is

    signal clk : std_ulogic := '0';
    signal hsync : std_ulogic;
    signal vsync : std_ulogic;

    component pong is
        port(
            clk : in std_ulogic;
            -- reset : in std_ulogic;
            -- start : in std_ulogic;
            -- ball_x : out std_ulogic_vector(3 downto 0);
            -- ball_y : out std_ulogic_vector(3 downto 0);
            -- ball_dir : out std_ulogic_vector(1 downto 0);
            -- player1 : out std_ulogic_vector(3 downto 0);
            -- player2 : out std_ulogic_vector(3 downto 0);
            -- score1 : out std_ulogic_vector(3 downto 0);
            -- score2 : out std_ulogic_vector(3 downto 0);
            -- led : out std_ulogic_vector(7 downto 0);
            hsync_out : out std_ulogic;
            vsync_out : out std_ulogic
        );
    end component;

begin

    uut : pong port map(
        clk => clk,
        -- reset => '0',
        -- start => '0',
        -- ball_x => open,
        -- ball_y => open,
        -- ball_dir => open,
        -- player1 => open,
        -- player2 => open,
        -- score1 => open,
        -- score2 => open,
        -- led => open,
        hsync_out => hsync,
        vsync_out => vsync
    );

    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

end test;