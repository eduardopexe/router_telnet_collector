#!/usr/bin/perl


$lote=@ARGV[0];

#aa##############adaptação
$dir_result="/coleta_crc/log_temp";



open(total_cti,">$dir_result/total_cti_geral.txt");


$diretorio="/coleta_crc/cti";

# abro o diretório
opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);
# já peguei todos os dados e armazenei no vetor, fecho o diretório

$t_t=0;
$dt_t=0;
$up_t=0;
$int_load_t=0;
$conta_err_t=0;
$dn_t=0;
$crc_t=0;

   foreach (@pegoodir) {
 
  $arquivo = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.
$t=0;
$dt=0;
$up=0;
$int_load=0;
$conta_err=0;
$dn=0;
$crc=0; 

     if ($arquivo eq '.') {next}
      if ($arquivo eq '..') {next}

      if ($arquivo=~/total/){

      }
      else{

      next;

      } 
      open (MEUFILE, "$diretorio/$arquivo");
      @minhas_linhas = <MEUFILE>;
      close (MEUFILE);

      foreach $item (@minhas_linhas) {

         @tot=split(/;/,$item);

         $t_t=@tot[0];
         $dt_t=@tot[1];
         $up_t=$up_t+@tot[2];
         $int_load_t=$int_load_t+@tot[3];
         $crc_t=$crc_t+@tot[4];
         $conta_err_t=$conta_err_t+@tot[5];
         $dn_t=$dn_t+@tot[6];


     }

   } 

print total_cti "$t_t;$dt_t;$up_t;$int_load_t;$crc_t;$conta_err_t;$dn_t";

close(total_cti);

exit;
