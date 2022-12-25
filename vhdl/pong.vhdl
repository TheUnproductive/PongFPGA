library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pong_board is
    Port (
        clk : in std_ulogic;
        -- reset : in std_ulogic;
        -- start : in std_ulogic;
        -- ball_x : in std_ulogic_vector(3 downto 0);
        -- ball_y : in std_ulogic_vector(3 downto 0);
        -- ball_dir : in std_ulogic_vector(1 downto 0);
        -- player1 : in std_ulogic_vector(3 downto 0);
        -- player2 : in std_ulogic_vector(3 downto 0);
        -- score1 : out std_ulogic_vector(3 downto 0);
        -- score2 : out std_ulogic_vector(3 downto 0);
        -- led : out std_ulogic_vector(7 downto 0);
        hsync_out : out std_ulogic;
        vsync_out : out std_ulogic
    );
end pong_board;

architecture pong_game of pong_board is

    -- signal ball_x_reg : std_ulogic_vector(3 downto 0);
    -- signal ball_y_reg : std_ulogic_vector(3 downto 0);
    -- signal ball_dir_reg : std_ulogic_vector(1 downto 0);
    -- signal player1_reg : std_ulogic_vector(3 downto 0);
    -- signal player2_reg : std_ulogic_vector(3 downto 0);
    -- signal score1_reg : std_ulogic_vector(3 downto 0);
    -- signal score2_reg : std_ulogic_vector(3 downto 0);
    -- signal led_reg : std_ulogic_vector(7 downto 0);
    signal clk_signal : std_ulogic;
    signal hreset : std_ulogic;

    component hsync is
        Port (
            clk : in std_ulogic;
            hsync : out std_ulogic;
            hreset : out std_ulogic
        );
    end component;

    component vsync is
        Port ( 
            clk : in std_ulogic;
            vsync : out std_ulogic
        );
    end component;

begin

    clk_signal <= clk;

    hsync_inst : hsync
        Port map (
            clk => clk_signal, 
            hreset => hreset, 
            hsync => hsync_out
        );

    vsync_inst : vsync
        Port map (
            clk => hreset, 
            vsync => vsync_out
        );
    
end pong_game;