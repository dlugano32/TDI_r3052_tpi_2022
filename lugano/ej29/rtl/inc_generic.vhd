library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity full_adder_generic is
    generic
    (
        N : natural :=16
    );
    port 
    (
        a : in std_logic_vector(N-1 downto 0);
        ci : in std_logic;  
        o : out std_logic_vector(N-1 downto 0);
        co : out std_logic
    ) ;
end full_adder_generic ; 

architecture arch of full_adder_generic is

    signal c: std_logic_vector(N-1 downto 0);

begin
    
    state_gen : for i in 0 to N-1 generate
        first_gen: 
            if(i=0) generate 
                inc : entity work.inc_cell
                    port map(
                        a=>a(i),
                        ci=>ci,
                        o=>o(i),
                        co=>c(i+1)
                    );
            end generate;
        
        middle_gen:
            if (i>0) and (i<N-1) generate
                inc: entity work.inc_cell
                    port map(
                        a=>a(i),
                        ci=>c(i),
                        o=>o(i),
                        co=>c(i+1)
                    );
                end generate;

        last_gen:
            if(i=(N-1)) generate
                inc: entity work.inc_cell
                port map(
                    a=>a(i),
                    ci=>c(i),
                    o=>o(i),
                    co=>co
                );
        end generate;
    end generate;
end architecture ;