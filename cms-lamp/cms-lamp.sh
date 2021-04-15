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
		echo "Instalación Completada"
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
                echo "Instalación Completada"
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
                echo "Instalación Completada"
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        pause
}

four(){
                clear
        echo "Instalar-Netdata"

        if
                apt-get install -y netdata netdata-*

                apt-get install -y bash curl iproute2 python python-yaml python-beanstalkc python-dnspython python-ipaddress python-pymysql python-psycopg2 python-pymongo nodejs lm-sensors libmnl0 netcat liblz4-1 libjudydebian1 openssl git cmake

                apt-get install -y zlib1g-dev uuid-dev libuv1-dev liblz4-dev libjudy-dev libssl-dev libmnl-dev gcc make git autoconf autoconf-archive autogen automake pkg-config curl python

                git clone https://github.com/netdata/netdata.git --depth=100

                chmod 777 -R netdata/

                cd netdata

                ./netdata-installer.sh

        then
                echo "Instalación Completada"
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        pause
}

five(){

        clear
	echo "1. Instalar-Todo"

	if
                apt-get update
                
		apt install -y apache2 libapache2-mod-php php-mysql mariadb-server
		
		apt -y install php-bcmath php-curl php-imagick php-gd php-mbstring php-xml php-zip

                wget https://es.wordpress.org/latest-es_ES.tar.gz

                tar -xf latest-es_ES.tar.gz -C /var/www/html

                chown $USER:www-data /var/www/html/wordpress/ -R

                chmod g+w /var/www/html/wordpress/ -R

                systemctl reload apache2.service
                
                apt -y install php-bz2 php-mbstring php-zip

                wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.xz

                tar -xf phpMyAdmin-5.0.2-all-languages.tar.xz -C /var/www/html/

                mv /var/www/html/phpMyAdmin-5.0.2-all-languages/ /var/www/html/phpmyadmin

                chown www-data /var/www/html/phpmyadmin/

                systemctl reload apache2
                
                apt-get install -y netdata netdata-*

                apt-get install -y bash curl iproute2 python python-yaml python-beanstalkc python-dnspython python-ipaddress python-pymysql python-psycopg2 python-pymongo nodejs lm-sensors libmnl0 netcat liblz4-1 libjudydebian1 openssl git cmake

                apt-get install -y zlib1g-dev uuid-dev libuv1-dev liblz4-dev libjudy-dev libssl-dev libmnl-dev gcc make git autoconf autoconf-archive autogen automake pkg-config curl python

                git clone https://github.com/netdata/netdata.git --depth=100

                chmod 777 -R netdata/

                cd netdata

                ./netdata-installer.sh
                

		
	then
		echo "Instalación Completada"
	else
	    	echo -e "${RED}Error...${STD}" && sleep 5

	fi
	pause


}

six(){
        clear
        echo "6. Instalar-OwnCloud"

        if
                apt-get update

                apt -y install gnupg php-apcu php-curl php-gd php-intl php-mbstring php-xml php-zip php-mysql php-pgsql

                wget https://download.owncloud.org/community/owncloud-complete-20210326.tar.bz2

                tar -xf owncloud-complete-20210326.tar.bz2 -C /var/www/

                chown -R www-data: /var/www/owncloud/

                cat oc.txt > /etc/apache2/conf-available/owncloud.conf

                systemctl reload apache2.service

                a2enconf owncloud

                systemctl reload apache2

        then
                echo "Instalación Completada"
        else
                echo -e "${RED}Error...${STD}" && sleep 5

        fi
        pause
}

show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "  Instalación De cms Lamp   "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Instalar-Lamp"
	echo "2. Instalar-Wordpress"
	echo "3. Instalar-phpMyAdmin"
	echo "4. Instalar-Netdata"
	echo "5. Instalar-Todo"
        echo "6. Instalar-OwnCloud"
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
		7) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

trap '' SIGINT SIGQUIT SIGTSTP

while true
do
	show_menus
	read_options
done
