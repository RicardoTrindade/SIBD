<?php session_start(); ?>
<html>
<head>
		<link type="text/css" rel="stylesheet" href="stylesheet.css"/>
</head>
<body>
<?php
 	$host="db.ist.utl.pt";	// MySQL is hosted in this machine
	$user="ist173150";	// <== replace istxxx by your IST identity
	$password="jjia4691";	// <== paste here the password assigned by mysql_reset
	$dbname = $user;	// Do nothing here, your database has the same name as your username.
	$number = $_REQUEST['number'];
 	
 	

	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
	
 	
	$sqltest="SELECT number from Patient where number like '%$number%';";
	$result = $connection->query($sqltest);
	$bool = $result->rowCount();
	

	if ($bool==0){
		echo("<h2>Patient was not found</h2>");
	}else{

	$sql = "SELECT r.value,s.units, r.datetime,d.serialnum,d.manufacturer
	from Patient as p, Wears as w, PAN as pa, Connects as c, Device as d, Sensor as s, Reading as r
	where p.number ='$number'
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

	echo("<h3><strong>Readings</strong></h3>\n");
	if($num==0){
	echo("<h4>There are no Readings<h4>\n");
	}else{

	echo("<h4><strong>$num readings retrieved:</strong></h4>\n");

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
	}
	
	$sql2="SELECT s.value,a.units,s.datetime,d.serialnum,d.manufacturer
	FROM Setting as s, Device as d, Actuator as a, Connects as c, Wears as w,Patient as p
	WHERE s.snum=d.serialnum
	and d.serialnum=c.snum
	and w.pan=c.pan
	and w.patient=p.number
	and p.number='$number'
	and d.serialnum=a.snum
	and w.start<=c.start
	and a.manuf=d.manufacturer
	and w.end>=c.end;
	";

	$result = $connection->query($sql2);
	
	$num = $result->rowCount();

	echo("<h3><strong>Settings</strong></h3>\n");
	if($num==0){
	echo("<h4>There are no Settings</h4>\n");
	}else{
	echo("<h4><strong>$num settings retrieved:</strong></h4>\n");
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

	}	
        $connection = null;
	
}
?>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<div>
<a href="records.html"><strong>Back</strong></a>
</div>

</body>
</html>