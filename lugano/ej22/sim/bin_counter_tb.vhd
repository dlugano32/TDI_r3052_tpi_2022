library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

ENTITY bin_counter_tb IS
    generic (
        W: natural := 8
    );
END bin_counter_tb;
 
ARCHITECTURE simulation OF bin_counter_tb IS

    signal            vif_clk     : std_logic                      := '0';
    signal            vif_rst     : std_logic                      := '0';
    signal            vif_en      : std_logic                      := '0';
    signal            vif_ld      : std_logic                      := '0';
    signal            vif_d       : std_logic_vector(W-1 downto 0) := (others => '0');
    signal            vif_tc      : std_logic                      := '0';
    signal            vif_q       : std_logic_vector(W-1 downto 0) := (others => '0');

    shared variable   var_clk     : std_logic;
    shared variable   var_rst     : std_logic;
    shared variable   var_en      : std_logic;
    shared variable   var_ld      : std_logic;
    shared variable   var_d       : std_logic_vector(W-1 downto 0);  

    shared variable   exp_tc      : std_logic                      := '0'            ;
    shared variable   exp_q       : std_logic_vector(W-1 downto 0) := (others => '0');
    shared variable   count       : unsigned          (W downto 0) := (others => '0');
    signal            all_ones    : std_logic_vector(W-1 downto 0) := (others => '1');

    shared variable   errors      : integer   := 0  ;
    shared variable   end_of_sim  : std_logic := '0';
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.bin_counter
    port map (
        clk => vif_clk, 
        rst => vif_rst,
        en  => vif_en ,
        ld  => vif_ld ,
        d   => vif_d  ,
        tc  => vif_tc ,
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
        wait until rising_edge(vif_clk);
        wait until falling_edge(vif_clk);
        ------------------------------------------------------
        vif_en <= '1';
        vif_ld <= '0';
        for k in 1 to 2*((2**W)+1) loop
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);
            count := to_unsigned(k,W+1) mod 2**W;
            exp_q := std_logic_vector(count(W-1 downto 0));
            if report_error(exp_q, vif_q, "q", "dec") then
                errors := errors + 1;
            end if;
            if (exp_q = all_ones) then
                exp_tc := '1';
                if report_error_bit(exp_tc, vif_tc, "tc") then 
                    errors := errors + 1;
                end if;
            end if;
        end loop;
        ------------------------------------------------------
        vif_en <= '1';
        vif_ld <= '1';
        vif_d  <= "00001111";
        wait until rising_edge(vif_clk);
        wait until falling_edge(vif_clk);
        vif_ld <= '0';
        for k in 16 to 2*((2**W)+1) loop
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);
            count := to_unsigned(k,W+1) mod 2**W;
            exp_q := std_logic_vector(count(W-1 downto 0));
            if report_error(exp_q, vif_q, "q", "dec") then
                errors := errors + 1;
            end if;
            if (exp_q = all_ones) then
                exp_tc := '1';
                if report_error_bit(exp_tc, vif_tc, "tc") then 
                    errors := errors + 1;
                end if;
            end if;
        end loop;
        ------------------------------------------------------
        vif_en <= '0';
        for k in 1 to 16 loop
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_clk);
            exp_q := "00000010";
            if report_error(exp_q, vif_q, "q", "dec") then
                errors := errors + 1;
            end if;
            exp_tc := '0';
            if report_error_bit(exp_tc, vif_tc, "tc") then 
                errors := errors + 1;
            end if;
        end loop;
        ------------------------------------------------------
        end_of_sim := '1';
        report_pass_fail(errors);
        report_end;
        wait;
     end process;

END;
