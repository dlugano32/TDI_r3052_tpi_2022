library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY mult_div_tb IS
END mult_div_tb;
 
ARCHITECTURE simulation OF mult_div_tb IS

    signal              vif_x      : std_logic_vector( 7 downto 0);
    signal              vif_factor : std_logic_vector( 1 downto 0);
    signal              vif_op     : std_logic;
    signal              vif_y      : std_logic_vector(10 downto 0);
 
    shared variable     var_x      : std_logic_vector( 7 downto 0);
    shared variable     var_factor : std_logic_vector( 1 downto 0);
    shared variable     var_op     : std_logic;
 
    signal              exp_y      : std_logic_vector(10 downto 0);
    shared variable     errors     : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.mult_div
    port map (
        x      => vif_x     ,
        factor => vif_factor,
        op     => vif_op    ,
        y      => vif_y     
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;

        var_op := '0';
        for i in 0 to 3 loop
            for j in 0 to 7 loop
                var_factor := std_logic_vector(to_unsigned(i,2));
                var_x      := random_vector(8);
                gldn_ej_02_07(var_x     , 
                              var_factor, 
                              var_op    ,
                              exp_y     );
                vif_x      <= var_x     ;
                vif_factor <= var_factor;
                vif_op     <= var_op    ;
                wait for 5 ns;
                if report_error(exp_y, vif_y, "y", "dec") then
                    errors := errors + 1;
                end if;
                wait for 5 ns;
            end loop;
        end loop;

        var_op := '1';
        for i in 0 to 3 loop
            for j in 0 to 7 loop
                var_factor := std_logic_vector(to_unsigned(i,2));
                var_x      := random_vector(8);
                gldn_ej_02_07(var_x     , 
                              var_factor, 
                              var_op    ,
                              exp_y     );
                vif_x      <= var_x     ;
                vif_factor <= var_factor;
                vif_op     <= var_op    ;
                wait for 5 ns;
                if report_error(exp_y, vif_y, "y", "dec") then
                    errors := errors + 1;
                end if;
                wait for 5 ns;
            end loop;
        end loop;

        report_pass_fail(errors);
        report_end;
        wait;
    end process;
END;