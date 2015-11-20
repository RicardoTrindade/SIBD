<html>
<body>
<?php
 	$host="db.ist.utl.pt";	// MySQL is hosted in this machine
	$user="ist173654";	// <== replace istxxx by your IST identity
	$password="nutr1007";	// <== paste here the password assigned by mysql_reset
	$dbname = $user;	// Do nothing here, your database has the same name as your username.
	$time = $_REQUEST['timestamp'];
	echo "$time";
	

 $connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
 $sqlperiod ="INSERT into Period values (current_timestamp,'2016-05-20 14:00:00' );"; 
 $addtime = $connection->exec($sqlperiod);
	foreach($_REQUEST as $name => $value)
{
if ($name == 'device')
{
foreach($_REQUEST[$name] as $device)
{
//echo($device); //plicas printam $name=$device
$myArray = explode(';', $device);
echo $myArray[0];
echo $myArray[1];
}
}

}
	$connection=null;
	?>
</html>