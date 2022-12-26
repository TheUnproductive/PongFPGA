library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pong_tb is
end pong_tb;

architecture testbench of pong_tb is

    signal clk : std_ulogic := '0';
    signal hsync_tb : std_ulogic;
    signal hreset_tb : std_ulogic;
    signal vsync_tb : std_ulogic;

    signal hsync_count : std_ulogic_vector(8 downto 0);
    signal hblanking : std_ulogic;
    signal hblanking_n : std_ulogic;

    signal vsync_count : std_ulogic_vector(8 downto 0);

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
            hsync_n_out : out std_ulogic;
            hreset_out : out std_ulogic;
            hreset_n_out : out std_ulogic;
            hblanking : out std_ulogic;
            hblanking_n : out std_ulogic;
            hsync_count : out std_ulogic_vector(8 downto 0)
        );
    end component;

    component vsync is
    Port(
        clk : in std_ulogic;
        vsync_out : out std_ulogic;
        vreset_out : out std_ulogic;
        vreset_n_out : out std_ulogic;
        vblanking : out std_ulogic;
        vblanking_n : out std_ulogic;
        vsync_count : out std_ulogic_vector(8 downto 0)
    );
    end component;

begin

    -- uut : pong port map(
    --     clk => clk,
    --     hsync_out => hsync_tb,
    --     vsync_out => vsync_tb
    -- );

    hsync_test : hsync 
    port map(
        clk => clk,
        hsync_n_out => hsync_tb,
        hreset_out => hreset_tb,
        hreset_n_out => open,
        hblanking => hblanking,
        hblanking_n => hblanking_n,
        hsync_count => hsync_count
    );

    vsync_test : vsync 
    port map(
        clk => hreset_tb,
        vsync_out => vsync_tb,
        vreset_out => open,
        vreset_n_out => open,
        vblanking => open,
        vblanking_n => open,
        vsync_count => vsync_count
    );

    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

end testbench;