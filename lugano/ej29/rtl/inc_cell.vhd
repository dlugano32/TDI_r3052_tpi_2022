library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity inc_cell is
  port 
  (
    a, ci: in std_logic;
    o, co: out std_logic
  ) ;
end inc_cell ; 

architecture arch of inc_cell is

begin
  o<=  a xor ci;
  co<= a and ci;
end architecture ;