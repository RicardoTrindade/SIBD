<html>
<body>
<?php
 	$host="db.ist.utl.pt";	// MySQL is hosted in this machine
	$user="ist173654";	// <== replace istxxx by your IST identity
	$password="nutr1007";	// <== paste here the password assigned by mysql_reset
	$dbname = $user;	// Do nothing here, your database has the same name as your username.
	$domain = $_REQUEST['domain'];
	$phone = $_REQUEST['phone'];


 
	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));

	
	echo $domain;
	echo $phone;
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