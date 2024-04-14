#!/bin/bash

#coleta_crc por roteador

ipx=$(echo $1 | cut -d ":" -f 1 );
hostx=$(echo $1 | cut -d ":" -f 2 );
lote=$(echo $1 | cut -d ":" -f 3 );


/usr/coleta_crc/coleta_cti_v2.tcl $ipx $hostx $lote ;

perl /usr/coleta_crc/coleta_v3.pl $lote $ipx-$hostx ;

mv /usr/coleta_crc/log_telnet/*$ipx-$hostx* /usr/coleta_crc/log_telnet_sum/ ;

st=`cat /usr/coleta_crc/st/$ipx-$hostx.txt` ;

if [ $st = "ok" ]; then

cp /usr/coleta_crc/log_telnet_sum/*$ipx-$hostx* /usr/coleta_crc/log_telnet_old ;

fi

if [ $st = "nao" ]; then

cp /usr/coleta_crc/log_telnet_old/*$ipx-$hostx* /usr/coleta_crc/log_telnet_sum ;

fi

mv /usr/coleta_crc/log/$lote/$ipx-$hostx.txt /usr/coleta_crc/log/$lote/old ;

exit

