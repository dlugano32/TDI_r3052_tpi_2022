library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity barrel_shifter is
  port 
  (
    x   : in    std_logic_vector(7 downto 0);
    dir : in    std_logic;
    amt : in    std_logic_vector(2 downto 0);
    y   : out   std_logic_vector(7 downto 0)
  ) ;
end barrel_shifter ; 

architecture arch of barrel_shifter is
    signal sh_l, sh_r   : std_logic_vector(7 downto 0);
    constant zeros      : std_logic_vector(6 downto 0):= (others => '0'); 
begin

    with amt select
    sh_l<=  (x(0) & zeros) when "111",
            (x(1 downto 0 ) & zeros(5 downto 0 )) when "110",
            (x(2 downto 0 ) & zeros(4 downto 0 )) when "101",
            (x(3 downto 0 ) & zeros(3 downto 0 )) when "100",
            (x(4 downto 0 ) & zeros(2 downto 0 )) when "011",
            (x(5 downto 0 ) & zeros(1 downto 0 )) when "010",
            (x(6 downto 0 ) & '0')                when "001",
            x when others;

    with amt select        
    sh_r<=  (zeros & x(0)) when "111",
            (zeros(5 downto 0 ) & x(1 downto 0 )) when "110",
            (zeros(4 downto 0 ) & x(2 downto 0 )) when "101",
            (zeros(3 downto 0 ) & x(3 downto 0 )) when "100",
            (zeros(2 downto 0 ) & x(4 downto 0 )) when "011",
            (zeros(1 downto 0 ) & x(5 downto 0 )) when "010",
            ('0' & x(6 downto 0))           when "001",
            x when others;

    y<= sh_l when (dir='0') else sh_r;
end architecture ;
