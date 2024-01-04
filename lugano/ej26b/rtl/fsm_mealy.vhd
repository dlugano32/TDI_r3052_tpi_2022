library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity fsm_mealy is
  port 
  (
    clk, rst, y : in std_logic;
    o : out std_logic
  ) ;
end fsm_mealy ; 

architecture arch of fsm_mealy is
    type estados is(s0, s1, s2, s3, s4, s5);
    signal state_reg, state_next : estados;
begin
    --Registro
    registers: process(rst, clk)
    begin
        if(rst='1') then
            state_reg<=s0;
        elsif (rising_edge(clk)) then
            state_reg<=state_next;
        end if;
    end process;

    future_state_logic: process(state_reg, y)
    begin
        --Valores por defecto
        state_next<=s0;

        --Casos particulares
        case state_reg is
            when s0=>
                if(y='0') then
                    state_next<=s1;
                end if;

            when s1=>
                if(y='1') then
                    state_next<=s2;
                end if;

            when s2=>
                if(y='1') then
                    state_next<=s3;
                end if;
            
            when s3=>
                if(y='0') then
                    state_next<=s4;
                end if;
            
            when s4=>
                if(y='1') then
                    state_next<=s5;
                end if;

            when s5=>
                if(y='0') then
                    state_next<=s0;
                end if;

            when others => state_next<=s0;
        end case;
    end process;

    out_logic : process(state_reg, y) --Como es una MDE mealy, la logica de salida depende de los estados y de las entradas
    begin
        case state_reg is
            when s5=> o<='1';
            when others => o<='0';
        end case;
    end process;

end architecture ;