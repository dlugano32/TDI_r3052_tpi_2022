library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY logic_unit_tb IS
    generic (
        W: natural := 8
    );
END logic_unit_tb;
 
ARCHITECTURE simulation OF logic_unit_tb IS

    signal              vif_x1      : std_logic_vector(W-1 downto 0);
    signal              vif_x2      : std_logic_vector(W-1 downto 0);
    signal              vif_x3      : std_logic_vector(W-1 downto 0);
    signal              vif_x4      : std_logic_vector(W-1 downto 0);
    signal              vif_sel     : std_logic;
    signal              vif_opcode  : std_logic_vector(  2 downto 0);
    signal              vif_y       : std_logic_vector(W-1 downto 0);

    shared variable     var_x1      : std_logic_vector(W-1 downto 0);
    shared variable     var_x2      : std_logic_vector(W-1 downto 0);
    shared variable     var_x3      : std_logic_vector(W-1 downto 0);
    shared variable     var_x4      : std_logic_vector(W-1 downto 0);
    shared variable     var_sel     : std_logic;
    shared variable     var_opcode  : std_logic_vector(  2 downto 0);

    signal              exp_y       : std_logic_vector(W-1 downto 0);
    shared variable     errors      : integer := 0;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.logic_unit
    generic map(
        W  => W
    )
    port map (
        x1     => vif_x1,
        x2     => vif_x2,
        x3     => vif_x3,
        x4     => vif_x4,
        sel    => vif_sel,
        opcode => vif_opcode,
        y      => vif_y
    );

    -- Stimulus process
    stim_proc: process begin
        report_begin;
        for j in 0 to 7 loop
            var_x1  := random_vector(W);
            var_x2  := random_vector(W);
            var_x3  := random_vector(W);
            var_x4  := random_vector(W);
            var_sel := random_bit;
            for k in 0 to 7 loop
                var_opcode := std_logic_vector(to_unsigned(k,3));
                gldn_ej_01_09(var_x1    , 
                              var_x2    , 
                              var_x3    ,
                              var_x4    , 
                              var_sel   ,
                              var_opcode,
                              exp_y     );
                vif_x1     <= var_x1;
                vif_x2     <= var_x2;
                vif_x3     <= var_x3;
                vif_x4     <= var_x4;
                vif_sel    <= var_sel;
                vif_opcode <= var_opcode;
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