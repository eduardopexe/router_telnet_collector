#!/bin/bash

#$1 - lista com os ips de coleta
#$2 - diretorio lote - ex lote0

ip=`cat /usr/coleta_crc/lista/$1`;

#file:
for x in $ip;
do

/usr/coleta_crc/coletor_crc.sh $x &  

#echo $x;
done

#perl /usr/coleta_crc/coleta_v3.pl

exit
