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

## Include File - sumario ##

include_once("mon_cti_sum.php");

#chave de exibicao

$ver=$_GET['ver'];

if ($ver=="vm" or $ver==""){

$fp = file("coleta_cti_dn_geral.txt");

#echo "#######vermelho#########<br>";

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Serial</td><td width='100'>Descricao</td><td width='100'>Servico</td></td></tr>";

rsort($fp);

foreach ( $fp as $linha )
{

#echo "$linha<br>";
$res=split(";",$linha);

$tempo=$res[0];
$data=$res[1];
$hostname=$res[2];
$interface=$res[3];
$status=$res[4];
$descr=$res[5];
#echo "$descr<br>";
$l_clear=$res[11];
$err_in=$res[16];
$err_out=$res[17];
$int_resets=$res[19];
$total_drop=$res[20];
$crc=$res[21];
$data_reg=$res[22];
$amb=$res[23];
$cli=$res[24];
$site=$res[25];
$serv=$res[26];
$usuario=$res[27];
$crit=$res[28];
$tipo_err=$res[29];
#$ip=trim($res[2]);
#$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where ip='$ip'";
#$resultado = mysql_query($sql,$con);
#$retorno=mysql_fetch_assoc($resultado);
#$hostname=$retorno['hostname'];
#$int=$retorno['interface'];
#$desc=$retorno['descricao'];
#$serv=$retorno['servico'];
#$cod=$retorno['cod'];
#$data_alm=$retorno['data_alm'];
#$st_alm=$retorno['st_alm'];

#$sep="_";

###########novo sistema check

$sqly="Select * from check_crc where interface='$res[3]' and hostname='$res[2]' and time_stamp='$res[0]' order by cod desc limit 1";

#echo "$sqly $con <br>";
$resultadoy = mysql_query($sqly,$con);

#echo "$resultado <br>";
$retornoy=mysql_fetch_assoc($resultadoy);


$tstp_checky=$retornoy['time_stamp'];
$inty=$retornoy['interface'];
$cod_chky=$retornoy['cod'];
$obsy=$retornoy['obs'];

#$tstp=$res[0];
#echo "$res[0] ||| $tstp_check -- $ip <br>";

$ty=$res[0];


$link_chk="<a style='text-decoration: none; font-color: white' href='http://$ipserver/$dir_rtt_w/bd/check_Update.php?acao=check&cod=$cod&dt=$res[1]&host=$res[2]&int=$res[3]&tstp=$ty&cli=crc' target=_blank><font color=white>check</font></a>";

$cor="FF0000";

if ($res[0]==$tstp_checky){

$cor="CCCCCC";

#$link_chk="<a href='./bd/check_Update.php?cod=$cod_chk' target=_blank>comentar</a>";

$link_chk="<a style='text-decoration: none; font-color: white' href='http://$ipserver/$dir_rtt_w/bd/atualiza_check_Update.php?cod=$cod_chk&host=$res[2]&int=$res[3]&tstp=$ty&v_acao=com&cli=crc' target=_blank><font color=white>comentar</font></a>";
}

echo "<tr bgcolor='FF0000'>";
echo "<td width='100'>$res[1]</td>";
echo "<td width='100'>$res[2]</td>";
echo "<td width='100'>$res[3]</td>";
echo "<td width='100'>$descr</td>";
echo "<td width='100'>$serv - <br>$tipo_err: <br> $txload / $rxload <br> last clear: $l_clear</td>";
echo "<td width='100' bgcolor='$cor'>$link_chk</font></td>";
echo "<td width='100'><font color='white'>$obsx</font></td>";
echo "</tr>";


$c++;

}

echo "</table>";
echo "total $c <br>";

}


#verde
if ($ver=="vd"){
$fp = file("coleta_cti_up_geral.txt");

#echo "#######amarelo#########<br>";

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Interface</td><td width='100'>ip</td><td width='100'>Descricao</td><td width='100'>Servico</td></tr>";

rsort($fp);

foreach ( $fp as $linha )
{

#echo "$linha <br>";

$res=split(";",$linha);

$tempo=$res[0];
$data=$res[1];
$hostname=$res[2];
$interface=$res[3];
$status=$res[4];
$descr=$res[5];
$l_clear=$res[11];
$err_in=$res[16];
$err_out=$res[17];
$int_resets=$res[19];
$total_drop=$res[20];
$crc=$res[21];
$data_reg=$res[22];
$amb=$res[23];
$cli=$res[24];
$site=$res[25];
$serv=$res[26];
$usuario=$res[27];
$crit=$res[28];
$tipo_err=$res[29];
#$ip=trim($res[2]);
#$sql="Select hostname,interface,descricao,servico,cli from devices Where ip='$ip'";
#$resultado = mysql_query($sql,$con);
#$retorno=mysql_fetch_assoc($resultado);
#$hostname=$retorno['hostname'];
#$int=$retorno['interface'];
#$desc=$retorno['descricao'];
#$serv=$retorno['servico'];

echo "<tr bgcolor='00FF00'><td width='100'>$res[1]</td><td width='100'>$res[2]</td><td width='100'>$res[3]</td><td width='100'></td><td width='100'>$descr</td><td width='100'>$serv</td></tr>";

$v++;
}

echo "</table>";
echo "total $v <br>";

}

#laranja
if ($ver=="lj"){

$fp = file("coleta_cti_crc_geral.txt");

#echo "#######vermelho#########<br>";

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Serial</td><tdwidth='100'>Descricao</td><td width='100'>Servico</td></td></tr>";

rsort($fp);

foreach ( $fp as $linha )
{

#echo "$linha<br>";
$res=split(";",$linha);

$tempo=$res[0];
$data=$res[1];
$hostname=$res[2];
$interface=$res[3];
$status=$res[4];
$descr=$res[5];
#echo "$descr<br>";
$l_clear=$res[11];
$err_in=$res[16];
$err_out=$res[17];
$int_resets=$res[19];
$total_drop=$res[20];
$crc=$res[21];
$data_reg=$res[22];
$amb=$res[23];
$cli=$res[24];
$site=$res[25];
$serv=$res[26];
$usuario=$res[27];
$crit=$res[28];
$tipo_err=$res[32];
#$ip=trim($res[2]);
#$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where ip='$ip'";
#$resultado = mysql_query($sql,$con);
#$retorno=mysql_fetch_assoc($resultado);
#$hostname=$retorno['hostname'];
#$int=$retorno['interface'];
#$desc=$retorno['descricao'];
#$serv=$retorno['servico'];
#$cod=$retorno['cod'];
#$data_alm=$retorno['data_alm'];
#$st_alm=$retorno['st_alm'];

#$sep="_";

###########novo sistema check

$sqly="Select * from check_crc where interface='$res[3]' and hostname='$res[2]' and time_stamp='$res[0]' order by cod desc limit 1";

#echo "$sqly $con <br>";
$resultadoy = mysql_query($sqly,$con);

#echo "$resultado <br>";
$retornoy=mysql_fetch_assoc($resultadoy);


$tstp_checky=$retornoy['time_stamp'];
$inty=$retornoy['interface'];
$cod_chky=$retornoy['cod'];
$obsy=$retornoy['obs'];

#$tstp=$res[0];
#echo "$res[0] ||| $tstp_check -- $ip <br>";

$ty=$res[0];


$link_chk="<a style='text-decoration: none; font-color: white' href='http://$ipserver/$dir_rtt_w/bd/check_Update.php?acao=check&cod=$cod&dt=$res[1]&host=$res[2]&int=$res[3]&tstp=$ty&cli=crc' target=_blank><font color=white>check</font></a>";

$cor="FFCC66";

if ($res[0]==$tstp_checky){

$cor="CCCCCC";

#$link_chk="<a href='./bd/check_Update.php?cod=$cod_chk' target=_blank>comentar</a>";

$link_chk="<a style='text-decoration: none; font-color: white' href='http://$ipserver/$dir_rtt_w/bd/atualiza_check_Update.php?cod=$cod_chk&host=$res[2]&int=$res[3]&tstp=$ty&v_acao=com&cli=crc' target=_blank><font color=white>comentar</font></a>";
}

$obsx=":";
$obsx=str_replace(chr(13),"<br>",$obsy);

###########novo sistema check

echo "<tr bgcolor='FFCC66'>";
echo "<td width='100'>$res[1]</td>";
echo "<td width='100'>$res[2]</td>";
echo "<td width='100'>$res[3]</td>";
echo "<td width='100'>$descr</td>";
echo "<td width='100'>$serv - <br>$tipo_err: $crc <br> last clear: $l_clear</td>";
echo "<td width='100' bgcolor='$cor'>$link_chk</font></td>";
echo "<td width='100'><font color='white'>$obsx</font></td>";
echo "</tr>";

#<td width='100'><a href='./bd/interface_Update.php?acao=des&cod=$cod'target=_blank>desativar</a></td>
#<td width='100'><a href='./bd/interface_Update.php?acao=des&cod=$cod'target=_blank>desativar</a></td>

$c++;

}

echo "</table>";
echo "total $c <br>";

}

#}
echo "</table>";
echo "total $a <br>";

#####

#amarelo q e roxo
if ($ver=="am"){

$fp = file("coleta_cti_trf_geral.txt");

#echo "#######vermelho#########<br>";

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Serial</td><tdwidt
h='100'>Descricao</td><td width='100'>Servico</td></td></tr>";

rsort($fp);

foreach ( $fp as $linha )
{

#echo "$linha<br>";
$res=split(";",$linha);

$tempo=$res[0];
$data=$res[1];
$hostname=$res[2];
$interface=$res[3];
$status=$res[4];
$descr=$res[5];
#echo "$descr<br>";
$l_clear=$res[11];
$err_in=$res[16];
$err_out=$res[17];
$int_resets=$res[19];
$total_drop=$res[20];
$crc=$res[21];
$data_reg=$res[22];
$amb=$res[23];
$cli=$res[24];
$site=$res[25];
$serv=$res[26];
$usuario=$res[27];
$crit=$res[28];
$reli_m=$res[29];
$txload=$res[30];
$rxload=$res[31];
$tipo_err=$res[32];
#$ip=trim($res[2]);
#$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where ip='$ip'";
#$resultado = mysql_query($sql,$con);
#$retorno=mysql_fetch_assoc($resultado);
#$hostname=$retorno['hostname'];
#$int=$retorno['interface'];
#$desc=$retorno['descricao'];
#$serv=$retorno['servico'];
#$cod=$retorno['cod'];
#$data_alm=$retorno['data_alm'];
#$st_alm=$retorno['st_alm'];

#$sep="_";
###########novo sistema check

$sqly="Select * from check_crc where interface='$res[3]' and hostname='$res[2]' and time_stamp='$res[0]' order by cod desc limit 1";

#echo "$sqly $con <br>";
$resultadoy = mysql_query($sqly,$con);

#echo "$resultado <br>";
$retornoy=mysql_fetch_assoc($resultadoy);


$tstp_checky=$retornoy['time_stamp'];
$inty=$retornoy['interface'];
$cod_chky=$retornoy['cod'];
$obsy=$retornoy['obs'];

#$tstp=$res[0];
#echo "$res[0] ||| $tstp_check -- $ip <br>";

$ty=$res[0];


$link_chk="<a style='text-decoration: none; font-color: white' href='http://$ipserver/$dir_rtt_w/bd/check_Update.php?acao=check&cod=$cod&dt=$res[1]&host=$res[2]&int=$res[3]&tstp=$ty&cli=crc' target=_blank><font color=white>check</font></a>";

$cor="CCCCFF";

if ($res[0]==$tstp_checky){

$cor="CCCCCC";

#$link_chk="<a href='./bd/check_Update.php?cod=$cod_chk' target=_blank>comentar</a>";

$link_chk="<a style='text-decoration: none; font-color: white' href='http://$ipserver/$dir_rtt_w/bd/atualiza_check_Update.php?cod=$cod_chk&host=$res[2]&int=$res[3]&tstp=$ty&v_acao=com&cli=crc' target=_blank><font color=white>comentar</font></a>";
}

$obsx=":";
$obsx=str_replace(chr(13),"<br>",$obsy);

###########novo sistema check


echo "<tr bgcolor='CCCCFF'>";
echo "<td width='100'>$res[1]</td>";
echo "<td width='100'>$res[2]</td>";
echo "<td width='100'>$res[3]</td>";
echo "<td width='100'>$descr</td>";
echo "<td width='100'>$serv - <br>$tipo_err: <br> $txload / $rxload <br> last clear: $l_clear</td>";
echo "<td width='100' bgcolor='$cor'>$link_chk</font></td>";
echo "<td width='100'><font color='white'>$obsx</font></td>";
echo "</tr>";

$a++;

}

#echo "</table>";
#echo "total $a <br>";

}

#}
echo "</table>";
echo "total $a <br>";

#####xxxxx

#azul - outros erros
if ($ver=="az"){

$fp = file("coleta_cti_err_geral.txt");

#echo "#######vermelho#########<br>";

echo "<table width=900>";
echo "<tr bgcolor='CCCCCC'><td width='100'>data</td><td width='100'>Hostname</td><td width='100'>Serial</td><tdwidt
h='100'>Descricao</td><td width='100'>Servico</td></td></tr>";

rsort($fp);

foreach ( $fp as $linha )
{

#echo "$linha<br>";
$res=split(";",$linha);

$tempo=$res[0];
$data=$res[1];
$hostname=$res[2];
$interface=$res[3];
$status=$res[4];
$descr=$res[5];
#echo "$descr<br>";
$l_clear=$res[11];
$err_in=$res[16];
$err_out=$res[17];
$int_resets=$res[19];
$total_drop=$res[20];
$crc=$res[21];
$data_reg=$res[22];
$amb=$res[23];
$cli=$res[24];
$site=$res[25];
$serv=$res[26];
$usuario=$res[27];
$crit=$res[28];
$reli_m=$res[29];
$txload=$res[30];
$rxload=$res[31];
$tipo_err=$res[32];
#$ip=trim($res[2]);
#$sql="Select hostname,interface,descricao,servico,cli,cod,data_alm,st_alm from devices Where ip='$ip'";
#$resultado = mysql_query($sql,$con);
#$retorno=mysql_fetch_assoc($resultado);
#$hostname=$retorno['hostname'];
#$int=$retorno['interface'];
#$desc=$retorno['descricao'];
#$serv=$retorno['servico'];
#$cod=$retorno['cod'];
#$data_alm=$retorno['data_alm'];
#$st_alm=$retorno['st_alm'];

#$sep="_";

###########novo sistema check

$sqly="Select * from check_crc where interface='$res[3]' and hostname='$res[2]' and time_stamp='$res[0]' order by cod desc limit 1";

#echo "$sqly $con <br>";
$resultadoy = mysql_query($sqly,$con);

#echo "$resultado <br>";
$retornoy=mysql_fetch_assoc($resultadoy);


$tstp_checky=$retornoy['time_stamp'];
$inty=$retornoy['interface'];
$cod_chky=$retornoy['cod'];
$obsy=$retornoy['obs'];

#$tstp=$res[0];
#echo "$res[0] ||| $tstp_check -- $ip <br>";

$ty=$res[0];


$link_chk="<a style='text-decoration: none; font-color: white' href='http://$ipserver/$dir_rtt_w/bd/check_Update.php?acao=check&cod=$cod&dt=$res[1]&host=$res[2]&int=$res[3]&tstp=$ty&cli=crc' target=_blank><font color=white>check</font></a>";

$cor="00CCFF";

if ($res[0]==$tstp_checky){

$cor="CCCCCC";

#$link_chk="<a href='./bd/check_Update.php?cod=$cod_chk' target=_blank>comentar</a>";

$link_chk="<a style='text-decoration: none; font-color: white' href='http://$ipserver/$dir_rtt_w/bd/atualiza_check_Update.php?cod=$cod_chk&host=$res[2]&int=$res[3]&tstp=$ty&v_acao=com&cli=crc' target=_blank><font color=white>comentar</font></a>";
}

$obsx=":";

echo "<tr bgcolor='00CCFF'>";
echo "<td width='100'>$res[1]</td>";
echo "<td width='100'>$res[2]</td>";
echo "<td width='100'>$res[3]</td>";
echo "<td width='100'>$descr</td>";
echo "<td width='100'>$serv - <br>$tipo_err: <br> $txload / $rxload <br> last clear: $l_clear</td>";
echo "<td width='100' bgcolor='$cor'>$link_chk</font></td>";
echo "<td width='100'><font color='white'>$obsx</font></td>";
echo "</tr>";


$z++;

}

#echo "</table>";
#echo "total $a <br>";

}

#}
echo "</table>";
echo "total $z <br>";

#####

?> 
</body>
</html>
