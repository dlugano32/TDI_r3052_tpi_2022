LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;

package random_stim_pkg is

   shared variable seed_1 : integer := 844396720;  -- uniform procedure seed1
   shared variable seed_2 : integer := 821616997;  -- uniform procedure seed2

   impure function random_int(
      constant lower_value : in integer;
      constant upper_value : in integer
   )
      return integer;

   impure function random_vector(
      constant size : in integer
   )
      return STD_LOGIC_VECTOR;

   impure function random_bit
      return STD_LOGIC;

end random_stim_pkg;

-------------------------------------------------------------------------------
-- begin of package
package body random_stim_pkg is

   impure function random_int(constant lower_value : in integer;
                              constant upper_value : in integer) return integer is
      variable result   : integer;
      variable tmp_real : real;
   begin
      uniform(seed_1, seed_2, tmp_real);
      result := integer(trunc((tmp_real * real(upper_value - lower_value + 1)) + real(lower_value)));
      return result;
   end random_int;

   impure function random_vector(constant size : in integer) 
      return STD_LOGIC_VECTOR is
      variable tmp_int : integer;
   begin
      tmp_int := random_int(0, 2**size-1);
      return std_logic_vector(to_unsigned(tmp_int,size));
   end random_vector;

   impure function random_bit
      return STD_LOGIC is
      variable tmp_int : integer;
   begin
      tmp_int := random_int(0, 1);
      if (tmp_int = 0) then
         return '0';
      else
         return '1';
      end if;
   end random_bit;

end package body random_stim_pkg;
