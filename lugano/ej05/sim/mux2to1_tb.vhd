library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;

ENTITY mux2to1_tb IS
END mux2to1_tb;
 
ARCHITECTURE simulation OF mux2to1_tb IS

    signal              vif_x1      : std_logic;
    signal              vif_x2      : std_logic;
    signal              vif_s       : std_logic;
    signal              vif_y       : std_logic;

    shared variable     var_x1      : std_logic;
    shared variable     var_x2      : std_logic;
    shared variable     var_s       : std_logic;
    shared variable     exp_y       : std_logic;
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.mux2to1
    port map (
        x1 => vif_x1,
        x2 => vif_x2,
        s  => vif_s ,
        y  => vif_y
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for k in 0 to 15 loop
            var_x1 := random_bit;
            var_x2 := random_bit;
            var_s  := '1';
            exp_y  := (var_s and var_x1) or (not(var_s) and var_x2);
            vif_x1 <= var_x1;
            vif_x2 <= var_x2;
            vif_s  <= var_s;
            wait for 5 ns;
            if report_error_bit(exp_y, vif_y, "y") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;
        for k in 0 to 15 loop
            var_x1 := random_bit;
            var_x2 := random_bit;
            var_s  := '0';
            exp_y  := (var_s and var_x1) or (not(var_s) and var_x2);
            vif_x1 <= var_x1;
            vif_x2 <= var_x2;
            vif_s  <= var_s;
            wait for 5 ns;
            if report_error_bit(exp_y, vif_y, "y") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;
        report_pass_fail(errors);
        report_end;
        wait;
    end process;
END;