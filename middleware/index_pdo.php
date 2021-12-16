<?php
header('Content-type: text/html');

$sql = "select \"PWSID\",\"PWS_NAME\",\"CITY_SERVED\" from \"SDWA_VIOLATIONS\"";
if (key_exists("query", $_GET))
{
	$sql = $_GET['query'];
	header("Content-disposition: attachment;filename=\"${sql}.csv\"");
}

try {
    $pdo = require 'connect.php';

    echo '<p>' . $sql;
    echo '<p>';
    foreach ( $pdo->query( $sql ) as $row) {
        print_r( "PWSID: " . $row[0] . "----PWS_NAME: " . $row[1] . "----CITY: " . $row[2] . "<br/>" );
    }
} catch ( PDOException $e ) {
    print( "Error: " . $e->getMessage() . "<br/>" );
}
 
?>
