<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Refresh" content="30">
<title>status</title>
</head>
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
<body topmargin="0" leftmargin="0">
<?

#echo "<table width=1 cellspacing=1 cellpading=0><tr><td width=250>";

echo "<font size=2><a href='http://10.98.22.10/fping_mon/views/fping_mon.asp?str_texto=def' target='_blank'>Atualizar BD-FPING</a></font><br>";

$liga_som=$_GET['key_som'];

if ($liga_som=="y"){

echo "som ativo - <a href='http://10.98.22.11/fping_mon/mon.php?key_som=n'>desativar</a>";
}
else{

echo "som desativado - <a href='http://10.98.22.11/fping_mon/mon.php?key_som=y'>ativar</a>";

}

#echo "</td><td width=250>";

#include_once("mon_brad_sum.php");
#echo "<br>";
#include_once("mon_unib_sum.php");

#echo "</td><td width=250>";
#echo "<br>";
#include_once("mon_psys_sum.php");

#echo "<br>";
#include_once("mon_ras_sum.php");
#echo "</td></tr></table>";
include_once("mon_rtt_sum.php");
?> 
</body>
</html>
