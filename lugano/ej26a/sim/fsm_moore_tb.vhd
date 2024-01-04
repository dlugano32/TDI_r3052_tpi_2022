library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY fsm_moore_tb IS
END fsm_moore_tb;
 
ARCHITECTURE simulation OF fsm_moore_tb IS

    signal            vif_clk     : std_logic := '0';
    signal            vif_rst     : std_logic := '0';
    signal            vif_nrzi    : std_logic := '1';
    signal            vif_data    : std_logic;

    shared variable   var_clk     : std_logic;
    shared variable   var_rst     : std_logic;
    shared variable   var_nrzi    : std_logic;
    shared variable   var_data    : std_logic; 

    shared variable   errors      : integer   := 0  ;
    shared variable   end_of_sim  : std_logic := '0';

    procedure inject_nrzi ( 
        constant var_nrzi : in    std_logic;
        constant exp_data : in    std_logic;
        signal   sig_nrzi : inout std_logic;
        signal   sig_data : in    std_logic
    ) is begin
        sig_nrzi <= var_nrzi;
        wait until rising_edge(vif_clk);
        wait for 10 ns;
        if report_error_bit(exp_data, sig_data, "data") then
            errors := errors + 1;
        end if;
    end procedure;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.fsm_moore
    port map (
        clk  => vif_clk , 
        rst  => vif_rst ,
        nrzi => vif_nrzi,
        data => vif_data
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
        wait for 10 ns;
        ------------------------------------------------------
        inject_nrzi('0','0', vif_nrzi, vif_data);
        inject_nrzi('0','1', vif_nrzi, vif_data);
        inject_nrzi('0','1', vif_nrzi, vif_data);
        inject_nrzi('1','0', vif_nrzi, vif_data);
        inject_nrzi('1','1', vif_nrzi, vif_data);
        inject_nrzi('0','0', vif_nrzi, vif_data);
        inject_nrzi('0','1', vif_nrzi, vif_data);
        inject_nrzi('1','0', vif_nrzi, vif_data);
        inject_nrzi('0','0', vif_nrzi, vif_data);
        inject_nrzi('1','0', vif_nrzi, vif_data);
        inject_nrzi('1','1', vif_nrzi, vif_data);
        inject_nrzi('0','0', vif_nrzi, vif_data);
        inject_nrzi('1','0', vif_nrzi, vif_data);
        inject_nrzi('1','1', vif_nrzi, vif_data);
        inject_nrzi('1','1', vif_nrzi, vif_data);
        inject_nrzi('0','0', vif_nrzi, vif_data);
        ------------------------------------------------------
        end_of_sim := '1';
        report_pass_fail(errors);
        report_end;
        wait;
     end process;

END;