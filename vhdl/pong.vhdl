library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pong_board is
    Port ( clk : in std_logic;
           reset : in std_logic;
           start : in std_logic;
           ball_x : in std_logic_vector(3 downto 0);
           ball_y : in std_logic_vector(3 downto 0);
           ball_dir : in std_logic_vector(1 downto 0);
           player1 : in std_logic_vector(3 downto 0);
           player2 : in std_logic_vector(3 downto 0);
           score1 : out std_logic_vector(3 downto 0);
           score2 : out std_logic_vector(3 downto 0);
           led : out std_logic_vector(7 downto 0));
end pong_board;

architecture pong_game of pong_board is

    signal ball_x_reg : std_logic_vector(3 downto 0);
    signal ball_y_reg : std_logic_vector(3 downto 0);
    signal ball_dir_reg : std_logic_vector(1 downto 0);
    signal player1_reg : std_logic_vector(3 downto 0);
    signal player2_reg : std_logic_vector(3 downto 0);
    signal score1_reg : std_logic_vector(3 downto 0);
    signal score2_reg : std_logic_vector(3 downto 0);
    signal led_reg : std_logic_vector(7 downto 0);
    signal clk : std_logic;
    signal hreset : std_logic;
    signal hsync : std_logic;
    signal vsync : std_logic;

    component hsync is
        Port (
            clk : in std_logic;
            hreset : out std_logic;
            hsync : out std_logic
        );
    end component hsync;

    component vsync is
        Port ( 
            clk : in std_logic;
            vsync : out std_logic
        );
    end component vsync;

begin

    hsync : hsync
        Port map (
            clk => clk, 
            hreset => hreset, 
            hsync => hsync
        );

    vsync : vsync
        Port map (
            clk => reset, 
            vsync => vsync
        );
    
end pong_game;