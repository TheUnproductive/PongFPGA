library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hsync is
    Port(
        clk : in std_ulogic;
        hsync_out : out std_ulogic;
        hreset_out : out std_ulogic;
        hreset_n_out : out std_ulogic;
        hblanking : out std_ulogic;
        hblanking_n : out std_ulogic;
        hsync_count : out std_ulogic_vector(8 downto 0)
    );
end hsync;

architecture hsync_gen of hsync is

    signal hsync_count_reg : std_ulogic_vector(8 downto 0);
    signal clk_signal : std_ulogic;
    signal hsync_signal : std_ulogic;
    signal hreset_signal : std_ulogic;
    signal hreset_n_signal : std_ulogic;
    signal hblanking_signal : std_ulogic;
    signal hblanking_n_signal : std_ulogic;

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
    signal hblanking_n_data : std_ulogic;
    signal hblanking_data : std_ulogic;
    signal hblanking_temp_n : std_ulogic;
    signal reset_flipflop_data_n : std_ulogic;

begin

    clk_signal <= clk;
    hsync_out <= not hsync_signal;
    hreset_out <= hreset_signal;
    hreset_n_out <= hreset_n_signal;
    hblanking <= hblanking_signal;
    hblanking_n <= hblanking_n_signal;
    hsync_count <= hsync_count_reg;

    counter1 : counter
    Port Map(
        clk => clk_signal,
        reset => hreset_signal,
        count => hsync_count_reg(3 downto 0)
    );

    counter2 : counter
    Port Map(
        clk => hsync_count_reg(3),
        reset => hreset_signal,
        count => hsync_count_reg(7 downto 4)
    );

    flipflop1 : ff_jk
    Port Map(
        clk => hsync_count_reg(7),
        j => '1',
        k => '1',
        ena => '1',
        clrn => hreset_n_signal,
        prn => hreset_n_signal,
        q => hsync_count_reg(8)
    );

    reset_flipflop_data <= hsync_count_reg(8) and hsync_count_reg(1) and hsync_count_reg(2) and hsync_count_reg(6) and hsync_count_reg(7);
    reset_flipflop_data_n <= not reset_flipflop_data;

    flipflop2 : ff_d
    Port Map(
        Q => hreset_n_signal,
        Clk => clk_signal,
        D => reset_flipflop_data_n
    );

    hreset_signal <= not hreset_n_signal;

    hblanking_signal <= hblanking_data;
    hblanking_n_signal <= hblanking_n_data;

    hblanking_temp_n <= hsync_count_reg(6) and hsync_count_reg(4);

    hblanking_n_data <= (not hblanking_temp_n) or (not hblanking_signal);
    hblanking_data <= (not hreset_n_signal) or (not hblanking_n_data);

    hsync_signal <= hsync_count_reg(5) nand hblanking_data;

end hsync_gen;