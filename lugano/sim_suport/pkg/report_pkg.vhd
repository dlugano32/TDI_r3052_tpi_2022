LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;

package report_pkg is

   procedure report_begin;

   procedure report_end;

   function  report_error(
      constant ev      : in std_logic_vector;
      constant cv      : in std_logic_vector;
      constant cv_name : in string;
      constant format  : in string
   ) return boolean;

   function  report_error_bit(
      constant ev      : in std_logic;
      constant cv      : in std_logic;
      constant cv_name : in string
   ) return boolean;

   procedure  report_pass_fail(
      constant errors  : in integer
   );

   function bin (lvec: in std_logic_vector) 
      return string;


end report_pkg;

-------------------------------------------------------------------------------
-- begin of package
package body report_pkg is

   procedure report_begin is
   begin
      report LF &
             "----------------------------------------" & LF &
             "COMIENZO DE LA SIMULACION"                & LF &
             "----------------------------------------" & LF ;
   end procedure report_begin;

   procedure report_end is
   begin
      report LF &
             "---------------------------------" & LF &
             "FIN  DE  LA  SIMULACION"           & LF &
             "---------------------------------" & LF
      severity note;
   end procedure report_end;

   function report_error(
      constant ev      : in std_logic_vector;
      constant cv      : in std_logic_vector;
      constant cv_name : in string;
      constant format  : in string
   ) return boolean is
   begin
      if (ev /= cv) then
         if (format = "bin") then
            report LF &
                  "************************************************" & LF &
                  "    ERROR al evaluar " & cv_name & "."            & LF &
                  "************************************************" & LF &
                  "        Valor esperado de " & cv_name & " = " & bin(ev) & LF &
                  "        Valor actual   de " & cv_name & " = " & bin(cv) & LF & LF;
         elsif (format = "dec") then
            report LF &
                  "************************************************" & LF &
                  "    ERROR al evaluar " & cv_name & "."            & LF &
                  "************************************************" & LF &
                  "        Valor esperado de " & cv_name & " = " & INTEGER'IMAGE(to_integer(unsigned(ev))) & LF &
                  "        Valor actual   de " & cv_name & " = " & INTEGER'IMAGE(to_integer(unsigned(cv))) & LF & LF;
         elsif (format = "sign") then
            report LF &
                  "************************************************" & LF &
                  "    ERROR al evaluar " & cv_name & "."            & LF &
                  "************************************************" & LF &
                  "        Valor esperado de " & cv_name & " = " & INTEGER'IMAGE(to_integer(signed(ev))) & LF &
                  "        Valor actual   de " & cv_name & " = " & INTEGER'IMAGE(to_integer(signed(cv))) & LF & LF;
         else
            report "Invalid argument when using report_error function!!!"
            severity failure;
         end if;
         return TRUE;
      else
         return FALSE;
      end if;
   end function report_error;

   function report_error_bit(
      constant ev      : in std_logic;
      constant cv      : in std_logic;
      constant cv_name : in string
   ) return boolean is
   begin
      if (ev /= cv) then
         report LF &
                "************************************************" & LF &
                "    ERROR al evaluar " & cv_name & "."            & LF &
                "************************************************" & LF &
                "        Valor esperado de " & cv_name & " = " & STD_LOGIC'IMAGE(ev) & LF &
                "        Valor actual   de " & cv_name & " = " & STD_LOGIC'IMAGE(cv) & LF & LF;
         return TRUE;
      else
         return FALSE;
      end if;
   end function report_error_bit;

   procedure report_pass_fail(
      constant errors  : in integer
   ) is
   begin
      if (errors /= 0) then
         report LF &
                "-------------------------------------------------" & LF &
                " LA SIMULACION NO FUE EXITOSA"                     & LF &
                " Se han detectado:"                                & LF &
                "     " & INTEGER'IMAGE(errors) & " errores."       & LF &
                " Revise los mensajes previos para     "            & LF &
                " poder corregir los errores cometidos."            & LF &
                "-------------------------------------------------" & LF;
      else
         report LF &
                "------------------------------------------------" & LF &
                "LA SIMULACION FUE SATISFACTORIA!"                 & LF &
                "------------------------------------------------" & LF;
      end if;
   end procedure report_pass_fail;

   function bin (lvec: in std_logic_vector) return string is
      variable rtext: string(lvec'length-1 downto 0) := (others => '9');
   begin
      for k in lvec'range loop
          case lvec(k) is
              when '0' => rtext(k) := '0';
              when '1' => rtext(k) := '1';
              when 'U' => rtext(k) := 'U';
              when 'X' => rtext(k) := 'X';
              when 'Z' => rtext(k) := 'Z';
              when '-' => rtext(k) := '-';
              when others => rtext(k) := '?';
          end case;
      end loop;
      return rtext;
  end function;


end package body report_pkg;
