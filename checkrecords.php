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
	$name = $_REQUEST['name'];

 	

	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
	$contaconta= "SELECT  Count(name) from Patient where name='$name';";
 	$sqlconta = $connection->query($contaconta);
 	
 	foreach($sqlconta as $row){
 		$num=$row['Count(name)'];
 		}
 	if($num>1){
 		$_SESSION['name']=$name;
 		$connection=null;
 		header('Location: repeatednames.php');
 		exit;
 	}
	
	$sqltest="SELECT name from Patient where name='$name';";
	$result = $connection->query($sqltest);
	$bool = $result->rowCount();
	

	if ($bool==0){
		echo("<h2>Patient was not found<h2>");
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
	and p.name='$name'
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