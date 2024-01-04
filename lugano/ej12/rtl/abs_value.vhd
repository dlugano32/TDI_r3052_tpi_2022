library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity abs_value is
    generic
    (
        W : natural :=8
    );
    port
    (
        x       : in    std_logic_vector(W-1 downto 0);
        ctrl    : in    std_logic;
        y       : out   std_logic_vector(W-1 downto 0)
    );
end abs_value ; 

architecture arch of abs_value is
    signal SyM, Ca2: std_logic_vector(W-1 downto 0);
    signal Ca2_u : unsigned(W-1 downto 0);
begin
    
    Ca2_u<= unsigned(not(x)) + 1;

    Ca2<= x when (x(W-1)='0') else std_logic_vector(Ca2_u);

    SyM<='0' & x(W-2 downto 0);

    y<= SyM when (ctrl='0') else Ca2;
end architecture;