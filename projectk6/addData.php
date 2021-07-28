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
				
		$id_user = $_GET['id_user'];
		$id_product = $_GET['id_product'];
		$nameproduct = $_GET['nameproduct'];
	
	
				
		$sql = "INSERT INTO `dataclick`(`id_user`, `id_product`, `nameproduct`) VALUES ('$id_user','$id_product','$nameproduct')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "###### Add DATA API ####### ";
   
}
	mysqli_close($link);
?>