library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

--lfsr de W=3 y M=2^w -1

entity lfsr_counter is
    port 
    (
        clk, rst, en : in std_logic;
        q : out std_logic(2 downto 0);
    );
end lfsr_counter ; 

architecture arch of lfsr_counter is
    signal q_next, q_reg : std_logic_vector(2 downto 0);
begin
    process(rst, clk)
    begin
        if (rst='1') then
            q_reg<="001"    --Elijo como valor de reset el primer numero de la secuencia ya que 000 es una secuencia espuria
        elsif (rising_edge(clk)) then
        q_reg<=q_next;
        end if;
    end process;

    q_next(0)<=q_reg(0) when (en='0') else (q_reg(2) xor q_reg(1));
    q_next(1)<=q_reg(1) when (en='0') else q_reg(0);
    q_next(2)<=q_reg(2) when (en='0') else q_reg(1);

    q<=q_reg;
end architecture;