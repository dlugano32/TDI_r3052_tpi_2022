library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY complement_tb IS
    generic (
        W: natural := 8
    );
END complement_tb;
 
ARCHITECTURE simulation OF complement_tb IS

    signal              vif_x       : std_logic_vector(W-1 downto 0);
    signal              vif_ctrl    : std_logic;
    signal              vif_y       : std_logic_vector(W-1 downto 0);

    shared variable     var_x       : std_logic_vector(W-1 downto 0);
    shared variable     var_ctrl    : std_logic;

    signal              exp_y       : std_logic_vector(W-1 downto 0);
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.complement
    generic map(
        W  => W
    )
    port map (
        x      => vif_x,
        ctrl   => vif_ctrl,
        y      => vif_y
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for j in 0 to 127 loop
            var_x    := random_vector(W);
            var_ctrl := random_bit;
            gldn_ej_02_02(var_x, var_ctrl, exp_y);
            vif_x    <= var_x;
            vif_ctrl <= var_ctrl;
            wait for 5 ns;
            if report_error(exp_y, vif_y, "y", "bin") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;
        report_pass_fail(errors);
        report_end;
        wait;
    end process;
END;