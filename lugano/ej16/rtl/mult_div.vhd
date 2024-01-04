library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity mult_div is
  port 
  (
    x       : in std_logic_vector(7 downto 0);
    factor  : in std_logic_vector(1 downto 0);
    op      : in std_logic;
    y       : out std_logic_vector(10 downto 0)
  );
end mult_div ; 

architecture arch of mult_div is
    signal  mult, div   : std_logic_vector(10 downto 0);

    constant zeros      : std_logic_vector(6 downto 0):= (others => '0'); 
begin

    with factor select
    mult<=  (zeros(2 downto 0) & x)         when "00",
            (zeros(1 downto 0) & x & '0')   when "01",
            ('0' & x & zeros(1 downto 0 ))  when "10",
            (x & zeros(2 downto 0 ))        when others;

    with factor select        
    div<=   (zeros(2 downto 0) & x)                 when "00",
            (zeros(3 downto 0) & x(7 downto 1))     when "01",
            (zeros(4 downto 0) & x(7 downto 2))     when "10",
            (zeros(5 downto 0) & x(7 downto 3))     when others;

    y<= mult when (op='0') else div;

end architecture ;