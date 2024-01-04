library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity inc_dec_generic is
    generic
    (
        W: natural := 8;
        K: integer := 1
    );
    port 
    (
        x : in  std_logic_vector(W-1 downto 0);
        m : in  std_logic;
        y : out std_logic_vector(W-1 downto 0);
        c : out std_logic
    ) ;
end inc_dec_generic ; 

architecture arch of inc_dec_generic is
    signal u : unsigned(W downto 0);
    signal Ku : unsigned(W-1 downto 0);
begin
    Ku<= to_unsigned(K,W);

    u<= (('0' & unsigned(x)) +Ku) when (m='0') else
        (('1' & unsigned(x)) -Ku);
    
    c<= std_logic(u(W)) when (m='0') else
        std_logic(not u(W));

    y<= std_logic_vector(u(W-1 downto 0));
end architecture ;