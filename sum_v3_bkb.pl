#!/usr/bin/perl
use Shell;

#$lote=@ARGV[0];

#$arq=@ARGV[1];

#aa##############adaptação
$dir_result="/usr/coleta_crc/www";

open(coleta_up,">$dir_result/coleta_cti_up_geral.txt");

open(coleta_dn,">$dir_result/coleta_cti_dn_geral.txt");

open(coleta_err,">$dir_result/coleta_cti_err_geral.txt");

open(coleta_trf,">$dir_result/coleta_cti_trf_geral.txt");

open(coleta_crc,">$dir_result/coleta_cti_crc_geral.txt");


###############


open(coletag1,">$dir_result/coleta_geral.txt");

##################fim adaptação

$diretorio="/usr/coleta_crc/log_telnet_sum";

# abro o diretório
opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);
# já peguei todos os dados e armazenei no vetor, fecho o diretório
$x=0;
$conta=0;

$ok=0;
$dn=0;
$err=0;
$crc=0;
$trf=0;

   foreach (@pegoodir) {

   $arquivo = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.

      if ($arquivo eq '.') {next}

      if ($arquivo eq '..') {next}

      if ($arquivo=~/coleta/){

      }
      else {

      next;

      }

      open (MEUFILE, "$diretorio/$arquivo");

      @minhas_linhas = <MEUFILE>;

      close (MEUFILE);


      foreach $item (@minhas_linhas) {

#0 $ti;
#1 $data_regi;
#2 $int_status;
#3 $protocolo_st;
#4 $serv;
#5 $status_int;
#6 $status_int_errs;
#7 $crc_x;
#8 $input_error;
#9 $out_err;
#10$collissions;
#11$int_resets;
#12$total_drop;
#13$reli_m;
#13$pkt_in;
#15$pkt_out;
#16$bytes_in;
#17$bytes_out;
#18$rxload;
#19$txload;
#20$hostame;
#21$int_s;
#22$te;
#23$data_rege;
#24$inc_crc;
#25$inc_input_error;
#26$inc_out_err;
#27$inc_collissions;
#28$inc_int_resets;
#29$inc_total_drop;

          @dd=split(/;/,$item);
 
         if ($dd[4]=~/BKB/){


         }
         else{

            next;

         }

         if ($dd[5]=~/up/){

            print coleta_up "$item";

            $ok++;

         }

         if ($dd[5]=~/down/){

            print coleta_dn "$item";

            $dn++;
         }

         if ($dd[6]=~/errors|resets/){


            print coleta_err "$item";


            $err++;
         }

         if ($arquivo=~/util link/){

            print coleta_trf "$item";

            $trf++;
         }

         if ($arquivo=~/crc/){

            print coleta_crc "$item";

            $crc++;
         }

         print coletag1 "$item";



      }

   }


$diretorio="/usr/coleta_crc/st";
opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);

$tel_ok=0;
$tel_err=0;
$total_tel=0;
   foreach (@pegoodir) {

      $arquivo = $_;

      if ($arquivo eq '.') {next}

      if ($arquivo eq '..') {next}

      open (MEUFILE, "$diretorio/$arquivo");

      $minhas_linhas = <MEUFILE>;

      close (MEUFILE);

if ($minhas_linhas=~/ok/){

$tel_ok++;
}
if ($minhas_linhas=~/nao/){

$tel_err++;

}

$total_tel++;

     
   }


      $t=time();
      ($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime($t);

      $anos=1900 + $ano;

      $mess=$mes+1;

      $data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);


open(total_cti,">$dir_result/total_cti_geral.txt");

print total_cti "$t;$data_reg;$ok;$trf;$crc;$err;$dn;$total_tel;$tel_ok;$tel_err;";

close(total_cti);
close(coleta_up);
close(coleta_dn);
close(coleta_err);
close(coletag1);
close(coleta_trf);
close(coleta_crc);

my $sh = Shell->new;

# 
$dir_result0="/usr/coleta_crc/www";
$dir_result="/coleta_crc/www";
$sh->scp("$dir_result0/coleta_cti_up_geral.txt","root\@10.98.22.11:$dir_result/coleta_cti_up_geral.txt");
$sh->scp("$dir_result0/coleta_cti_dn_geral.txt","root\@10.98.22.11:$dir_result/coleta_cti_dn_geral.txt");
$sh->scp("$dir_result0/coleta_cti_err_geral.txt","root\@10.98.22.11:$dir_result/coleta_cti_err_geral.txt");
$sh->scp("$dir_result0/coleta_cti_trf_geral.txt","root\@10.98.22.11:$dir_result/coleta_cti_trf_geral.txt");
$sh->scp("$dir_result0/coleta_cti_crc_geral.txt","root\@10.98.22.11:$dir_result/coleta_cti_crc_geral.txt");
$sh->scp("$dir_result0/coleta_geral.txt","root\@10.98.22.11:$dir_result/coleta_geral.txt");
$sh->scp("$dir_result0/total_cti_geral.txt","root\@10.98.22.11:$dir_result/total_cti_geral.txt");

exit
