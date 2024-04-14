#!/bin/bash

lotel=$1;
ipxl=$2;
hostxl=$3;

perl /usr/coleta_crc/coleta_v3.pl $lotel $ipxl-$hostxl ;

mv /usr/coleta_crc/log_telnet/*$ipxl-$hostxl* /usr/coleta_crc/log_telnet_sum ;

st=`cat /usr/coleta_crc/st/$ipxl-$hostxl.txt` ;

if [ $st = "ok" ]; then

cp /usr/coleta_crc/log_telnet_sum/*$ipxl-$hostxl* /usr/coleta_crc/log_telnet_old ;

fi

if [ $st = "nao" ]; then

cp /usr/coleta_crc/log_telnet_old/*$ipxl-$hostxl* /usr/coleta_crc/log_telnet_sum ;

fi

mv /usr/coleta_crc/log/$lotel/$ipxl-$hostxl.txt /usr/coleta_crc/log/$lotel/old ;


exit
