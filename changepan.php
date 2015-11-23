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
	$pan=$_SESSION['domain'];
	
	

 $connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));


 	$sqltest="SELECT start, end from Wears
	where pan='$pan'
	and end >=all(select end from Wears
	where pan='pan003.healthunit.org');";

	$checktime =$connection->query($sqltest);
	foreach ($checktime as $row) {
		$t1=$row['start'];
		$t2=$row['end'];
	}
	if($t2<$time_end || $t1>$time_start){
			echo "Invalid Period";
	}else{
 $sqlperiod ="INSERT into Period values ('$time_start','$time_end');"; 
 $addtime = $connection->exec($sqlperiod);
	foreach($_REQUEST as $name => $value)
{
if ($name == 'device')
{
foreach($_REQUEST[$name] as $device)
{


$myArray = explode(';', $device);
$snum=$myArray[0];
$manuf=$myArray[1]; 
$panurl=$_SESSION['domain'];
$sqlconnects = "INSERT into Connects values ('$time_start','$time_end','$snum','$manuf','$panurl');";
$addconnnects = $connection->exec($sqlconnects);
echo("<p>Rows inserted: $addconnnects</p>");
echo("<p>Devices have been transfered!!!");
}
}

}
	$connection=null;
}
	?>
</html>