<?php
if (key_exists("query", $_GET))
{
	$sql = $_GET['query'];
	header("Content-disposition: attachment;filename=\"${sql}.json\"");
}
$sql = "SELECT jsonb_build_object('type', 'FeatureCollection', 'features', jsonb_agg(features.feature)) FROM (SELECT jsonb_build_object('type','Feature','id', gid, 'geometry', ST_AsGeoJSON(geom)::jsonb,'properties', to_jsonb(inputs) - 'gid' - 'geom') AS feature FROM (SELECT * FROM \"epa_regions\") inputs) features;;";
$scrapePath = "/home/karen/workspace/EDGI/ECHOEPA_SQL/";
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

 $row = pg_fetch_all($result);

//print_r(json_encode($row));
print_r($row[0]['jsonb_build_object']);






?>
