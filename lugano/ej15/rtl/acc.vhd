library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity acc is
  port 
  (
    bin         :   in  std_logic_vector(7 downto 0);
    acc_curr    :   in  std_logic_vector(15 downto 0);
    mode        :   in  std_logic;
    acc_next    :   out std_logic_vector(15 downto 0);
    sat         :   out std_logic
  ) ;
end acc ; 

architecture arch of acc is
    signal  acc_curr_u, bin_u, res_u: unsigned(16 downto 0);
    signal  sat_val : std_logic_vector(15 downto 0);
    signal  c : std_logic;

    constant sat_val_max    : std_logic_vector (15 downto 0) := (others => '1'); -- Sat_val_max=65535;
    constant sat_val_min    : std_logic_vector (15 downto 0) := (others => '0'); -- Sat_val_min=0;
    constant zeros  : std_logic_vector(8 downto 0) := (others => '0');
begin
    acc_curr_u<= ('0' & unsigned(acc_curr)) when (mode ='0') else ('1' & unsigned(acc_curr)); --Hago un vector de 17 para que el ultimo sea el carry
    bin_u<= unsigned(zeros & bin);

    res_u<= (acc_curr_u+bin_u) when (mode='0') else (acc_curr_u-bin_u); --Suma o resta dependiendo del modo

    c<= std_logic(res_u(16)) when (mode='0') else std_logic(not(res_u(16))); --Carry o borrow dependiendo del modo

    sat_val<= sat_val_max when (mode='0') else sat_val_min; --Valor de saturacion dependiendo del modo

    acc_next<=  std_logic_vector(res_u(15 downto 0)) when (c='0') else std_logic_vector(sat_val);
    sat<=c;

end architecture;