library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ma4 is
    generic
    (
        W : natural :=8
    );
    port  
    (
        x1, x2, x3, x4: in  std_logic_vector(W-1 downto 0);
        y:  out std_logic_vector(W-1 downto 0)
    );
end ma4 ; 

architecture arch of ma4 is
    signal x1_s, x2_s, x3_s, x4_s : signed(W+1 downto 0);
    signal res, x1_wp2, x2_wp2, x3_wp2, x4_wp2, y_wp2  : std_logic_vector(W+1 downto 0);
    constant zeros  : std_logic_vector(1 downto 0) := (others => '0');
    constant ones   : std_logic_vector(1 downto 0) := (others => '1');
    
begin 
    x1_wp2<=(zeros & x1) when (x1(W-1)='0') else (ones & x1);   --Completo +2 bits con el bit de signo
    x2_wp2<=(zeros & x2) when (x2(W-1)='0') else (ones & x2);
    x3_wp2<=(zeros & x3) when (x3(W-1)='0') else (ones & x3);
    x4_wp2<=(zeros & x4) when (x4(W-1)='0') else (ones & x4);

    x1_s<=signed(x1_wp2);
    x2_s<=signed(x2_wp2);
    x3_s<=signed(x3_wp2);
    x4_s<=signed(x4_wp2);

    res<=std_logic_vector(x1_s+x2_s+x3_s+x4_s);

    with (res(W-1)) select
    y_wp2<= (zeros & res(W+1 downto 2)) when '0',   --Divison x4 teniendo en cuenta si es positivo o negativo
            (ones & res(W+1 downto 2)) when others;
            
    y<= std_logic_vector(y_wp2(W-1 downto 0));

end architecture ;