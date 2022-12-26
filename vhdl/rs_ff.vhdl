library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity rs_ff is
    PORT(
        s,r,clk: in std_logic;
        Q, Qnot: out std_logic
    );
end rs_ff;

Architecture behavioral of rs_ff is

begin

    PROCESS(clk)
    variable tmp: std_logic;
    begin
        if(clk='1' and clk'EVENT) then
            if(s='0' and r='0')then
                tmp:=tmp;
            elsif(s='1' and r='1')then
                tmp:='X';
            elsif(s='0' and r='1')then
                tmp:='0';
            else
                tmp:='1';
            end if;
        end if;
        Q <= tmp;
        Qnot <= not tmp;
    end PROCESS;
end behavioral;