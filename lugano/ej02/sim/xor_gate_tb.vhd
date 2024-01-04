library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;

ENTITY xor_gate_tb IS
END xor_gate_tb;
 
ARCHITECTURE simulation OF xor_gate_tb IS

    signal              vif_x1      : std_logic;
    signal              vif_x2      : std_logic;
    signal              vif_y       : std_logic;

    shared variable     var_x1      : std_logic;
    shared variable     var_x2      : std_logic;
    shared variable     var_y       : std_logic;
    shared variable     exp_y       : std_logic;
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.xor_gate
    port map (
        x1 => vif_x1,
        x2 => vif_x2,
        y  => vif_y
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for k in 0 to 15 loop
            var_x1 := random_bit;
            var_x2 := random_bit;
            exp_y  := var_x1 xor var_x2;
            vif_x1 <= var_x1;
            vif_x2 <= var_x2;
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