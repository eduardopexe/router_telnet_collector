#!/usr/bin/perl


$lote=@ARGV[0];

#aa##############adaptação
$dir_result="/coleta_crc/cti";

$amb=@ARGV[1];

if ($amb eq 'spb'){

$dir_result="/coleta_crc/spb";
}



open(coleta_up,">$dir_result/coleta_cti_up_$lote.txt");

open(coleta_dn,">$dir_result/coleta_cti_dn_$lote.txt");

open(total_cti,">$dir_result/total_cti_$lote.txt");

open(coleta_err,">$dir_result/coleta_cti_err_$lote.txt");

open(coleta_trf,">$dir_result/coleta_cti_trf_$lote.txt");

open(coleta_crc,">$dir_result/coleta_cti_crc_$lote.txt");

open(data_coleta,"</coleta_crc/resultado_cti/data_coleta_cti_$lote.txt");

$dt=<data_coleta>;


$dt=~s/\r//;
$dt=~s/\n//;

$t=time();
##################fim adaptação

$diretorio="/coleta_crc/log/$lote";

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
$trf=0;
$crc=0;

#print tac_brad "hostname\tint\tstatus\tprotocolo status\tdescription\tdcd\tdsr\tdtr\trts\tcts\tlt_clear\tpkt_in\tbytes_in\tpkt_out\tbytes_out\tout_err\tinput error\tcollissions\tint_resets\ttotal_drop\tcrc\n";

foreach (@pegoodir) {

$arquivo = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.

if ($arquivo eq '.') {next}

if ($arquivo eq '..') {next}

if ($arquivo eq 'dia_ant') {next}

if ($arquivo=~/lista\.routers/) {next}

if ($arquivo=~/\.tcl/) {next}


   open (MEUFILE, "$diretorio/$arquivo");

   @minhas_linhas = <MEUFILE>;

   close (MEUFILE);


      foreach $item (@minhas_linhas) {

$item=~s/\r//;
$item=~s/\n//;

      #captura hostname correto

         if ($item=~/>show int/){

           @host=split(/>/,$item);

           $hostname=@host[0];
 
           $ver='y';    
         }

         if ($ver eq 'y'){

#print "$hostname;$item\n";

            if ($item=~/#show mem/){

            $ver="n";

            }

#            if ($item=~/^(Ser|ATM|Eth|Fas|Gig|Vla)/){

            if ($item=~/^(Ser|ATM|Eth|Fas|Gig|Vla)/){
            $int="$item"; 
             
# a            print "$item";
            }

            if ($int=~/[0-9]\.[0-9]{1,3}/){

$ver_int='y';

$t_int="sub";
#habilita ver sub atm
#if ($int=~/ATM/){

#$ver_int='y';

#}
#else{
#            $ver_int='n';
#}
#a            print "$int\n";
            }
            else{
            
            $ver_int='y';

            }


          if ($ver_int eq 'y'){

#retira last clear


             if ($item=~/Last clearing of /){

             $last_c=$item;


             }

#pkts in
             if ($item=~/packets input/){

             $traf_in=$item;

             
             }

#pkts out
             if ($item=~/packets output/){

             $traf_out=$item;


             }

#tx e rx load 

             if ($item=~/reliability/){

             $reli=$item;


             }
           
#CRC

             if ($item=~/CRC/){

             $crc_int=$item;
#print "$item\n";
             }
           

#interface reset


             if ($item=~/interface resets/){

             $int_reset=$item;

             }

#drops

             if ($item=~/Input queue:/){

             $in_q=$item;
 
             }

             if ($item=~/Output queue:/){

             $out_q=$item;

             }

#descriprion::

            if ($item=~/Description:/){

            $descr=$item;

            $descr=~s/Description://g;            
            $descr=~s/'//g; 

            }
#retira sinalizacao interface
             if ($item=~/DCD/){

             $st=$item;

             $ver_print="y";

             }

#indica fim de interface para atm e ethernet

             if ($item=~/buffers swapped out/ and $int=~/(ATM|Eth|Fas|Gig)/ or $item=~/AAL5 Oversized SDUs/ and $int=~/ATM/ and $descr=~/BKB/){

             $st="-,-,-,-,-,";

             $ver_print="y";
             }


             if ($item=~/Timeslot/){

             $st=$item;

             $ver_print="y"; 

#print "$item\n";
             }
              

          }

          if ($ver_print eq 'y'){  

#print "$st\n";

$std=$st;
$std=~s/DCD=/!/;
$std=~s/DCD /!/;
$std=~s/,/ /g;

@dcdx=split(/!/,$std);

@dcd=split(/ /,@dcdx[1]);

$dcd=@dcd[0];

###DSR########################

$stds=$st;
$stds=~s/DSR=/!/;
$stds=~s/DSR /!/;
$stds=~s/,/ /g;

@dsrx=split(/!/,$stds);

@dsr=split(/ /,@dsrx[1]);

$dsr=@dsr[0];
#############################
###DTR########################

$stdr=$st;
$stdr=~s/DTR=/!/;
$stdr=~s/DTR /!/;
$stdr=~s/,/ /g;

@dtrx=split(/!/,$stdr);

@dtr=split(/ /,@dtrx[1]);

$dtr=@dtr[0];
#############################
###RTS########################

$stdrt=$st;
$stdrt=~s/RTS=/!/;
$stdrt=~s/RTS /!/;
$stdrt=~s/,/ /g;

@rtsx=split(/!/,$stdrt);

@rts=split(/ /,@rtsx[1]);

$rts=@rts[0];
#############################
###CTS########################

$stdc=$st;
$stdc=~s/CTS=/!/;
$stdc=~s/CTS /!/;
$stdc=~s/,/ /g;

@ctsx=split(/!/,$stdc);

@cts=split(/ /,@ctsx[1]);

$cts=@cts[0];
#############################


######################

$last_c=~s/counters /#/g;

@last=split(/#/,$last_c);

$lt_clear=@last[1];


$int=~s/, line protocol is/;/g;
$int=~s/ is /;/g;

@int_s=split(/;/,$int);

$int_s=@int_s[0];
$int_status=@int_s[1];
$protocolo_st=@int_s[2];

if (length($int_s)<2){

$int_s=$int;

}
#################################
$traf_in=~s/packets input//g;
$traf_in=~s/bytes//g;
$traf_in=~s/ //g;

$traf_out=~s/packets output//g;
$traf_out=~s/bytes//g;
$traf_out=~s/ //g;


@traf_in=split(/,/,$traf_in);

$pkt_in=@traf_in[0];
$bytes_in=@traf_in[1];

@traf_out=split(/,/,$traf_out);

$pkt_out=@traf_out[0];
$bytes_out=@traf_out[1];
##############################

$int_reset=~s/output errors//g;
$int_reset=~s/collisions//g;
$int_reset=~s/interface resets//g;
$int_reset=~s/ //g;

@int_res=split(/,/,$int_reset);

$out_err=@int_res[0];
$collisions=@int_res[1];
$int_resets=@int_res[2];

#if ($hostname=~/rccpe01.cpe.unib/ and $int=~/Serial2\/1:1/){
#print "$hostname;$int - $int_reset-----$int_resets\n";
####drops in e out
#}

@total_drops=split(/:/,$in_q);

$total_drop=@total_drops[2];
$total_drop=~s/ //g;

#vercrc de subinterface

if ($crc_int=~/AAL5 CRC errors/){

#print "#####$crc_int\n";
$crc_int=~s/ //g;
$crc_int=~s/\r//g;
$crc_int=~s/\n//g;

@crc=split(/:/,$crc_int);

$crc_x=@crc[1];

#print "$hostname - $interface - $crc_int - $crc_x\n";
}
else{
####input errors CRC a

$crc_int=~s/CRC//g;
$crc_int=~s/input errors//g;
$crc_int=~s/ //g;

@crc=split(/,/,$crc_int);

$input_error=@crc[0];
$crc_x=@crc[1];
}
################inserir na base##########################################################

($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime(time);

$anos=1900 + $ano;

$mess=$mes+1;

$data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);


@site=split(/\./,$hostname);

$amb=@site[2];
$site=@site[1];

#######trata descr
if ($descr=~/[A-Za-z0-9]{1,13}\.[A-Za-z0-9]{1,4}\.[A-Za-z]{1,4}/){

   @cliente=split(/_/,$descr);

   #print "@cliente \n";
   @cli=split(/\./,@cliente[0]);

   #   $cli=@cli[0];
   #print "@cliente ,@cli[2]\n";

   if (@cli[2]=~/[A-Za-z]{1,4}/){

   $cli=@cli[2];

   }
   else{

   $cli="$amb";


   }

}
else{

   if($descr=~/RCCF|BOVESPA|BVSP/){

      $cli="rccf";
      $serv="rccf";
   }

   if($descr=~/DEFEIT/){

      $cli="$amb";
      $serv="DEF";
   }

   if($descr=~/vaga|VAGA|VAGO|vago|Vago|Vaga|INTERFACE VAGA/){

      $cli="$amb";
      $serv="VAGA";
   }

   if($descr=~/BACKBONE|Backbone|backbone/){

      $cli="$amb";
      $serv="BKB";
   }

   if($descr=~/AGS |ags |Ags/){

      $cli="$amb";
      $serv="AGS";
   }

   if ($descr=~/RESERVAD|Reservad/){

      $cli="$amb";
      $serv="RESERV";

   }
   else{

      $cli="$amb";
      $serv="-";

   }

}


#usuario e servico

if ($descr=~/#/){

   if ($descr=~/\$/){

      @usu=split(/#/,$descr);

      @usuario=split(/\$/,@usu[1]);

      $usuario=@usuario[0];
   }
   else{

     @usu=split(/#/,$descr);

      $usuario=@usu[1];

   }
}


#servico

if ($descr=~/\$/){

   if ($descr=~/!/){

      @serv=split(/\$/,$descr);
 
      @servico=split(/!/,@serv[1]);

      $serv=@servico[0];
   }
   else{

   @serv=split(/\$/,$descr);

   $serv=@serv[1];

   }

}


#criticidade

if ($descr=~/!/){

   if ($descr=~/\@/){

      @crit=split(/!/,$descr);

      @critic=split(/\@/,@crit[1]);

      $crit=@critic[0];
   }
   else{

      @crit=split(/!/,$descr);

      $crit=@crit[1];

   }

}

############

######

$serv=~s/ //g;
$usuario=~s/  //g;
$usuario=~s/'/ /g;
$cli=~s/ //g;
$crit=~s/ //g;

### reliability 255/255, txload 19/255, rxload 3/255

@reli=split(/,/,$reli);

@reli[0]=~s/reliability /#/g;
@reli2=split(/#/,@reli[0]);

#print "@reli2[1]\n";

@reli_n=split(/\//,@reli2[1]);

if (@reli_n[1] eq ''){



}
else {
$reli_m=@reli_n[0]/@reli_n[1]*100;
}
$reli_m=sprintf("%.0f",$reli_m);

@txload=split(/ /,@reli[1]);

@tx_n=split(/\//,@txload[2]);

if (@tx_n[1] eq ''){

}
else{

$txload=@tx_n[0]/@tx_n[1]*100;

}
#$txload=@txload[2]*100;

@rxload=split(/ /,@reli[2]);

#$rxload=@rxload[2]*100;
@rx_n=split(/\//,@rxload[2]);

if (@rx_n[1] eq ''){


}
else{
$rxload=@rx_n[0]/@rx_n[1]*100;
}
$txload=sprintf("%.1f",$txload);
$rxload=sprintf("%.1f",$rxload);
#####################

#print "$reli_m;$rxload;$txload\n";
if ($int_status=~/up/ and $protocolo_st=~/up/){

#####so para interfaces com BKB

if ($serv=~/BKB/ or $hostname=~/\.spb/){
print coleta_up "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;$descr;$dcd;$dsr;$dtr;$rts;$cts;$lt_clear;$pkt_in;$bytes_in;$pkt_out;$bytes_out;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;$amb;$cli;$site;$serv;$usuario;$crit;$reli_m;$rxload;$txload;ok;\n";

$up++;
}
}
if ($int_status=~/down/ or $protocolo_st=~/down/){

   if ($int_status=~/administratively down|deleted/ or $protocolo_st=~/deleted/){

   }
   else{
if ($serv=~/BKB/ or $hostname=~/\.spb/){
   print coleta_dn "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;$descr;$dcd;$dsr;$dtr;$rts;$cts;$lt_clear;$pkt_in;$bytes_in;$pkt_out;$bytes_out;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;$amb;$cli;$site;$serv;$usuario;$crit;$reli_m;$rxload;$txload;down;\n";

   $dn++;
}
   }
}
###################################
#trafego

if ($txload>79 or $rxload>79){

if ($serv=~/BKB/ or $hostname=~/\.spb/){
print coleta_trf "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;$descr;$dcd;$dsr;$dtr;$rts;$cts;$lt_clear;$pkt_in;$bytes_in;$pkt_out;$bytes_out;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;$amb;$cli;$site;$serv;$usuario;$crit;$reli_m;$rxload;$txload;trafego acima de 79%;\n";


$trf++;
}
}

#conta erros crc
$st="-";

if ($int_status=~/up/ and $protocolo_st=~/up/ and $crc_x>500){

#$st=$st."crc,";
if ($serv=~/BKB/){
print coleta_crc "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;$descr;$dcd;$dsr;$dtr;$rts;$cts;$lt_clear;$pkt_in;$bytes_in;$pkt_out;$bytes_out;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;$amb;$cli;$site;$serv;$usuario;$crit;$reli_m;$rxload;$txload;crc;\n";

$crc++;
}
}

$err_tot=$input_error+$out_err;

if ($int_status=~/up/ and $protocolo_st=~/up/ and $err_tot>100){

$st=$st."erros interface,";

}

if ($int_status=~/up/ and $protocolo_st=~/up/ and $int_resets>10){

$st=$st."int resets,";
}

#reliability

if ($reli_m<95){

$st=$st."reliability erros,";
}

if ($st eq '-'){


}
else{

if ($serv=~/BKB/ and $t_int ne 'sub' or $hostname=~/\.spb/ and $t_int ne 'sub'){
print coleta_err "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;$descr;$dcd;$dsr;$dtr;$rts;$cts;$lt_clear;$pkt_in;$bytes_in;$pkt_out;$bytes_out;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;$amb;$cli;$site;$serv;$usuario;$crit;$reli_m;$rxload;$txload;$st;\n";

$conta_err++;
}
}
#######################################################################
           $ver_print='n'; 

$descr="-";
$int="-";
$dcd="-"; 
$dsr="-"; 
$dtr="-"; 
$rts="-"; 
$cts="-"; 
$lt_clear="-"; 
$pkt_in="-1"; 
$bytes_in="-1"; 
$pkt_out="-1";
$bytes_out="-1"; 
$out_err="-1"; 
$collisions="-1"; 
$int_resets="-1"; 
$total_drop="-1";
$crc_x="-1";
$out_err="-1";
$cli="-";
$usuario="-";
$crit="-";
$rxload="";
$txload="";
$reli_m="";
$t_int="-";
#$ver_int='n';
#           last;  

             }
          }
      }

$ver='n';
$proc="";
$io="";
$ver_int='n';
$ver_print='n';
   }

print total_cti "$t;$dt;$up;$trf;$crc;$conta_err;$dn";
#close(tac_brad);
close(coleta_up);
close(coleta_dn);
close(coleta_err);
close(total_cti);
close(coleta_trf);
close(coleta_crc);
