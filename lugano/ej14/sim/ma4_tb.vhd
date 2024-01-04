library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY ma4_tb IS
END ma4_tb;
 
ARCHITECTURE simulation OF ma4_tb IS

    signal              vif_x1      : std_logic_vector(7 downto 0);
    signal              vif_x2      : std_logic_vector(7 downto 0);
    signal              vif_x3      : std_logic_vector(7 downto 0);
    signal              vif_x4      : std_logic_vector(7 downto 0);
    signal              vif_y       : std_logic_vector(7 downto 0);
    shared variable     var_x1      : std_logic_vector(7 downto 0);
    shared variable     var_x2      : std_logic_vector(7 downto 0);
    shared variable     var_x3      : std_logic_vector(7 downto 0);
    shared variable     var_x4      : std_logic_vector(7 downto 0);
    signal              exp_y       : std_logic_vector(7 downto 0);
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.ma4
    port map (
        x1     => vif_x1,
        x2     => vif_x2,
        x3     => vif_x3,
        x4     => vif_x4,
        y      => vif_y
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for j in 0 to 31 loop
            var_x1  := random_vector(8);
            var_x2  := random_vector(8);
            var_x3  := random_vector(8);
            var_x4  := random_vector(8);
            gldn_ej_02_05(var_x1, 
                          var_x2, 
                          var_x3,
                          var_x4, 
                          exp_y );
            vif_x1     <= var_x1;
            vif_x2     <= var_x2;
            vif_x3     <= var_x3;
            vif_x4     <= var_x4;
            wait for 5 ns;
            if report_error(exp_y, vif_y, "y", "sign") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;
        report_pass_fail(errors);
        report_end;
        wait;
    end process;
END;