<?
$arq=$_GET['ahost'];

$arqs=split("-",$arq);

$host=$arqs[0];

$int_x=split("\.",$arqs[1]);

#echo "$int_x[0] ; $int_x[1] ; $arqs[1] <br>";

$int_r=str_replace("/","_",$int_x[0]);
$int=$arqs[1];

$arquivo=$host."_".$int_r."_crc.txt";
#$res_arq=split("-",$arq_2);


$arquivo="/usr/coleta_crc/log_interfaces/".$arquivo;

#echo "$arquivo <br>";


$fp = file($arquivo);

//##############################
//## DEFININDO ARRAYS

$inc_hora=array();
$inc_crc=array();
$inc_out_err=array();
$inc_coll=array();
$inc_int_resets=array();
$inc_drop=array();
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

$int_status=$res[2];
$protocolo_st=$res[3];
$serv=$res[4];
$status_int=$res[5];
$status_int_errs_s=$res[6];
$inc_crc_s=$res[7];
$inc_err_s=$res[8];
$inc_coll_s=$res[9];
$inc_resets_s=$res[10];
$inc_drop_s=$res[11];


// UTILIZANDO ARRAYS PARA AS LINHAS DE EIXO X E Y

$ji=$j-$i;

#echo "$ji <br>";
$inc_hora[$ji]=$res_seg;
$inc_crc[$ji]=$inc_crc_s;
$inc_out_err[$ji]=$inc_crc_s;
$inc_coll[$ji]=$inc_coll_s;
$inc_int_resets[$ji]=$inc_resets_s;
$inc_drop[$ji]=$inc_drop_s;
$i++;
}

include ("/usr/local/jpgraph/src/jpgraph.php");
include ("/usr/local/jpgraph/src/jpgraph_line.php");


//----------------------
// Setup graph 1
//----------------------

$titulo_1=$host."_".$int." - inc errors e crc - ".$res_data;

$y_axis =($inc_crc);
$y_axis2=($inc_out_err);
$x_axis =($inc_hora);

#echo "$x_axis[19] <br>";

$tam_x="580";
$tam_y="220";

rsort($inc_crc);
rsort($inc_out_err);

// Create the graph and specify the scale for both Y-axis
$graph = new Graph($tam_x,$tam_y,"auto");
$graph->SetScale("textlin");
$graph->SetY2Scale("lin");
$graph->SetShadow();

// Adjust the margin
$graph->img->SetMargin(40,40,20,70);

// Create the two linear plot
$lineplot=new LinePlot($y_axis);
$lineplot2=new LinePlot($y_axis2);

// Add the plot to the graph
$graph->Add($lineplot);
$graph->AddY2($lineplot2);
$lineplot2->SetColor("orange");
$lineplot2->SetWeight(2);

// Adjust the axis color
$graph->y2axis->SetColor("orange");
$graph->yaxis->SetColor("blue");

$graph->title->Set("$titulo_1");
#$graph->xaxis->title->Set("inc crc e out errors");
$graph->yaxis->title->Set("qtd");

$graph->title->SetFont(FF_FONT1,FS_BOLD);
$graph->yaxis->title->SetFont(FF_FONT1,FS_BOLD);
$graph->xaxis->title->SetFont(FF_FONT1,FS_BOLD);
$graph->xaxis->SetTickLabels($inc_hora);
$graph->xaxis->SetLabelAngle(90);
// Set the colors for the plots
$lineplot->SetColor("blue");
$lineplot->SetWeight(2);
$lineplot2->SetColor("orange");
$lineplot2->SetWeight(2);

// Set the legends for the plots
$lineplot->SetLegend("inc CRC 10min +");
$lineplot2->SetLegend("inc out errors");

// Adjust the legend position
$graph->legend->SetLayout(LEGEND_HOR);
$graph->legend->Pos(0.7,0.6,"center","bottom");

// Display the graph
$graph->Stroke();
?>
