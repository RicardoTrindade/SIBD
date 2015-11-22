<?php session_start(); ?>
<html>
<body>
	<?php
 	$host="db.ist.utl.pt";	// MySQL is hosted in this machine
	$user="ist173654";	// <== replace istxxx by your IST identity
	$password="nutr1007";	// <== paste here the password assigned by mysql_reset
	$dbname = $user;	// Do nothing here, your database has the same name as your username.
	$name = $_SESSION['name'];

 	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
 	
 	?>
 	<p>The name you wrote appears more than once in our database, please choose which one you want to check for readings and settings.</p>
 	<?php
 	$sql = "SELECT number,name from Patient where name ='$name';";
 	$result = $connection->query($sql);
 	foreach ($result as $row){
 		$number=$row['number'];
 		$name = $row['name'];
 		echo $number;
 		echo ("-");
 		echo $name;
 		?><form action="repeatedrecords.php" method="post">
 		<p><input type="hidden" name="number" value =  <?php echo $number; ?>> </p>
 		<p><input type="submit" value ="Submit"></p>
			
 		</form>
 		</br><?php
 	}
 	$connection=null;
 	 ?>
</body>
</html>	