<?php
header('Content-Type: text/html; charset=utf-8');
function myReturnUpdateResult( $rst ){
	$returnValue = array("result"=>$rst);// Send back request in JSON format
	echo json_encode($returnValue);
}

if (isset($_REQUEST["No"])){

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
	
	
	
	$sql = "UPDATE pcinfomation SET ";
	
	if (isset($_REQUEST["Location"])){
		$sql.="Location = '".$_REQUEST["Location"]."', ";
	}
	
	if (isset($_REQUEST["OS"])){
		$sql.="OS = '".$_REQUEST["OS"]."', ";
	}
	
	if (isset($_REQUEST["DamagedCheck"])){
		$sql.="DamagedCheck = ".$_REQUEST["DamagedCheck"].", ";
	}
	
	if (isset($_REQUEST["OfficeCheck"])){
		$sql.="OfficeCheck = ".$_REQUEST["OfficeCheck"].", ";
	}
	
	if (isset($_REQUEST["SecurityCheck"])){
		$sql.="SecurityCheck = ".$_REQUEST["SecurityCheck"].", ";
	}
	
	
	
	
	$sql.="UpdateDate = sysdate() WHERE No = ".$_REQUEST["No"];
	
	if ($conn->query($sql) === TRUE) {
		myReturnUpdateResult(1);
	} else {
		myReturnUpdateResult(0);
	}
	
	$conn->close();
}else{
	myReturnUpdateResult(0);
}





