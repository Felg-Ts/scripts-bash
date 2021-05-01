#!/bin/bash

RED='\033[0;41;30m'
STD='\033[0;0;39m'

pause(){
	read -p "Presiona [Enter] para continuar..." fackEnterKey
}

one(){
        clear
	echo "1. Instalar-Lamp"

	if
                apt-get update
		apt install -y apache2 libapache2-mod-php php-mysql mariadb-server

		
	then
		echo "Instalación de Lamp Completada."
	else
	    	echo -e "${RED}Error...${STD}" && sleep 5

	fi
	pause
}

two(){
	clear
        echo "2. Instalar-Wordpress"

        if
                apt-get update

                apt -y install php-bcmath php-curl php-imagick php-gd php-mbstring php-xml php-zip

                wget https://es.wordpress.org/latest-es_ES.tar.gz

                tar -xf latest-es_ES.tar.gz -C /var/www/html

                chown $USER:www-data /var/www/html/wordpress/ -R

                chmod g+w /var/www/html/wordpress/ -R

                systemctl reload apache2.service

        then
                echo "Instalación de Wordpress Completada."
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        pause
}

three(){
	clear
        echo "3. Instalar-phpMyAdmin"

        if

                apt-get update

                apt -y install php-bz2 php-mbstring php-zip

                wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.xz

                tar -xf phpMyAdmin-5.0.2-all-languages.tar.xz -C /var/www/html/

                mv /var/www/html/phpMyAdmin-5.0.2-all-languages/ /var/www/html/phpmyadmin

                chown www-data /var/www/html/phpmyadmin/

                systemctl reload apache2


                
        then
                echo "Instalación de phpMyAdmin Completada."
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        pause
}

four(){
        clear
        echo "Instalar-Netdata"

        if
                apt install curl
                curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh | sudo bash
                apt -y install netdata

        then
                echo "Instalación de Netdata Completada."
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        pause
}

five(){
        clear
        echo "6. Instalar-OwnCloud"

        if
                apt-get update

                apt -y install gnupg php-apcu php-curl php-gd php-intl php-mbstring php-xml php-zip php-mysql php-pgsql

                wget https://download.owncloud.org/community/owncloud-complete-20210326.tar.bz2

                tar -xf owncloud-complete-20210326.tar.bz2 -C /var/www/

                chown -R www-data: /var/www/html/owncloud/

                cat oc.txt > /etc/apache2/conf-available/owncloud.conf

                systemctl reload apache2.service

                a2enconf owncloud

                systemctl reload apache2

        then
                echo "Instalación de OwnCloud Completada."
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
	pause


}

six(){
        clear
        echo "6. Instalar-Todo"

        if
                echo "Comenzando instalaciones."
                if
                        one
                then
                        if
                                two
                        then
                                if
                                        three
                                then
                                        if
                                                four
                                        then
                                                five
                                        else
                                                echo "Instalación de Wordpress fallida"
                                                echo -e "${RED}Error...${STD}" && sleep 5
                                        fi

                                else
                                        echo "Instalación de phpMyAdmin fallida"
                                        echo -e "${RED}Error...${STD}" && sleep 5
                                fi
                        else

                                echo "Instalación de Wordpress fallida"
                                echo -e "${RED}Error...${STD}" && sleep 5
                        fi

                else
                        echo "Instalación de Lamp fallida"
                        echo -e "${RED}Error...${STD}" && sleep 5
                fi
                
        
        then
                        echo "Proceso finalizado"
        else
                echo -e "${RED}Error...${STD}" && sleep 5
        fi
        pause
}

seven(){
        clear
        echo "Bases De Datos"

        sql_host=”localhost”
        slq_usuario=”root”
        sql_password=”usuario”
        sql_database=”nombre_db”
        sql_args=”-h $sql_host -u $slq_usuario -p$sql_password -D $sql_database -s -e”
        mysql $sql_args “SELECT * from usuarios;”

}

show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " Instalación De cms en Lamp "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Instalar-Lamp"
	echo "2. Instalar-Wordpress"
	echo "3. Instalar-phpMyAdmin"
	echo "4. Instalar-Netdata"
	echo "5. Instalar-OwnCloud"
        echo "6. Instalar-Todo"
        echo "7. Bases De Datos"
	echo "8. Exit"
}

read_options(){
	local choice
	read -p "Escoje una opción [ 1 - 6] " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) three ;;
		4) four ;;
		5) five ;;
                6) six ;;
		7) seven
                8) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

trap '' SIGINT SIGQUIT SIGTSTP

while true
do
	show_menus
	read_options
done
