<?php
header('Content-type: text/csv');
$sql = "show tables";
if (key_exists("query", $_GET))
{
	$sql = $_GET['query'];
	header("Content-disposition: attachment;filename=\"${sql}.csv\"");
}
$scrapePath = "/home/tltsecure/work/ECHOEPA_SQL/";
$out = fopen('php://output', 'w');
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



if (key_exists("pg", $_GET))
{

$conn = pg_connect("host=$host port=5432 dbname=$currentDB user=$user password=$pass");
$result = pg_query($conn, $sql);
if(!$result){
	echo pg_last_error($result);
}

while ( $row = pg_fetch_array($result, NULL, PGSQL_ASSOC))
{

	if ($firstRow)
	{
		fputcsv($out, array_keys($row));
		$firstRow = false;
	}
	fputcsv($out, $row);

}

}
// else
// {
// 	$mysqli = new mysqli($host, $user, $pass, $currentDB);

// 	if ($mysqli->connect_errno)
// 	{
// 		fputcsv($out, "Error: Failed to make a MySQL connection, here is why: \n");
// 		fputcsv($out, "Errno: " . $mysqli->connect_errno . "\n");
// 		fputcsv($out, "Error: " . $mysqli->connect_error . "\n");

// 		exit;
// 	}
// 	$services = $mysqli->query($sql);
// 	if(!$services){
// 		$row= array($mysqli->error);
// 		fputcsv($out, $row);

// 	}
// 	else{
// 		while ($row = $services->fetch_array(MYSQLI_ASSOC))
// 		{

// 			if ($firstRow)
// 			{
// 				fputcsv($out, array_keys($row));
// 				$firstRow = false;
// 			}
// 			fputcsv($out, $row);

// 		}
// 	}
// }

?>
