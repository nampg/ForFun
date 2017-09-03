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

$sql = "SELECT * FROM locationm";
$result = $conn->query($sql);








$locationmList = array();


if ($result->num_rows > 0) {
	// output data of each row
	while($row = $result->fetch_assoc()) {
		$tempSubLocationm = array("No"=>$row["No"],
				"Location"=>$row["Location"]
				
		);
		
		array_push($locationmList,$tempSubLocationm);
		
		
	}
} else {
	echo "0 results";
}


echo json_encode($locationmList);


$conn->close();
?>