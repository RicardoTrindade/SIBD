<?php session_start(); ?>
<html>
<body>
<?php
 	$host="db.ist.utl.pt";	// MySQL is hosted in this machine
	$user="ist173654";	// <== replace istxxx by your IST identity
	$password="nutr1007";	// <== paste here the password assigned by mysql_reset
	$dbname = $user;	// Do nothing here, your database has the same name as your username.
	$time_start = $_REQUEST['timestamp_start'];
	$time_end =$_REQUEST['timestamp_end'];

	
	

 $connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
 $sqlperiod ="INSERT into Period values ('$time_start','$time_end');"; 
 $addtime = $connection->exec($sqlperiod);
	foreach($_REQUEST as $name => $value)
{
if ($name == 'device')
{
foreach($_REQUEST[$name] as $device)
{


$myArray = explode(';', $device);
$snum=$myArray[0]; echo $snum;
$manuf=$myArray[1]; echo $manuf;
$panurl=$_SESSION['domain']; echo $panurl;
$sqlconnects = "INSERT into Connects values ('$time_start','$time_end','$snum','$manuf','$panurl');";
$addconnnects = $connection->exec($sqlconnects);
echo("<p>Rows inserted: $addconnnects</p>");
}
}

}
	$connection=null;
	?>
</html>