#!/bin/bash

#coleta_crc por roteador

ipx=$(echo $1 | cut -d ":" -f 2 );
hostx=$(echo $1 | cut -d ":" -f 1 );
lote=$(echo $1 | cut -d ":" -f 3 );
now=$(date +"%T")

/usr/coleta_crc/coleta_cti_v2.tcl $ipx $hostx $lote $now ;

#v  /usr/coleta_crc/log/$lote/$ipx-$hostx.temp /usr/coleta_crc/log/$lote/$ipx-$hostx.txt
#/usr/coleta_crc/leitor.sh $lote $ipx $hostx & 

perl /usr/coleta_crc/coleta_v3_bkb.pl $lote $ipx $hostx $now 

rm "/usr/coleta_crc/log/"$lote"/"$ipx"-"$hostx"-"$now"-.txt" ;

exit

