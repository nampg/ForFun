<?php
header('Content-Type: text/html; charset=utf-8');
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "pcmanagementsystem";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset("utf8");
// Check connection
if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM osm";
$result = $conn->query($sql);








$osmList = array();


if ($result->num_rows > 0) {
	// output data of each row
	while($row = $result->fetch_assoc()) {
		$tempSubOSM = array("No"=>$row["No"],
				"OSName"=>$row["OSName"]
				
		);
		
		array_push($osmList,$tempSubOSM);
		
		/*
		
		
				| No     | varchar(10) | NO   | PRI | NULL    |       |
				| OSName | varchar(50) | YES  |     | NULL    |      
		
		
		
		*/
	}
} else {
	echo "0 results";
}


echo json_encode($osmList);


$conn->close();
?>