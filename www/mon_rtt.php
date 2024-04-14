<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Refresh" content="60">
<title>status</title>
</head>

<body>
<style type="text/css">
<!--
.style2 {
        color: #00FF00;
        font-size: small;
        font-family: Arial, Helvetica, sans-serif;
        font-weight: bold;
}
.style12 {font-size: x-small; font-family: Verdana, Arial, Helvetica, sans-serif
; color: #000033; }
-->
</style>
</head>

<?

$dir="rtt";
## Include File - sumario ##

$arq="mon_".$dir."_sum.php";

include_once($arq);


#base de dados
$db_server="10.98.22.12";
$db_login="noc";
$db_pass="noc";
$db_name="fping_mon";

$con = @mysql_connect($db_server,$db_login,$db_pass,"");

#echo $_con."###################<br>";
if($con == FALSE) {
echo "Nao foi possivel conectar ao Mysql <br>";
mysql_erro();
exit;
} else {

mysql_select_db($db_name,$con);

}

#chave de exibicao

$ver=$_GET['ver'];

if ($ver=="vm" or $ver=="" or $ver=="vml"){

$fp = file("/coleta_rtt/log_result/lista_result_falha.txt");

#echo "#######vermelho#########<br>";

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Interface</td><td width='100'>ip destino</td><td width='100'>Descricao</td><td width='100'>Servico</td><td width='100'>Loss/total/Lim</td><td width='100'>Med / Lim</td><td width='100'>Max / Lim</td><td width='100'>tipo alarme</td></tr>";
rsort($fp);

foreach ( $fp as $linha )
{

#aif (preg_match('/;vermelho/i', $linha)) {

$res=split(";",$linha);

$ip=trim($res[5]);
$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where ip='$ip'";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);
$hostname=$retorno['hostname'];
$int=$retorno['interface'];
$desc=$retorno['descricao'];
$serv=$retorno['servico'];
$cod=$retorno['cod'];
$data_alm=$retorno['data_alm'];
$st_alm=$retorno['st_alm'];

###ase retorno for vazio testa por interface

if (strlen($desc)<5){

$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where cod='$res[16]'";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);
$hostname="-";
$int="-";
$desc=$retorno['descricao'];
$serv=$retorno['servico'];
$cod=$retorno['cod'];
$data_alm=$retorno['data_alm'];
$st_alm=$retorno['st_alm'];

}


$sep="_";

$cor="FF0000";

if ($st_alm=="check" and $data_alm==$res[1]){

$cor="CCCCCC";
}

$verx="y";

//echo $int;
if ($ver=="vml"){
//total de loopback alarmada

       if (preg_match('/Loopback/i', $int)) {

       //echo "example 1 successful.";

         $verx="y";

       }
        else{

         $verx="n";

        }

}


if ($verx=="y"){ 
echo "<tr bgcolor='FF0000'><td width='100'>$res[1]</td><td width='100'>$res[3]<br>$hostname</td><td width='100'>$res[4]<br>$int</td><td width='100'>$res[5]</td><td width='100'>$desc</td><td width='100'>$serv</td><td width='100'>$res[11] / $res[12]<br>Lim: [ $res[10] ]</td><td width='100'>$res[7] / $res[6]</td><td width='100'>$res[9] / $res[8]</td><td width='100'>$res[14]<br>tam pacote: $res[13]</td></tr>";
#<td width='100'><a href='./bd/interface_Update.php?acao=des&cod=$cod'target=_blank>desativar</a></td>
#<td width='100'><a href='./bd/interface_Update.php?acao=des&cod=$cod'target=_blank>desativar</a></td>
}
$c++;
#}
}

echo "</table>";
echo "total $c <br>";

}
#echo "#######laranja#########<br>";

if ($ver=="lj" or $ver==""){

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Interface</td><td width='100'>ip destino</td><td width='100'>Descricao</td><td width='100'>Servico</td><td width='100'>Loss/total/Lim</td><td width='100'>Med / Lim</td><td width='100'>Max / Lim</td><td width='100'>tipo alarme</td></tr>";
$fp = file("/coleta_rtt/log_result/lista_result_lat.txt");

rsort($fp);

foreach ( $fp as $linha )
{

#if (preg_match('/;laranja/i', $linha)) {

#echo "$linha <br>";
$res=split(";",$linha);
$ip=trim($res[5]);
$sql="Select hostname,interface,descricao,servico,cli from devices Where ip='$ip'";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);
$hostname=$retorno['hostname'];
$int=$retorno['interface'];
$desc=$retorno['descricao'];
$serv=$retorno['servico'];

if (strlen($desc)<5){

$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where cod='$res[16]
'";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);
$hostname="-";
$int="-";
$desc=$retorno['descricao'];
$serv=$retorno['servico'];
$cod=$retorno['cod'];
$data_alm=$retorno['data_alm'];
$st_alm=$retorno['st_alm'];

}
#aecho "<tr bgcolor='FF9900'><td width='100'>$res[1]</td><td width='100'>$hostname</td><td width='100'>$int</td><td width='100'>$ip</td><td width='100'>$desc</td><td width='100'>$serv</td><td width='100'>$res[3]</td><td width='100'>$res[4]</td><td width='100'>$res[5]</td><td width='100'>$res[6]</td></tr>";


echo "<tr bgcolor='9900CC'><td width='100'><font color='white'>$res[1]</td><td width='100'><font color='white'>$res[3]<br><font color='white'>$hostname</td><td width='100'><font color='white'>$res[4]<br>$int</td><td width='100'><font color='white'>$res[5]</td><td width='100'><font color='white'>$desc</td><td width='100'><font color='white'>$serv</td><td width='100'><font color='white'>$res[11] / $res[12]<br>Lim: [ $res[10] ]</td><td width='100'><font color='white'>$res[7] / $res[6]</td><td width='100'><font color='white'>$res[9] / $res[8]</td><td width='100'><font color='white'>$res[14]<br>tam pacote: $res[13]</font></td></tr>";

$d++;
#}
}

echo "</table>";
echo "total $d <br>";

}

if ($ver=="am" or $ver==""){
$fp = file("/coleta_rtt/log_result/lista_result_desc.txt");

#echo "#######amarelo#########<br>";

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Interface</td><td width='100'>ip destino</td><td width='100'>Descricao</td><td width='100'>Servico</td><td width='100'>Loss/total/Lim</td><td width='100'>Med / Lim</td><td width='100'>Max / Lim</td><td width='100'>tipo alarme</td></tr>";
rsort($fp);

foreach ( $fp as $linha )
{

#aif (preg_match('/;amarelo/i', $linha)) {

#echo "$linha <br>";

   $res=split(";",$linha);
   $ip=trim($res[5]);
   $sql="Select hostname,interface,descricao,servico,cli from devices Where ip='$ip'";
   $resultado = mysql_query($sql,$con);
   $retorno=mysql_fetch_assoc($resultado);
   $hostname=$retorno['hostname'];
   $int=$retorno['interface'];
   $desc=$retorno['descricao'];
   $serv=$retorno['servico'];

if (strlen($desc)<5){

$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where cod='$res[16]
'";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);
$hostname="-";
$int="-";
$desc=$retorno['descricao'];
$serv=$retorno['servico'];
$cod=$retorno['cod'];
$data_alm=$retorno['data_alm'];
$st_alm=$retorno['st_alm'];

}
#a   echo "<tr bgcolor='FFFF00'><td width='100'>$res[1]</td><td width='100'>$hostname</td><td width='100'>$int</td><td width='100'>$ip</td><td width='100'>$desc</td><td width='100'>$serv</td><td width='100'>$res[3]</td><td width='100'>$res[4]</td><td width='100'>$res[5]</td><td width='100'>$res[6]</td></tr>";

echo "<tr bgcolor='99CCFF'><td width='100'>$res[1]</td><td width='100'>$res[3]<br>$hostname</td><td width='100'>$res[4]<br>$int</td><td width='100'>$res[5]</td><td width='100'>$desc</td><td width='100'>$serv</td><td width='100'>$res[11] / $res[12]<br>Lim: [ $res[10] ]</td><td width='100'>$res[7] / $res[6]</td><td width='100'>$res[9] / $res[8]</td><td width='100'>$res[14]<br>tam pacote: $res[13]</td></tr>";

   $a++;
#   echo "</table>";
#   echo "total $a <br>";
#}

}
   echo "</table>";
   echo "total $a <br>";

}

#verde
if ($ver=="vd"){
$fp = file("/coleta_rtt/log_result/lista_result_ok.txt");

#echo "#######amarelo#########<br>";

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Interface</td><td width='100'>ip destino</td><td width='100'>Descricao</td><td width='100'>Servico</td><td width='100'>Loss/total/Lim</td><td width='100'>Med / Lim</td><td width='100'>Max / Lim</td><td width='100'>tipo alarme</td></tr>";
rsort($fp);

foreach ( $fp as $linha )
{

#if (preg_match('/;verde/i', $linha)) {
#echo "$linha <br>";

$res=split(";",$linha);
$ip=trim($res[5]);
$sql="Select hostname,interface,descricao,servico,cli from devices Where ip='$ip'";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);
$hostname=$retorno['hostname'];
$int=$retorno['interface'];
$desc=$retorno['descricao'];
$serv=$retorno['servico'];

if (strlen($desc)<5){

$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where cod='$res[16]
'";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);
$hostname="-";
$int="-";
$desc=$retorno['descricao'];
$serv=$retorno['servico'];
$cod=$retorno['cod'];
$data_alm=$retorno['data_alm'];
$st_alm=$retorno['st_alm'];

}
#aecho "<tr bgcolor='00FF00'><td width='100'>$res[1]</td><td width='100'>$hostname</td><td width='100'>$int</td><td width='100'>$ip</td><td width='100'>$desc</td><td width='100'>$serv</td><td width='100'>$res[3]</td><td width='100'>$res[4]</td><td width='100'>$res[5]</td><td width='100'>$res[6]</td></tr>";

echo "<tr bgcolor='00FF00'><td width='100'>$res[1]</td><td width='100'>$res[3]<br>$hostname</td><td width='100'>$res[4]<br>$int</td><td width='100'>$res[5]</td><td width='100'>$desc</td><td width='100'>$serv</td><td width='100'>$res[11] / $res[12]<br>Lim: [ $res[10] ]</td><td width='100'>$res[7] / $res[6]</td><td width='100'>$res[9] / $res[8]</td><td width='100'>$res[14]<br>tam pacote: $res[13]</td></tr>";
$v++;
#}
}
#}
echo "</table>";
echo "total $v <br>";
#}

}
?> 
</body>
</html>
