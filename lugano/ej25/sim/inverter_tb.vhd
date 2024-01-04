library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY inverter_tb IS
END inverter_tb;
 
ARCHITECTURE simulation OF inverter_tb IS

    signal            vif_clk     : std_logic                    := '0';
    signal            vif_rst     : std_logic                    := '0';
    signal            vif_en      : std_logic                    := '0';
    signal            vif_q       : std_logic_vector(5 downto 0) := (others => '0');

    shared variable   var_clk     : std_logic;
    shared variable   var_rst     : std_logic;
    shared variable   var_en      : std_logic;
    shared variable   var_q       : std_logic_vector(5 downto 0);
    shared variable   exp_q       : std_logic_vector(5 downto 0) := (others => '0');

    shared variable   errors      : integer   := 0  ;
    shared variable   end_of_sim  : std_logic := '0';
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.inverter
    port map (
        clk => vif_clk, 
        rst => vif_rst,
        en  => vif_en ,
        q   => vif_q  
    );

    clk_proc: process begin
        while (end_of_sim = '0') loop
           vif_clk <= '0';
           wait for 10 ns;
           vif_clk <= '1';
           wait for 10 ns;
        end loop;
        wait;
     end process;
     
     rst_proc: process begin
        wait for 20 ns;
        wait for 20 ns;
        vif_rst <= '1';
        wait for 25 ns;
        vif_rst <= '0';
        wait;
     end process;
     
     driver_proc: process begin
        report_begin;
        wait until falling_edge(vif_rst);
        vif_en <= '1';
        for k in 1 to 4 loop
            exp_q := "110001";
            if report_error(exp_q, vif_q, "q", "bin") then
                errors := errors + 1;
            end if;
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);

            exp_q := "100011";
            if report_error(exp_q, vif_q, "q", "bin") then
                errors := errors + 1;
            end if;
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);

            exp_q := "000111";
            if report_error(exp_q, vif_q, "q", "bin") then
                errors := errors + 1;
            end if;
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);

            exp_q := "001110";
            if report_error(exp_q, vif_q, "q", "bin") then
                errors := errors + 1;
            end if;
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);

            exp_q := "011100";
            if report_error(exp_q, vif_q, "q", "bin") then
                errors := errors + 1;
            end if;
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);

            exp_q := "111000";
            if report_error(exp_q, vif_q, "q", "bin") then
                errors := errors + 1;
            end if;
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);
        end loop;
        ------------------------------------------------------
        end_of_sim := '1';
        report_pass_fail(errors);
        report_end;
        wait;
     end process;

END;