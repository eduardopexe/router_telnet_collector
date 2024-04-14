<?
$arq=$_GET['ahost'];
$tipo=$_GET['tip'];

$arqs=split("-",$arq);

$host=$arqs[0];

$int=$arqs[1];

$int_x=split(" ",$arqs[1]);

#echo "$int_x[0] ; $int_x[1] ; $arqs[1] <br>";

$int_r=str_replace("/","_",$int_x[0]);
$int=$arqs[1];


#echo "$arquivo <br>";

//##############################
//## DEFININDO ARRAYS
#echo "$tipo####";
if ($tipo=="crc"){

$n=7;
$nl=300;
$max=900;
}

if ($tipo=="errors"){

$n=8;
$nl=300;
$max=900;

$tipo2="in errors";
$n2=9;

}

if ($tipo=="collisions"){

$n=10;
$nl=300;
$max=900;
}

if ($tipo=="resets"){

$n=11;
$nl=1;
$max=10;
}

if ($tipo=="drops"){

$n=12;
$nl=300;
$max=900;
}

if ($tipo=="rxload"){

$n=18;
$nl=80;
$max=100;

$tipo2="txload";
$n2=19;

}

$arquivo=$host."_".$int_r."_crc.txt";
#$res_arq=split("-",$arq_2);


$arquivo="/usr/coleta_crc/log_interfaces/".$arquivo;
#echo "$arquivo <br>";

$fp = file($arquivo);

$inc_inst=array();
$inc_inst2=array();
$i=0;

//#############################

#rsort($fp);
$tlin=0;

foreach ( $fp as $linha ){

$tlin++;

}

if ($tlin<20){
$i=0;
$j=$tlin-1;
}
else{

$i=0;
$j=20;
}

#$j=20;
if ($tlin==0){

$intx=split("\.",$int_r);
$int2=split("\.",$int);
$int=$int2[0];

$arquivo=$host."_".$intx[0]."_crc.txt";
#$res_arq=split("-",$arq_2);


$arquivo="/usr/coleta_crc/log_interfaces/".$arquivo;
#echo "$arquivo <br>";

$fp = file($arquivo);


foreach ( $fp as $linha ){

$tlin++;

}

if ($tlin<20){
$i=0;
$j=$tlin-1;
}
else{

$i=0;
$j=20;
}


}


if ($tlin>0){

foreach ( $fp as $linha ){

if ($i>$j){
Break;
}


$res=split(";",$linha);

$timestp=$res[0];

$data=$res[1];
  
  // SEPARANDO A DATA DA HORA
    $rt_hora=split(" ",$data);
    $res_hora=$rt_hora[1];
  
  // RETIRANDO OS SEGUNDOS DA HORA 
    $res_segundo=split(":",$res_hora);  
    $res_seg=$res_segundo[0].":".$res_segundo[1];
 
#echo "$res_seg $res[2]<br>"; 
  // DATA
    $res_data=$rt_hora[0];  

$inc=$res[$n];

#echo "$n || $nl ||----  $res[$n]  ---- $res_seg <br>";
// UTILIZANDO ARRAYS PARA AS LINHAS DE EIXO X E Y

$ji=$j-$i;

#echo "$ji <br>";
$inc_hora[$ji]=$res_seg;
$inc_inst[$ji]=$inc;
$inc_lim[$ji]=$nl;

if ($n2>0){

$inc_inst2[$ji]=$res[$n2];

}

$i++;
}

include ("/usr/local/jpgraph/src/jpgraph.php");
include ("/usr/local/jpgraph/src/jpgraph_line.php");


//----------------------
// Setup graph 1
//----------------------

$titulo_1=$host."_".$int." - $tipo - ".$res_data;

$x_axis =($inc_hora);

#echo "$x_axis[19] <br>";

$tam_x="580";
$tam_y="280";

$datay1 = $inc_inst;
$datay2 = $inc_lim;
// Setup the graph
$graph = new Graph($tam_x,$tam_y);


$graph->SetScale("textlin",0,$max);
#$theme_class=new UniversalTheme;

#$graph->SetTheme($theme_class);
$graph->img->SetAntiAliasing(false);
$graph->title->Set("$titulo_1");
$graph->SetBox(false);

$graph->img->SetAntiAliasing();

$graph->yaxis->HideZeroLabel();
$graph->yaxis->HideLine(false);
$graph->yaxis->HideTicks(false,false);

$graph->xgrid->Show();
#$graph->xgrid->SetLineStyle("solid");
$graph->xaxis->SetTickLabels($inc_hora);
$graph->xaxis->SetLabelAngle(90);
$graph->xgrid->SetColor('#E3E3E3');

// Create the first line
$p1 = new LinePlot($datay1);
$graph->Add($p1);
$p1->SetColor("#6495ED");
$p1->SetLegend("$tipo");

// Create the second line
$p2 = new LinePlot($datay2);
$graph->Add($p2);
$p2->SetColor("#FF0000");
$p2->SetLegend("limiar: $nl");

if ($n2>0){

$p3 = new LinePlot($inc_inst2);
$graph->Add($p3);
$p3->SetColor("#FF00FF");
$p3->SetLegend("$tipo2");


}

$graph->legend->SetFrameWeight(0);

// Adjust the margin
$graph->img->SetMargin(40,40,20,70);
$graph->legend->SetLayout(LEGEND_HOR);
$graph->legend->Pos(0.5,0.99,"center","bottom");

// Output line
$graph->Stroke();
}
else{

echo "coleta nao realizada para $host $int !<br>";

}

?>
