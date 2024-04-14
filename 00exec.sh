#!/bin/bash

#$1 - lista com os ips de coleta
#$2 - diretorio lote - ex lote0

cd /usr/coleta_crc

rm   /usr/coleta_crc/log/lote0/*.txt
rm   /usr/coleta_crc/log/lote1/*.txt
rm   /usr/coleta_crc/log/lote2/*.txt
rm   /usr/coleta_crc/log/lote3/*.txt
rm   /usr/coleta_crc/log/lote4/*.txt
rm   /usr/coleta_crc/log/lote5/*.txt
rm   /usr/coleta_crc/log/lote6/*.txt
rm   /usr/coleta_crc/log/lote7/*.txt
rm   /usr/coleta_crc/log/lote8/*.txt

./coleta_cti_v2.sh lista_cti0.txt lote0 

sleep 40;

./coleta_cti_v2.sh lista_cti1.txt lote1 

sleep 40;

./coleta_cti_v2.sh lista_cti2.txt lote2 

sleep 40;
./coleta_cti_v2.sh lista_cti3.txt lote3

sleep 40;
./coleta_cti_v2.sh lista_cti4.txt lote4 
sleep 40;
./coleta_cti_v2.sh lista_cti5.txt lote5 
sleep 40;
./coleta_cti_v2.sh lista_cti6.txt lote6 
sleep 40;
./coleta_cti_v2.sh lista_cti7.txt lote7 
sleep 40;
./coleta_cti_v2.sh lista_cti8.txt lote8 

sleep 60;

/usr/coleta_crc/00sum.sh

exit
