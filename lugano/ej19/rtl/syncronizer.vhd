library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity syncronizer is
    generic
    (
        W : natural :=3
    );
    port 
    (
        clk : in std_logic;
        rst : in std_logic; --async reset
        da  : in std_logic_vector(W-1 downto 0); --async input
        ds : out std_logic_vector(W-1 downto 0) --sync output
    );
end syncronizer ; 

architecture arch of syncronizer is
    signal q_reg, q_next : std_logic_vector(W-1 downto 0);
    constant zeros : std_logic_vector(W-1 downto 0) :=(others =>'0');

begin   
    process(rst, clk)
    begin
        if (rst = '1') then
            q_reg<=zeros;
        elsif (rising_edge(clk)) then
            q_reg<=q_next;
        end if;
    end process;
    
    q_next<=da;
    ds<=q_reg;

end architecture;
