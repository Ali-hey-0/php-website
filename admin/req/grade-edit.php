<?php 
session_start();
if (isset($_SESSION['admin_id']) && 
    isset($_SESSION['role'])) {

    if ($_SESSION['role'] == 'Admin') {
    	

if (isset($_POST['grade_code']) &&
    isset($_POST['grade']) &&
    isset($_POST['grade_id'])) {
    
    include '../../DB_connection.php';

    $grade_code = $_POST['grade_code'];
    $grade = $_POST['grade'];
    $grade_id = $_POST['grade_id'];
   
    $data = 'grade_code='.$grade_code.'&grade='.$grade.'&grade_id='.$grade_id;

    if (empty($grade_code)) {
        $em  = "ورود کد مقطع تحصیلی الزامی میباشد";
        header("Location: ../grade-edit.php?error=$em&$data");
        exit;
    }else if (empty($grade)) {
        $em  = "مقطع تحصیلی را وارد کنید ";
        header("Location: ../grade-edit.php?error=$em&$data");
        exit;
    }else {

        $sql  = "UPDATE grades SET grade=?, grade_code=?
                 WHERE grade_id=?";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$grade, $grade_code, $grade_id]);
        $sm = "مقطع تحصیلی با موفقیت آپدیت شده است ";
        header("Location: ../grade-edit.php?success=$sm&$data");
        exit;
	}
    
  }else {
  	$em = " مشکلی پیش آمده است!";
    header("Location: ../grade.php?error=$em");
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
