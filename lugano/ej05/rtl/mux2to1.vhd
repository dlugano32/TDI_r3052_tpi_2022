library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
    port
    (
        x1 : in std_logic;
        x2 : in std_logic;
        s  : in std_logic;
        y  : out std_logic
    );
end mux2to1;

architecture sel_arch of mux2to1 is
    begin
        with s select
        y<= x2 when '0',
            x1 when '1', 
		'0' when others;
    end sel_arch;