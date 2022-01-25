#Actualizar información de los paquetes

apt update

#Actalizar version de los paquetes

apt upgrade -y

#Instalación de java JRE Debian 10

apt install -y default-jre

#Instalación de Java 8

apt update

apt install -y apt-transport-https gnupg

echo "deb http://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main" > /etc/apt/sources.list.d/adoptopenjdk.list

echo "# deb-src http://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main" >> /etc/apt/sources.list.d/adoptopenjdk.list

wget -qO- https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add

apt update

apt install -y adoptopenjdk-8-hotspot-jre

#Versión de java instalada

java -version

update-alternatives --config java

#Configuración de la variable Java_Home

echo $JAVA_HOME

echo "JAVA_HOME=/usr/lib/jvm/default-java" > /etc/environment

echo "JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-jre-amd64" >> /etc/environment

~$ source /etc/environment

#Comprobación de JAVA_HOME

echo $JAVA_HOME
/usr/lib/jvm/default-java