<html>

 
<body>
<?php
 	$host="db.ist.utl.pt";	// MySQL is hosted in this machine
	$user="ist173654";	// <== replace istxxx by your IST identity
	$password="nutr1007";	// <== paste here the password assigned by mysql_reset
	$dbname = $user;	// Do nothing here, your database has the same name as your username.
	$name = $_REQUEST['name'];

 
	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));

	echo("<p>Connected to MySQL database $dbname on $host as user $user</p>\n");

	$sql = "SELECT distinct serialnum,manufacturer,description
	FROM Device as d,Patient as p, Wears as w, Connects as c,PAN as pa
	where p.name='$name'
	and d.serialnum=c.snum
	and c.pan=pa.domain
	and w.pan=pa.domain
	and w.patient=p.number
	and d.manufacturer=c.manuf
	and c.start<=current_timestamp
	and c.end>=current_timestamp
	and w.start=c.start
	and w.end=c.end
	;";

	$result = $connection->query($sql);
	
	$num = $result->rowCount();

	echo("<p>$num devices retrieved:</p>\n");

	?>

	
	<form action="de.php" method="post">

		<?php
		
	foreach($result as $row)
	{
		$d=$row['description'];
	?>
	 <span><?php echo $d; ?></span>
	<input type="checkbox" name="PAN" value=<?php echo $d; ?> /><br />
	<?php
	}
	?>
	</form>
	<?php

	
		
        $connection = null;
	
	echo("<p>Connection closed.</p>\n");
	echo("<p>Test completed successfully. Now you know how to connect to your MySQL database.</p>\n");

?>


</body>
</html>