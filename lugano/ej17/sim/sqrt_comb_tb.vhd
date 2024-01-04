library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY sqrt_comb_tb IS
END sqrt_comb_tb;
 
ARCHITECTURE simulation OF sqrt_comb_tb IS

    signal              vif_x      : std_logic_vector(3 downto 0);
    signal              vif_o_sqrt : std_logic_vector(3 downto 0);
    signal              vif_o_rem  : std_logic_vector(3 downto 0);
 
    shared variable     var_x      : std_logic_vector(3 downto 0);

    signal              exp_sqrt   : std_logic_vector(3 downto 0);
    signal              exp_rem    : std_logic_vector(3 downto 0);
    shared variable     errors     : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.sqrt_comb
    port map (
        x      => vif_x     ,
        o_sqrt => vif_o_sqrt,
        o_rem  => vif_o_rem 
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;

        for j in 0 to 15 loop 
            var_x := std_logic_vector(to_unsigned(j,4));
            gldn_ej_02_08(var_x   , 
                          exp_sqrt,
                          exp_rem);
            vif_x <= var_x;
            wait for 5 ns;
            if report_error(exp_sqrt, vif_o_sqrt, "o_sqrt", "dec") then
                errors := errors + 1;
            end if;
            if report_error(exp_rem , vif_o_rem , "o_rem" , "dec") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;

        report_pass_fail(errors);
        report_end;
        wait;
    end process;
END;