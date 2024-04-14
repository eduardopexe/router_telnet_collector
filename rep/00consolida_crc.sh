#!/bin/bash

#$1 - lista com os ips de coleta
#$2 - diretorio lote - ex: lote0

cd /coleta_crc

perl sum_coleta_cti_result.pl
perl sum_coleta_cti_tot.pl

cp /coleta_crc/log_temp/*.txt /coleta_crc/www/
 
rm /coleta_crc/www/dados_crc.tar

tar -cf /coleta_crc/www/dados_crc.tar /coleta_crc/www/*.txt

exit
