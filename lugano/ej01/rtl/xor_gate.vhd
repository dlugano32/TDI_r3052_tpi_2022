library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
    port 
    (
        x1 : in std_logic;
        x2 : in std_logic;
        y : out std_logic
    )   ;
end xor_gate;

architecture gates of xor_gate is
    begin
        y<= ( ( x1 and (not(x2)) ) or (not(x1) and x2) );
    end architecture gates;