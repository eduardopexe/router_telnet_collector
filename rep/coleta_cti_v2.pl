#!/usr/bin/perl


$lote=@ARGV[0];

$arq=@ARGV[1];
#aa##############adaptação
$dir_result="/usr/coleta_crc/log_telnet";
$dir_result_o="/usr/coleta_crc/log_telnet_sum";
$arqx="$arq".".txt";

#monta hash status anterior ---------------- para analisar incremento....e montar historio por interface

#$t;0 ->                          0
#$dt;1
#$hostname;2 -> chave
#$int_s;3    -> chave
#$int_status / $protocolo_st;4 -> 1
#$descr;5
#$dcd;6
#$dsr;7
#$dtr;8
#$rts;9
#$cts;10
#$lt_clear;11
#$pkt_in;12
#$bytes_in;13
#$pkt_out;14
#$bytes_out;15
#$input_error;16 -> 2
#$out_err;17 ->     3
#$collissions;18 -> 4
#$int_resets;19  -> 5
#$total_drop;20  -> 6
#$crc_x;21       -> 7
#$data_reg;22
#$amb;23
#$cli;24
#$site;25
#$serv;26
#$usuario;27
#$crit;28
#$reli_m;29      -> 8
#$rxload;30
#$txload;31
#$status;";32    -> 9

#total_cti_10.32.12.1-mcrce01.rce.psys.txt


#### monta os hashs

%host_interface_old=();

open(coleta_up1,"$dir_result_o/coleta_cti_up_$arqx");

@t_up_old=<coleta_up1>;

close(coleta_up1);

foreach $ito (@t_up_old){

   $ito=~s/\n//g;
   $ito=~s/\r//g;


   @dd=split(/;/,$ito);

   $time_stamp=@dd[0];
   $hostname=@dd[2];
   $interface=@dd[3];
   $interface_status=@dd[4];
   $in_errs=@dd[16];
   $out_errs=@dd[17];
   $colis=@dd[18];
   $resets=@dd[19];
   $drop=@dd[20];
   $crc=@dd[21];
   $load=@dd[29];
   $status=@dd[32];

   $ref=$hostname."_".$interface;
   $dados="$time_stamp;$interface_status;$in_errs;$out_errs;$colis;$resets;$drop;$crc;$load;$status";
#print "$ref | $dados \n";
   $host_interface_old{$ref}=$dados;
}

open(coleta_dn1,"$dir_result_o/coleta_cti_dn_$arqx");

@t_up_old=<coleta_dn1>;

close(coleta_dn1);

foreach $ito (@t_up_old){

   $ito=~s/\n//g;
   $ito=~s/\r//g;

   @dd=split(/;/,$ito);

   $time_stamp=$dd[0];
   $hostname=$dd[2];
   $interface=$dd[3];
   $interface_status=$dd[4];
   $in_errs=$dd[16];
   $out_errs=$dd[17];
   $colis=$dd[18];
   $resets=$dd[19];
   $drop=$dd[20];
   $crc=$dd[21];
   $load=$dd[29];
   $status=$dd[32];

   $ref=$hostname."_".$interface;

   $dados="$time_stamp;$interface_status;$in_errs;$out_errs;$colis;$resets;$drop;$crc;$load;$status";
   $host_interface_old{$ref}=$dados;
}

open(coleta_err1,"$dir_result_o/coleta_cti_err_$arqx");

@t_up_old=<coleta_err1>;

close(coleta_err1);

foreach $ito (@t_up_old){

   $ito=~s/\n//g;
   $ito=~s/\r//g;

   @dd=split(/;/,$ito);

   $time_stamp=$dd[0];
   $hostname=$dd[2];
   $interface=$dd[3];
   $interface_status=$dd[4];
   $in_errs=$dd[16];
   $out_errs=$dd[17];
   $colis=$dd[18];
   $resets=$dd[19];
   $drop=$dd[20];
   $crc=$dd[21];
   $load=$dd[29];
   $status=$dd[32];

   $ref=$hostname."_".$interface;

   $dados="$time_stamp;$interface_status;$in_errs;$out_errs;$colis;$resets;$drop;$crc;$load;$status";
   $host_interface_old{$ref}=$dados;
}

open(coleta_trf1,"$dir_result_o/coleta_cti_trf_$arqx");

@t_up_old=<coleta_trf1>;

close(coleta_trf1);

foreach $ito (@t_up_old){

   $ito=~s/\n//g;
   $ito=~s/\r//g;

   @dd=split(/;/,$ito);

   $time_stamp=$dd[0];
   $hostname=$dd[2];
   $interface=$dd[3];
   $interface_status=$dd[4];
   $in_errs=$dd[16];
   $out_errs=$dd[17];
   $colis=$dd[18];
   $resets=$dd[19];
   $drop=$dd[20];
   $crc=$dd[21];
   $load=$dd[29];
   $status=$dd[32];

   $ref=$hostname."_".$interface;

   $dados="$time_stamp;$interface_status;$in_errs;$out_errs;$colis;$resets;$drop;$crc;$load;$status";
   $host_interface_old{$ref}=$dados;
}

open(coleta_crc1,"$dir_result_o/coleta_cti_crc_$arqx");

@t_up_old=<coleta_crc1>;

close(coleta_crc1);

foreach $ito (@t_up_old){

   $ito=~s/\n//g;
   $ito=~s/\r//g;

   @dd=split(/;/,$ito);

   $time_stamp=$dd[0];
   $hostname=$dd[2];
   $interface=$dd[3];
   $interface_status=$dd[4];
   $in_errs=$dd[16];
   $out_errs=$dd[17];
   $colis=$dd[18];
   $resets=$dd[19];
   $drop=$dd[20];
   $crc=$dd[21];
   $load=$dd[29];
   $status=$dd[32];

   $ref=$hostname."_".$interface;

   $dados="$time_stamp;$interface_status;$in_errs;$out_errs;$colis;$resets;$drop;$crc;$load;$status";
   $host_interface_old{$ref}=$dados;
}


##########hash status anterior
open(r_stx,">/usr/coleta_crc/st/$arqx");

print r_stx "nao";

close(r_stx);

open(coleta_up,">$dir_result/coleta_cti_up_$arqx");

open(coleta_dn,">$dir_result/coleta_cti_dn_$arqx");

open(total_cti,">$dir_result/total_cti_$arqx");

open(coleta_err,">$dir_result/coleta_cti_err_$arqx");

open(coleta_trf,">$dir_result/coleta_cti_trf_$arqx");

open(coleta_crc,">$dir_result/coleta_cti_crc_$arqx");

open(data_coleta,"</usr/coleta_crc/resultado_cti/data_coleta_cti_$arqx");

#print "/coleta_crc/resultado_cti/data_coleta_cti_$arqx \n";
$up=0;
$trf=0;
$crc=0;
$conta_err=0;
$dn=0;

$dt=<data_coleta>;


$dt=~s/\r//;
$dt=~s/\n//;

$t=time();

$diretorio="/usr/coleta_crc/log/$lote";

#foreach (@pegoodir) {

#$arquivo = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.

#if ($arquivo eq '.') {next}

#if ($arquivo eq '..') {next}

#if ($arquivo eq 'dia_ant') {next}

#if ($arquivo=~/lista\.routers/) {next}

#if ($arquivo=~/\.tcl/) {next}


$arquivo=$arq.".txt";

#print "$diretorio/$arquivo\n";
   open (MEUFILE, "$diretorio/$arquivo");

   @minhas_linhas = <MEUFILE>;

   close (MEUFILE);


      foreach $item (@minhas_linhas) {

#print "$item";
          $item=~s/\r//;
          $item=~s/\n//;

      #captura hostname correto

         if ($item=~/>show int/){

#print "$item\n";
           @host=split(/>/,$item);

           $hostname=@host[0];
 
           $ver='y';    

           open(r_st,">/coleta_crc/st/$arqx");

              print r_st "ok";

           close(r_st);      
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

            if ($int=~/[0-9]\.[0-9]{1,4}/){

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

             if ($item=~/reliability|rely/){

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

$inc_input_error="";
$inc_crc="";
$inc_out_err="";
$inc_collissions="";
$inc_int_resets="";
$inc_total_drop="";


$collissions="";
$input_error="";
$crcx="";
$out_err="";

$int_resets="";
$total_drop="";
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

if ($reli=~/reliability/){


$marc="reliability";


@reli=split(/,/,$reli);

@reli[0]=~s/$marc /#/g;
@reli2=split(/#/,@reli[0]);

#print "@reli2[1]\n";

@reli_n=split(/\//,@reli2[1]);

if (@reli_n[1]>0){

$reli_m=@reli_n[0]/@reli_n[1]*100;

}
else{

print "####### ----> @reli_n --  @reli\n";

}
$reli_m=sprintf("%.0f",$reli_m);

@txload=split(/ /,@reli[1]);

@tx_n=split(/\//,@txload[2]);

if (@tx_n[1]>0){

$txload=@tx_n[0]/@tx_n[1]*100;

}
else{

print "######### @txload\n";
}

#$txload=@txload[2]*100;

@rxload=split(/ /,@reli[2]);

#$rxload=@rxload[2]*100;
@rx_n=split(/\//,@rxload[2]);

if (@rx_n[1]>0){

$rxload=@rx_n[0]/@rx_n[1]*100;

}
else{

print "###### @rxload -- $reli\n";
}
$txload=sprintf("%.1f",$txload);
$rxload=sprintf("%.1f",$rxload);


}
else{

$marc="rely";

@reli=split(/,/,$reli);

if (@reli[3]=~/rely/){

$marc_r=@reli[3];
$marc_t=@reli[4];

}

if (@reli[4]=~/rely/){

$marc_r=@reli[4];
$marc_t=@reli[5];

}

$marc_r=~s/$marc /#/g;
@reli2=split(/#/,$marc_r);

#print "@reli2[1]\n";

@reli_n=split(/\//,@reli2[1]);

if (@reli_n[1]>0){

$reli_m=@reli_n[0]/@reli_n[1]*100;

}
else{

print "####### ----> @reli_n --  @reli\n";

}
$reli_m=sprintf("%.0f",$reli_m);

$marc_t=~s/load /#/g;

@txload=split(/#/,$marc_t);

@txload[1]=~s/ //g;

@tx_n=split(/\//,@txload[1]);

if (@tx_n[1]>0){

$txload=@tx_n[0]/@tx_n[1]*100;

}
else{

print "######### @txload\n";
}

#$txload=@txload[2]*100;

@rxload=split(/#/,$marc_t);

@rxload[1]=~s/ //g;

#$rxload=@rxload[2]*100;
@rx_n=split(/\//,@rxload[1]);

if (@rx_n[1]>0){

$rxload=@rx_n[0]/@rx_n[1]*100;

}
else{

print "###### @rxload -- $reli\n";
}
$txload=sprintf("%.1f",$txload);
$rxload=sprintf("%.1f",$rxload);

}


#####################
###926
#redefine status ----- 

$refx=$hostname."_".$int_s;

@dd=split(/;/,$host_interface_old{$refx});

   $time_stamp_o=$dd[0];
   $interface_status_o=$dd[1];
   $in_errs_o=$dd[2];
   $out_errs_o=$dd[3];
   $colis_o=$dd[4];
   $resets_o=$dd[5];
   $drop_o=$dd[6];
   $crc_o=$dd[7];
   $load_o=$dd[8];
   $status_o=$dd[9];

#se crcx maior que crc antigo
#crc
if ($crc_x>=$crc_o){

$inc_crc=$crc_x-$crc_o;

}
else{

$inc_crc=$crc_x;

}

$crc_x="$inc_crc/$crc_x";

#print "############## $crc_x \n";
#errs in
if ($input_error>=$in_errs_o){

$inc_input_error=$input_error-$in_errs_o;

}
else{

$inc_input_error=$input_error;

}

$input_error="$inc_input_error / $input_error";
#errs out
if ($out_err>=$out_errs_o){

$inc_out_err=$out_err-$out_errs_o;

}
else{

$inc_out_err=$out_err;

}
$out_err="$inc_out_err / $out_err";
#collisions

if ($collissions>=$colis_o){

$inc_collissions=$collissions-$colis_o;

}
else{

$inc_collissions=$collissions;

}
$collissions=$inc_collissions;
#resets

if ($int_resets>=$resets_o){

$inc_int_resets=$int_resets-$resets_o;

}
else{

$inc_int_resets=$int_resets;

}
$int_resets="$inc_int_resets / $int_resets";
#drops

if ($total_drop>=$drop_o){

$inc_total_drop=$total_drop-$drop_o;

}
else{

$inc_total_drop=$total_drop;

}
$total_drop="$inc_total_drop / $total_drop";
$refi=$refx;
$refi=~s/\//_/g;
$arq=$refi."_crc.txt";

#print "$refx /coleta_crc/log_interfaces/$arq ############----\n";
open($refx,"/usr/coleta_crc/log_interfaces/$arq");

@crc_olds=<$refx>;

close($refx);

$cit=0;

$conta_inc_crc=0;
$conta_inc_errs=0;
$conta_inc_coli=0;
$conta_inc_resets=0;
$conta_inc_drop=0;
$conta_inc_trf=0;
$conta_inc_reli=0;

#print $refx "$t;$dt;$inc_crc;$inc_input_error;$inc_out_err;$inc_collissions;$inc_int_resets;$inc_total_drop;$reli_m;$pkt_in;$pkt_out;$bytes_in;$bytes_out;$rxload;$txload;\n";

   if ($inc_crc>300){

      $conta_inc_crc++; 

   } 

   if ($inc_input_error+$inc_out_err>300){

      $conta_inc_errs++; 

   } 

   if ($inc_collissions>300){

      $conta_inc_coli++; 

   } 

   if ($inc_int_resets>1){

      $conta_inc_resets++; 

   } 

   if ($inc_total_drop>200){

      $conta_inc_drop++; 

   } 

   if ($reli_m>80){

       $conta_inc_reli++;
   } 

   if ($rxload>79 or $txload>79){

      $conta_inc_trf++;

   }  

   
####contador para status anterior

foreach $it (@crc_olds){

$cit++;

if ($cit>6){

last;

}

@dds=split(/;/,$it);

   if ($dds[2]>300){

      $conta_inc_crc++; 

   } 

   if ($dds[3]+$dds[4]>300){

      $conta_inc_errs++; 

   } 

   if ($dds[5]>300){

      $conta_inc_coli++; 

   } 

   if ($dds[6]>1){

      $conta_inc_resets++; 

   } 

   if ($dds[7]>200){

      $conta_inc_drop++; 

   } 

   if ($dds[8]>80){

      $conta_inc_reli++;
   } 

   if ($dds[13]>79 or $dds[14]>79){

      $conta_inc_trf++; 

   } 
}

open($refx,">/usr/coleta_crc/log_interfaces/$arq");

print $refx "$t;$dt;$inc_crc;$inc_input_error;$inc_out_err;$inc_collissions;$inc_int_resets;$inc_total_drop;$reli_m;$pkt_in;$pkt_out;$bytes_in;$bytes_out;$rxload;$txload;\n";

$conta=0;

foreach $it (@crc_olds){

if ($conta>2){

last;

}

print $refx "$it";

$conta++;

}

print "########### $collissions \n";
$collissions="";
########################incremento de erros
#print "$reli_m;$rxload;$txload\n";
if ($int_status=~/up/ and $protocolo_st=~/up/){

#####so para interfaces com BKB

if ($serv=~/BKB/){
print coleta_up "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;;;;;;;;;;;7;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;;;;$serv;;$crit;$reli_m;$rxload;$txload;ok;\n";

$up++;
}
}
if ($int_status=~/down/ or $protocolo_st=~/down/){

   if ($int_status=~/administratively down|deleted/ or $protocolo_st=~/deleted/){

   }
   else{
if ($serv=~/BKB/){
   print coleta_dn "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;$descr;$dcd;$dsr;$dtr;$rts;$cts;$lt_clear;$pkt_in;$bytes_in;$pkt_out;$bytes_out;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;$amb;$cli;$site;$serv;$usuario;$crit;$reli_m;$rxload;$txload;down;\n";

   $dn++;
}
   }
}
###################################
#trafego

if ($conta_inc_trf>2){

if ($serv=~/BKB/){
print coleta_trf "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;$descr;$dcd;$dsr;$dtr;$rts;$cts;$lt_clear;$pkt_in;$bytes_in;$pkt_out;$bytes_out;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;$amb;$cli;$site;$serv;$usuario;$crit;$reli_m;$rxload;$txload;trafego acima de 79%;\n";


$trf++;
}
}

#conta erros crc
$st="-";

if ($int_status=~/up/ and $protocolo_st=~/up/ and $conta_inc_crc>2){

#$st=$st."crc,";
if ($serv=~/BKB/){
print coleta_crc "$t;$dt;$hostname;$int_s;$int_status / $protocolo_st;$descr;$dcd;$dsr;$dtr;$rts;$cts;$lt_clear;$pkt_in;$bytes_in;$pkt_out;$bytes_out;$input_error;$out_err;$collissions;$int_resets;$total_drop;$crc_x;$data_reg;$amb;$cli;$site;$serv;$usuario;$crit;$reli_m;$rxload;$txload;crc;\n";

$crc++;
}
}

$err_tot=$input_error+$out_err;

if ($int_status=~/up/ and $protocolo_st=~/up/ and $conta_inc_errs>2){

$st=$st."erros interface,";

}

if ($int_status=~/up/ and $protocolo_st=~/up/ and $conta_inc_resets>2){

$st=$st."int resets,";
}

#reliability

if ($reli_m<95 and $conta_inc_reli>2){

$st=$st."reliability erros,";
}

if ($st eq '-'){


}
else{

if ($serv=~/BKB/ and $t_int ne 'sub'){
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

#$ver='n';
#$proc="";
#$io="";
#$ver_int='n';
#$ver_print='n';
#   }

print total_cti "$t;$dt;$up;$trf;$crc;$conta_err;$dn";
#close(tac_brad);
close(coleta_up);
close(coleta_dn);
close(coleta_err);
close(total_cti);
close(coleta_trf);
close(coleta_crc);
