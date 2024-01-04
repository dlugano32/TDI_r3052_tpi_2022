library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity logic_unit is
    generic
    (
        W:  natural :=8
    );
    port 
    (
        x1, x2 ,x3 ,x4  : in    std_logic_vector(W-1 downto 0);
        sel             : in    std_logic;
        opcode          : in    std_logic_vector(2 downto 0);
        y               : out   std_logic_vector(w-1 downto 0)
    ) ;
end logic_unit ; 

architecture arch of logic_unit is 
    signal  sel0, sel1 :  std_logic_vector(W-1 downto 0);
begin
    with opcode select
    sel0<=  x2              when "000",
            (x2 and x4)     when "001",
            (x2 or x4)      when "010",
            (x2 xor x4)     when "011",
            (not x2)        when "100",
            (x2 nand x4)    when "101",
            (x2 nor x4)     when "110",
            (x2 xnor x4)     when others;

    with opcode select
    sel1<=  x1              when "000",
            (x1 and x3)     when "001",
            (x1 or x3)      when "010",
            (x1 xor x3)     when "011",
            (not x1)        when "100",
            (x1 nand x3)    when "101",
            (x1 nor x3)     when "110",
            (x1 xnor x3)     when others;

    y<= sel0 when (sel='0') else sel1; 

end architecture ;