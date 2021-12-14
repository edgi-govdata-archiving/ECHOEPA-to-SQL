<?php
$isJSON=true;


$sql = "select * from ECHO_EXPORTER";
if (key_exists("query", $_GET))
{
	$sql = $_GET['query'];

}
else{
	$sql = 'select * from "ECHO_EXPORTER" limit 100';
}
if(stristr($sql, 'json') === FALSE) {
	$isJSON=false;
}
if(!$isJSON){
header('Content-type: text/csv');
header("Content-disposition: attachment;filename=\"${sql}.csv\"");
$out = fopen('php://output', 'w');
}
else{
	header('Content-Type: application/json; charset=utf-8');
	$out="";
}

$scrapePath = "../";

$dbPostixes = array(
		'a',
		'b'
		);
$currentDBIndex = (int)file_get_contents("${scrapePath}currentDBIndex");
$currentDBpostfix = $dbPostixes[$currentDBIndex];
$db_csv = array_map('str_getcsv', file("${scrapePath}db_${currentDBpostfix}_public.csv"));
$host = $db_csv[1][0];
$currentDB = $db_csv[1][1];
$user = $db_csv[1][2];
$pass = $db_csv[1][3];
$firstRow = true;




$conn = pg_connect("host=$host port=5432 dbname=$currentDB user=$user password=$pass");
$result = pg_query($conn, $sql);
if(!$result){
	echo pg_last_error($result);
}

while ( $row = pg_fetch_array($result, NULL, PGSQL_ASSOC))
{

	if($isJSON)
	{
		$out+=$row;
	}
	if ($firstRow)
	{
		fputcsv($out, array_keys($row));
		$firstRow = false;
	}
	fputcsv($out, $row);

}




?>
