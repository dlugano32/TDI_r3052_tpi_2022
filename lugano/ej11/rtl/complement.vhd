library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity complement is
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
end complement; 

architecture arch of complement is
    signal u_x, u_y : unsigned(W-1 downto 0);
begin
    u_x<= unsigned(x);

    u_y<= ( not(u_x) ) when (ctrl = '0') else (not(u_x) +1);

    y<= std_logic_vector(u_y);
end architecture ;