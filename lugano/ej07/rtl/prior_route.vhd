library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity prior_route is
    generic
    (
        W: natural := 8
    );
    port 
    (
        x1, x2, x3, x4  : in  std_logic_vector(W-1 downto 0);
        c1, c2, c3      : in  std_logic;
        y               : out std_logic_vector(W-1 downto 0)
    );
end prior_route ; 

architecture rtl of prior_route is
begin
        y<= x1 when (c1='1') else
            x2 when (c2='1') else
            x3 when (c3='1') else
            x4;
end architecture rtl;