<?php
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
?>
