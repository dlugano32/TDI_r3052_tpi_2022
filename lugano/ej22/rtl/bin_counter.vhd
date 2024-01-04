library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity bin_counter is
    generic
    (
        W: natural :=8
    );
    port 
    (
        clk, rst, en, ld : in std_logic;
        d : in std_logic_vector(W-1 downto 0);
        tc : out std_logic;
        q : out std_logic_vector(W-1 downto 0)
    );
end bin_counter ; 

architecture arch of bin_counter is
    signal q_reg, q_next, cont: std_logic_vector(W-1 downto 0);
    signal op_u : unsigned(W-1 downto 0);
    constant rst_value : std_logic_vector(W-1 downto 0) := (others => '0');
    constant tc_value  : std_logic_vector(W-1 downto 0) := (others => '1');
begin
    process(rst, clk)
    begin
        if(rst = '1') then
            q_reg<=rst_value;
        elsif(rising_edge(clk)) then
            q_reg<=q_next;

        end if;
    end process;
    
    op_u<=unsigned(q_reg);
    cont<=std_logic_vector(op_u+1);
    q_next<=    q_reg when (en='0') else
                cont when  (ld='0') else 
                d;

    tc<= '1' when (q_reg=tc_value) else '0';

    q<=q_reg;


end architecture ;
