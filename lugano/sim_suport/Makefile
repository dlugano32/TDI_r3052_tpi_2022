###################################################################################################
# ARGUMENTS
###################################################################################################
GTK_ARGS = --rcvar 'fontname_signals Monospace 24' --rcvar 'fontname_waves Monospace 16'


###################################################################################################
# RULES
###################################################################################################
all: help

check: clean
	ghdl -a --workdir=. --work=work rtl/*

comp: clean
	ghdl -a --workdir=. --work=work rtl/* sim/pkg/* sim/*.vhd

elab: clean comp
	ghdl -e $(tle)

run: clean comp elab
	ghdl -r $(tle) --vcd=waves.vcd

waves:
	gtkwave waves.vcd $(GTK_ARGS)

clean:
	rm -rf *.cf *.vcd

help:
	clear
	@echo "*************************************************************************"
	@echo "   MENU DE AYUDA PARA EL ALUMNO                                          "
	@echo "*************************************************************************"
	@echo "                                                                         "
	@echo "    A continuación se listan las reglas para trabajar y algunos ejemplos "
	@echo "                                                                         "
	@echo "    check : Analiza el código RTL y reporta si hay errores de sintáxis   "
	@echo "            Comando > make check                                         "
	@echo "                                                                         "
	@echo "    run   : Simula la entidad de mayor jerarquía.                        "
	@echo "            Sólo válido para ejercicios que tienen TB disponible.        "
	@echo "            Requiere argumento tle=<module_tb>                           "
	@echo "            Ejemplo de uso: Para el ejercicio 1, la TLE es xor_gate_tb   "
	@echo "            Comando > make run tle=xor_gate_tb                           "
	@echo "                                                                         "
	@echo "    waves : Permite visualizar las formas de onda de la simulación       "
	@echo "            Sólo válido luego de correr el comando **run**               "
	@echo "            Comando > make waves                                         "
	@echo "                                                                         "
	@echo "    clean : Limpia el directorio de trabajo                              "
	@echo "            Comando > make clean                                         "
	@echo "                                                                         "
	@echo "    all   : Imprime este menu de opciones                                "
	@echo "            Comando > make                                               "
	@echo "                                                                         "
	@echo "*************************************************************************"
