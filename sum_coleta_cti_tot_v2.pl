#!/usr/bin/perl


$lote=@ARGV[0];

#aa##############adaptação
$dir_result="/usr/coleta_crc/log_temp2";



open(total_cti,">$dir_result/total_cti_geral.txt");


$diretorio="/usr/coleta_crc/log_telnet_sum";

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

#print "$arquivo $item\n";
#print "$t_t;$dt_t;$up_t;$int_load_t;$crc_t;$conta_err_t;$dn_t;\n";

         $t_t=@tot[0];
         $dt_t=@tot[1];
         $up_t=$up_t+@tot[2];
         $int_load_t=$int_load_t+@tot[3];
         $crc_t=$crc_t+@tot[4];
         $conta_err_t=$conta_err_t+@tot[5];
         $dn_t=$dn_t+@tot[6];


     }

   } 


##########################3

$diretorio="/coleta_crc/st";


opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);


open(conta_tel,">/usr/coleta_crc/log_temp2/sum_telnet.txt");

           ($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime();

           $anos=1900 + $ano;

           $mess=$mes+1;

           $data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);

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

      print conta_tel "$minhas_linhas;$arquivo\n";


   }

print "$t_t;$data_reg;$up_t;$int_load_t;$crc_t;$conta_err_t;$dn_t;$total_tel;$tel_ok;$tel_err;";
####################################

print total_cti "$t_t;$data_reg;$up_t;$int_load_t;$crc_t;$conta_err_t;$dn_t;$total_tel;$tel_ok;$tel_err;";

close(total_cti);

close(conta_tel);

exit;
