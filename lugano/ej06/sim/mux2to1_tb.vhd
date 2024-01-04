library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;

ENTITY mux2to1_tb IS
    generic (
        W: natural := 8
    );
END mux2to1_tb;
 
ARCHITECTURE simulation OF mux2to1_tb IS

    signal              vif_x1      : std_logic_vector(W-1 downto 0);
    signal              vif_x2      : std_logic_vector(W-1 downto 0);
    signal              vif_s       : std_logic;
    signal              vif_y       : std_logic_vector(W-1 downto 0);

    shared variable     var_x1      : std_logic_vector(W-1 downto 0);
    shared variable     var_x2      : std_logic_vector(W-1 downto 0);
    shared variable     var_s       : std_logic;
    shared variable     exp_y       : std_logic_vector(W-1 downto 0);
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.mux2to1
    generic map(
        W  => W
    )
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
            var_x1 := random_vector(W);
            var_x2 := random_vector(W);
            var_s  := '1';
            exp_y  := var_x1;
            vif_x1 <= var_x1;
            vif_x2 <= var_x2;
            vif_s  <= var_s;
            wait for 5 ns;
            if report_error(exp_y, vif_y, "y", "bin") then
                errors := errors + 1;
            end if;
            wait for 5 ns;
        end loop;
        for k in 0 to 15 loop
            var_x1 := random_vector(W);
            var_x2 := random_vector(W);
            var_s  := '0';
            exp_y  := var_x2;
            vif_x1 <= var_x1;
            vif_x2 <= var_x2;
            vif_s  <= var_s;
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