library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity reg_status is
  port 
  (
    i_clk, i_rst, i_en, i_srst, i_ld_en : in std_logic;
    i_flags : in  std_logic_vector(3 downto 0);
    o_flags : out std_logic_vector(3 downto 0)
  ) ;
end reg_status ; 

architecture arch of reg_status is
    signal q_reg, q_next : std_logic_vector(3 downto 0);
    constant rst_value : std_logic_vector(3 downto 0) := (others => '0');
begin
    process (i_rst, i_clk)
    begin
        if(i_rst = '1') then
            q_reg<= rst_value;
        elsif (rising_edge(i_clk)) then
            q_reg <= q_next;
        end if;
    end process;

    q_next<= q_reg when (i_en='0') else 
            rst_value when (i_srst='1') else 
            q_reg when (i_ld_en='0') else 
            i_flags;

    o_flags<=q_reg;

end architecture ;