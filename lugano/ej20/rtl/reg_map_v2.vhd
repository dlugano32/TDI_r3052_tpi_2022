library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity reg_map is
    generic
    (
        DATA_WIDTH : natural :=8
    );
    port 
    (
        i_clk, i_rst, i_en, i_srst : in std_logic;
        i_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
        i_address : in std_logic_vector(2 downto 0);
        o_r0, o_r1, o_r2, o_r3, o_r4, o_r5, o_r6, o_r7 : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end reg_map ; 

architecture arch of reg_map is
    constant rst_value : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    constant REGS : natural :=8;

    signal load_r: std_logic_vector(REGS-1 downto 0);
    type slv_array_t is array (REGS-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0); --8 registros de 8 bits
    signal q_reg, q_next : slv_array_t; 
begin

    with i_address select
    load_r <=   "00000001" when "000",
                "00000010" when "001",
                "00000100" when "010",
                "00001000" when "011",
                "00010000" when "100",
                "00100000" when "101",
                "01000000" when "110",
                "10000000" when others;


    register_bank : for i in REGS-1 downto 0 generate
        registro_indiv : process (i_clk, i_rst, i_en, i_srst)
        begin
            if(i_rst='1') then
                q_reg(i)<=rst_value;
            elsif(rising_edge(i_clk)) then
                if(i_en='1') then
                    if(i_srst='1') then
                        q_reg(i)<=rst_value;
                    else
                        q_reg(i)<=q_next(i);
                    end if;
                else
                    q_reg(i)<=q_reg(i);
                end if;
            end if;
        end process;
    end generate;

    future_log : for i in REGS-1 downto 0 generate
    q_next(i)<=q_reg(i) when (load_r(i)='0') else i_data;
    end generate;


    o_r0<= q_reg(0);
    o_r1<= q_reg(1);
    o_r2<= q_reg(2);
    o_r3<= q_reg(3);
    o_r4<= q_reg(4);
    o_r5<= q_reg(5);
    o_r6<= q_reg(6);
    o_r7<= q_reg(7);

end architecture ;