<?php
	header("content-type:text/javascript;charset=utf-8");
    error_reporting(0);
    error_reporting(E_ERROR | E_PARSE);
    $link = mysqli_connect('localhost', 'root', '123456', "projectk6data");