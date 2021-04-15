f_UUID () {
echo "Indique el nombre del dispositivo de bloques del que quiere obtener el UUID"
read d
blkid | egrep /dev/$d
}

f_modifica_fstab () {
lsblk
echo "Indique el nombre del dispositivo de bloques que quiere habilitar para quota"
}

f_habilita_quota () {
echo "Buscando ficheros de cuotas"
if
find / aquota | egrep -o aquota 2> /dev/nulls
then
echo "ya existen los ficheros"
else
echo "Creando ficheros de coutas"
quotacheck -ugm /QUOTA
find / aquota | egrep -o aquota 2> /dev/nulls
quotaon -V /QUOTA
ficheros
fi
}

#f_plantilla_quota () {

#}

f_configura_quota () {
echo "Donde desea realizar la configuración 'usuario' o 'grupo'"
read var1 in
user(){
echo"Usuario selecccionado"
}
group(){
echo"grupo selecccionado"
}
fi
}

f_existe_directorio () {
echo "Indique el nombre del directorio que quiere buscar"
read a
find / $a | egrep -o $a 2> /dev/nulls
}

