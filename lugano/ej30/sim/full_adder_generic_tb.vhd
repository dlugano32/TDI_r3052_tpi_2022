library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

entity full_adder_generic_tb is
    generic (
        N: natural := 4
    );
end entity full_adder_generic_tb;

architecture simulation of full_adder_generic_tb is

    signal            vif_a       : std_logic_vector(N-1 downto 0)  := (others => '0');
    signal            vif_b       : std_logic_vector(N-1 downto 0)  := (others => '0');
    signal            vif_ci      : std_logic                       := '0';
    signal            vif_o       : std_logic_vector(N-1 downto 0);
    signal            vif_co      : std_logic;

    shared variable   var_a       : std_logic_vector(N-1 downto 0);
    shared variable   var_b       : std_logic_vector(N-1 downto 0);
    shared variable   exp_o       : std_logic_vector(N downto 0);
    shared variable   exp_co      : std_logic;
    shared variable   errors      : integer   := 0;
    shared variable   end_of_sim  : std_logic := '0';
 
begin

    -- instantiate the unit under test (uut)			
    uut: entity work.full_adder_generic
    generic map(
        N     => N
    )
    port map(
        a  => vif_a ,
        b  => vif_b ,
        ci => vif_ci,
        o  => vif_o ,
        co => vif_co
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for i in 0 to 7 loop
            var_a := random_vector(N);
            for j in 0 to 7 loop
                var_b  := random_vector(N);
                exp_o  := std_logic_vector(('0' & unsigned(var_a)) + ('0' & unsigned(var_b)));
                exp_co := exp_o(N);
                vif_a  <= var_a;
                vif_b  <= var_b;
                wait for 5 ns;
                if report_error(exp_o(N-1 downto 0), vif_o, "o", "dec") then
                    errors := errors + 1;
                end if;
                if report_error_bit(exp_co, vif_co, "co") then
                    errors := errors + 1;
                end if;
                wait for 5 ns;
            end loop;
        end loop;
        report_pass_fail(errors);
        report_end;
        wait;
    end process;

end architecture simulation;