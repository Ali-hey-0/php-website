<?php 
session_start();
if (isset($_SESSION['admin_id']) && 
    isset($_SESSION['role'])) {

    if ($_SESSION['role'] == 'Admin') {
    	

if (isset($_POST['section']) &&
    isset($_POST['section_id'])) {
    
    include '../../DB_connection.php';

    $section = $_POST['section'];
    $section_id = $_POST['section_id'];

   
    $data = 'section_id='.$section_id;

    if (empty($section)) {
        $em  = "بخش خود را وارد کنید ";
        header("Location: ../section-edit.php?error=$em&$data");
        exit;
    }else {

        $sql  = "UPDATE section SET section=?
                 WHERE section_id=?";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$section, $section_id]);
        $sm = "بخش با موفقیت بروزرسانی گردید";
        header("Location: ../section-edit.php?success=$sm&$data");
        exit;
	}
    
  }else {
  	$em = " مشکلی پیش آمده است";
    header("Location: ../section.php?error=$em");
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
