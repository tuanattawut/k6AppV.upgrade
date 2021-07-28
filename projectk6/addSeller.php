<?php

include 'connected.php';
	header("Access-Control-Allow-Origin: *");


if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$name = $_GET['name'];
		$lastname = $_GET['lastname'];
		$idcard = $_GET['idcard'];
		$phone = $_GET['phone'];
		$birthday = $_GET['birthday'];	
		$email = $_GET['email'];
		$password = $_GET['password'];
		$gender = $_GET['gender'];
		$image = $_GET['image'];
		$idfb = $_GET['idfb'];
				
		$sql = "INSERT INTO `seller`(`id_seller`, `name`, `lastname`, `idcard`, `gender`, `phone`, `birthday`, `email`, `password`, `image`, `idfb`) VALUES (Null,'$name','$lastname','$idcard','$gender','$phone','$birthday','$email','$password','$image','$idfb')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "###### Add Seller API ####### ";
   
}
	mysqli_close($link);
?>