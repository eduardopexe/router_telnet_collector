#!/usr/bin/perl


#$lote=@ARGV[0];

#$arq=@ARGV[1];

#aa##############adaptação
$dir_result="/coleta_crc/log_temp2";

open(coleta_up,">$dir_result/coleta_cti_up_geral.txt");

open(coleta_dn,">$dir_result/coleta_cti_dn_geral.txt");

open(coleta_err,">$dir_result/coleta_cti_err_geral.txt");

open(coleta_trf,">$dir_result/coleta_cti_trf_geral.txt");

open(coleta_crc,">$dir_result/coleta_cti_crc_geral.txt");

open(coletag,"$dir_result/coleta_geral_old.txt");

@coleta_geral=<coletag>;

close(coletag);

############################
#monta hash status antigo
%status_antigo=();

foreach $linha (@coleta_geral){


$linha=~s/\n//g;
$linha=~s/\r//g;
@dados_o=split(/;/,$linha);
$host_int_o=@dados_o[2].";".@dados_o[3];

$status_antigo{$host_int_o}=$linha;


}

###############

open(coletag1,">$dir_result/coleta_geral.txt");

##################fim adaptação

$diretorio="/coleta_crc/log_telnet_sum";

# abro o diretório
opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);
# já peguei todos os dados e armazenei no vetor, fecho o diretório
$x=0;
$conta=0;

$up=0;
$dn=0;
$conta_err=0;

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

          @dados=split(/;/,$item);

          $encontrou="n";

          $host_int=@dados[2].";".@dados[3];
          $item=~s/\n//g;
          $item=~s/\r//g;

####busca status anterior

               if (length($status_antigo{$host_int})>10){

                  $encontrou="y";

                  @dados_o=split(/;/,$status_antigo{$host_int});

                  if (@dados[32] eq @dados_o[32]){

                     $tp="@dados_o[1]";

                     @lin_al=split(/;/,$item);

                     $linha_alarmex=@dados_o[0].";".$tp.";".@lin_al[2].";".@lin_al[3].";".@lin_al[4].";".@lin_al[5].";".@lin_al[6].";";
                     $linha_alarmex=$linha_alarmex.@lin_al[7].";".@lin_al[8].";".@lin_al[9].";".@lin_al[10].";".@lin_al[11].";".@lin_al[12].";".@lin_al[13].";";
                     $linha_alarmex=$linha_alarmex.@lin_al[14].";".@lin_al[15].";".@lin_al[16].";".@lin_al[17].";".@lin_al[18].";".@lin_al[19].";".@lin_al[20].";";
                     $linha_alarmex=$linha_alarmex.@lin_al[21].";".@lin_al[22].";".@lin_al[23].";".@lin_al[24].";".@lin_al[25].";".@lin_al[26].";".@lin_al[27].";";
                     $linha_alarmex=$linha_alarmex.@lin_al[28].";".@lin_al[29].";".@lin_al[30].";".@lin_al[31].";".@lin_al[32].";".@lin_al[1]."\n";

                     $linha_al=$linha_alarmex;

                  }
                  else{

                     $linha_al=$item.@dados[1]."\n";

                  }

               }
               else{

                  $encontrou="n";

               }
####

          if ($encontrou eq 'n'){


             print "$nao encontrou --- $item \n";
             $linha_al=$item.@dados[1]."\n";
          }

         if ($arquivo=~/_up_/){

            print coleta_up "$linha_al";
         
         }
         if ($arquivo=~/_dn_/){

            print coleta_dn "$linha_al";
         
         }
         if ($arquivo=~/_err_/){

            print coleta_err "$linha_al";
         
         }

         if ($arquivo=~/_trf_/){

            print coleta_trf "$linha_al";

         }

         if ($arquivo=~/_crc_/){

            print coleta_crc "$linha_al";

         }

         print coletag1 "$linha_al";     

#print "$linha_al";

      }

}
close(coleta_up);
close(coleta_dn);
close(coleta_err);
close(coletag1);
close(coleta_trf);
close(coleta_crc);
