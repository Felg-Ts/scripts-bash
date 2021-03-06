#Este script se encarga de instalar Lamp y tambien tiene la posibilidad de instalar cms y una aplicación para monitorizar el rendimiento (netdata). 
#En la instalación de cada aplicación se instala sus dependencias, se descargar el binario de aplicación, 
#lo descomprime, lo mueve al directorio /var/www/html, 
#le ajusta los permisos para que lo controle apache y crea sus bases de datos mas un fichero ubicado en /root con todo lo necesario para poder continuar con la instalación desde el navegador y en caso de fallo en la creación de las bases de datos en las instalaciones hay un segundo menú con opciones para unicamente crear las bases de datos.

#!/bin/bash

RED='\033[0;41;30m'
STD='\033[0;0;39m'

#Función para añadir pausas durante las ejecuciones de las otras funciones.

pause(){
	read -p "Presiona [Enter] para continuar..." fackEnterKey
}

#Función para intalación de una pila lamp.

one(){
        clear
	echo "1. Instalar-Lamp"

#Instalación de paquetes necesarios para lamp y en caso de fallo da un mensaje de error

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

#Función para instalación y configuración de cms wordpress.

two(){
	clear
        echo "2. Instalar-Wordpress"

        if

#Instalación de paquetes necesarios para wordpress + descarga del binario de wordpress y ajustes de permisos.

                apt-get update

                apt -y install php-bcmath php-curl php-imagick php-gd php-mbstring php-xml php-zip

                wget https://es.wordpress.org/latest-es_ES.tar.gz

                tar -xf latest-es_ES.tar.gz -C /var/www/html

                chown $USER:www-data /var/www/html/wordpress/ -R

                chmod g+w /var/www/html/wordpress/ -R

#Creación del fichero virtualhosts y activación de módulos para el acceso desde el navegador.

                echo "
                <Directory /var/www/html/wordpress>
                        AllowOverride all
                </Directory>
                " >> /etc/apache2/conf-available/wordpress.conf

                a2enmod rewrite

                a2enconf wordpress

                systemctl reload apache2.service

        then

#Creación de la base de datos para wordpress y generación de fichero de credenciales para la instalación de wordpress.

                echo "Instalación de Wordpress Completada."
                if
                        echo "Base de datos de Wordpress"
                        slq_usuario=root
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
                        echo "Se a creado un fichero en /$USER/acccesowordpress.txt con la información de acceso a wordpress"

                else
                echo "Error en la creación de la base de datos"
                fi
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        pause
}

#Función para instalación y configuración de phpmyadmin.

three(){
	clear
        echo "3. Instalar-phpMyAdmin"

        if

#Instalación de paquetes necesarios para phpyadmin + descarga del binario de phpmyadmin y ajustes de permisos.

                apt-get update

                apt -y install php-bz2 php-mbstring php-zip

                wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.xz

                tar -xf phpMyAdmin-5.0.2-all-languages.tar.xz -C /var/www/html/

                mv /var/www/html/phpMyAdmin-5.0.2-all-languages/ /var/www/html/phpmyadmin

                chown www-data /var/www/html/phpmyadmin/

                systemctl reload apache2

                echo "Instalación de Netdata Completada."

                if

#Creación de la base de datos para phpmyadmin (este usuario puede acceder al resto de bases de datos) y generación de fichero de credenciales para la instalación de phpmyadmin.


                        echo "Base de datos de phpMyAdmin"
                        slq_usuario=root
                        mysql -u $slq_usuario -p$sql_password -s -e "create database phpmyadmin charset utf8mb4 collate utf8mb4_unicode_ci;"
                        mysql -u $slq_usuario -p$sql_password -s -e "create user phpmyadmin@localhost identified by 'usrphpmyadmin123';"
                        mysql -u $slq_usuario -p$sql_password -s -e "grant all privileges on *.* to phpmyadmin@localhost;"
                        mysql -u $slq_usuario -p$sql_password -s -e "flush privileges;"
                then
                        echo "Base de datos creada"
                        echo "
                        accceso: localhost/phpmyadmin
                        nombre de la base de datos: phpmyadmin
                        usuario db: phpmyadmin
                        contraseña db: usrphpmyadmin123 " >> /$USER/acccesophpmyadmin.txt
                        echo "Se a creado un fichero en /$USER/acccesophpmyadmin.txt con la información de acceso a phpmyadmin"

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

#Función para instalación y configuración de netdata.

four(){
        clear
        echo "Instalar-Netdata"

        if
                apt install curl
                curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh | sudo bash
                apt -y install netdata

        then

#Generación de fichero con ruta de acceso a netdata. (Esta instalación está pensada para acceder a netdata desde el localhosts.)


                echo "Instalación de Netdata Completada."
                echo "
                accceso: localhost:19999" >> /$USER/acccesonetdata.txt
                echo "Se a creado un fichero en /$USER/acccesonetdata.txt con la información de acceso a netdata"
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        pause
}

#Función para instalación y configuración de owncloud.

five(){
        clear
        echo "6. Instalar-OwnCloud"

        if

#Instalación de paquetes necesarios para owncloud + descarga del binario de owncloud y ajustes de permisos.

                apt-get update

                apt -y install gnupg php-apcu php-curl php-gd php-intl php-mbstring php-xml php-zip php-mysql php-pgsql

                wget https://download.owncloud.org/community/owncloud-complete-20210326.tar.bz2

                tar -xf owncloud-complete-20210326.tar.bz2 -C /var/www/html/

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

#Creación de la base de datos para owncloud y generación de fichero de credenciales para la instalación de owncloud.

                        echo "Base de datos de OwnCloud"
                        slq_usuario=root
                        mysql -u $slq_usuario -p$sql_password -s -e "create database ownCloud charset utf8mb4 collate utf8mb4_unicode_ci;"
                        mysql -u $slq_usuario -p$sql_password -s -e "create user ownCloud@localhost identified by 'usrownCloud123';"
                        mysql -u $slq_usuario -p$sql_password -s -e "grant all privileges on ownCloud.* to ownCloud@localhost;"
                        mysql -u $slq_usuario -p$sql_password -s -e "flush privileges;"
                then

                        echo "Base de datos creada"
                        echo "
                        accceso: localhost/owncloud
                        nombre de la base de datos: ownCloud
                        usuario db: ownCloud
                        contraseña db: usrownCloud123 " > /$USER/acccesoownCloud.txt
                        echo "Se a creado un fichero en /$USER/acccesoownCloud.txt con la información de acceso a ownCloud"

                else
                echo "Error en la creación de la base de datos"
                fi

                
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        
	pause

}

#Función que ejecuta todas las funciones anteriores relacionadas con las intalaciones y configuraciones.

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
                        echo "Todos los ficheros con la información de acceso se encuentran en el directorio /$USER/"
        else
                echo -e "${RED}Error...${STD}" && sleep 5
        fi
        pause
}

#Función que muestra un menú secundario para la creación de las bases de datos en caso de fallo en la instalación.

seven(){
        while true
        do
	show_menus_db
	read_options_db
        done
}

#Función que crea la base de datos para la aplicación wordpress (esta función se ejecuta en caso de que en la función original de instalación fallase en este proceso).

one_db(){
        if
                echo "Base de datos de Wordpress"
                slq_usuario=root
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
        pause
}

#Función que crea la base de datos para la aplicación phpmyadmin (esta función se ejecuta en caso de que en la función original de instalación fallase en este proceso).

two_db(){
        if
                echo "Base de datos de phpMyAdmin"
                slq_usuario=root
                mysql -u $slq_usuario -p$sql_password -s -e "create database phpmyadmin charset utf8mb4 collate utf8mb4_unicode_ci;"
                mysql -u $slq_usuario -p$sql_password -s -e "create user phpmyadmin@localhost identified by 'usrphpmyadmin123';"
                mysql -u $slq_usuario -p$sql_password -s -e "grant all privileges on *.* to phpmyadmin@localhost;"
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
        pause
}

#Función que crea la base de datos para la aplicación owncloud (esta función se ejecuta en caso de que en la función original de instalación fallase en este proceso).

three_db(){
        if
                echo "Base de datos de OwnCloud"
                slq_usuario=root
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
        pause
}

four_db(){

        while true
        do
	show_menus
	read_options
        done

}
#Función que muestra el menú principal de opciones para ejecutar las funciones.

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
        echo "7. Generación Bases de Datos"
        echo "8. Exit"
}

#Función para ejecutar las funciones del menú principal con una tecla concreta.

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
                8) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

#Función que muestra el menú secundario de creación de bases de datos.

show_menus_db() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " Bases de datos de los cms  "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "7-1. Generar db Wordpress"
	echo "7-2. Generar db phpMyAdmin"
	echo "7-3. Generar db OwnCloud"
        echo "7-4. Exit"
}

#Función para ejecutar las funciones de menú secundario con una tecla concreta.

read_options_db(){
	local choice1
	read -p "Escoje una opción [ 7-1 - 7-4] " choice1
	case $choice1 in
		7-1) one_db ;;
		7-2) two_db ;;
		7-3) three_db ;;
		7-4) four_db ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

#Lo primero que se ejecuta del script. Pide contraseña de root para la creación de las bases de datos y muestra el menú principal.

trap '' SIGINT SIGQUIT SIGTSTP

if [ $USER = "root" ]

then
#Tiene que introducir la contraseña de root para poder crear las bases de datos.

#En caso de no querer tener que poner la contraseña por cada ejecución comente las lineas. 
#Ojo el hacer esto implica que su contraseña la puede ver cualquiera que mire el codigo del script.
#1"echo "Introduzca la contraseña de root""
#2 "echo "Asegurese de escribir bien la contraseña o podria haber errores en las instalaciones.""
#y "read -s sql_password"
#Ahora quite el comentario a la linea "#sql_password=root" y cambia root por su contraseña de root.

        echo "Introduzca la contraseña de root"
        echo "Asegurese de escribir bien la contraseña o podria haber errores en las instalaciones."
        read -s sql_password
        #sql_password=root
        echo "Recuerde que para instalar los cms primero tiene que ser instalada la opción 1 (instalar-Lamp)"
        pause
else
        echo "Se necesita estar logueado como root"
        exit
fi

while true
do
	show_menus
	read_options
done
