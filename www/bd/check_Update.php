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
$dir_w="coleta_crc";

$con = @mysql_connect($db_server,$db_login,$db_pass,"");
#echo $_con."###################<br>";
if($con == FALSE) {
echo "Nao foi possivel conectar ao Mysql <br>";
mysql_erro();
exit;
} else {

mysql_select_db($db_name,$con);

}


$acao=$_GET['acao'];

$cod=$_GET['cod'];

$data=$_GET['dt'];

$time_stamp=$_GET['tstp'];
$cli=$_GET['cli'];
$int=$_GET['int'];

$host=$_GET['host'];

$tabela="check_rtt";

if ($acao=="check"){

if ($cli=="crc"){

$tabela="check_".$cli;
}

$sql = "insert into $tabela (time_stamp,interface,cli,hostname,status) values ('$time_stamp','$int','rtt','$host','check')";

$resultado = mysql_query($sql,$con);

# Mostro com esta funcao do Mysql quando registros foram alterados.
#echo "<br>teste $sql : ".mysql_affected_rows($con)."<br>";

#echo "<br> $sql";
}


#$resultado = mysql_query($sql,$con);

# Mostro com esta funcao do Mysql quando registros foram alterados.
#:wq
#aecho "<br>teste $sql : ".mysql_affected_rows($con)."<br>";


#echo "<br> $sql";

echo "atualizacao ok";

echo "<form method='POST' action='http://$ip_server/$dir_w/bd/atualiza_check_Update.php?v_acao=altx&host=$host&tstp=$time_stamp&int=$int&cli=$cli'>";
echo "  <p>&nbsp;</p>";
echo "  <table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='73%' id='AutoNumber1'>";
echo "    <tr>";
echo "      <td width='100%'>";
echo "      <p align='center'><font size='2'>COMENTÁRIO DO ALARME:</font></td>";
echo "    </tr>";
echo "    <tr>";
echo "      <td width='100%'>";
echo "      <p align='center'>&nbsp;</td>";
echo "    </tr>";
echo "    <tr>";
echo "      <td width='100%'><textarea rows='15' name='txt_obs' cols='61'></textarea></td>";
echo "    </tr>";
echo "    <tr>";
echo "      <td width='100%'>";
echo "     <p align='center'><input type='submit' value='enviar' name='B1'></td>";
echo "    </tr>";
echo "  </table>";
echo "  <p align='center'>&nbsp;</p>";
echo "  <input type='hidden' name='txt_hostname' value='$host'>";
echo "  <input type='hidden' name='txt_interface' value='$int'>";
echo "  <input type='hidden' name='txt_time_stamp' value='$time_stamp'>";
echo "  <input type='hidden' name='txt_cod' value='0'>";
echo "</form>";

?>

