#!/usr/bin/perl 

$t=time();



open (result, ">/fping_mon/ras/resultado/coleta_ras.txt");

#open (data,"/fping_mon/resultados/data_coleta_pnam_pabx.txt");

@minhas_linhas = <result>;

close (result);

@data=<data>;
close(data);

$dt=@data[0];



$dt=~s/\n//;
$dt=~s/\r//;

$tempo_coleta=$dt;
#print "$dt\n";

$dir="/coleta_config_router/fping_mon/log";

$dir_log_st="/coleta_config_router/fping_mon/log_st";
#monta arrays

open (log_st,">>$dir_log_st/log_pnam_pabx.txt");

open (am_old,"<$dir/amarelo_pnam_pabx.txt");
open (vm_old,"<$dir/vermelho_pnam_pabx.txt");
open (lj_old,"<$dir/laranja_pnam_pabx.txt");
open (vd_old,"<$dir/verde_pnam_pabx.txt");

@am=<am_old>;
@vm=<vm_old>;
@lj=<lj_old>;
@vd=<vd_old>;

close(am_old);
close(vm_old);
close(lj_old);
close(vd_old);

############################################
open (am,">$dir/amarelo_pnam_pabx.txt");
open (vm,">$dir/vermelho_pnam_pabx.txt");
open (lj,">$dir/laranja_pnam_pabx.txt");
open (vd,">$dir/verde_pnam_pabx.txt");
open (geral,">$dir/geral_pnam_pabx.txt");

$vd=0;
$am=0;
$lj=0;
$vm=0;

foreach $rtt (@minhas_linhas){

($seg,$min,$hora,$dia_m,$mes,$ano,$dia_s,$dia_a,$isdst)=localtime(time);

$mes=$mes+1;

$ano=1900+$ano;

$data_reg=sprintf("%04d-%02d-%02d %02d:%02d:%02d",$ano,$mes,$dia_m,$hora,$min,$seg);


if ($rtt=~/=/ and $rtt=~/,/){

#print "ok - $rtt";

$rtt=~s/:/=/;
$rtt=~s/,/\//;
@result=split(/=/,$rtt);

$ip=@result[0];

@loss=split(/\//,@result[2]);

$loss=@loss[2];

@tempo=split(/\//,@result[3]);

$min=@tempo[0];
$avg=@tempo[1];
$max=@tempo[2];

#############################3

$ip=~s/ //;

$max=~s/ //;
$max=~s/\n//;
$max=~s/\r//;

$loss=~s/%//;

#prepara o ip
@ip=split(/\./,$ip);

if ($loss>32 and $loss<66){

#print am "$dt;$ip;$loss;$min;$avg;$max\n";

#print "$dt;$ip;$loss;$min;$avg;$max\n";

foreach $alarme (@am) {

if ($alarme=~/@ip[0]\.@ip[1]\.@ip[2]\.@ip[3]/){

$al="old";
$linha=$alarme;

}

}
if ($al eq 'old'){

print am "$linha";

#print "$linha\n";

}

else{

print am "$t;$dt;$ip;$loss;$min;$avg;$max\n";

print log_st "$t;$dt;$ip;$loss;$min;$avg;$max;amarelo\n";
}

$am++; 
}

if ($loss>60){
#print lj "$dt;$ip;$loss;$min;$avg;$max\n" ;

#print "$dt;$ip;$loss;$min;$avg;$max\n" ;

foreach $alarme (@lj) {

if ($alarme=~/@ip[0]\.@ip[1]\.@ip[2]\.@ip[3]/){

$al="old";
$linha=$alarme;

}

}
if ($al eq 'old'){

print lj "$linha";

#print "$linha\n";

}

else{

print lj "$t;$dt;$ip;$loss;$min;$avg;$max\n";

print log_st "$t;$dt;$ip;$loss;$min;$avg;$max;laranja\n";

}


$lj++;
}

if ($loss==0){
#print vd "$t;$dt;$ip;$loss;$min;$avg;$max\n" ;

$al="";
#log verde

foreach $alarme (@vd) {

if ($alarme=~/@ip[0]\.@ip[1]\.@ip[2]\.@ip[3]/){

$al="old";
$linha=$alarme;

}

}
if ($al eq 'old'){

#print vd "$linha";

@linha=split(/;/,$linha);

$t=@linha[0];
$dt=@linha[1];

print vd "$t;$dt;$ip;$loss;$min;$avg;$max\n";

#print "$linha\n";

}

else{

print vd "$t;$dt;$ip;$loss;$min;$avg;$max\n";

print log_st "$t;$dt;$ip;$loss;$min;$avg;$max;verde\n";

}

$vd++;


}


}
else{

if ($rtt=~/=/){

#print "nao ok - $rtt";

$rtt=~s/:/=/;
$rtt=~s/,/\//;
@result=split(/=/,$rtt);

$ip=@result[0];

@loss=split(/\//,@result[2]);

$loss=@loss[2];
$loss=~s/\n//;
$loss=~s/\r//;

$loss=~s/%//;

$ip=~s/ //;

#print vm "$dt;$ip;$loss;.;.;.\n" ;

#rotina de verificacao se ja esta fora

@ip=split(/\./,$ip);

foreach $alarme (@vm) {

if ($alarme=~/@ip[0]\.@ip[1]\.@ip[2]\.@ip[3]/){

$al="old";
$linha=$alarme;

}

}
if ($al eq 'old'){

#print tell(vm);

#sysseek(vm,0,SEEK_SET);

#print "-";

#print tell(vm);

print vm "$linha";


#print "\n";

#print "$linha";

#sysseek(vm,2,SEEK_END);
#print "$linha\n";

}

else{

#print tell(vm);

#sysseek(vm,0,SEEK_SET);

#print "-";

#$tst="$dt;$ip;$loss;.;.;.\n" ;

#syswrite vm,$tst,4096,0;

#print $tst;

print vm "$t;$dt;$ip;$loss;.;.;.\n" ;

print log_st "$t;$dt;$ip;$loss;.;.;.;vermelho\n";

#sysseek(vm,2,SEEK_END);

#print tell(vm);

}

$vm++;

}
}

$al="";

$dt=$tempo_coleta;
}

print geral "$tempo_coleta;$vd;$am;$lj;$vm";

close(am);
close(vm);
close(lj);
close(vd);
close(geral);
close(log_st);