<?php
## Include File ##
## Base de Dados ##


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

?>
