<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Refresh" content="30">
<title>BKB CRIT CRC</title>
<style rtt_roxo>
A:hover {color: 0000FF; text-decoration: none}
A:link {color: 000080; text-decoration: none}
A:visited {color: 000080; text-decoration: none}
</style>

</head>

<body link="#000080" vlink="#000080" alink="#0000FF">


<?

####################no sumario

$db_server="10.98.22.12";
$db_login="noc";
$db_pass="noc";
$db_name="fping_mon";
$ipserver="10.98.22.14";
$dir_rtt_w="coleta_crc";
$dir="cti";
$dir_result="coleta_crc/www";

$con = @mysql_connect($db_server,$db_login,$db_pass,"");
if($con == FALSE) {
echo "Nao foi possivel conectar ao Mysql <br>";
mysql_erro();
exit;
}
mysql_select_db($db_name,$con);

$t=strlen($liga_som);

if ($t==0){

$liga_som=$_GET['key_som'];

}

###menu som

$menu_som=$_GET['menu_som'];

if (strlen($menu_som)==0){

$menu_som=$liga_som;

}

echo "<table width=250><tr><td><a href='mon.php?key_som=$menu_som'>menu principal</a></td>";

$link="onclick=\"window.open('http://10.98.22.11/fping_mon/mon_cti_sum.php?key_som=$menu_som','cxras','height=160,width=260,status=no,toolbar=no,menubar=no,location=yes')\"";

echo "<td><a href='#'$link>caixa</a></td></tr></table>";

$fp = file("total_cti_geral.txt");

#echo "#######vermelho#########<br>";

foreach ( $fp as $linha ){

$res=split(";",$linha);

$crc=$res[4];
$crc_chk=0;
$err=$res[5];
$err_chk=0;
$trf=$res[3];
$trf_chk=0;
$vm=$res[6];
$vm_chk=0;

###################################

#verifica crc

#se existe alarme de crc verificar se existe check

   if ($crc>0){

#echo "entrou <br>";
      $fpcrc = file("/$dir_result/coleta_cti_crc_geral.txt");

      rsort($fpcrc);

         foreach ( $fpcrc as $linha ){

            $rescrc=split(";",$linha);

            $sqlcrc="Select * from check_crc where interface='$rescrc[3]' and hostname='$rescrc[2]' and time_stamp='$rescrc[0]' order by cod desc limit 1";

            $resultador = mysql_query($sqlcrc,$con);
#echo "$sqlcrc <br>";

            $retornor=mysql_fetch_assoc($resultador);

            $tcrc=$retornor['time_stamp'];

            if ($rescrc[0]==$tcrc){

               $crc_chk++;

#echo "entrou <br>";
            }

         }

      }

#fim crc verificaa

#verifica err

#se existe alarme de err verificar se existe check

   if ($err>0){

#echo "entrou <br>";
      $fperr = file("/$dir_result/coleta_cti_err_geral.txt");

      rsort($fperr);

         foreach ( $fperr as $linha ){

            $reserr=split(";",$linha);

            $sqlerr="Select * from check_crc where interface='$reserr[3]' and hostname='$reserr[2]' and time_stamp='$reserr[0]' order by cod desc limit 1";

            $resultador = mysql_query($sqlerr,$con);

            #echo "$sqlerr <br>";

            $retornor=mysql_fetch_assoc($resultador);

            $terr=$retornor['time_stamp'];

            if ($reserr[0]==$terr){

               $err_chk++;

            }

         }

      }

#fim err verificaa


#verifica vm

#se existe alarme de vm verificar se existe check

   if ($vm>0){

#echo "entrou <br>";
      $fpvm = file("/$dir_result/coleta_cti_dn_geral.txt");

      rsort($fpvm);

         foreach ( $fpvm as $linha ){

            $resvm=split(";",$linha);

            $sqlvm="Select * from check_crc where interface='$resvm[3]' and hostname='$resvm[2]' and time_stamp='$resvm[0]' order by cod desc limit 1";

            $resultador = mysql_query($sqlvm,$con);
            #echo "$sqlvm <br>";

            $retornor=mysql_fetch_assoc($resultador);

            $tvm=$retornor['time_stamp'];

            if ($resvm[0]==$tvm){

               $vm_chk++;

            }

         }

      }

#fim vm verificaa


#verifica trf

#se existe alarme de trf verificar se existe check

   if ($trf>0){

#echo "entrou <br>";
      $fptrf = file("/$dir_result/coleta_cti_trf_geral.txt");

      rsort($fptrf);

         foreach ( $fptrf as $linha ){

            $restrf=split(";",$linha);

            $sqltrf="Select * from check_crc where interface='$restrf[3]' and hostname='$restrf[2]' and time_stamp='$restrf[0]' order by cod desc limit 1";

            $resultador = mysql_query($sqltrf,$con);
#            echo "$sqltrf <br>";

            $retornor=mysql_fetch_assoc($resultador);

            $ttrf=$retornor['time_stamp'];

            if ($restrf[0]==$ttrf){

               $trf_chk++;

            }

         }

      }

#fim trf verificaa


$crc=$crc-$crc_chk;
$err=$err-$err_chk;
$trf=$trf-$trf_chk;
$vm=$vm-$vm_chk;


$col_span=5;

if ($crc_chk>0){

$crc_span="2";

$col_span++;
}
else {

$crc_span="1";

}

if ($err_chk>0){

$err_span="2";
$col_span++;
}
else {

$err_span="1";

}


if ($trf_chk>0){

$trf_span="2";
$col_span++;
}
else {

$trf_span="1";

}


if ($vm_chk>0){

$vm_span="2";
$col_span++;
}
else {

$vm_span="1";

}
#################################
echo "<table width=250>";

echo "<tr bgcolor='CCCCCC'><td colspan='$col_span' width='490'><font size=1>BKB MPLS INT CRIT! - $res[1]</font></td></tr>";

echo "<tr bgcolor='CCCCCC'>";
echo "<td width='121' bgcolor='00FF00' align='center'>ok</td>";
echo "<td width='242' bgcolor='FF6600' align='center' colspan='$crc_span'>crc</td>";
echo "<td width='242' bgcolor='33CCFF' align='center' colspan='$err_span'>int errs</td>";
echo "<td width='242' bgcolor='9900FF' align='center' colspan='$trf_span'><font color='white'>+ 80%</font></td>";
echo "<td width='121' bgcolor='FF0000' align='center' colspan='$vm_span'><font color='white'>Falha</font></td>";
echo "</tr>";

echo "<tr>";
echo "<td width='121' bgcolor='00FF00' align='center'>";
echo "<a href='mon_$dir.php?ver=vd&key_som=n&menu_som=$menu_som'>$res[2]</a></td>";

echo "</td><td width='242' bgcolor='FF6600' align='center'>";
echo "<a href='mon_$dir.php?ver=lj&key_som=n&menu_som=$menu_som'>$crc</a></td>";

if ($crc_chk>0){

echo "</td><td width='242' bgcolor='CCCCCC' align='center'>";
echo "<a href='mon_$dir.php?ver=lj&key_som=n&menu_som=$menu_som'>$crc_chk</a></td>";

}

echo "<td width='242' bgcolor='33CCFF' align='center'>";
echo "<a href='mon_$dir.php?ver=az&key_som=n&menu_som=$menu_som'>$err</a></td>";

if ($err_chk>0){

echo "</td><td width='242' bgcolor='CCCCCC' align='center'>";
echo "<a href='mon_$dir.php?ver=az&key_som=n&menu_som=$menu_som'>$err_chk</a></td>";

}

echo "<td width='242' bgcolor='9900FF' align='center'>";
echo "<a href='mon_$dir.php?ver=am&key_som=n&menu_som=$menu_som'><font color='white'>$trf</a></font></td>";

if ($trf_chk>0){
echo "entrou";
echo "</td><td width='242' bgcolor='CCCCCC' align='center'>";
echo "<a href='mon_$dir.php?ver=az&key_som=n&menu_som=$menu_som'>$trf_chk</a></td>";

}

echo "<td width='121' bgcolor='FF0000' align='center'>";
echo "<a href='mon_cti.php?ver=vm&key_som=n&menu_som=$menu_som'><font color='white'><b>$vm</b></font></a></td>";


if ($vm_chk>0){

echo "</td><td width='242' bgcolor='CCCCCC' align='center'>";
echo "<a href='mon_$dir.php?ver=az&key_som=n&menu_som=$menu_som'>$vm_chk</a></td>";

}

echo "</tr>";

}


?> 
</body>
</html>
