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
	echo "Particionado del disco"
		
		lsblk
		echo "Especifique la unidad a partifionar"
		read Unidad
		cfdisk $Unidad
		lsblk
	if
		echo "Especifique la partición / del sistema"
		read Particion1
		mkfs.ext4 $Particion1
		mount $Particion1 /mnt	
	then	
		echo "1ºPartición Completada"
		pause
	else
		echo -e "${RED}Error...${STD}" && sleep 2
		umount /mnt
		pause
		exit
	fi

	if
		echo "Especifique la particion swap del sistema"
		read Particion2
		mkswap $Particion2
		swapon $Particion2
	then
		clear
		lsblk
		lsblk -f
		echo "Particionado completado"
		pause

	else
	    	echo -e "${RED}Error...${STD}" && sleep 2
		umount /mnt
		pause
	fi

}

# do something in two()
two(){


	one(){
        	clear
		echo "Se a seleccionado la instalación Bios"
		pacstrap /mnt base base-devel grub-bios os-prober ntfs-3g networkmanager gvfs gvfs-afc gvfs-mtp xdg-user-dirs linux linux-firmware nano dhcpcd net-tools
		arch-chroot useradd /mnt
		echo "Introduzca una contraseña para el usuario root"
		passwd
	
        	pause
		arch-chroot /mnt
}	

        two(){
        	clear
        	echo "Se a seleccionado la instalación Efi"
		pacstrap /mnt base base-devel efibootmgr os-prober ntfs-3g networkmanager grub gvfs gvfs-afc gvfs-mtp xdg-user-dirs linux linux-firmware nano dhcpcd net-tools
		arch-chroot useradd /mnt
		echo "Introduzca una contraseña para el usuario root"
		passwd

		pause
		arch-chroot /mnt
}

# function to display menus
show_menus() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo " Tipo De Instalación "
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Bios"
        echo "2. Efi"
        echo "3. Exit"
}
read_options(){
        local choice
        read -p "Escoje una opción [ 1 - 3] " choice
        case $choice in
                1) one ;;
                2) two ;;
                3) exit 0;;
                *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
}
}

three(){
	clear
	echo "Configurar el sistema base"

	if
		echo "Inserte un nombre de host"
		read nombredehost
		echo  $nombredehost > /etc/hostname
		echo "Indique zona horaria"
		ls /usr/share/zoneinfo/Europe/
		read zhoraria
		ln -sf /usr/share/zoneinfo/Europe/$zhoraria
		ln -sf /usr/share/zoneinfo/Europe/$zhoraria /etc/localtime
		echo "Idioma del sistema"
		sleep 2
		nano /etc/locale.gen
		locale-gen
		hwclock -w
		pause
	then
		echo "Configuración terminada"
	else
		echo -e "${RED}Error...${STD}" && sleep 2
	fi
}

four(){


        one(){
                
	if
		clear
                echo "Se a seleccionado Grub Bios"
                echo "Indique en que unidad quiere instalar el grub"
		lsblk
		read unidadgrub
		grub-install $unidadgrub
		grub-mkconfig -o /boot/grub/grub.cfg
		os-prober
		grub-mkconfig -o /boot/grub/grub.cfg
	then
		echo "La instalación y configuración del cargador de arranque grub a finalizado"

	else
		echo -e "${RED}Error...${STD}" && sleep 2
	fi
	pause
}

        two(){
                clear
	if

		echo "Se a seleccionado el Grub Efi"
		mkdir /boot/efi
		grub-install --efi-directory=/boot/efi --bootloader-id='Arch Linux' --target=x86_64-efi
		grub-mkconfig -o /boot/grub/grub.cfg
		os-prober
		grub-mkconfig -o /boot/grub/grub.cfg
	then
		echo "La instalación y configuración del cargador de arranque grub a finalizado"
	else
		echo -e "${RED}Error...${STD}" && sleep 2
	fi

                pause
}

# function to display menus
show_menus() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo " 	   Tipo De Grub    "
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Bios"
        echo "2. Efi"
        echo "3. Exit"
}
read_options(){
        local choice
        read -p "Escoje una opción [ 1 - 3] " choice
        case $choice in
                1) one ;;
                2) two ;;
                3) exit 0;;
                *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
}
}


five(){
        one(){
		if
			clear
			echo "Indique el nombre del nuevo usuario"
			read nombreusuario
			useradd -m -g users -s /bin/bash $nombreusuario
			echo "Contraseña para el usuario"
			passwd $nombreusuario
		then
			echo "Usuario Creado"
		else
			echo -e "${RED}Error...${STD}" && sleep 2
		fi
			pause
}

        two(){
                clear
	if
                echo "Indique el usuario que quiere eliminar"
                ls /home
		read usuariodel
                userdel -r $usuariodel
	then
		echo "Usuario eliminado"
	else
		echo -e "${RED}Error...${STD}" && sleep 2
	fi
		pause
}

# function to display menus
show_menus() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo " Gestión De Usuarios "
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Crear usuario"
        echo "2. Borrar usuario"
        echo "3. Exit"
}
read_options(){
        local choice
        read -p "Escoje una opción [ 1 - 3] " choice
        case $choice in
                1) one ;;
                2) two ;;
                3) exit 0;;
                *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
}
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
	echo "Instalación Arch-Linux"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Particionado Del Disco"
	echo "2. Instalación Del Sistema Base"
	echo "3. Configurar El Sistema Base"
	echo "4. Instalación y Configuración Del Cargador De Arranque Grub"
	echo "5. Gestión De Usuarios"
	echo "6. Filtrar Busquedas"
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
