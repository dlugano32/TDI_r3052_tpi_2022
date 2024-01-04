LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;

package gldn_mdl_pkg is

   ----------------------------------------------------------------------------
   -- useful functions
   ----------------------------------------------------------------------------
   function inc(x: std_logic_vector)
      return std_logic_vector;

   function dec(x: std_logic_vector)
      return std_logic_vector;

   function ca2(x: std_logic_vector)
      return std_logic_vector;

   function f_abs(x: std_logic_vector; format: integer)
      return std_logic_vector;

   procedure gldn_route_src (
      constant i_r0        : in  std_logic_vector(15 downto 0);
      constant i_r1        : in  std_logic_vector(15 downto 0);
      constant i_r2        : in  std_logic_vector(15 downto 0);
      constant i_r3        : in  std_logic_vector(15 downto 0);
      constant i_const     : in  std_logic_vector(15 downto 0);
      constant i_sel_src1  : in  std_logic_vector (1 downto 0);
      constant i_sel_src2  : in  std_logic_vector (1 downto 0);
      constant i_const_en  : in  std_logic                    ;
      signal   o_op1       : out std_logic_vector(15 downto 0);
      signal   o_op2       : out std_logic_vector(15 downto 0)
   );

   procedure gldn_route_dest (
      constant i_data      : in  std_logic_vector(15 downto 0);
      constant i_const     : in  std_logic_vector(15 downto 0);
      constant i_sel_dest  : in  std_logic_vector (1 downto 0);
      constant i_const_en  : in  std_logic                    ;
      signal   o_data      : out std_logic_vector(15 downto 0);
      signal   o_ld        : out std_logic_vector (3 downto 0)
   );

   procedure gldn_logic_unit (
      constant i_op1       : in  std_logic_vector(15 downto 0);
      constant i_op2       : in  std_logic_vector(15 downto 0);
      constant i_opcode    : in  std_logic_vector (3 downto 0);
      signal   o_result    : out std_logic_vector(15 downto 0)
   );

   procedure gldn_arith_unit (
      constant i_op1       : in  std_logic_vector(15 downto 0);
      constant i_op2       : in  std_logic_vector(15 downto 0);
      constant i_opcode    : in  std_logic_vector (3 downto 0);
      signal   o_result    : out std_logic_vector(15 downto 0);
      signal   o_flags     : out std_logic_vector (3 downto 0)
   );

   procedure gldn_reg_map    (
      constant i_en         : in    std_logic;
      constant i_srst       : in    std_logic;
      constant i_data       : in    std_logic_vector(15 downto 0);
      constant i_ld_en      : in    std_logic_vector (3 downto 0);
      signal   exp_o_r0     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r1     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r2     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r3     : inout std_logic_vector(15 downto 0)
   );

   procedure gldn_pc_counter (
      constant i_en          : in    std_logic;
      constant i_srst        : in    std_logic;
      constant i_jump_e      : in    std_logic;
      constant i_cond_e      : in    std_logic;
      constant i_jump_sel    : in    std_logic_vector(1 downto 0);
      constant i_cond_vec    : in    std_logic_vector(3 downto 0);
      constant i_const_addr  : in    std_logic_vector(7 downto 0);
      signal   exp_o_pc_addr : inout std_logic_vector(7 downto 0)
   );

   procedure gldn_ej_01_07 (
      constant x1 : in  std_logic_vector;
      constant x2 : in  std_logic_vector;
      constant x3 : in  std_logic_vector;
      constant x4 : in  std_logic_vector;
      constant c1 : in  std_logic;
      constant c2 : in  std_logic;
      constant c3 : in  std_logic;
      signal   y  : out std_logic_vector
   );

   procedure gldn_ej_01_08 (
      constant x1 : in  std_logic_vector;
      constant x2 : in  std_logic_vector;
      constant x3 : in  std_logic_vector;
      constant x4 : in  std_logic_vector;
      constant s  : in  std_logic_vector(1 downto 0);
      signal   y  : out std_logic_vector
   );

   procedure gldn_ej_01_09 (
      constant x1     : in  std_logic_vector;
      constant x2     : in  std_logic_vector;
      constant x3     : in  std_logic_vector;
      constant x4     : in  std_logic_vector;
      constant s      : in  std_logic;
      constant opcode : in  std_logic_vector(2 downto 0);
      signal   y      : out std_logic_vector
   );

   procedure gldn_ej_02_02 (
      constant x    : in  std_logic_vector;
      constant ctrl : in  std_logic;
      signal   y    : out std_logic_vector
   );

   procedure gldn_ej_02_03 (
      constant x    : in  std_logic_vector;
      constant ctrl : in  std_logic;
      signal   y    : out std_logic_vector
   );

   procedure gldn_ej_02_04 (
      constant x    : in  std_logic_vector;
      constant dir  : in  std_logic;
      constant amt  : in  std_logic_vector;
      signal   y    : out std_logic_vector
   );

   procedure gldn_ej_02_05 (
      constant x1   : in  std_logic_vector;
      constant x2   : in  std_logic_vector;
      constant x3   : in  std_logic_vector;
      constant x4   : in  std_logic_vector;
      signal   y    : out std_logic_vector
   );

   procedure gldn_ej_02_06 (
      constant bin      : in    std_logic_vector;
      constant acc_curr : in    std_logic_vector;
      constant mode     : in    std_logic;
      signal   acc_next : out   std_logic_vector;
      signal   sat      : out   std_logic
   );

   procedure gldn_ej_02_07 (
      constant x      : in    std_logic_vector;
      constant factor : in    std_logic_vector;
      constant op     : in    std_logic;
      signal   y      : out   std_logic_vector
   );

   procedure gldn_ej_02_08 (
      constant x      : in    std_logic_vector(3 downto 0);
      signal   o_sqrt : out   std_logic_vector(3 downto 0);
      signal   o_rem  : out   std_logic_vector(3 downto 0)
   );

   procedure gldn_ej_03_01  (
      constant i_en         : in    std_logic;
      constant i_srst       : in    std_logic;
      constant i_flags      : in    std_logic_vector(3 downto 0);
      constant i_ld_en      : in    std_logic;
      signal   exp_o_flags  : inout std_logic_vector(3 downto 0)
   );

   procedure gldn_ej_03_03    (
      constant i_en         : in    std_logic;
      constant i_srst       : in    std_logic;
      constant i_data       : in    std_logic_vector(15 downto 0);
      constant i_address    : in    std_logic_vector (2 downto 0);
      signal   exp_o_r0     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r1     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r2     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r3     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r4     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r5     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r6     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r7     : inout std_logic_vector(15 downto 0)
   );

end gldn_mdl_pkg;

-------------------------------------------------------------------------------
-- begin of package
package body gldn_mdl_pkg is

   ----------------------------------------------------------------------------
   -- useful functions
   ----------------------------------------------------------------------------
   function inc(x: std_logic_vector)
      return std_logic_vector is
   begin
      return std_logic_vector(unsigned(x) + 1);
   end inc;

   function dec(x: std_logic_vector)
      return std_logic_vector is
   begin
      return std_logic_vector(unsigned(x) - 1);
   end dec;

   function ca2(x: std_logic_vector)
      return std_logic_vector is
   begin
      return std_logic_vector(unsigned(not(x)) + 1);
   end ca2;

   function f_abs(x: std_logic_vector; format: integer)
      return std_logic_vector is
   begin
      if (format = 0) then
         return ('0' & x(6 downto 0));
      elsif (x(7) = '0') then
         return ('0' & x(6 downto 0));
      else
         return (inc(not(x)));
      end if;
   end f_abs;

   ----------------------------------------------------------------------------
   -- procedure
   ----------------------------------------------------------------------------
   procedure gldn_route_src (
      constant i_r0        : in  std_logic_vector(15 downto 0);
      constant i_r1        : in  std_logic_vector(15 downto 0);
      constant i_r2        : in  std_logic_vector(15 downto 0);
      constant i_r3        : in  std_logic_vector(15 downto 0);
      constant i_const     : in  std_logic_vector(15 downto 0);
      constant i_sel_src1  : in  std_logic_vector (1 downto 0);
      constant i_sel_src2  : in  std_logic_vector (1 downto 0);
      constant i_const_en  : in  std_logic                    ;
      signal   o_op1       : out std_logic_vector(15 downto 0);
      signal   o_op2       : out std_logic_vector(15 downto 0)
   ) is
   begin
      if (i_sel_src1 = "00") then
         o_op1 <= i_r0;
      elsif (i_sel_src1 = "01") then
         o_op1 <= i_r1;
      elsif (i_sel_src1 = "10") then
         o_op1 <= i_r2;
      elsif (i_sel_src1 = "11") then
         o_op1 <= i_r3;
      else
         o_op1 <= (others => '0');
      end if;

      if (i_const_en = '1') then
         o_op2 <= i_const;
      elsif (i_sel_src2 = "00") then
         o_op2 <= i_r0;
      elsif (i_sel_src2 = "01") then
         o_op2 <= i_r1;
      elsif (i_sel_src2 = "10") then
         o_op2 <= i_r2;
      elsif (i_sel_src2 = "11") then
         o_op2 <= i_r3;
      else
         o_op1 <= (others => '0');
      end if;
   end procedure gldn_route_src;

   ----------------------------------------------------------------------------
   -- procedure
   ----------------------------------------------------------------------------
   procedure gldn_route_dest (
      constant i_data      : in  std_logic_vector(15 downto 0);
      constant i_const     : in  std_logic_vector(15 downto 0);
      constant i_sel_dest  : in  std_logic_vector (1 downto 0);
      constant i_const_en  : in  std_logic                    ;
      signal   o_data      : out std_logic_vector(15 downto 0);
      signal   o_ld        : out std_logic_vector (3 downto 0)
   ) is
   begin
      if (i_sel_dest = "00") then
         o_ld <= "0001";
      elsif (i_sel_dest = "01") then
         o_ld <= "0010";
      elsif (i_sel_dest = "10") then
         o_ld <= "0100";
      elsif (i_sel_dest = "11") then
         o_ld <= "1000";
      end if;
      if (i_const_en = '1') then
         o_data <= i_const;
      else
         o_data <= i_data;
      end if;
   end procedure gldn_route_dest;

   ----------------------------------------------------------------------------
   -- procedure
   ----------------------------------------------------------------------------
   procedure gldn_logic_unit (
      constant i_op1       : in  std_logic_vector(15 downto 0);
      constant i_op2       : in  std_logic_vector(15 downto 0);
      constant i_opcode    : in  std_logic_vector (3 downto 0);
      signal   o_result    : out std_logic_vector(15 downto 0)
   ) is
   begin
      if (i_opcode = "0000") then
         o_result <= i_op1;
      elsif (i_opcode = "0001") then
         o_result <= i_op1;
      elsif (i_opcode = "0010") then
         o_result <= (i_op1 and i_op2);
      elsif (i_opcode = "0011") then
         o_result <= (i_op1 or  i_op2);
      elsif (i_opcode = "0100") then
         o_result <= (i_op1 xor i_op2);
      elsif (i_opcode = "0101") then
         o_result <= (not i_op1);
      elsif (i_opcode = "0110") then
         o_result <= (i_op1(14 downto 0) & '0');
      elsif (i_opcode = "0111") then
         o_result <= ('0' & i_op1(15 downto 1));
      else
         o_result <= i_op1;
      end if;
   end procedure gldn_logic_unit;

   ----------------------------------------------------------------------------
   -- procedure
   ----------------------------------------------------------------------------
   procedure gldn_arith_unit (
      constant i_op1       : in  std_logic_vector(15 downto 0);
      constant i_op2       : in  std_logic_vector(15 downto 0);
      constant i_opcode    : in  std_logic_vector (3 downto 0);
      signal   o_result    : out std_logic_vector(15 downto 0);
      signal   o_flags     : out std_logic_vector (3 downto 0)
   ) is
      variable sum   : signed(15 downto 0);
      variable sub   : signed(15 downto 0);
      variable v_add : std_logic;
      variable v_sub : std_logic;
   begin
      sum   := signed(i_op1) + signed(i_op2);
      sub   := signed(i_op1) - signed(i_op2);
      v_add := (    sum(15)  and not(i_op2(15)) and not(i_op1(15))) or
               (not(sum(15)) and     i_op2(15)  and     i_op1(15) ) ;
      v_sub := (    sub(15)  and     i_op2(15)  and not(i_op1(15))) or
               (not(sub(15)) and not(i_op2(15)) and     i_op1(15) ) ;

      case (i_opcode) is
         when "1000"|"1001" =>
            o_result <= std_logic_vector(sum);
            if (sum = 0) then
               o_flags(0) <= '1';
            else
               o_flags(0) <= '0';
            end if;
            o_flags(1) <= sum(15);
            o_flags(2) <= '0';
            o_flags(3) <= v_add;
         when "1010"|"1011" =>
            o_result <= std_logic_vector(sub);
            if (sub = 0) then
               o_flags(0) <= '1';
            else
               o_flags(0) <= '0';
            end if;
            o_flags(1) <= sub(15);
            o_flags(2) <= '0';
            o_flags(3) <= v_sub;
         when "1100"|"1101" =>
            o_result   <= (others => '0');
            o_flags(0) <= '0';
            o_flags(1) <= '0';
            if (i_op1 = i_op2) then
               o_flags(2) <= '1';
            else
               o_flags(2) <= '0';
            end if;
            o_flags(3) <= '0';
         when "1110"|"1111" =>
            o_result   <= (others => '0');
            o_flags    <= (others => '0');
         when others        =>
            o_result   <= (others => '0');
            o_flags    <= (others => '0');
      end case;
   end procedure gldn_arith_unit;

   ----------------------------------------------------------------------------
   -- procedure
   ----------------------------------------------------------------------------
   procedure gldn_reg_map    (
      constant i_en         : in    std_logic;
      constant i_srst       : in    std_logic;
      constant i_data       : in    std_logic_vector(15 downto 0);
      constant i_ld_en      : in    std_logic_vector (3 downto 0);
      signal   exp_o_r0     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r1     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r2     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r3     : inout std_logic_vector(15 downto 0)
   ) is
   begin
      if (i_en = '1') then
         if (i_srst = '1') then
            exp_o_r0 <= (others => '0');
            exp_o_r1 <= (others => '0');
            exp_o_r2 <= (others => '0');
            exp_o_r3 <= (others => '0');
         else
            if (i_ld_en(0) = '1') then
               exp_o_r0 <= i_data;
            end if;
            if (i_ld_en(1) = '1') then
               exp_o_r1 <= i_data;
            end if;
            if (i_ld_en(2) = '1') then
               exp_o_r2 <= i_data;
            end if;
            if (i_ld_en(3) = '1') then
               exp_o_r3 <= i_data;
            end if;
         end if;
      end if;
   end procedure gldn_reg_map;

   ----------------------------------------------------------------------------
   -- procedure
   ----------------------------------------------------------------------------
   procedure gldn_pc_counter (
      constant i_en          : in    std_logic;
      constant i_srst        : in    std_logic;
      constant i_jump_e      : in    std_logic;
      constant i_cond_e      : in    std_logic;
      constant i_jump_sel    : in    std_logic_vector(1 downto 0);
      constant i_cond_vec    : in    std_logic_vector(3 downto 0);
      constant i_const_addr  : in    std_logic_vector(7 downto 0);
      signal   exp_o_pc_addr : inout std_logic_vector(7 downto 0)
   ) is
      variable curr_addr : unsigned(7 downto 0);
      variable next_addr : unsigned(7 downto 0);
      variable cond_met  : std_logic;
      variable jump_vec  : std_logic_vector(2 downto 0);
   begin
      case (i_jump_sel) is
         when "00"   => 
            cond_met := i_cond_vec(0);
         when "01"   => 
            cond_met := i_cond_vec(1);
         when "10"   => 
            cond_met := i_cond_vec(2);
         when "11"   => 
            cond_met := i_cond_vec(3);
         when others => 
            cond_met := 'X';
      end case;
      curr_addr := unsigned(exp_o_pc_addr);
      jump_vec  := i_jump_e & i_cond_e & cond_met;
      case (jump_vec) is
         when "111"|"101"|"100" =>
            next_addr := unsigned(i_const_addr);
         when others =>
            next_addr := curr_addr + 1;
      end case;
      if (i_en = '1') then
         if (i_srst = '1') then
            exp_o_pc_addr <= (others => '0');
         else
            exp_o_pc_addr <= std_logic_vector(next_addr);
         end if;
      end if;
   end procedure gldn_pc_counter;

   ----------------------------------------------------------------------------
   -- procedure: ej 01 07 prior route
   ----------------------------------------------------------------------------
   procedure gldn_ej_01_07 (
      constant x1 : in  std_logic_vector;
      constant x2 : in  std_logic_vector;
      constant x3 : in  std_logic_vector;
      constant x4 : in  std_logic_vector;
      constant c1 : in  std_logic;
      constant c2 : in  std_logic;
      constant c3 : in  std_logic;
      signal   y  : out std_logic_vector
   ) is 
   begin
      if (c1 = '1') then
         y <= x1;
      elsif (c2 = '1') then 
         y <= x2;
      elsif (c3 = '1') then
         y <= x3;
      else
         y <= x4;
      end if;
   end procedure gldn_ej_01_07;

   ----------------------------------------------------------------------------
   -- procedure: ej 01 08 non prior route
   ----------------------------------------------------------------------------
   procedure gldn_ej_01_08 (
      constant x1 : in  std_logic_vector;
      constant x2 : in  std_logic_vector;
      constant x3 : in  std_logic_vector;
      constant x4 : in  std_logic_vector;
      constant s  : in  std_logic_vector(1 downto 0);
      signal   y  : out std_logic_vector
   ) is 
   begin
      if (s = "00") then
         y <= x1;
      elsif (s = "01") then 
         y <= x2;
      elsif (s = "10") then
         y <= x3;
      else
         y <= x4;
      end if;
   end procedure gldn_ej_01_08;

   ----------------------------------------------------------------------------
   -- procedure: ej 01 09 logic unit
   ----------------------------------------------------------------------------
   procedure gldn_ej_01_09 (
      constant x1     : in  std_logic_vector;
      constant x2     : in  std_logic_vector;
      constant x3     : in  std_logic_vector;
      constant x4     : in  std_logic_vector;
      constant s      : in  std_logic;
      constant opcode : in  std_logic_vector(2 downto 0);
      signal   y      : out std_logic_vector
   ) is
   begin
      case (opcode) is
         when "000"   => 
            if (s = '0') then 
               y <= x2;
            else
               y <= x1;
            end if;
         when "001"   => 
            if (s = '0') then 
               y <= x2 and x4;
            else
               y <= x1 and x3;
            end if;
         when "010"   => 
            if (s = '0') then 
               y <= x2 or x4;
            else
               y <= x1 or x3;
            end if;
         when "011"   => 
            if (s = '0') then 
               y <= x2 xor x4;
            else
               y <= x1 xor x3;
            end if;
         when "100"   => 
            if (s = '0') then 
               y <= not x2;
            else
               y <= not x1;
            end if;
         when "101"   => 
            if (s = '0') then 
                  y <= x2 nand x4;
            else
               y <= x1 nand x3;
            end if;
         when "110"   => 
            if (s = '0') then 
               y <= x2 nor x4;
            else
               y <= x1 nor x3;
            end if;
         when others => 
            if (s = '0') then 
               y <= x2 xnor x4;
            else
               y <= x1 xnor x3;
            end if;
      end case;
   end procedure gldn_ej_01_09;

   ----------------------------------------------------------------------------
   -- procedure: ej 02 02 complement
   ----------------------------------------------------------------------------
   procedure gldn_ej_02_02 (
      constant x    : in  std_logic_vector;
      constant ctrl : in  std_logic;
      signal   y    : out std_logic_vector
   ) is 
   begin
      if (ctrl='0') then
         y <= not(x);
      else 
         y <= inc(not(x));
      end if;
   end procedure gldn_ej_02_02;

   ----------------------------------------------------------------------------
   -- procedure: ej 02 03 abs_value
   ----------------------------------------------------------------------------
   procedure gldn_ej_02_03 (
      constant x    : in  std_logic_vector;
      constant ctrl : in  std_logic;
      signal   y    : out std_logic_vector
   ) is 
   begin
      if (ctrl='0') then
         y <= f_abs(x,0);
      else
         y <= f_abs(x,1);
      end if;
   end procedure gldn_ej_02_03;

   ----------------------------------------------------------------------------
   -- procedure: ej 02 04 barrel_shifter
   ----------------------------------------------------------------------------
   procedure gldn_ej_02_04 (
      constant x    : in  std_logic_vector;
      constant dir  : in  std_logic;
      constant amt  : in  std_logic_vector;
      signal   y    : out std_logic_vector
   ) is 
   begin
      if (dir = '0') then
         y <= std_logic_vector(shift_left(unsigned(x), to_integer(unsigned(amt))));
      else
         y <= std_logic_vector(shift_right(unsigned(x), to_integer(unsigned(amt))));
      end if;      
   end procedure gldn_ej_02_04;

   ----------------------------------------------------------------------------
   -- procedure: ej 02 05
   ----------------------------------------------------------------------------
   procedure gldn_ej_02_05 (
      constant x1   : in  std_logic_vector;
      constant x2   : in  std_logic_vector;
      constant x3   : in  std_logic_vector;
      constant x4   : in  std_logic_vector;
      signal   y    : out std_logic_vector
   ) is 
      variable sum : signed(9 downto 0);
   begin
      sum := signed(x1(7) & x1(7) & x1) +
             signed(x2(7) & x2(7) & x2) +
             signed(x3(7) & x3(7) & x3) +
             signed(x4(7) & x4(7) & x4) ;
      y   <= std_logic_vector(sum(9 downto 2));
   end procedure gldn_ej_02_05;

   ----------------------------------------------------------------------------
   -- procedure: ej 02 06
   ----------------------------------------------------------------------------
   procedure gldn_ej_02_06 (
      constant bin      : in    std_logic_vector;
      constant acc_curr : in    std_logic_vector;
      constant mode     : in    std_logic;
      signal   acc_next : out   std_logic_vector;
      signal   sat      : out   std_logic
   ) is 
      variable u_sum : unsigned(16 downto 0);
      variable u_bin : unsigned(16 downto 0);
      variable u_acc : unsigned(16 downto 0);
   begin
      u_bin := resize(unsigned(bin),17);
      u_acc := resize(unsigned(acc_curr),17);
      if (mode = '0') then
         u_sum := u_acc + u_bin;
      else
         u_sum := u_acc - u_bin;
      end if;
      if (u_sum >= 2**16) then
         sat      <= '1';
         if (mode = '0') then
            acc_next <= x"FFFF";
         else
            acc_next <= x"0000";
         end if;
      else
         sat      <= '0';
         acc_next <= std_logic_vector(u_sum(15 downto 0));
      end if;
   end procedure gldn_ej_02_06;

   ----------------------------------------------------------------------------
   -- procedure: ej 02 07
   ----------------------------------------------------------------------------
   procedure gldn_ej_02_07 (
      constant x      : in    std_logic_vector;
      constant factor : in    std_logic_vector;
      constant op     : in    std_logic;
      signal   y      : out   std_logic_vector
   ) is 
      variable int_factor : integer;
      variable u_x        : unsigned(10 downto 0);
   begin
      int_factor := to_integer(unsigned(factor));
      u_x        := "000" & unsigned(x);
      if (op = '0') then
         y <= std_logic_vector( shift_left(u_x, int_factor) );
      else 
         y <= std_logic_vector( shift_right(u_x, int_factor) );
      end if;
   end procedure gldn_ej_02_07;

   ----------------------------------------------------------------------------
   -- procedure: ej 02 08
   ----------------------------------------------------------------------------
   procedure gldn_ej_02_08 (
      constant x      : in    std_logic_vector(3 downto 0);
      signal   o_sqrt : out   std_logic_vector(3 downto 0);
      signal   o_rem  : out   std_logic_vector(3 downto 0)
   ) is 
   begin
      case (x) is
         when "0000" => 
            o_sqrt <= "0000";
            o_rem  <= "0000";
         when "0001" => 
            o_sqrt <= "0001";
            o_rem  <= "0000";
         when "0010" => 
            o_sqrt <= "0001";
            o_rem  <= "0001";
         when "0011" => 
            o_sqrt <= "0001";
            o_rem  <= "0010";
         when "0100" => 
            o_sqrt <= "0010";
            o_rem  <= "0000";
         when "0101" => 
            o_sqrt <= "0010";
            o_rem  <= "0001";
         when "0110" => 
            o_sqrt <= "0010";
            o_rem  <= "0010";
         when "0111" => 
            o_sqrt <= "0010";
            o_rem  <= "0011";
         when "1000" => 
            o_sqrt <= "0011";
            o_rem  <= "0000";
         when "1001" => 
            o_sqrt <= "0011";
            o_rem  <= "0001";
         when "1010" => 
            o_sqrt <= "0011";
            o_rem  <= "0010";
         when "1011" => 
            o_sqrt <= "0011";
            o_rem  <= "0011";
         when "1100" => 
            o_sqrt <= "0011";
            o_rem  <= "0100";
         when "1101" => 
            o_sqrt <= "0011";
            o_rem  <= "0101";
         when "1110" => 
            o_sqrt <= "0011";
            o_rem  <= "0110";
         when others => 
            o_sqrt <= "0011";
            o_rem  <= "0111";
      end case;      
   end procedure gldn_ej_02_08;

   ----------------------------------------------------------------------------
   -- procedure ej 03 01
   ----------------------------------------------------------------------------
   procedure gldn_ej_03_01  (
      constant i_en         : in    std_logic;
      constant i_srst       : in    std_logic;
      constant i_flags      : in    std_logic_vector(3 downto 0);
      constant i_ld_en      : in    std_logic;
      signal   exp_o_flags  : inout std_logic_vector(3 downto 0)
   ) is
   begin
      if (i_en = '1') then
         if (i_srst = '1') then
            exp_o_flags <= (others => '0');
         elsif (i_ld_en = '1') then
            exp_o_flags <= i_flags;
         end if;
      end if;
   end procedure  gldn_ej_03_01;

   ----------------------------------------------------------------------------
   -- procedure ej 03 03
   ----------------------------------------------------------------------------
   procedure gldn_ej_03_03    (
      constant i_en         : in    std_logic;
      constant i_srst       : in    std_logic;
      constant i_data       : in    std_logic_vector(15 downto 0);
      constant i_address    : in    std_logic_vector (2 downto 0);
      signal   exp_o_r0     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r1     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r2     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r3     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r4     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r5     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r6     : inout std_logic_vector(15 downto 0);
      signal   exp_o_r7     : inout std_logic_vector(15 downto 0)
   ) is
   begin
      if (i_en = '1') then
         if (i_srst = '1') then
            exp_o_r0 <= (others => '0');
            exp_o_r1 <= (others => '0');
            exp_o_r2 <= (others => '0');
            exp_o_r3 <= (others => '0');
            exp_o_r4 <= (others => '0');
            exp_o_r5 <= (others => '0');
            exp_o_r6 <= (others => '0');
            exp_o_r7 <= (others => '0');
         else
            case (i_address) is 
               when "000"  => exp_o_r0 <= i_data;
               when "001"  => exp_o_r1 <= i_data;
               when "010"  => exp_o_r2 <= i_data;
               when "011"  => exp_o_r3 <= i_data;
               when "100"  => exp_o_r4 <= i_data;
               when "101"  => exp_o_r5 <= i_data;
               when "110"  => exp_o_r6 <= i_data;
               when others => exp_o_r7 <= i_data;
            end case;
         end if;
      end if;
   end procedure gldn_ej_03_03;
         
end package body gldn_mdl_pkg;
