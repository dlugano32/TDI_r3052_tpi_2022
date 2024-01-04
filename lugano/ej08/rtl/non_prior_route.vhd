library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity non_prior_route is
    generic
    (
        W: natural := 8
    );
    port 
    (
        x1, x2, x3, x4  : in  std_logic_vector(W-1 downto 0);
        s               : in std_logic_vector(1 downto 0);
        y               : out std_logic_vector(W-1 downto 0)        
    ) ;
end non_prior_route ; 

architecture rtl of non_prior_route is
begin
        with s select
        y<= x1 when "00",
            x2 when "01",
            x3 when "10",
            x4 when others;
end architecture rtl;