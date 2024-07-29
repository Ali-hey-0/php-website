<?php 
session_start();
if (isset($_SESSION['admin_id']) && 
    isset($_SESSION['role'])) {

    if ($_SESSION['role'] == 'Admin') {
    	

if (isset($_POST['section'])) {
    
    include '../../DB_connection.php';

    $section = $_POST['section'];
    
  if (empty($section)) {
		$em  = "Section is required";
		header("Location: ../section-add.php?error=$em");
		exit;
	}else {
        $sql  = "INSERT INTO
                 section (section)
                 VALUES(?)";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$section]);
        $sm = "بخش جدید با موفقیت ایجاد گردید !";
        header("Location: ../section-add.php?success=$sm");
        exit;
	}
    
  }else {
  	$em = " مشکلی پیش آمده است";
    header("Location: ../section-add.php?error=$em");
    exit;
  }

  }else {
    header("Location: ../../logout.php");
    exit;
  } 
}else {
	header("Location: ../../logout.php");
	exit;
} 
