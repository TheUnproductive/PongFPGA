-- FPGA projects using VHDL/ VHDL 
-- fpga4student.com
-- VHDL code for D Flip FLop
-- VHDL code for rising edge D flip flop 
Library IEEE;
USE IEEE.Std_logic_1164.all;
-- Test
entity ff_d is 
    port(
        Q : out std_ulogic;    
        Clk :in std_ulogic;   
        D :in  std_ulogic    
    );
end ff_d;

architecture Behavioral of ff_d is  

begin  

    process(Clk)
    begin 
        if(rising_edge(Clk)) then
            Q <= D; 
        end if;       
    end process;  

end Behavioral; 