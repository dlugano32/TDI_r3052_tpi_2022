library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity mux2to1 is
    generic
    (
        W: natural := 8
    );
    port 
    (
        x1,x2 : in std_logic_vector(W-1 downto 0);
        s :     in std_logic;
        y :     out std_logic_vector(W-1 downto 0)
    );
end mux2to1; 

architecture rtl of mux2to1 is
    signal zero: std_logic_vector(W-1 downto 0);
begin
    zero <= (others => '0');

    with s select
    y<= x2 when '0',
        x1 when '1',
        zero when others;   --No es necesario hacer esto, se puede hacer directamente x1 when others.
end architecture rtl;