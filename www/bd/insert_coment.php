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

if ($acao=="check"){

$sql = "Select * from check_rtt where cod=".$cod;
#$sql = "insert into check_rccf (time_stamp,interface,cli,hostname,status) values ('$time_stamp','$int','rccf','$host','check')";

#$sql="";

$resultado = mysql_query($sql,$con);
$retorno=mysql_fetch_assoc($resultado);


$int=$retorno["interface"];
$cli=$retorno["cli"];
$host=$retorno["hostname"];
$status=$retorno["obs"];
$time=$retorno["time_stamp"];
$cod=$retorno["cod"];


}



$int=$_POST['txt_interface'];
$cli=$_POST['txt_cli'];
$host=$_POST['txt_hostname'];
$status=$_POST['txt_obs'];
$time=$_POST['txt_time_stamp'];
$cod=$_POST['txt_cod'];

?>

