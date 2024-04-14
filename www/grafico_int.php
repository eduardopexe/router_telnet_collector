<?

$hosts=$_GET['rhost'];

$link=split("-",$hosts);

$tp=$_GET['tip'];

$host_a=$link[0];
$int_a=$link[1];
$lpa=$link[2];

$host_b=$link[3];
$int_b=$link[4];
$lpb=$link[5];

$itema=$host_a."-".$int_a."-".$lpa;
$itemb=$host_b."-".$int_b."-".$lpb;

$link_url_a="http://10.98.22.18/fping4.0/mon_grap.php?ahost=$itema";
$link_url_b="http://10.98.22.18/fping4.0/mon_grap.php?ahost=$itemb";

$links=array();

$links[0]=$tp;
$links[1]="rxload";
$links[2]="crc";
$links[3]="errors";
$links[4]="resets";
$links[5]="drops";
$links[6]="collisions";

$tt=0;


$frame_c="conteudo".$tt;
$frame_p="principal".$tt;


$link_load_a=$link_url_a."&tip=$tp";
$link_load_b=$link_url_b."&tip=$tp";

echo "<frameset framespacing=\"0\" border=\"0\" frameborder=\"0\" cols=\"639,*\" scrolling=\"auto\">";
echo "<frame name=\"Conteudo\" target=\"principal\" src=$link_load_a>";
echo "<frame name=\"principal\" src=$link_load_b>";
echo "<noframes>";
echo "<body>";

echo "<p>Esta pána usa quadros mas seu navegador nãaceita quadros.</p>";

echo "</body>";
echo "</noframes>";
echo "</frameset>";

?>
