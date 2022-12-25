library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vsync is
    Port(
        clk : in std_ulogic;
        vsync_out : out std_ulogic;
        vreset_out : out std_ulogic;
        vreset_n_out : out std_ulogic;
        vblanking : out std_ulogic;
        vblanking_n : out std_ulogic;
        vsync_count : out std_ulogic_vector(8 downto 0)
    );
end vsync;

-- implement a vsync signal generator 
architecture vsync_gen of vsync is

    signal vsync_count_reg : std_ulogic_vector(8 downto 0);
    signal clk_signal : std_ulogic;
    signal vsync_signal : std_ulogic;
    signal vreset_signal : std_ulogic;
    signal vreset_n_signal : std_ulogic;
    signal vblanking_signal : std_ulogic;
    signal vblanking_n_signal : std_ulogic;

    component counter is
    Port(
        clk : in std_ulogic;
        reset : in std_ulogic;
        count : out std_ulogic_vector(3 downto 0)
    );
    end component;

    component ff_jk is
        Port(
            clk : in std_ulogic;
            j : in std_ulogic;
            k : in std_ulogic;
            ena  : in  std_ulogic;
            clrn : in  std_ulogic;
            prn  : in  std_ulogic;
            q : out std_ulogic
        );
    end component;

    component ff_d is
        Port(
            Q : out std_ulogic;    
            Clk :in std_ulogic;   
            D :in  std_ulogic  
        );
    end component;

    signal reset_flipflop_data : std_ulogic;
    signal vblanking_n_data : std_ulogic;
    signal vblanking_data : std_ulogic;
    signal reset_flipflop_data_n : std_ulogic;

begin

    clk_signal <= clk;
    vsync_out <= vsync_signal;
    vreset_out <= vreset_signal;
    vreset_n_out <= vreset_n_signal;
    vblanking <= vblanking_signal;
    vblanking_n <= vblanking_n_signal;
    vsync_count <= vsync_count_reg;

    counter1 : counter
    Port map(
        clk => clk_signal,
        reset => vreset_signal,
        count => vsync_count_reg(3 downto 0)
    );

    counter2 : counter
    Port map(
        clk => clk_signal,
        reset => vreset_signal,
        count => vsync_count_reg(7 downto 4)
    );

    flipflop1 : ff_jk
    Port map(
        clk => vsync_count_reg(7),
        j => '1',
        k => '1',
        ena => '1',
        clrn => vreset_n_signal,
        prn => vreset_n_signal,
        q => vsync_count_reg(8)
    );
    
    reset_flipflop_data <= vsync_count_reg(8) and vsync_count_reg(2) and vsync_count_reg(0);
    reset_flipflop_data_n <= not reset_flipflop_data;

    flipflop2 : ff_d
    Port map(
        Q => vreset_n_signal,
        Clk => clk_signal,
        D => reset_flipflop_data_n
    );

    vreset_signal <= not vreset_n_signal;

    vblanking_signal <= vblanking_data;
    vblanking_n_signal <= vblanking_n_data;

    vblanking_n_data <= not vreset_signal and not vblanking_signal;
    vblanking_data <= not vblanking_n_signal and not vsync_count_reg(4);

    vsync_signal <= vblanking_signal and vsync_count_reg(2) and not vsync_count_reg(3);

end vsync_gen;