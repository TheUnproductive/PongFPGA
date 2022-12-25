library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pong_board is
    Port (
        clk : in std_ulogic;
        hsync_out : out std_ulogic;
        vsync_out : out std_ulogic
    );
end pong_board;

architecture pong_game of pong_board is

    signal clk_signal : std_ulogic;
    signal hreset : std_ulogic;

    signal hsync_signal : std_ulogic;
    signal vsync_signal : std_ulogic;

    component hsync is
        Port (
            clk : in std_ulogic;
            hsync_output : out std_ulogic;
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

    hsync_out <= hsync_signal;
    vsync_out <= vsync_signal;

    hsync_inst : hsync
        Port map (
            clk => clk_signal, 
            hreset => hreset, 
            hsync_output => hsync_signal
        );

    vsync_inst : vsync
        Port map (
            clk => hreset, 
            vsync => vsync_signal
        );
    
end pong_game;