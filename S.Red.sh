#!/bin/bash

## ----------------------------------
# Define variables
# ----------------------------------
EDITOR=nano
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'

# ----------------------------------
# User defined function
# ----------------------------------
pause(){
	read -p "Presiona [Enter] para continuar..." fackEnterKey
}

one(){
	echo "Verificación de Root"
	echo "Comprobando logueo de Root"
	if
		ifconfig
	then
		echo "Esta como root"
	else
	    	echo "Se a producido un fallo"
	    	sleep 5
	fi
	pause
}

# do something in two()
two(){
	echo "Snifer De Red"
	echo "Introduzca un nombre para la captura"
	read Nombre
	if
		cat $Nombre.bash
	then
		clear
		echo "El fichero existe"
	else
		echo "No existe el fichero"
        	tcpdump -D
        	tcpdump -w  $Nombre.bash -s 0
	fi
	pause
}

three(){
	clear
	echo "Intalar paquetes necesários"
	echo "Los paquetes necesarios son los siguientes: tcpdump,wireshark"
	pause

	if
		which tcpdump
	then
		echo "El paquete tcpdump esta instalado"
	else
	   	echo "El paquete tcpdump no esta instalado"
	    	pause
	    	apt-get install tcpdump
	fi
	pause
	clear

	if
		which wireshark
	then
		echo "El paquete wireshark esta instalado"
	else
		echo "El paquete wireshark no esta instalado"
	    	pause
	    	apt-get install wireshark
	fi
	pause
}

four(){
	echo "Inserte el Nombre de la captura"
	read Nombre

	if
		cat $Nombre.bash
	then
		echo "Ejecutando el archivo"
		wireshark $Nombre.bash
	else
	    	echo "Error. No se pudo ejecutar el archivo"
	fi
	pause
}

five(){
	echo "Inserte el nombre de la captura"
	read Nombre
	echo "De un nombre a la Traducción"
	read Nombre2

	if
		tcpdump -r $Nombre.bash > $Nombre2
	then
		echo "La traducción se a completado"
		cat $Nombre2
	else
		echo "La traducción a fallado"

	fi
	pause
}

six(){
	echo "Inserte el nombre del fichero que contiene la Traducción"
	read Nombre
	echo "Inserte lo que quiere buscar en el fichero"
	read Busqueda
	echo "De un nombre al nuevo fichero de traducción"
	read Nombre2

	if
		cat $Nombre
	then
		echo "Se encontro el fichero"
	else
		echo "Se produjo un fallo"
	fi

	if
		grep -w $Busqueda $Nombre
	then
		grep -w $Busqueda $Nombre > $Nombre2
	else
		echo "Se produjo un fallo"
	fi
	pause
}

seven(){
	clear
	echo "Este Script lo que hace es capturar el trafico que la tarjeta de red detecta y lo introduce en un fichero que podemos o traducir o ejecutar con wireshark"
	pause
	clear
	echo "La traducción sirve en el caso de que no entienda wireshark que pueda leer el contenido del fichero en uno nuevo que no este codificado"
	pause
	clear
	echo "Este Script solo funciona en distribuciones de Linux"
	pause
	clear
	echo "Este Script a sido creado con fines educativos no me hago responsable de cualquier acción negativa que pueda generar"
	pause
}

# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " Capturar Trafico Red "
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Verificar inicio de Root"
	echo "2. Snifer De Red"
	echo "3. Instalación de paquetes"
	echo "4. Visualizar en wireshark"
	echo "5. Traducción De Captura"
	echo "6. Busqueda En Captura"
	echo "7. Detalles Del Script"
	echo "8. Exit"
}
# Lee la accion sobre el teclado y la ejecuta.
# Invoca el () cuando el usuario selecciona 1 en el menú.
# Invoca a los dos () cuando el usuario selecciona 2 en el menú.
# Salir del menu cuando el usuario selecciona 3 en el menú.
read_options(){
	local choice
	read -p "Escoje una opción [ 1 - 8] " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) three ;;
		4) four ;;
		5) five ;;
		6) six ;;
		7) seven ;;
		8) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

# ----------------------------------------------
# Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP

# -----------------------------------
# Main logic - infinite loop
# ------------------------------------
while true
do
	show_menus
	read_options
done
