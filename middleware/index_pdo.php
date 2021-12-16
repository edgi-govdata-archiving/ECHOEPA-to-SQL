<?php
header('Content-type: text/html');

$sql = "select 'REGISTRY_ID' from \"ECHO_EXPORTER\"";
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
        print_r( $row );
    }
} catch ( PDOException $e ) {
    print( "Error: " . $e->getMessage() . "<br/>" );
}
 
?>
