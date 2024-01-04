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
    signal r0_reg, r1_reg, r2_reg, r3_reg, r4_reg, r5_reg, r6_reg, r7_reg : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal r0_next, r1_next, r2_next, r3_next, r4_next, r5_next, r6_next, r7_next : std_logic_vector(DATA_WIDTH-1 downto 0);
    constant rst_value : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
begin

    process(i_rst, i_clk)
    begin
        if(i_rst= '1') then
            r0_reg<=rst_value;
            r1_reg<=rst_value;
            r2_reg<=rst_value;
            r3_reg<=rst_value;
            r4_reg<=rst_value;
            r5_reg<=rst_value;
            r6_reg<=rst_value;
            r7_reg<=rst_value;
        elsif (rising_edge(i_clk)) then
            r0_reg<=r0_next;
            r1_reg<=r1_next;
            r2_reg<=r2_next;
            r3_reg<=r3_next;
            r4_reg<=r4_next;
            r5_reg<=r5_next;
            r6_reg<=r6_next;
            r7_reg<=r7_next;
        end if;
    end process;

    r0_next<=   r0_reg when (i_en='0') else 
                rst_value when (i_srst='1') else
                i_data when (i_address = "000") else
                r0_reg;

    r1_next<=   r1_reg when (i_en='0') else 
                rst_value when (i_srst='1') else
                i_data when (i_address = "001") else
                r1_reg;

    r2_next<=   r2_reg when (i_en='0') else 
                rst_value when (i_srst='1') else
                i_data when (i_address = "010") else
                r2_reg;

    r3_next<=   r3_reg when (i_en='0') else 
                rst_value when (i_srst='1') else
                i_data when (i_address = "011") else
                r3_reg;

    r4_next<=   r4_reg when (i_en='0') else 
                rst_value when (i_srst='1') else
                i_data when (i_address = "100") else
                r4_reg;

    r5_next<=   r5_reg when (i_en='0') else 
                rst_value when (i_srst='1') else
                i_data when (i_address = "101") else
                r5_reg;

    r6_next<=   r6_reg when (i_en='0') else 
                rst_value when (i_srst='1') else
                i_data when (i_address = "110") else
                r6_reg;

    r7_next<=   r7_reg when (i_en='0') else 
                rst_value when (i_srst='1') else
                i_data when (i_address = "111") else
                r7_reg;

    o_r0<= r0_reg;
    o_r1<= r1_reg;
    o_r2<= r2_reg;
    o_r3<= r3_reg;
    o_r4<= r4_reg;
    o_r5<= r5_reg;
    o_r6<= r6_reg;
    o_r7<= r7_reg;

end architecture ;