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
	$sqltest="SELECT name from Patient where name='$name';";
	$result = $connection->query($sqltest);
	$bool = $result->rowCount();
	

	if ($bool==0){
		echo("Patient was not found");
	}else{

	$sql = "SELECT r.value,s.units, r.datetime,d.serialnum,d.manufacturer
	from Patient as p, Wears as w, PAN as pa, Connects as c, Device as d, Sensor as s, Reading as r
	where p.name='$name'
	AND p.number=w.patient
	AND w.pan=pa.domain
	AND pa.domain=c.pan
	AND w.start<=c.start
	AND w.end>=c.end
	AND c.snum=d.serialnum
	AND d.serialnum=s.snum
	AND s.snum=r.snum
	AND c.manuf=d.manufacturer
	AND d.manufacturer=s.manuf
	AND s.manuf=r.manuf
	AND r.datetime>=c.start
	AND r.datetime<=c.end;";

	

	$result = $connection->query($sql);
	
	$num = $result->rowCount();

	echo("<p>$num readings retrieved:</p>\n");

	echo("<table border=\"1\">\n");
	echo("<tr><td>Value</td><td>Units</td><td>Timestamp</td><td>Serial number</td><td>Manufacturer</td></tr>\n");
	foreach($result as $row)
	{
		echo("<tr><td>");
		echo($row["value"]);
		echo("</td><td>");
		echo($row["units"]);
		echo("</td><td>");
		echo($row["datetime"]);
		echo("</td><td>");
		echo($row["serialnum"]);
		echo("</td><td>");
		echo($row["manufacturer"]);
		echo("</td></tr>\n");

	}
	echo("</table>\n");

	
	$sql2="SELECT s.value,a.units,s.datetime,d.serialnum,d.manufacturer
	FROM Setting as s, Device as d, Actuator as a, Connects as c, Wears as w,Patient as p
	WHERE s.snum=d.serialnum
	and d.serialnum=c.snum
	and w.pan=c.pan
	and w.patient=p.number
	and p.name='$name'
	and d.serialnum=a.snum
	and w.start<=c.start
	and a.manuf=d.manufacturer
	and w.end>=c.end;
	";

	$result = $connection->query($sql2);
	
	$num = $result->rowCount();
	echo("<p>$num settings retrieved:</p>\n");
	echo("<table border=\"1\">\n");
	echo("<tr><td>Value</td><td>Units</td><td>Timestamp</td><td>Serial number</td><td>Manufacturer</td></tr>\n");
	foreach($result as $row)
	{
		echo("<tr><td>");
		echo($row["value"]);
		echo("</td><td>");
		echo($row["units"]);
		echo("</td><td>");
		echo($row["datetime"]);
		echo("</td><td>");
		echo($row["serialnum"]);
		echo("</td><td>");
		echo($row["manufacturer"]);
		echo("</td></tr>\n");
	}
	echo("</table>\n");

		
        $connection = null;
	
	echo("<p>Connection closed.</p>\n");
	echo("<p>Test completed successfully. Now you know how to connect to your MySQL database.</p>\n");
}
?>


</body>
</html>