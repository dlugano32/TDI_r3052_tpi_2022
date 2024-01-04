library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY acc_tb IS
END acc_tb;
 
ARCHITECTURE simulation OF acc_tb IS

    signal              vif_bin      : std_logic_vector( 7 downto 0);
    signal              vif_acc_curr : std_logic_vector(15 downto 0);
    signal              vif_mode     : std_logic;
    signal              vif_acc_next : std_logic_vector(15 downto 0);
    signal              vif_sat      : std_logic;
 
    shared variable     var_bin      : std_logic_vector( 7 downto 0);
    shared variable     var_acc_curr : std_logic_vector(15 downto 0);
    shared variable     var_mode     : std_logic;
 
    signal              exp_acc_next : std_logic_vector(15 downto 0);
    signal              exp_sat      : std_logic;
    shared variable     errors       : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.acc
    port map (
        bin      => vif_bin     ,
        acc_curr => vif_acc_curr,
        mode     => vif_mode    ,
        acc_next => vif_acc_next,
        sat      => vif_sat     
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;

        var_mode     := '0';
        var_bin      := "11111111";
        var_acc_curr := (others => '0');
        for j in 0 to 300 loop
            gldn_ej_02_06(var_bin     , 
                          var_acc_curr, 
                          var_mode    ,
                          exp_acc_next,
                          exp_sat     );
            vif_bin      <= var_bin     ;
            vif_acc_curr <= var_acc_curr;
            vif_mode     <= var_mode    ;
            wait for 5 ns;
            if report_error(exp_acc_next, vif_acc_next, "acc_next", "dec") then
                errors := errors + 1;
            end if;
            if report_error_bit(exp_sat, vif_sat, "sat") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
            var_acc_curr := vif_acc_next;
        end loop;

        var_mode     := '1';
        var_bin      := "11111111";
        var_acc_curr := (others => '1');
        for j in 0 to 300 loop
            gldn_ej_02_06(var_bin     , 
                          var_acc_curr, 
                          var_mode    ,
                          exp_acc_next,
                          exp_sat     );
            vif_bin      <= var_bin     ;
            vif_acc_curr <= var_acc_curr;
            vif_mode     <= var_mode    ;
            wait for 5 ns;
            if report_error(exp_acc_next, vif_acc_next, "acc_next", "dec") then
                errors := errors + 1;
            end if;
            if report_error_bit(exp_sat, vif_sat, "sat") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
            var_acc_curr := vif_acc_next;
        end loop;

        report_pass_fail(errors);
        report_end;
        wait;
    end process;
END;