library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY barrel_shifter_tb IS
END barrel_shifter_tb;
 
ARCHITECTURE simulation OF barrel_shifter_tb IS

    signal              vif_x       : std_logic_vector(7 downto 0);
    signal              vif_dir     : std_logic;
    signal              vif_amt     : std_logic_vector(2 downto 0);
    signal              vif_y       : std_logic_vector(7 downto 0);

    shared variable     var_x       : std_logic_vector(7 downto 0);
    shared variable     var_dir     : std_logic;
    shared variable     var_amt     : std_logic_vector(2 downto 0);

    signal              exp_y       : std_logic_vector(7 downto 0);
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.barrel_shifter
    port map (
        x   => vif_x  ,
        dir => vif_dir,
        amt => vif_amt,
        y   => vif_y
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        var_x   := (others => '1');
        var_dir := '0';
        for k in 0 to 7 loop
            var_amt := std_logic_vector(to_unsigned(k,3));
            gldn_ej_02_04(var_x, var_dir, var_amt, exp_y);
            vif_x   <= var_x;
            vif_dir <= var_dir;
            vif_amt <= var_amt;
            wait for 5 ns;
            if report_error(exp_y, vif_y, "y", "bin") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;

        var_x   := (others => '1');
        var_dir := '1';
        for k in 0 to 7 loop
            var_amt := std_logic_vector(to_unsigned(k,3));
            gldn_ej_02_04(var_x, var_dir, var_amt, exp_y);
            vif_x   <= var_x;
            vif_dir <= var_dir;
            vif_amt <= var_amt;
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