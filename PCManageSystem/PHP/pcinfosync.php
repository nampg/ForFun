<?php
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

$sql = "SELECT * FROM pcinfomation";
$result = $conn->query($sql);








$pcinfoList = array();


if ($result->num_rows > 0) {
	// output data of each row
	while($row = $result->fetch_assoc()) {
		$tempSubPcInfo = array("No"=>$row["No"],
				"PCNo"=>$row["PCNo"],
				"Location"=>$row["Location"],
				"Model"=>$row["Model"],
				"OS"=>$row["OS"],
				"OfficeCheck"=>$row["OfficeCheck"],
				"SecurityCheck"=>$row["SecurityCheck"],
				"DamagedCheck"=>$row["DamagedCheck"],
				"DelFlg"=>$row["DelFlg"],
				"InsertDate"=>$row["InsertDate"],
				"UpdateDate"=>$row["UpdateDate"]
		);
		
		array_push($pcinfoList,$tempSubPcInfo);
		
		/*
		 
		
		echo "No: " . $row["No"]. 
			" - PCNo: " . $row["PCNo"]. 
		"Location " . $row["Location"].
		"Model".$row["Model"]. 
		"OS".$row["OS"].
		"OfficeCheck".$row["OfficeCheck"].
		"SecurityCheck".$row["SecurityCheck"].
		"DamagedCheck".$row["DamagedCheck"].
		"DelFlg".$row["DelFlg"].
		"InsertDate".$row["InsertDate"].
		"UpdateDate".$row["UpdateDate"]."<br>";
		
		
		 */
	}
} else {
	echo "0 results";
}


echo json_encode($pcinfoList);


$conn->close();
?>