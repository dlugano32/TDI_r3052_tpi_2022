library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY reg_map_tb IS
   generic (
      DATA_WIDTH : natural := 16
   );
END reg_map_tb;
 
ARCHITECTURE simulation OF reg_map_tb IS

   shared variable   var_i_en      : std_logic                                                 ;
   shared variable   var_i_srst    : std_logic                                                 ;
   shared variable   var_i_data    : std_logic_vector(DATA_WIDTH-1 downto 0)                   ;
   shared variable   var_i_address : std_logic_vector(2 downto 0)                              ;

   signal            vif_i_clk     : std_logic                               := '0'            ;
   signal            vif_i_rst     : std_logic                               := '0'            ;
   signal            vif_i_en      : std_logic                               := '0'            ;
   signal            vif_i_srst    : std_logic                               := '0'            ;
   signal            vif_i_data    : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            vif_i_address : std_logic_vector           (2 downto 0) := (others => '0');
   signal            vif_o_r0      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            vif_o_r1      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            vif_o_r2      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            vif_o_r3      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            vif_o_r4      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            vif_o_r5      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            vif_o_r6      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            vif_o_r7      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');

   signal            exp_o_r0      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            exp_o_r1      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            exp_o_r2      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            exp_o_r3      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            exp_o_r4      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            exp_o_r5      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            exp_o_r6      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal            exp_o_r7      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');

   shared variable   errors        : integer := 0;
   shared variable   end_of_sim    : std_logic := '0';
 
BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut: entity work.reg_map
   generic map (
      DATA_WIDTH => DATA_WIDTH
   )
   port map (
      i_clk     => vif_i_clk  ,
      i_rst     => vif_i_rst  ,
      i_en      => vif_i_en   ,
      i_srst    => vif_i_srst ,
      i_data    => vif_i_data ,
      i_address => vif_i_address,
      o_r0      => vif_o_r0   ,
      o_r1      => vif_o_r1   ,
      o_r2      => vif_o_r2   ,
      o_r3      => vif_o_r3   ,
      o_r4      => vif_o_r4   ,
      o_r5      => vif_o_r5   ,
      o_r6      => vif_o_r6   ,
      o_r7      => vif_o_r7   
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

      var_i_en    := '1';
      var_i_srst  := '0';
      var_i_data  := random_vector(16);
      for k in 0 to 7 loop
         var_i_address := std_logic_vector(to_unsigned(k,3));
         wait until falling_edge(vif_i_clk);
         vif_i_en      <= var_i_en     ;
         vif_i_srst    <= var_i_srst   ;
         vif_i_data    <= var_i_data   ;
         vif_i_address <= var_i_address;
         wait until rising_edge(vif_i_clk);
         gldn_ej_03_03(
            var_i_en     ,
            var_i_srst   ,
            var_i_data   ,
            var_i_address,
            exp_o_r0   ,
            exp_o_r1   ,
            exp_o_r2   ,
            exp_o_r3   ,
            exp_o_r4   ,
            exp_o_r5   ,
            exp_o_r6   ,
            exp_o_r7   
         );
         case (k) is
            when 0 =>
               if report_error(exp_o_r0, vif_o_r0, "REG_0", "bin") then
                  errors := errors + 1;
               end if;
            when 1 =>
               if report_error(exp_o_r1, vif_o_r1, "REG_1", "bin") then
                  errors := errors + 1;
               end if;
            when 2 =>
               if report_error(exp_o_r2, vif_o_r2, "REG_2", "bin") then
                  errors := errors + 1;
               end if;
            when 3 =>
               if report_error(exp_o_r3, vif_o_r3, "REG_3", "bin") then
                  errors := errors + 1;
               end if;
            when 4 =>
               if report_error(exp_o_r4, vif_o_r4, "REG_4", "bin") then
                  errors := errors + 1;
               end if;
            when 5 =>
               if report_error(exp_o_r5, vif_o_r5, "REG_5", "bin") then
                  errors := errors + 1;
               end if;
            when 6 =>
               if report_error(exp_o_r6, vif_o_r6, "REG_6", "bin") then
                  errors := errors + 1;
               end if;
            when others =>
               if report_error(exp_o_r7, vif_o_r7, "REG_7", "bin") then
                  errors := errors + 1;
               end if;
         end case;
      end loop;

      var_i_en    := '1';
      var_i_srst  := '0';
      var_i_data  := random_vector(16);
      for k in 7 downto 0 loop
         var_i_address := std_logic_vector(to_unsigned(k,3));
         wait until falling_edge(vif_i_clk);
         vif_i_en      <= var_i_en     ;
         vif_i_srst    <= var_i_srst   ;
         vif_i_data    <= var_i_data   ;
         vif_i_address <= var_i_address;
         wait until rising_edge(vif_i_clk);
         gldn_ej_03_03(
            var_i_en     ,
            var_i_srst   ,
            var_i_data   ,
            var_i_address,
            exp_o_r0   ,
            exp_o_r1   ,
            exp_o_r2   ,
            exp_o_r3   ,
            exp_o_r4   ,
            exp_o_r5   ,
            exp_o_r6   ,
            exp_o_r7   
         );
         case (k) is
            when 0 =>
               if report_error(exp_o_r0, vif_o_r0, "REG_0", "bin") then
                  errors := errors + 1;
               end if;
            when 1 =>
               if report_error(exp_o_r1, vif_o_r1, "REG_1", "bin") then
                  errors := errors + 1;
               end if;
            when 2 =>
               if report_error(exp_o_r2, vif_o_r2, "REG_2", "bin") then
                  errors := errors + 1;
               end if;
            when 3 =>
               if report_error(exp_o_r3, vif_o_r3, "REG_3", "bin") then
                  errors := errors + 1;
               end if;
            when 4 =>
               if report_error(exp_o_r4, vif_o_r4, "REG_4", "bin") then
                  errors := errors + 1;
               end if;
            when 5 =>
               if report_error(exp_o_r5, vif_o_r5, "REG_5", "bin") then
                  errors := errors + 1;
               end if;
            when 6 =>
               if report_error(exp_o_r6, vif_o_r6, "REG_6", "bin") then
                  errors := errors + 1;
               end if;
            when others =>
               if report_error(exp_o_r7, vif_o_r7, "REG_7", "bin") then
                  errors := errors + 1;
               end if;
         end case;
      end loop;

      var_i_en    := '1';
      var_i_srst  := '1';
      var_i_data  := random_vector(16);
      for k in 7 downto 0 loop
         var_i_address := std_logic_vector(to_unsigned(k,3));
         wait until falling_edge(vif_i_clk);
         vif_i_en      <= var_i_en     ;
         vif_i_srst    <= var_i_srst   ;
         vif_i_data    <= var_i_data   ;
         vif_i_address <= var_i_address;
         wait until rising_edge(vif_i_clk);
         gldn_ej_03_03(
            var_i_en     ,
            var_i_srst   ,
            var_i_data   ,
            var_i_address,
            exp_o_r0   ,
            exp_o_r1   ,
            exp_o_r2   ,
            exp_o_r3   ,
            exp_o_r4   ,
            exp_o_r5   ,
            exp_o_r6   ,
            exp_o_r7   
         );
         case (k) is
            when 0 =>
               if report_error(exp_o_r0, vif_o_r0, "REG_0", "bin") then
                  errors := errors + 1;
               end if;
            when 1 =>
               if report_error(exp_o_r1, vif_o_r1, "REG_1", "bin") then
                  errors := errors + 1;
               end if;
            when 2 =>
               if report_error(exp_o_r2, vif_o_r2, "REG_2", "bin") then
                  errors := errors + 1;
               end if;
            when 3 =>
               if report_error(exp_o_r3, vif_o_r3, "REG_3", "bin") then
                  errors := errors + 1;
               end if;
            when 4 =>
               if report_error(exp_o_r4, vif_o_r4, "REG_4", "bin") then
                  errors := errors + 1;
               end if;
            when 5 =>
               if report_error(exp_o_r5, vif_o_r5, "REG_5", "bin") then
                  errors := errors + 1;
               end if;
            when 6 =>
               if report_error(exp_o_r6, vif_o_r6, "REG_6", "bin") then
                  errors := errors + 1;
               end if;
            when others =>
               if report_error(exp_o_r7, vif_o_r7, "REG_7", "bin") then
                  errors := errors + 1;
               end if;
         end case;
      end loop;

      end_of_sim := '1';
      report_pass_fail(errors);
      report_end;
      wait;
   end process;


END;