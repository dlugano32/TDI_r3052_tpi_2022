LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;
 
ENTITY reg_status_tb IS
END reg_status_tb;
 
ARCHITECTURE behavior OF reg_status_tb IS 

   signal            vif_i_clk     : std_logic                    := '0';
   signal            vif_i_rst     : std_logic                    := '0';
   signal            vif_i_en      : std_logic                    := '0';
   signal            vif_i_srst    : std_logic                    := '0';
   signal            vif_i_flags   : std_logic_vector(3 downto 0) := (others => '0');
   signal            vif_i_ld_en   : std_logic                    := '0';
   signal            vif_o_flags   : std_logic_vector(3 downto 0) := (others => '0');

   shared variable   var_i_clk     : std_logic;
   shared variable   var_i_rst     : std_logic;
   shared variable   var_i_en      : std_logic;
   shared variable   var_i_srst    : std_logic;
   shared variable   var_i_flags   : std_logic_vector(3 downto 0);
   shared variable   var_i_ld_en   : std_logic;

   signal            exp_o_flags   : std_logic_vector(3 downto 0) := (others => '0');

   shared variable   errors        : integer   := 0;
   shared variable   end_of_sim    : std_logic := '0';
 
BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut: entity work.reg_status
   port map (
      i_clk   => vif_i_clk  ,
      i_rst   => vif_i_rst  ,
      i_en    => vif_i_en   ,
      i_srst  => vif_i_srst ,
      i_flags => vif_i_flags,
      i_ld_en => vif_i_ld_en,
      o_flags => vif_o_flags
   );

   clk_proc: process begin
      while (end_of_sim = '0') loop
         vif_i_clk <= '0';
         wait for 10 ns;
         vif_i_clk <= '1';
         wait for 10 ns;
      end loop;
      wait;
   end process;
   
   rst_proc: process begin
      wait for 20 ns;
      wait for 20 ns;
      vif_i_rst <= '1';
      wait for 25 ns;
      vif_i_rst <= '0';
      wait;
   end process;
   
   driver_proc: process begin
      report_begin;
      wait until falling_edge(vif_i_rst);
      for k in 0 to 99 loop
         var_i_en    := random_bit;
         var_i_srst  := random_bit;
         var_i_flags := random_vector(4); 
         var_i_ld_en := random_bit;
         wait until falling_edge(vif_i_clk);
         vif_i_en    <= var_i_en   ;
         vif_i_srst  <= var_i_srst ;
         vif_i_flags <= var_i_flags;
         vif_i_ld_en <= var_i_ld_en;
         wait until rising_edge(vif_i_clk);
         gldn_ej_03_01(
            var_i_en   ,
            var_i_srst ,
            var_i_flags,
            var_i_ld_en,
            exp_o_flags
         );
         if report_error(exp_o_flags, vif_o_flags, "o_flags", "bin") then
            errors := errors + 1;
         end if;         
      end loop;
      end_of_sim := '1';
      report_pass_fail(errors);
      report_end;
      wait;
   end process;

END;