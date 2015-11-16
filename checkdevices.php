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
	FROM Device as d,Patient as p, Wears as w , Connects as c,PAN as pa, Period as t
	where p.name='$name'
	and d.serialnum=c.snum
	and c.pan=pa.domain
	and w.pan=pa.domain
	and w.patient=p.number
	and c.start<=current_timestamp
	and c.end>=current_timestamp;";/* passa-se qualquer coisa com o zé e joana*/

	$result = $connection->query($sql);
	
	$num = $result->rowCount();

	echo("<p>$num devices retrieved:</p>\n");

	echo("<table border=\"1\">\n");
	echo("<tr><td>Serial No.</td><td>Manufacturer</td><td>Description</td></tr>\n");
	foreach($result as $row)
	{
		echo("<tr><td>");
		echo($row["serialnum"]);
		echo("</td><td>");
		echo($row["manufacturer"]);
		echo("</td><td>");
		echo($row["description"]);
		echo("</td></tr>\n");
	}
	echo("</table>\n");

	
		
        $connection = null;
	
	echo("<p>Connection closed.</p>\n");
	echo("<p>Test completed successfully. Now you know how to connect to your MySQL database.</p>\n");

?>


</body>
</html>