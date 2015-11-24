<?php session_start(); ?>
<html>
<head>
		<link type="text/css" rel="stylesheet" href="stylesheet.css"/>
</head>
<body>
<?php
 	$host="db.ist.utl.pt";	
	$user="ist173150";	
	$password="jjia4691";	
	$dbname = $user;	
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
echo("<h2>The Device(s) have been successfully transfered!<h2>");
}
}

}
	$connection=null;

}

?>
<p>&nbsp;</p>
<p>&nbsp;</p>
<h4>If you want to associate other device click "Back"<h4>
<div>
<a href="checkdevices.php"><strong>Back</strong></a>
</div>
</body>

</html>