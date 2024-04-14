#!/bin/bash

#$1 - lista com os ips de coleta
#$2 - diretorio lote - ex: lote0

ip=`cat /coleta_crc/lista/$1`;

#file:
for x in $ip;
do

{ /coleta_crc/coleta_cti.tcl $x; };   

done

#echo "fim script ok";
# date;

cd /coleta_crc/resultado_cti
date &> "data_coleta_cti_$2.txt";

cd /coleta_crc
perl coleta_cti.pl $2

cd /coleta_crc/log/$2
rm *.*

date;


exit
