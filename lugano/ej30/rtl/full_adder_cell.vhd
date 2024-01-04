library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity full_adder_cell is
  port 
  (
    a, b, ci   : in std_logic;
    o, co   : out std_logic
  );
end full_adder_cell ; 

architecture arch of full_adder_cell is

begin

    co<= (a and b) or (ci and b) or (ci and a);
    o<= a xor b xor ci;

end architecture ;