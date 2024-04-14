<?PHP
##############################################################################
/* Dados recebidos do Formulario de UPDATE Do Registro Selecionado*/
##############################################################################

# Chamo Arquivo contento as conexoes com o MySQL. #
#include_once("conexao.inc");

$db_server="10.98.22.12";
$db_login="noc";
$db_pass="noc";
$db_name="fping_mon";
$ip_server="10.98.22.14";
$dir_w="rtt_monm";

$con = @mysql_connect($db_server,$db_login,$db_pass,"");
#echo $_con."###################<br>";
if($con == FALSE) {
echo "Nao foi possivel conectar ao Mysql <br>";
mysql_erro();
exit;
} else {

mysql_select_db($db_name,$con);

}

$v_acao=$_GET['v_acao'];

$acao=$_GET['acao'];

$cod=$_GET['cod'];

$data=$_GET['dt'];

$time_stamp=$_GET['tstp'];
$cli=$_GET['cli'];
$int=$_GET['int'];
$host=$_GET['host'];

$acao="check";

$tabela="check_rtt";

if ($cli=="crc"){

$tabela="check_".$cli;

$dir_w="coleta_crc";
}



if ($acao=="check"){

$sql = "Select * from $tabela where time_stamp='$time_stp' AND interface='$int' AND hostname='$host'";
#$sql = "insert into check_rtt (time_stamp,interface,cli,hostname,obs) values ('$time_stamp','$int','rccf','$host','check')";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);


$int=$retorno["interface"];
$cli=$retorno["cli"];
$host=$retorno["hostname"];
$status=$retorno["obs"];
$time=$retorno["time_stamp"];
$cod=$retorno["cod"];


}

if ($v_acao=="alt"){

#echo "entrou <br>";
$int=$_POST['txt_interface'];
$cli=$_POST['txt_cli'];
$host=$_POST['txt_hostname'];
$obs=$_POST['txt_obs'];
$time_stp=$_POST['txt_time_stamp'];
$cod=$_POST['txt_cod'];
$sql2 = "UPDATE $tabela SET obs='$obs' WHERE cod='$cod' AND time_stamp='$time_stp' AND interface='$int' AND hostname='$host'";
#echo $sql;
$uptade = mysql_query($sql2,$con);

###############

$sql = "Select * from $tabela where time_stamp='$time_stp' AND interface='$int' AND hostname='$host'";
#$sql = "insert into check_rccf (time_stamp,interface,cli,hostname,obs) values ('$time_stamp','$int','rccf','$host','check')";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);

#echo "$sql <br>";
$int=$retorno["interface"];
$cli=$retorno["cli"];
$host=$retorno["hostname"];
$obs=$retorno["obs"];
$time=$retorno["time_stamp"];
$cod=$retorno["cod"];

#echo "$obs <br>";
}

######################################3a


if ($v_acao=="altx"){

#echo "entrou <br>";
$int=$_GET['int'];
$cli='rccf';
$host=$_GET['host'];
$time_stp=$_GET['tstp'];
$obs=$_POST['txt_obs'];

$sql2 = "UPDATE $tabela SET obs='$obs' WHERE time_stamp='$time_stp' AND interface='$int' AND hostname='$host'";
#echo $sql;
$uptade = mysql_query($sql2,$con);

###############

$sql = "Select * from $tabela where time_stamp='$time_stp' AND interface='$int' AND hostname='$host'";
#$sql = "insert into check_rccf (time_stamp,interface,cli,hostname,obs) values ('$time_stamp','$int','rccf','$host','check')";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);

#echo "$sql <br>";
$int=$retorno["interface"];
$cli=$retorno["cli"];
$host=$retorno["hostname"];
$obs=$retorno["obs"];
$time=$retorno["time_stamp"];
$cod=$retorno["cod"];

#echo "$obs <br>";
}
#######################################3
if ($v_acao=="com"){

#echo "entrou <br>";
$int=$_GET['int'];
$cli='rccf';
$host=$_GET['host'];
$time_stp=$_GET['tstp'];
$cod=$_GET['cod'];

$sql = "Select * from $tabela where time_stamp='$time_stp' AND interface='$int' AND hostname='$host'";
#$sql = "insert into check_rccf (time_stamp,interface,cli,hostname,obs) values ('$time_stamp','$int','rccf','$host','check')";
$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);

#echo "$sql <br>";
$int=$retorno["interface"];
$cli=$retorno["cli"];
$host=$retorno["hostname"];
$obs=$retorno["obs"];
$time=$retorno["time_stamp"];
$cod=$retorno["cod"];

#echo "$obs <br>";
}

######################################
echo "<br>";
echo "<form method='POST' action='http://$ip_server/$dir_w/bd/atualiza_check_Update.php?v_acao=alt'>";
echo "  <p>&nbsp;</p>";
echo "  <table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='73%' id='AutoNumber1'>";
echo "    <tr>";
echo "      <td width='100%'>";
echo "      <p align='center'><font size='2'>ATUALIZAÇÃO DO COMENTÁRIO:</font></td>";
echo "    </tr>";
echo "    <tr>";
echo "      <td width='100%'>";
echo "      <p align='center'><b>Hostname:</b>".$host." - <b>Interface:</b>".$int." - <b>Cliente:</b>".$cli."</td>";
echo "    </tr>";
echo "    <tr>";
echo "      <td width='100%'><textarea rows='15' name='txt_obs' cols='61' >".$obs."</textarea></td>";
echo "    </tr>";
echo "    <tr>";
echo "      <td width='100%'>";
echo "     <p align='center'><input type='submit' value='atualizar' name='B1'></td>";
echo "    </tr>";
echo "  </table>";
echo "  <p align='center'>&nbsp;</p>";
echo "  <input type='hidden' name='txt_hostname' value='$host'>";
echo "  <input type='hidden' name='txt_interface' value='$int'>";
echo "  <input type='hidden' name='txt_time_stamp' value='$time'>";
echo "  <input type='hidden' name='txt_cod' value='$cod'>";
echo " <input type='hidden' name='txt_cli' value='$cli'>";
echo "</form>";

?>

