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

architecture rtl of mux2to1 is
    begin
        y<= x1 when (s= '1') else x2;
    end architecture rtl;