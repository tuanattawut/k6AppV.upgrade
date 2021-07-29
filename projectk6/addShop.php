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
				
		$id_seller = $_GET['id_seller'];
		$id_area = $_GET['id_area'];
		$nameshop = $_GET['nameshop'];
		$image = $_GET['image'];
		$lat = $_GET['lat'];
		$long = $_GET['long'];	
	
				
		$sql = "INSERT INTO `shop`(`id_shop`, `id_seller`, `id_area`, `nameshop`, `image`, `lat`, `long`) VALUES (Null,'$id_seller','$id_area','$nameshop','$image','$lat','$long')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "###### Add Shop API ####### ";
   
}
	mysqli_close($link);
?>