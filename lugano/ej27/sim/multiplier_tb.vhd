library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use work.random_stim_pkg.all;
use work.report_pkg.all;
use work.gldn_mdl_pkg.all;

entity multiplier_tb is
    generic (
        W: natural := 8
    );
end entity multiplier_tb;

architecture simulation of multiplier_tb is

    signal            vif_clk     : std_logic                        := '0';
    signal            vif_rst     : std_logic                        := '0';
    signal            vif_en      : std_logic                        := '1';
    signal            vif_srst    : std_logic                        := '0';
    signal            vif_start   : std_logic                        := '0';
    signal            vif_a       : std_logic_vector(  W-1 downto 0) := (others => '0');
    signal            vif_b       : std_logic_vector(  W-1 downto 0) := (others => '0');
    signal            vif_p       : std_logic_vector(2*W-1 downto 0);
    signal            vif_p_end   : std_logic;

    shared variable   result      : std_logic_vector(15 downto 0);
    shared variable   errors      : integer   := 0  ;
    shared variable   end_of_sim  : std_logic := '0';
 
begin

    -- instantiate the unit under test (uut)			
    uut: entity work.multiplier
    generic map(
        W     => W
    )
    port map(
        clk   => vif_clk  ,
        rst   => vif_rst  ,
        en    => vif_en   ,
        srst  => vif_srst ,
        start => vif_start,
        a     => vif_a    ,
        b     => vif_b    ,
        p     => vif_p    ,
        p_end => vif_p_end
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

    mult_proc: process

    begin
        report_begin;
        for k in 0 to 30 loop
            vif_a <= random_vector(W);
            vif_b <= random_vector(W);
            vif_start <= '1';   -- Starts the mult operation
            wait until rising_edge(vif_clk);
            wait until falling_edge(vif_p_end); -- until opertions ends
            vif_start <= '0';
            result := std_logic_vector(unsigned(vif_a) * unsigned(vif_b));
            if report_error(result, vif_p, "p", "dec") then
                errors := errors + 1;
            end if;
        end loop;
        ------------------------------------------------------
        end_of_sim := '1';
        report_pass_fail(errors);
        report_end;
        wait;
    end process;

end architecture simulation;