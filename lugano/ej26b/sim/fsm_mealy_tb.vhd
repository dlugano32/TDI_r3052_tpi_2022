library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY fsm_mealy_tb IS
END fsm_mealy_tb;
 
ARCHITECTURE simulation OF fsm_mealy_tb IS

    signal            vif_clk     : std_logic := '0';
    signal            vif_rst     : std_logic := '0';
    signal            vif_y       : std_logic := '1';
    signal            vif_o       : std_logic;

    shared variable   var_clk     : std_logic;
    shared variable   var_rst     : std_logic;
    shared variable   var_y       : std_logic;
    shared variable   var_o       : std_logic; 

    shared variable   errors      : integer   := 0  ;
    shared variable   end_of_sim  : std_logic := '0';
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.fsm_mealy
    port map (
        clk => vif_clk, 
        rst => vif_rst,
        y   => vif_y  ,
        o   => vif_o  
    );

    clk_proc: process begin
        while (end_of_sim = '0') loop
           vif_clk <= '0';
           wait for 10 ns;
           vif_clk <= '1';
           wait for 10 ns;
        end loop;
        wait;
     end process;
     
     rst_proc: process begin
        wait for 20 ns;
        wait for 20 ns;
        vif_rst <= '1';
        wait for 25 ns;
        vif_rst <= '0';
        wait;
     end process;
     
     driver_proc: process begin
        report_begin;
        wait until falling_edge(vif_rst);
        wait until rising_edge(vif_clk);
        wait for 2 ns;
        ------------------------------------------------------
        vif_y <= '0';
        wait until rising_edge(vif_clk);
        wait for 2 ns;

        vif_y <= '1';
        wait until rising_edge(vif_clk);
        wait for 2 ns;

        vif_y <= '1';
        wait until rising_edge(vif_clk);
        wait for 2 ns;

        vif_y <= '0';
        wait until rising_edge(vif_clk);
        wait for 2 ns;

        vif_y <= '1';
        wait for 2 ns;
        wait until rising_edge(vif_clk);
        if report_error_bit('0', vif_o, "o") then
            errors := errors + 1;
        end if;
        
        vif_y <= '0';
        wait for 2 ns;
        if report_error_bit('1', vif_o, "o") then
            errors := errors + 1;
        end if;
        wait until rising_edge(vif_clk);
        ------------------------------------------------------
        end_of_sim := '1';
        report_pass_fail(errors);
        report_end;
        wait;
     end process;

END;