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
	$name = $_SESSION['name'];

 	$connection = new PDO("mysql:host=" . $host. ";dbname=" . $dbname, $user, $password, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING));
 	
 	?>
 	<h4>The name you wrote appears more than once in our database, please choose which one you want to check for readings and settings.</h4>
 	<fieldset>
<?php
 	$sql = "SELECT number,name from Patient where name ='$name';";
 	$result = $connection->query($sql);

 	foreach ($result as $row){
 		$number=$row['number'];
 		$name = $row['name'];
 		echo ("<p text-align:center,color:black>$number<p>");
 		echo $name;
 		?><form action="repeatedrecords.php" method="post">
 		<p><input type="hidden" name="number" value =  <?php echo $number; ?>></p>
		<p id="p2"><input type="submit" value ="Submit"></p>	
 		

</form>
 		<?php
 	}
 	$connection=null;
 	 ?>
</fieldset>
</body>
</html>	