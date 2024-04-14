#!/bin/bash

#$1 - lista com os ips de coleta
#$2 - diretorio lote - ex: lote0

cd /coleta_crc

./coleta_cti.sh lista_cti0.txt lote0 &

./coleta_cti.sh lista_cti1.txt lote1 &

./coleta_cti.sh lista_cti2.txt lote2 &

./coleta_cti.sh lista_cti3.txt lote3 &

./coleta_cti.sh lista_cti4.txt lote4 &

./coleta_cti.sh lista_cti5.txt lote5 &

./coleta_cti.sh lista_cti6.txt lote6 &

./coleta_cti.sh lista_cti7.txt lote7 &

./coleta_cti.sh lista_cti8.txt lote8 &

exit
