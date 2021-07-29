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
		$email = $_GET['email'];
		$password = $_GET['password'];
		$gender = $_GET['gender'];
		$phone = $_GET['phone'];	
		$image = $_GET['image'];
		$idfb = $_GET['idfb'];
				
		$sql = "INSERT INTO `user`(`id_user`, `name`, `lastname`, `email`, `password`, `gender`, `phone`, `image`, `idfb`) VALUES (Null,'$name','$lastname','$email','$password','$gender','$phone','$image','$idfb')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "###### Add User API ####### ";
   
}
	mysqli_close($link);
?>