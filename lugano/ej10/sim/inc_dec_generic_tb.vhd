library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY inc_dec_generic_tb IS
    generic (
        W: natural := 8;
        K: integer := 1
    );
END inc_dec_generic_tb;
 
ARCHITECTURE simulation OF inc_dec_generic_tb IS

    signal              vif_x       : std_logic_vector(W-1 downto 0);
    signal              vif_m       : std_logic;
    signal              vif_y       : std_logic_vector(W-1 downto 0);
    signal              vif_c       : std_logic;

    shared variable     var_x       : std_logic_vector(W-1 downto 0);
    shared variable     var_m       : std_logic;

    shared variable     exp_y       : std_logic_vector(W downto 0);
    shared variable     exp_c       : std_logic;
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.inc_dec_generic
    generic map(
        W  => W
    )
    port map (
        x => vif_x,
        m => vif_m,
        y => vif_y,
        c => vif_c
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for i in 0 to 7 loop
            var_m := random_bit;
            for j in 0 to 7 loop
                var_x := random_vector(W);
                if (var_m = '0') then
                    exp_y := std_logic_vector(('0' & unsigned(var_x)) + ('0' & to_unsigned(K,W)));
                else
                    exp_y := std_logic_vector(('0' & unsigned(var_x)) - ('0' & to_unsigned(K,W)));
                end if;
                exp_c := exp_y(W);
                vif_x <= var_x;
                vif_m <= var_m;
                wait for 5 ns;
                if report_error(exp_y(W-1 downto 0), vif_y, "y", "dec") then
                    errors := errors + 1;
                end if;
                if report_error_bit(exp_c, vif_c, "c") then
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
