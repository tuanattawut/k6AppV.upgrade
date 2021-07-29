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
				
		$id_shop = $_GET['id_shop'];
		$id_category = $_GET['id_category'];
		$nameproduct = $_GET['nameproduct'];
		$price = $_GET['price'];
		$detail = $_GET['detail'];
		$image = $_GET['image'];	
	
				
		$sql = "INSERT INTO `product`(`id_product`, `id_shop`, `id_category`, `nameproduct`, `price`, `detail`, `image`) VALUES (Null,'$id_shop','$id_category','$nameproduct','$price','$detail','$image')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "###### Add Product API ####### ";
   
}
	mysqli_close($link);
?>