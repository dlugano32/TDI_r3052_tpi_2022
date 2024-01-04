library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY non_prior_route_tb IS
    generic (
        W: natural := 8
    );
END non_prior_route_tb;
 
ARCHITECTURE simulation OF non_prior_route_tb IS

    shared variable     var_x1      : std_logic_vector(W-1 downto 0);
    shared variable     var_x2      : std_logic_vector(W-1 downto 0);
    shared variable     var_x3      : std_logic_vector(W-1 downto 0);
    shared variable     var_x4      : std_logic_vector(W-1 downto 0);
    shared variable     var_s       : std_logic_vector(  1 downto 0);

    signal              vif_x1      : std_logic_vector(W-1 downto 0);
    signal              vif_x2      : std_logic_vector(W-1 downto 0);
    signal              vif_x3      : std_logic_vector(W-1 downto 0);
    signal              vif_x4      : std_logic_vector(W-1 downto 0);
    signal              vif_s       : std_logic_vector(  1 downto 0);
    signal              vif_y       : std_logic_vector(W-1 downto 0);
    signal              exp_y       : std_logic_vector(W-1 downto 0);

    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.non_prior_route
    generic map(
        W  => W
    )
    port map (
        x1 => vif_x1,
        x2 => vif_x2,
        x3 => vif_x3,
        x4 => vif_x4,
        s  => vif_s ,
        y  => vif_y
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for i in 0 to 15 loop
            var_s  := random_vector(2);
            var_x1 := random_vector(W);
            var_x2 := random_vector(W);
            var_x3 := random_vector(W);
            var_x4 := random_vector(W);
            for j in 0 to 3 loop
                gldn_ej_01_08(var_x1, 
                              var_x2, 
                              var_x3,
                              var_x4, 
                              var_s ,
                              exp_y );
                vif_x1 <= var_x1;
                vif_x2 <= var_x2;
                vif_x3 <= var_x3;
                vif_x4 <= var_x4;
                vif_s  <= var_s ;
                wait for 5 ns;
                if report_error(exp_y, vif_y, "y", "bin") then
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
