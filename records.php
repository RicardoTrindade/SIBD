<html>
	<head>
		<link type="text/css" rel="stylesheet" href="stylesheet.css"/>
		<title>Welcome</title>
	</head>
	<body>
<fieldset>
		<form action ="checkrecords.php" method="post">
		<h2> Welcome to the Medical Center Database</h2>
		<h3>Input patient name to check his readings and settings</h3>
		<select>
	<?php
	$connection = new PDO($dsn, $user, $pass);
	$sql= "SELECT name FROM Patient ORDER BY name";
	$result = $connection->query($sql);
	foreach($result as $row)
	{
	$names= $row['name'];
	echo("<option value=\"$names\">$names</option>");
	}
	?>
	</select>

		<p><input type="submit" value ="Submit"></p>
		</form>
</fieldset>

		<form action ="checkdevices.php" method="post">
		<h3>Input patient name to check the devices attached to his PAN</h3>
		<p> Patient name: <input type ="text" name ="name"/></p>
		<p><input type="submit" value ="Submit"></p>
		</form>
	</body>
</html>

