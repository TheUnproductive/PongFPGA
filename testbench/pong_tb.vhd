library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture test of testbench is

    signal clk : std_logic := '0';
    signal hsync : std_logic := '0';
    signal vsync : std_logic := '0';

    component pong is
        port(
            clk : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            ball_x : out std_logic_vector(3 downto 0);
            ball_y : out std_logic_vector(3 downto 0);
            ball_dir : out std_logic_vector(1 downto 0);
            player1 : out std_logic_vector(3 downto 0);
            player2 : out std_logic_vector(3 downto 0);
            score1 : out std_logic_vector(3 downto 0);
            score2 : out std_logic_vector(3 downto 0);
            led : out std_logic_vector(7 downto 0);
            hsync_out : out std_logic;
            vsync_out : out std_logic
        );
    end component;

begin

    uut : pong port map(
        clk => clk,
        reset => '0',
        start => '0',
        ball_x => open,
        ball_y => open,
        ball_dir => open,
        player1 => open,
        player2 => open,
        score1 => open,
        score2 => open,
        led => open,
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