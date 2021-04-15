f_UUID () {
echo "Indique el nombre del dispositivo de bloques del que quiere obtener el UUID"
read d
blkid | egrep /dev/$d
}

f_modifica_fstab () {

}

f_habilita_quota () {

}

f_plantilla_quota () {

}

f_configura_quota () {

}

f_existe_directorio () {
echo "Indique el nombre del directorio que quiere buscar"
read a
find / $a | egrep -o $a 2> /dev/nulls
}

