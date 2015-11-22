<?php session_start(); ?>
<html>
<body>
<?php
 	$host="db.ist.utl.pt";	// MySQL is hosted in this machine
	$user="ist173654";	// <== replace istxxx by your IST identity
	$password="nutr1007";	// <== paste here the password assigned by mysql_reset
	$dbname = $user;	// Do nothing here, your database has the same name as your username.
	$number = $_REQUEST['number'];

 
	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
	
 	
	echo("<p>Connected to MySQL database $dbname on $host as user $user</p>\n");
	$sqltest="SELECT pan
	from Wears as w, Patient as p
	where w.end>current_timestamp
	and w.patient=p.number
	and p.number='$number';";
	$result = $connection->query($sqltest);

	$bool = $result->rowCount();
	
	if ($bool==0){
		echo("Either this patient doesn't exist or doesn't have any PAN associated to it right now");
	}else{
	foreach($result as $row){
		$_SESSION['domain']=$row['pan'];
		
	}

	$sql = "SELECT c.snum,c.manuf
from Wears as w, PAN as p,Patient as pa, Connects as c
where w.end<current_timestamp
and pa.number=w.patient
and w.pan=p.domain
and pa.number=w.patient
and pa.number='$number'
and w.start<=c.start
and w.end>=c.end
and c.pan=w.pan
and w.end>=all (SELECT w.end
from Wears as w,PAN as p, Patient as pa
where w.end<current_timestamp
and pa.number=w.patient
and w.pan=p.domain
and pa.number=w.patient
and pa.number='$number');";

	$result = $connection->query($sql);
	
	$num = $result->rowCount();

	echo("<p>$num devices retrieved:</p>\n"); // Usar um if para quando so teve uma pan na vida

	?>

	
	<form action="changepan.php" method="post">

		<?php
		
	foreach($result as $row)
	{
		
		$snum=$row['snum'];
		$snum=(string)$snum;
		$manuf=$row['manuf'];
		$manuf=(string)$manuf;
	?>
	 <span><?php echo   ("$snum" .'| '. "$manuf"); ?></span>
	
	<input type="checkbox" name="device[]" value=<?php echo ( $snum .';'. $manuf .';') ; ?> /><br />
	
	<?php
	
	}
	?>
	
	<?php		
        $connection = null;
}
?>

<p><input type="text" name="timestamp_start" value = <?php echo (" '2016-05-20 14:00:00' " ); ?>> </p>
<p><input type="text" name="timestamp_end" value = <?php echo (" '2016-05-25 14:00:00' " ); ?>> </p>
<p><input type="submit" value ="Submit"></p>
</form>
</body>
</html>