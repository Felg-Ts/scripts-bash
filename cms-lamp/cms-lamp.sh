#!/bin/bash

RED='\033[0;41;30m'
STD='\033[0;0;39m'

pause(){
	read -p "Presiona [Enter] para continuar..." fackEnterKey
}

one(){
        clear
	echo "1. Instalar-Lamp"
        echo "Quiere realizar la instalación de la pila Lamp? [y/n]"
        read vd

	if [ $vd = "y" ]
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
                
                echo "
                <Directory /var/www/html/wordpress>
                        AllowOverride all
                </Directory>
                " >> /etc/apache2/conf-available/wordpress.conf

                a2enmod rewrite

                a2enconf wordpress

                systemctl reload apache2.service

        then
                echo "Instalación de Wordpress Completada."
                if
                        echo "Base de datos de Wordpress"
                        slq_usuario=root
                        sql_password=usuario
                        mysql -u $slq_usuario -p$sql_password -s -e "create database wordpress charset utf8mb4 collate utf8mb4_unicode_ci;"
                        mysql -u $slq_usuario -p$sql_password -s -e "create user wordpress@localhost identified by 'usrwordpress123';"
                        mysql -u $slq_usuario -p$sql_password -s -e "grant all privileges on wordpress.* to wordpress@localhost;"
                        mysql -u $slq_usuario -p$sql_password -s -e "flush privileges;"
                then

                        echo "Base de datos creada"
                        echo "
                        accceso: localhost/wordpress
                        nombre de la base de datos: wordpress
                        usuario db: wordpress
                        contraseña db: usrwordpress123 " >> /$USER/acccesowordpress.txt
                        echo "Se a creado un fichero en /$USER/acccesowordpress.txt con la inforación de acceso a wordpress"

                else
                echo "Error en la creación de la base de datos"
                fi
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

                echo "Instalación de Netdata Completada."

                if
                        echo "Base de datos de phpMyAdmin"
                        slq_usuario=root
                        sql_password=usuario
                        mysql -u $slq_usuario -p$sql_password -s -e "create database phpmyadmin charset utf8mb4 collate utf8mb4_unicode_ci;"
                        mysql -u $slq_usuario -p$sql_password -s -e "create user phpmyadmin@localhost identified by 'usrphpmyadmin123';"
                        mysql -u $slq_usuario -p$sql_password -s -e "grant all privileges on wordpress.* to phpmyadmin@localhost;"
                        mysql -u $slq_usuario -p$sql_password -s -e "flush privileges;"
                then
                        echo "Base de datos creada"
                        echo "
                        accceso: localhost/phpmyadmin
                        nombre de la base de datos: phpmyadmin
                        usuario db: phpmyadmin
                        contraseña db: usrphpmyadmin123 " >> /$USER/acccesophpmyadmin.txt
                        echo "Se a creado un fichero en /$USER/acccesophpmyadmin.txt con la inforación de acceso a phpmyadmin"

                else
                echo "Error en la creación de la base de datos"
                fi
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
                echo "
                accceso: localhost:19999" >> /$USER/acccesonetdata.txt
                echo "Se a creado un fichero en /$USER/acccesonetdata.txt con la inforación de acceso a netdata"
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

                echo "
                <Directory /var/www/html/owncloud>
                        AllowOverride all
                </Directory>" >> /etc/apache2/conf-available/owncloud.conf

                a2enconf owncloud

                echo "*/15 * * * * www-data /usr/bin/php /var/www/owncloud/occ system:cron" >> /etc/cron.d/owncloud

                systemctl reload apache2.service

        then
                echo "Instalación de OwnCloud Completada."
                if
                        echo "Base de datos de OwnCloud"
                        slq_usuario=root
                        sql_password=usuario
                        mysql -u $slq_usuario -p$sql_password -s -e "create database ownCloud charset utf8mb4 collate utf8mb4_unicode_ci;"
                        mysql -u $slq_usuario -p$sql_password -s -e "create user ownCloud@localhost identified by 'usrownCloud123';"
                        mysql -u $slq_usuario -p$sql_password -s -e "grant all privileges on ownCloud.* to ownCloud@localhost;"
                        mysql -u $slq_usuario -p$sql_password -s -e "flush privileges;"
                then

                        echo "Base de datos creada"
                        touch /$USER/acccesownCloud.txt
                        echo "
                        accceso: localhost/ownCloud
                        nombre de la base de datos: ownCloud
                        usuario db: ownCloud
                        contraseña db: usrownCloud123 " > /$USER/acccesoownCloud.txt
                        echo "Se a creado un fichero en /$USER/acccesoownCloud.txt con la inforación de acceso a ownCloud"

                else
                echo "Error en la creación de la base de datos"
                fi

                
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
        echo "7. Exit"
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
		7) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

trap '' SIGINT SIGQUIT SIGTSTP

if [ $USER = "root" ]

then
        echo ""
else
        echo "Se necesita estar logueado como root"
        exit
fi

while true
do
	show_menus
	read_options
done
