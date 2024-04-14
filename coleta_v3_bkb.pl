#!/usr/bin/perl

#use Shell;

sub trim {
  my ($param) = @_;
  $param =~ s/^\\s+//;
  $param =~ s/\\s+$//;

#print "-$param-\n";
  return $param;
}

#monta hash status anterior ---------------- para analisar incremento....e montar historio por interface

#$t;0
#$data_reg;1
#$int_status;2
#$protocolo_st;3
#$serv;4
#$status_int;5
#$status_int_errs;6
#$inc_crc;7
#$inc_input_error;8
#$inc_out_err;9
#$inc_collissions;10
#$inc_int_resets;11
#$inc_total_drop;12
#$reli_m;13
#$pkt_in;14
#$pkt_out;15
#$bytes_in;16
#$bytes_out;17
#$rxload;18
#$txload;19
#$hostame;20
#$int_s;21
#$tst;22
#$data_tst;23
#$inc_crc;24
#$inc_input_error;25
#$inc_out_err;26
#$inc_collissions;27
#$inc_int_resets;28
#$inc_total_drop;29

#total_cti_10.32.12.1-mcrce01.rce.psys.txt

$lote=@ARGV[0];

#arq=@ARGV[1];
$ip=@ARGV[1];
$hostname=@ARGV[2];
$times=@ARGV[3];

$arquivo=$ip."-".$hostname."-".$times."-.txt";

$dir="/usr/coleta_crc/log/".$lote;

#opendir (MEUDIR, "$dir");
#@pegoodir = readdir(MEUDIR);
#closedir (MEUDIR);

   $dir_result="/usr/coleta_crc/log_telnet";
   $dir_result_o="/usr/coleta_crc/log_telnet_sum";
   $dir_st_telnet="/usr/coleta_crc/st";
   $arq_open=$dir."/".$arquivo;

  $arqx=$ip."-".$hostname.".txt";
  $arqxt=$ip."-".$hostname."-".$times."-.txt";
#$arqx="$arq".".txt";

#### monta os hashs

%host_interface_old=();

open(coleta_up1,"$dir_result_o/coleta_int_$arqx");

@t_up_old=<coleta_up1>;

close(coleta_up1);

#print "1dir $dir \n 2arq $arq_open \n 3old $dir_result_o/coleta_int_$arqx ###########\n";
foreach $ito (@t_up_old){

   $ito=~s/\n//g;
   $ito=~s/\r//g;


   @dd=split(/;/,$ito);

   $time_stamp=@dd[0];
   $hostname=@dd[20];
   $interface=@dd[21];
   $interface_status=@dd[5];
   $in_errs=@dd[8];
   $out_errs=@dd[9];
   $colis=@dd[10];
   $resets=@dd[11];
   $drop=@dd[12];
   $crc=@dd[7];
   $rxload=@dd[18];
   $txload=@dd[19];
   $status=@dd[6];
   $data_r=@dd[1];
   $time_err=@dd[22];
   $data_err=@dd[23];

   $ref=$hostname."_".$interface;

   $dados="$time_stamp;$data_erro;$interface_status;$in_errs;$out_errs;$colis;$resets;$drop;$crc;$rxload;$txload;$status;$time_err;$data_err;";
#print "$ref | $dados \n";
   $host_interface_old{$ref}=$dados;
}



#print "$dir_result_o/coleta_int_$arqx\n";

#$diretorio="/usr/coleta_crc/log/$lote";

#$arquivo=$arq_open;

#print "$diretorio/$arquivo\n";
   open (MEUFILE, "$dir/$arquivo");

   @minhas_linhas = <MEUFILE>;

   close (MEUFILE);

#rint "open $dir/$arq_open\n";
#print "$dir/$dados ===> $dir/old/$dados\n";
#$sh->rm("$dir/$arquivo");
#sh->mv("$dir/$arquivo","$dir/old/$arqxt");

#unlink($dir/$arquivo);

$up=0;
$trf=0;
$crc=0;
$conta_err=0;
$dn=0;

open(coleta_int,">$dir_result_o/coleta_int_$arqx");

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
         open(r_st,">$dir_st_telnet/$arqx");
         print r_st "ok";
         close(r_st);  

      }

#######durante interfaces habilitadas

      if ($ver eq 'y'){

         #print "$hostname;$item\n";

         if ($item=~/#show mem/){

            $ver="n";

         }

         if ($item=~/^(Ser|ATM|Eth|Fas|Gig|Vla)/){
            $int="$item"; 
             
         }

         if ($int=~/[0-9]\.[0-9]{1,4}/){

            $ver_int='y';

            $t_int="sub"; 
            #habilita ver sub atm

         }
         else{
            
            $ver_int='y';

         }

###########retira dados da interface
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
##### fim retira dados interface

      }

#########################
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
       #  ############################
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

       @total_drops=split(/:/,$in_q);

       $total_drop=@total_drops[2];
       $total_drop=~s/ //g;

#ver crc de subinterface

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

######################

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

             #print "####### ----> @reli_n --  @reli\n";

          }

          $reli_m=sprintf("%.0f",$reli_m);

          @txload=split(/ /,@reli[1]);

          @tx_n=split(/\//,@txload[2]);

          if (@tx_n[1]>0){

             $txload=@tx_n[0]/@tx_n[1]*100;

          }
          else{

             #print "######### @txload\n";
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

             #print "####### ----> @reli_n --  @reli\n";

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

             #print "######### @txload\n";
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

             #print "###### @rxload -- $reli\n";
          }

          $txload=sprintf("%.1f",$txload);
          $rxload=sprintf("%.1f",$rxload);

       }
################inserir na base##########################################################

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
###retira espaços

       $serv=~s/ //g;
       $usuario=~s/  //g;
       $usuario=~s/'/ /g;
       $cli=~s/ //g;
       $crit=~s/ //g;


      #so faz bkb
#print "$serv\n";

      if ($serv=~/BKB/){

#        print "faz $interface <br>";
     }
     else{

        next;

    }
######


      $t=time();
      ($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime($t);

      $anos=1900 + $ano;

      $mess=$mes+1;

      $data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$anos,$mess,$dia_m,$hora,$min,$seg);

      #####################
      ###926
      #redefine status ----- 

      $refx=$hostname."_".$int_s;
 
#   $dados="$time_stamp;$data_erro;$interface_status;$in_errs;$out_errs;$colis;$resets;$drop;$crc;$rxload;$txload;$status;$time_err;$data_err;";
      @dd=split(/;/,$host_interface_old{$refx});

#print "$refx || $host_interface_old{$refx} \n";
      $time_stamp_o=$dd[0];
      $data_reg_o=$dd[1];
      $interface_status_o=$dd[2];
      $in_errs_o=$dd[3];
      $out_errs_o=$dd[4];
      $colis_o=$dd[5];
      $resets_o=$dd[5];
      $drop_o=$dd[7];
      $crc_o=$dd[8];
      $rxload_o=$dd[9];
      $txload_o=$dd[10];
      $status_o=$dd[11];
      $time_err_o=$dd[12];
      $data_err_o=$dd[13];

      #se crcx maior que crc antigo
      #crc
      if ($crc_x>=$crc_o){

         $inc_crc=$crc_x-$crc_o;

      }
      else{

         $inc_crc=$crc_x;

      }


      #print "############## $crc_x \n";
      #errs in
      if ($input_error>=$in_errs_o){

         $inc_input_error=$input_error-$in_errs_o;

      }
      else{

         $inc_input_error=$input_error;

      }

      #errs out
      if ($out_err>=$out_errs_o){

          $inc_out_err=$out_err-$out_errs_o;

      }
      else{

         $inc_out_err=$out_err;

      }

      #collisions

      if ($collissions>=$colis_o){

         $inc_collissions=$collissions-$colis_o;

      }
      else{

         $inc_collissions=$collissions;

      }

      #resets

      if ($int_resets>=$resets_o){

         $inc_int_resets=$int_resets-$resets_o;

      }
      else{

         $inc_int_resets=$int_resets;

      }

      #drops

      if ($total_drop>=$drop_o){

         $inc_total_drop=$total_drop-$drop_o;

      }
      else{

         $inc_total_drop=$total_drop;

      }

      $refi=$refx;
      $refi=~s/\//_/g;
      $arq=$refi."_crc.txt";


#############################################################################

      $status_int="";


     if ($protocolo_st=~/up/ and $int_status=~/up/){

         $status_int="up";

      }

      if ($protocolo_st=~/down/ and $int_status=~/up/){

         $status_int="up down";

      }


      if ($int_status=~/administratively down/){

         $status_int="administratively down";

      }

      if ($protocolo_st=~/down/ and $int_status=~/down/){

         $status_int="down down";

      }

      if ($int_status=~/deleted/){

         $status_int="deleted";

      }

      if ($status_int eq $interface_status_o){

         $ti="$time_stamp_o";
         $data_regi="$data_reg_o";

         if (length($ti)<3){

            $ti=$t;
            $data_regi=$data_reg;
         }
      }
      else{

         $ti="$t";
         $data_regi="$data_reg";

#print "$ti - $data_regi\n";
      }


       $int_status=~s/^\\s+//g;
       $int_status=~s/\\s+$//g;

       $protocolo_st=~s/ //g;


      if ($status_int eq 'up' or $status_int eq 'up down'){

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

         if ($dds[7]>300){

             $conta_inc_crc++; 

         } 

         if ($dds[8]+$dds[9]>300){

             $conta_inc_errs++; 

         } 

         if ($dds[10]>300){

             $conta_inc_coli++; 

         } 

         if ($dds[11]>1){

             $conta_inc_resets++; 

         } 

         if ($dds[12]>200){

             $conta_inc_drop++; 

         } 

         if ($dds[13]>80){

             $conta_inc_reli++;
         } 
  
         if ($dds[18]>79 or $dds[19]>79){

             $conta_inc_trf++; 

         } 
      }

      open($refx,">/usr/coleta_crc/log_interfaces/$arq");


#define data e hora status
#print "$status_int -- $int_s - $int_status \n";

      $status_int_errs="-";

#$inc_crc;

      if ($conta_inc_crc>2){

         $status_int_errs=$status_int_errs."crc - ";

      }

#$inc_input_error

      if ($conta_inc_input_error>2 or $conta_inc_out_err>2 or $reli_m<95){

         $status_int_errs=$status_int_errs."errors - ";

      }

      if ($conta_inc_coli>1){

         $status_int_errs=$status_int_errs."collisions - ";

      }

      if ($conta_inc_resets>2){

         $status_int_errs=$status_int_errs."resets - ";

      }

      if ($conta_inc_drop>5){

         $status_int_errs=$status_int_errs."drops - ";

      }

      if ($conta_inc_trf>2){

         $status_int_errs=$status_int_errs."util link > 80% - ";

      }

     if ($status_int_errs eq '-'){
     
     $status_int_errs="ok";
     }


print "\n$status_int_errs || trf: $conta_inc_trf;drop: $conta_inc_drop;ts: $conta_inc_resets;err: $conta_inc_out_err;crc: $conta_inc_crc \n";
      print coleta_int "$ti;$data_regi;$int_status;$protocolo_st;$serv;$status_int;$status_int_errs;$crc_x;$input_error;$out_err;$collissions;$int_resets;$total_drop;$reli_m;$pkt_in;$pkt_out;$bytes_in;$bytes_out;$rxload;$txload;$hostname;$int_s;$te;$data_rege;$inc_crc;$inc_input_error;$inc_out_err;$inc_collissions;$inc_int_resets;$inc_total_drop;\n";

#      print "$ti;$data_regi\n";
      print $refx "$t;$data_reg;$int_status;$protocolo_st;$serv;$status_int;$status_int_errs;$inc_crc;$inc_input_error;$inc_out_err;$inc_collissions;$inc_int_resets;$inc_total_drop;$reli_m;$pkt_in;$pkt_out;$bytes_in;$bytes_out;$rxload;$txload;\n";


      $conta=0;

      foreach $it (@crc_olds){

         if ($conta>144){

            last;

         }

         print $refx "$it";

         $conta++;

      }

close($refx);
      }
############################################################### fim if
#####gravar interface


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
   $status_int="";
   $status_int_errs="";
####
   }


#########################
#$sh->mv("$dir_result/coleta_int_$arqx","$dir_result_o/coleta_int_$arqx");
#### fim for arquivo
   }

close(coleta_int);
#$sh->mv("$dir_result/coleta_int_$arqxt","$dir_result_o/coleta_int_$arqx");
# fim for dir
#}

#$sh->close;
exit
