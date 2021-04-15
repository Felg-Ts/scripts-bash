f_UUID () {
echo "Indique el nombre del dispositivo de bloques del que quiere obtener el UUID"
read d
blkid | egrep /dev/$d
}

f_modifica_fstab () {
cp /etc/fstab /tmp
lsblk
echo "Indique el nombre del dispositivo de bloques que quiere habilitar para quota"
read var1
echo "Indique el punto de montaje"
read var2
echo "Indique el sistema de ficheros"
read var3
sed -i '/$var1/ d' /tmp/fstab
echo "$var1     $var2     $var3      defaults,noatime,nodiratime,usrquota,grpquota   0   1" >> /tmp/fstab
cat /tmp/fstab
echo "Desea confirmar los cambios realizados en el fichero? 'si' o 'no'"
read var3
case $var3 in
    si) conf ;;
    no) deny ;;
esac
}

conf(){
echo "aplicando cambios"
mv /tmp/fstab /etc/fstab
echo "cambios aplicados"
}

deny(){
echo "cambios no aplicados"
}

f_habilita_quota () {
echo "Buscando ficheros de cuotas"
if
find / -iname aquota 2> /dev/null
then
echo "ya existen los ficheros"
else
echo "Creando ficheros de coutas"
quotacheck -ugm /QUOTA
find / -iname aquota 2> /dev/null
quotaon -V /QUOTA
fi
}

#f_plantilla_quota () {

#}

f_configura_quota () {
echo "Donde desea realizar la configuración: 'usuario' o 'grupo'"
read var1
case $var1 in
    usuario) user ;;
    grupo) group ;;
esac
}

user(){
echo "Usuario selecccionado"
echo "Seleccione la edición a realizar: 'cuota' o 'periodo'"
read var2
case $var2 in
    cuota) cuotauser ;;
    periodo) periodouser ;;
esac
}

cuotauser(){
echo "edición de cuota"
echo "indique el usuario a configurar"
read var3
edquota -u $var3
}

periodouser(){
echo "edición de periodo de gracia"
echo "indique el usuario a configurar"
read var3
edquota -u $var3 -T
}

group(){
echo "grupo selecccionado"
echo "Seleccione la edición a realizar: 'cuota' o 'periodo'"
read var2
case $var2 in
    cuota) cuotagroup ;;
    periodo) periodogroup ;;
esac
}

cuotagroup(){
echo "edición de cuota"
echo "indique el grupo a configurar"
read var3
edquota -g $var3 -T
}

periodogroup(){
echo "edición de periodo de gracia"
echo "indique el grupo a configurar"
read var3
edquota -g $var3 -T
}


f_existe_directorio () {
echo "Indique el nombre del directorio que quiere buscar"
read a
find / $a | egrep -o $a 2> /dev/nulls
}


f_modifica_fstab