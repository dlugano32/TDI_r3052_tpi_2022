library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;

entity multiplier is
  generic
  (
    W : natural := 4
  );
  port
  (
    clk   : in  std_logic;
    rst   : in  std_logic;
    en    : in  std_logic;
    srst  : in  std_logic;
    start : in  std_logic;
    a     : in  std_logic_vector(  W-1 downto 0);
    b     : in  std_logic_vector(  W-1 downto 0);
    p     : out std_logic_vector(2*W-1 downto 0);
    p_end : out std_logic
  );
end entity multiplier;

architecture fsmd of multiplier is
  type    state is (ST_IDLE, ST_LOAD, ST_COMP, ST_CALC, ST_UPDATE, ST_COUNT, ST_END);
  signal  state_reg, state_next : state;
  signal  a_ext16               : unsigned(2*W-1 downto 0);
  signal  a_u                   : unsigned(  W-1 downto 0);
  signal  acc_reg, acc_next     : unsigned(2*W-1 downto 0);
  signal  b_u                   : unsigned(  W-1 downto 0);
  signal  c_reg, c_next         : unsigned(  W-1 downto 0);
  signal  m_reg, m_next         : unsigned(  W-1 downto 0);
  signal  s_reg, s_next         : unsigned(2*W-1 downto 0);
  signal  total_bits            : natural;
  signal  total_bits_u          : unsigned(  W-1 downto 0);
  constant zeros                : unsigned(  W-1 downto 0) := (others => '0');
begin
  --Registro de estados
  process(rst, clk)
  begin
    if (rst = '1') then
      state_reg <= ST_IDLE;
    elsif (rising_edge(clk)) then
      if (srst = '1') then
        state_reg <= ST_IDLE;
      elsif (en = '1') then
        state_reg <= state_next;
      end if;
    end if;
  end process;
  
  --Registros de datos
  process(rst, clk)
  begin
    if (rst = '1') then
      acc_reg <= (others => '0');
      c_reg   <= (others => '0');
      m_reg   <= (others => '0');
      s_reg   <= (others => '0');
    elsif (rising_edge(clk)) then
      if (srst = '1') then
        acc_reg <= (others => '0');
        m_reg   <= (others => '0');
        c_reg   <= (others => '0');
        s_reg   <= (others => '0');
      elsif (en = '1') then
        acc_reg <= acc_next;
        c_reg   <= c_next;
        m_reg   <= m_next;
        s_reg   <= s_next;
      end if;
    end if;
  end process;
  
  process (state_reg, c_reg, m_reg, start)
  begin
    state_next <= state_reg;

    case state_reg is
      when ST_IDLE =>
        if (start = '1') then
          state_next <= ST_LOAD;
        end if;
      when ST_LOAD =>
        state_next <= ST_COMP;
      when ST_COMP =>
        if (m_reg(0) = '1') then
          state_next <= ST_CALC;
        else
          state_next <= ST_UPDATE;
        end if;
      when ST_CALC =>
        state_next <= ST_UPDATE;
      when ST_UPDATE =>
        state_next <= ST_COUNT;
      when ST_COUNT =>
        if (c_reg = 0) then
          state_next <= ST_END;
        else
          state_next <= ST_COMP;
        end if;
      when ST_END =>
        state_next <= ST_IDLE;
    end case;
  end process;
  
  -- auxiliares
  a_ext16      <= zeros & a_u;
  a_u          <= unsigned(a);
  b_u          <= unsigned(b);
  total_bits   <= W;
  total_bits_u <= to_unsigned(total_bits, W);
  
  -- registros de datos - logica de estados futuros
  acc_next <= (others => '0') when (state_reg = ST_LOAD) else
              acc_reg + s_reg when (state_reg = ST_CALC) else
              acc_reg;
              
  c_next   <= total_bits_u when (state_reg = ST_LOAD)   else
              c_reg - 1    when (state_reg = ST_UPDATE) else
              c_reg;
  
  m_next   <= b_u                       when (state_reg = ST_LOAD)   else
              '0' & m_reg(W-1 downto 1) when (state_reg = ST_UPDATE) else
              m_reg;
  
  s_next   <= a_ext16                     when (state_reg = ST_LOAD)   else
              s_reg(2*W-2 downto 0) & '0' when (state_reg = ST_UPDATE) else
              s_reg;
  
  p        <= std_logic_vector(acc_reg);
  
  p_end    <= '1' when (state_reg = ST_END) else '0';
end architecture fsmd;