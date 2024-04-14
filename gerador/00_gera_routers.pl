#!/usr/bin/perl

use DBI();
require "/pexe/config.pl";

$database = "noc";
$host = "10.98.22.7";
$usuario = "noc";
$senha = "noc";

my $dbh = DBI->connect
("DBI:mysql:database=$database;host=$host","$usuario", "$senha",
{'RaiseError' => 1});


#cod,cod_fping,cod_iris,igxa,igxa_porta,igxb,igxb_portb,origem,hostname,interface,ip,mfr_a,housing_a,hostname_remoto,interface_remoto,ip_remoto,mfr_b,housing_b,descricao,servico,envia_email,user_up,data_up,user_inc,obs,endereco_b,endereco_a,vel,designacao_link,designacao_link_b,tipo_link,operadora,operadora_b,cli,ativo,data_alm,st_alm,site,site_b,uf,uf_b,data_inc,atualizado_por,ip_loopback_host,ip_loopback_host_b,ipdest,ipdest_b,ipdest_hex,ipdest_hex_b,id_int,pings,tam_pct,lim_rtt_avg,lim_rtt_max,lim_descartes,ping_snmp,atualizar_snmp_ping,fping,rtt,mnemo_hostname,mnemo_hostname_remoto,id_int_b,e1_a,e1_b



$sql="select cod,cod_fping,cod_iris,igxa,igxa_porta,igxb,igxb_portb,origem,";
$sql=$sql."hostname,interface,ip,mfr_a,housing_a,hostname_remoto,interface_remoto,";
$sql=$sql."ip_remoto,mfr_b,housing_b,descricao,servico,envia_email,user_up,data_up,";
$sql=$sql."user_inc,obs,endereco_b,endereco_a,vel,designacao_link,designacao_link_b,";
$sql=$sql."tipo_link,operadora,operadora_b,cli,ativo,data_alm,st_alm,site,site_b,uf,uf_b,";
$sql=$sql."data_inc,atualizado_por,ip_loopback_host,ip_loopback_host_b,ipdest,ipdest_b,";
$sql=$sql."ipdest_hex,ipdest_hex_b,id_int,pings,tam_pct,lim_rtt_avg,lim_rtt_max,lim_descartes,";
$sql=$sql."ping_snmp,atualizar_snmp_ping,fping,rtt,mnemo_hostname,mnemo_hostname_remoto,id_int_b,e1_a,e1_b";
$sql=$sql." from devices where left(ativo,1) in ('1') and left(fping,1) in ('2','3')";


#print "$sql\n";
%ambiente_a=();
%ambiente_b=();

%snmp_a=();
%snmp_b=();
%hosts=();
%hosts_all=();
%hosts_all_ip=();
%rtt_hosts_a=();
%rtt_hosts_b=();
%rtt_man_hosts=();

%rtt_a=();
%rtt_b=();
%rtt_man=();

###lista de hosts para receber snmpwalk
%hostname_walk=();
%host_ip_loop=();

   $stf = $dbh->prepare("$sql");
   $stf->execute();

   if ($stf->rows==0){

#print "nao entrou\!$sql\n";
   }
   else{

open(lger,">/fping4.0/lista_geral/geral.txt");

      while(($cod,$cod_fping,$cod_iris,$igxa,$igxa_porta,$igxb,$igxb_portb,$origem,$hostname,$interface,$ip,$mfr_a,$housing_a,$hostname_remoto,$interface_remoto,$ip_remoto,$mfr_b,$housing_b,$descricao,$servico,$envia_email,$user_up,$data_up,$user_inc,$obs,$endereco_b,$endereco_a,$vel,$designacao_link,$designacao_link_b,$tipo_link,$operadora,$operadora_b,$cli,$ativo,$data_alm,$st_alm,$site,$site_b,$uf,$uf_b,$data_inc,$atualizado_por,$ip_loopback_host,$ip_loopback_host_b,$ipdest,$ipdest_b,$ipdest_hex,$ipdest_hex_b,$id_int,$pings,$tam_pct,$lim_rtt_avg,$lim_rtt_max,$lim_descartes,$ping_snmp,$atualizar_snmp_ping,$fping,$rtt,$mnemo_hostname,$mnemo_hostname_remoto,$id_int_b,$e1_a,$e1_b) = $stf->fetchrow_array) {

     $hostname=~s/#//g;
     $hostname=~s/-/\./g;
     $hostname=~s/_/\./g;
     $hostname_remoto=~s/#//g;
     $hostname_remoto=~s/-/\./g;
     $hostname_remoto=~s/_/\./g;

print lger "$cod;$cod_fping;$cod_iris;$igxa;$igxa_porta;$igxb;$igxb_portb;$origem;$hostname;$interface;$ip;$mfr_a;$housing_a;$hostname_remoto;$interface_remoto;$ip_remoto;$mfr_b;$housing_b;$descricao;$servico;$envia_email;$user_up;$data_up;$user_inc;$obs;$endereco_b;$endereco_a;$vel;$designacao_link;$designacao_link_b;$tipo_link;$operadora;$operadora_b;$cli;$ativo;$data_alm;$st_alm;$site;$site_b;$uf;$uf_b;$data_inc;$atualizado_por;$ip_loopback_host;$ip_loopback_host_b;$ipdest;$ipdest_b;$ipdest_hex;$ipdest_hex_b;$id_int;$pings;$tam_pct;$lim_rtt_avg;$lim_rtt_max;$lim_descartes;$ping_snmp;$atualizar_snmp_ping;$fping;$rtt;$mnemo_hostname;$mnemo_hostname_remoto;$id_int_b;$e1_a;$e1_b;\n";


         @ha=split(/\./,$hostname);
         @hb=split(/\./,$hostname_remoto);

         if(lc($interface)=~/loo|vlan/ and $tipo_link=~/3-/){
 
            $rl=@ha[0]."-".@ha[2];
            $host_ip_loop{$rl}=$ip;         
            $hosts_all_ip{$hostname}=$ip;
         }

         if (length($hosts_all{$hostname}<3 and length($hostname))>3){

            $hosts_all{$hostname}=$hostname;

         }

         if (length($hosts_all{$hostname_remoto})<3 and length($hostname_remoto)>3){


            $hosts_all{$hostname_remoto}=$hostname_remoto;

         }


         #testa ipa


         $ipa="nao";

##################RTT

      if ($rtt eq 'rtt'){

         $rl=@ha[0]."-".@ha[2];
         $hostname_walk{$rl}=$hostname;

      $sleep=($lim_rtt_avg/1000)*($pings+($pings*0.3));

         if ($sleep<2){
      
            $sleep=2;
         }

         if (length($ipdest_hex)>5){

         #  $rh=
            $rtt_hosts_a{@ha[0]}=$hostname;
            $ref=@ha[0]."_".$interface."_".$cod;
            $tst="shown0cro $ip_loopback_host $ipdest $ipdest_hex $id_int $pings $tam_pct $hostname"."-".$lim_rtt_avg."-"."$lim_rtt_max"."-"."$lim_descartes $interface $sleep $cod\n";
            $tst=~s/\n//g;
            $tst=~s/\r//g;

            $rtt_a{$ref}=$tst;
         }


         if (length($ipdest_hex_b)>5){

            $rl=@hb[0]."-".@hb[2];
            $hostname_walk{$rl}=$hostname_remoto;

            $rtt_hosts_a{@hb[0]}=$hostname_remoto;
            $ref=@hb[0]."_".$interface_remoto."_".$cod;
            $tst="shown0cro $ip_loopback_host_b $ipdest_b $ipdest_hex_b $id_int_b $pings $tam_pct $hostname_remoto"."-".$lim_rtt_avg."-"."$lim_rtt_max"."-"."$lim_descartes $interface_remoto $sleep $cod\n";
            $tst=~s/\n//g;
            $tst=~s/\r//g;
            $rtt_a{$ref}=$tst;

         }

      }


      if ($rtt eq 'rtt man'){

         if ($sleep<2){

            $sleep=2;
         }

         if (length($ipdest_hex)>5){

            $rl=@ha[0]."-".@ha[2];
            $hostname_walk{$rl}=$hostname;
            $rtt_man_hosts{@ha[0]}=$hostname;
            $ref=@ha[0]."_".$interface."_".$cod;
            $tst="shown0cro $ip_loopback_host $ipdest $ipdest_hex $id_int $pings $tam_pct $hostname"."-".$lim_rtt_avg."-"."$lim_rtt_max"."-"."$lim_descartes $interface $sleep $cod\n";
            $tst=~s/\n//g;
            $tst=~s/\r//g;

            $rtt_man{$ref}=$tst;
         }


         if (length($ipdest_hex_b)>5){

            $rl=@hb[0]."-".@hb[2];
            $hostname_walk{$rl}=$hostname_remoto;

            $rtt_man_hosts{@hb[0]}=$hostname_remoto;
            $ref=@hb[0]."_".$interface_remoto."_".$cod;
            $tst="shown0cro $ip_loopback_host_b $ipdest_b $ipdest_hex_b $id_int_b $pings $tam_pct $hostname_remoto"."-".$lim_rtt_avg."-"."$lim_rtt_max"."-"."$lim_descartes $interface_remoto $sleep $cod\n";
            $tst=~s/\n//g;
            $tst=~s/\r//g;

            $rtt_man{$ref}=$tst;

         }



      }



##############RTT

         if ($ip=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ and $fping=~/2-/){

            $ipa="sim";            

            $amb=$cli."-".$ip;
            $ambiente_a{$amb}=$ip;

         }   


        #testa ipb
        
        $ipb="nao";

          if ($ip_remoto=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ and $fping=~/2-/){

            $ipb="sim";            

            $amb=$cli."-".$ip_remoto;
            $ambiente_b{$amb}=$ip_remoto;

         }   

###### se ipa=nao e ipb=nao ----> get snmp de interface


         if ($ipa eq 'nao' and $ipb eq 'nao'){

            ####coleta interfaces

            #a:
            if ($interface ne '-'){

               $ref=$hostname."_".$interface;

               $snmp_a{$ref}=$interface; 

               if (length(@ha[0])>2){

                  $hosts{@ha[0]}=@ha[2];
 
               }

            }
            #b:

            if ($interface_remoto ne '-'){

               $ref=$hostname_remoto."_".$interface_remoto;

               $snmp_b{$ref}=$interface_remoto; 

               if (length(@hb[0])>2){

                  $hosts{@hb[0]}=@hb[2];
 
               }
            }
  
         }


#### se mfra =~ MFR ----> get seriais e controlers

         #mfra a

         if ($mfr_a=~/MFR/){
#if ($hostname=~/mcpae03/){

#print "$hostname $interface \n";
#}
               $ref=$hostname."_".$interface;

               $snmp_a{$ref}=$interface; 

               if (length(@ha[0])>2){

                  $hosts{@ha[0]}=@ha[2];
 
               }

         $rl=@ha[0]."-".@ha[2];
         $hostname_walk{$rl}=$hostname;

         $ver_mfra="y";
         }


         #mfra b

         if ($mfr_b=~/MFR/){

               $ref=$hostname_remoto."_".$interface_remoto;

               $snmp_b{$ref}=$interface_remoto; 
               if (length(@hb[0])>2){

                  $hosts{@hb[0]}=@hb[2];
 
               }
         $rl=@hb[0]."-".@hb[2];
         $hostname_walk{$rl}=$hostname_remoto;

         $ver_mfrb="y";
         }

####no ip A

        if ($ip=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ and $fping=~/2-/ or $ver_mfra eq 'y'){ 

        

        } 
        else {

           if ($tipo_link=~/1-/){

             $rl=@ha[0]."-".@ha[2];
             $hostname_walk{$rl}=$hostname;
             $ref=$hostname."_".$interface;
             $snmp_a{$ref}=$interface;

           }

        }

#### no ip B
        if ($ip_remoto=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/ and $fping=~/2-/ or $ver_mfrb eq 'y'){



        }
        else {

           if ($tipo_link=~/1-/ or $fping=~/3-/){

             $rl=@hb[0]."-".@hb[2];
             $hostname_walk{$rl}=$hostname_remoto;
             $ref=$hostname_remoto."_".$interface_remoto;
             $snmp_b{$ref}=$interface_remoto;

           }

        }


       $ver_mfra="n";
       $ver_mfrb="n";

####################################fim while
      }

   }
###fim if select



foreach $hs (keys(%$hosts_all)){

#$ints="Loopback0";

if ($hosts_all_ip{$hs}=~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/){

next;

}

#print "$hs\n";

 if ($hosts_all{$hs}=~/\.brad/){


      $ints="Loopback100";


  }
  else{

      $ints="Loopback0";


  }

$p=".".$hosts{$hs};

$sql="select ip from controle_interfaces where hostname like '%".$hs."%' and interface like '%".$ints."%' limit 1";


   $stf = $dbh->prepare("$sql");
   $stf->execute();

   if ($stf->rows==0){



   }
   else{


      while(($ipx) = $stf->fetchrow_array) {


         $hosts_all_ip{$hs}=$ipx;

      }


   }

   $stf->finish();

}

$h=0;

$dir_l="/usr/coleta_crc/lista";

open(crc0,">$dir_l/lista_cti0.txt");
open(crc1,">$dir_l/lista_cti1.txt");
open(crc2,">$dir_l/lista_cti2.txt");
open(crc3,">$dir_l/lista_cti3.txt");
open(crc4,">$dir_l/lista_cti4.txt");
open(crc5,">$dir_l/lista_cti5.txt");
open(crc6,">$dir_l/lista_cti6.txt");
open(crc7,">$dir_l/lista_cti7.txt");
open(crc8,">$dir_l/lista_cti8.txt");
open(crc9,">$dir_l/lista_cti9.txt");

$tp=0;

foreach $it (keys(%hosts_all_ip)){
$h++;

if ($it=~/\.psys/){

  if ($tp>9){

     $tp=0;
  }

  $arq_s="crc".$tp;


   print $arq_s "$it:$hosts_all_ip{$it}:lote".$tp."\n";

   $tp++;
}
}
print "total $h \n";
###hosts ip

close(crc0);
close(crc1);
close(crc2);
close(crc3);
close(crc4);
close(crc5);
close(crc6);
close(crc7);
close(crc8);
close(crc9);

exit
