<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Refresh" content="30">
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


$t=strlen($liga_som);

if ($t==0){

$liga_som=$_GET['key_som'];

}

###menu som

$menu_som=$_GET['menu_som'];

if (strlen($menu_som)==0){

$menu_som=$liga_som;

}

$dir="rtt";


$fp = file("/coleta_rtt/log_result/lista_result_sum.txt");

#echo "#######vermelho#########<br>";

foreach ( $fp as $linha ){

#echo "$linha<br>";
$res=split(";",$linha);


echo "<table width=250><tr><td><a href='mon.php?key_som=$menu_som'>menu principal</a></td>";

$link="onclick=\"window.open('http://10.98.22.11/fping_mon/mon_$dir_sum.php?key_som=$menu_som','cxbrad','height=160,width=260,status=no,toolbar=no,menubar=no,location=no')\"";

echo "<td><a href='#'$link>caixa</a></td></tr></table>";

echo "<table width='300'>";

echo "<tr bgcolor='CCCCCC'><td colspan='5' width='250'>COR RTT Backbone MPLS</td></tr>";
echo "<tr bgcolor='CCCCCC'><td colspan='5' width='250'>$res[1]</td></tr>";

echo "<tr bgcolor='CCCCCC'><td width='50' bgcolor='00FF00' align='center'>ok</td><td width='50' bgcolor='99CCFF' align='center'>descartes</td><td width='50' bgcolor='9900CC' align='center'><font color='white'>rtt</font></td><td width='50' bgcolor='FF0000' align='center'><font color='white'>Falha</font></td><td width='50' bgcolor='CCCCCC' align='center'><font color='white'>CHK</font></td></tr>";

#$fp = file("/coleta_rtt/log_result/lista_result_sum.txt");

#echo "#######vermelho#########<br>";

#foreach ( $fp as $linha ){

#echo "$linha<br>";
#$res=split(";",$linha);


#fim conta check

echo "<tr><td width='121' bgcolor='00FF00' align='center'><a href='mon_$dir.php?ver=vd&key_som=n&menu_som=$menu_som'>$res[2]</a></td><td width='121' bgcolor='99CCFF' align='center'><a href='mon_$dir.php?ver=am&key_som=n&menu_som=$menu_som'>$res[3]</a></td><td width='121' bgcolor='9900CC' align='center'><a href='mon_$dir.php?ver=lj&key_som=n&menu_som=$menu_som'><font color='white'>$res[4]</font></a></td><td width='121' bgcolor='FF0000' align='center'><a href='mon_$dir.php?ver=vm&key_som=n&menu_som=$menu_som'><font color='white'><b>$res[5]</b></font></a></td><td width='121' bgcolor='CCCCCC' align='center'><a href='mon_$dir.php?ver=vm&key_som=n&menu_som=$menu_som'><font color='white'><b>$res[5]</b></font></a></td></tr>";

$som=$res[6];
}

echo "</table>";

   if ($som=="y" and $liga_som=="y"){

      echo "<bgsound src='http://10.98.22.11/fping_mon_novo/alerta_sonoro/alarme_$dir.wav' loop='1'>";

   }


?>
</body>
</html>
