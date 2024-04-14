<?

$arqx=$_GET['ahost'];
$arq_2x=$_GET['rhost'];

$arq_r=$_GET['bhost'];
$arq_r2=$_GET['brhost'];

echo "<frameset framespacing=\"0\" border=\"0\" frameborder=\"0\" cols=\"*,*\">";
echo 	"<frame name=\"esquerdo\" src=\"http://10.98.22.11/rtt_monm/mon_grap.php?ahost=$arqx&rhost=$arq_2x\">";
echo 	"<frame name=\"direito\" src=\"http://10.98.22.11/rtt_monm/mon_grap.php?ahost=$arq_r&rhost=$arq_r2\">";
echo 	"<noframes>";
echo 	"<body>";
echo 	"<p>Esta página usa quadros mas seu navegador não aceita quadros.</p>";

echo 	"</body>";
echo 	"</noframes>";
echo "</frameset>";


?>

