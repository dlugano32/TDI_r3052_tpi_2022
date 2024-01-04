library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity fsm_moore is
  port 
  (
    clk, rst, nrzi: in std_logic;
    data : out std_logic
  );
end fsm_moore ; 

architecture arch of fsm_moore is
    type estados is (s0,s1,s2,s3);
    signal state_next, state_reg : estados;
begin

    registers: process(clk, rst)
    begin
        if(rst='1') then
            state_reg<=s0;
        elsif (rising_edge(clk)) then
            state_reg<=state_next;
    end if;
    end process;

    future_state_logic: process(state_reg, nrzi) 
    begin
        state_next<=state_reg;

        case state_reg is
            when s0=>
                if(nrzi='1') then
                    state_next<=s0;
                else
                    state_next<=s1;
                end if;

            when s1=>
                if(nrzi='1') then
                    state_next<=s3;
                else
                    state_next<=s2;
                end if;

            when s2=>
            if(nrzi='1') then
                state_next<=s3;
            else
                state_next<=s2;
            end if;

            when s3=>
                if(nrzi='1') then
                    state_next<=s0;
                else
                    state_next<=s1;
                end if;
            
            when others=> state_next<=s0;
        end case;
    end process;

    out_logic : process(state_reg)  --Como es una MDE Moore, las salidas dependen unicamente de los estados
    begin
        case(state_reg) is
            when s0=> data<='1';
            when s2=> data<='1';
            when others => data<='0';
        end case;
    end process;

end architecture ;