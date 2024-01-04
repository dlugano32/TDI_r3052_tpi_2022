library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity bin_mod_counter is
    generic
    (
        W : natural :=8
    );
    port 
    (
        clk, rst, en, ld : in std_logic;
        d, max : in std_logic_vector(W-1 downto 0);
        q : out std_logic_vector(W-1 downto 0);
        tc : out std_logic
    );
end bin_mod_counter ; 

architecture arch of bin_mod_counter is
    signal q_reg, q_next, cont : std_logic_vector(W-1 downto 0);
    signal op_u : unsigned(W-1 downto 0);
    signal fc : std_logic;
    constant zeros : std_logic_vector(W-1 downto 0) := (others => '0');

begin
    process(rst, clk)
    begin
        if (rst = '1') then
            q_reg<=zeros;
        elsif (rising_edge(clk)) then
            q_reg<=q_next;
        end if;
    end process ;

    op_u<=unsigned(q_reg);
    cont<=std_logic_vector(op_u+1);
    
    fc<= '1' when (q_reg=max) else '0'; -- Final de cuenta

    q_next<=    q_reg when (en='0') else
                zeros when (fc='1') else 
                cont when (ld='0') else
                d;
    tc<=fc;

    q<=q_reg;

end architecture ;