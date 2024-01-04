library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY abs_value_tb IS
END abs_value_tb;
 
ARCHITECTURE simulation OF abs_value_tb IS

    signal              vif_x       : std_logic_vector(7 downto 0);
    signal              vif_ctrl    : std_logic;
    signal              vif_y       : std_logic_vector(7 downto 0);

    shared variable     var_x       : std_logic_vector(7 downto 0);
    shared variable     var_ctrl    : std_logic;

    signal              exp_y       : std_logic_vector(7 downto 0);
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.abs_value
    port map (
        x      => vif_x,
        ctrl   => vif_ctrl,
        y      => vif_y
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for j in 0 to 127 loop
            var_x    := random_vector(8);
            var_ctrl := '0';
            gldn_ej_02_03(var_x, var_ctrl, exp_y);
            vif_x    <= var_x;
            vif_ctrl <= var_ctrl;
            wait for 5 ns;
            if report_error(exp_y, vif_y, "y", "dec") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;
        for j in 0 to 127 loop
            var_x    := random_vector(8);
            var_ctrl := '1';
            gldn_ej_02_03(var_x, var_ctrl, exp_y);
            vif_x    <= var_x;
            vif_ctrl <= var_ctrl;
            wait for 5 ns;
            if report_error(exp_y, vif_y, "y", "dec") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;
        report_pass_fail(errors);
        report_end;
        wait;
    end process;
END;