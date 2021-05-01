if
    echo "Base de datos Wordpress"
        slq_usuario=”root”
        sql_password=”usuario”
        sql_database=”nombre_db”
        mysql -u $slq_usuario -p$sql_password -s -e “create database wordpress charset utf8mb4 collate utf8mb4_unicode_ci;”
        mysql -u $slq_usuario -p$sql_password -s -e “create user wordpress@localhost identified by 'usrwordpress123';”
        mysql -u $slq_usuario -p$sql_password -s -e “grant all privileges on wordpress.* to wordpress@localhost;“
        mysql -u $slq_usuario -p$sql_password -s -e “flush privileges;“
then

    echo "Base de datos creada"
    mysql -u $slq_usuario -p$sql_password -s -e “show databases;”
    echo "accceso: localhost wordpress
    nombre de la base de datos: wordpress
    usuario db: wordpress
    contraseña db: usrwordpress123 " > /home/$USER/acccesowordpress

else
    echo "Error en la creación de la base de datos"
fi