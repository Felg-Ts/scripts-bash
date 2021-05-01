if
    echo "Base de datos Wordpress"
        slq_usuario=”root”
        sql_password=”usuario”
        sql_database=”nombre_db”
        mysql -u $slq_usuario -p$sql_password -s -e “create database wordpress charset utf8mb4 collate utf8mb4_unicode_ci;”
then

    echo "Base de datos creada"
    mysql -u $slq_usuario -p$sql_password -s -e “show databases;”

else
    echo "Error en la creación de la base de datos"
fi