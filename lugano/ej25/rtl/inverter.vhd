library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity inverter is
  port 
  (
    clk, rst, en: in std_logic;
    q : out std_logic_vector(5 downto 0)
  );
end inverter ; 

architecture arch of inverter is
    signal q_reg, q_next: std_logic_vector(5 downto 0);
begin
    process(rst, clk)
    begin
        if(rst = '1') then
            q_reg<="110001"; --Valor en el cual comienzan los registros
        elsif (rising_edge(clk)) then
            q_reg<=q_next;
        end if;        
    end process;

    q_next(0)<=q_reg(5) when (en='1') else q_reg(0);
    q_next(1)<=q_reg(0) when (en='1') else q_reg(1);
    q_next(2)<=q_reg(1) when (en='1') else q_reg(2);
    q_next(3)<=q_reg(2) when (en='1') else q_reg(3);
    q_next(4)<=q_reg(3) when (en='1') else q_reg(4);
    q_next(5)<=q_reg(4) when (en='1') else q_reg(5);

    q<=q_reg;

end architecture ;