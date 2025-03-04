<?php 
session_start();
if (isset($_SESSION['admin_id']) && 
    isset($_SESSION['role'])) {

    if ($_SESSION['role'] == 'Admin') {
    	

if (isset($_POST['school_name']) &&
    isset($_POST['slogan']) &&
    isset($_POST['about']) &&
    isset($_POST['current_year']) &&
    isset($_POST['current_semester'])) {
    
    include '../../DB_connection.php';

    $school_name = $_POST['school_name'];
    $slogan = $_POST['slogan'];
    $about = $_POST['about'];
    $current_year = $_POST['current_year'];
    $current_semester = $_POST['current_semester'];

   

    if (empty($school_name)) {
        $em  = "نام مدرسه را وارد کنید ";
        header("Location: ../settings.php?error=$em");
        exit;
    }else if (empty($slogan)) {
        $em  = "شعار را وارد کنید ";
        header("Location: ../settings.php?error=$em");
        exit;
    }else if (empty($about)) {
        $em  = "About name is required";
        header("Location: ../settings.php?error=$em");
        exit;
    }else if (empty($current_year)) {
        $em  = "سال جاری را وارد بفرمایید";
        header("Location: ../settings.php?error=$em");
        exit;
    }else if (empty($current_semester)) {
        $em  = "نام نیم سال جاری را مشخص کنید ";
        header("Location: ../settings.php?error=$em");
        exit;
    }else {
        $id = 1;
        $sql  = "UPDATE setting 
                 SET current_year=?,
                     current_semester=?,
                     school_name=?,
                     slogan=?,
                     about=?
                 WHERE id=?";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$current_year, $current_semester, $school_name, $slogan, $about, $id]);
        $sm = "تنظیمات با موفقیت بروزرسانی گردید";
        header("Location: ../settings.php?success=$sm&$data");
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
