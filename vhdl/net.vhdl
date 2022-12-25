library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity net_calculations is
    Port(
        clk : in std_ulogic;
        vblank : in std_ulogic;
        twofiftysixH : in std_ulogic;
        fourV : in std_ulogic;
        net : out std_ulogic
    );
end net_calculations;

architecture Behavioral of net_calculations is

    signal net_wire : std_ulogic;
    signal qnot_wire : std_ulogic;
    signal q_wire : std_ulogic;
    signal nand_wire : std_ulogic;
    signal k_wire : std_ulogic;

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

begin

    k_wire <= '0';

    flipflop : ff_jk
    Port map(
        clk => clk,
        j => twofiftysixH,
        k => k_wire,
        ena => '1',
        clrn => '1',
        prn => '1',
        q => q_wire
    );

    qnot_wire <= not q_wire;

    nand_wire <= twofiftysixH and qnot_wire;

    net <= nand_wire and not fourV and not vblank;

end Behavioral;
