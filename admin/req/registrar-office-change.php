<?php 
session_start();
if (isset($_SESSION['admin_id']) && 
    isset($_SESSION['role'])) {

    if ($_SESSION['role'] == 'Admin') {
    	

if (isset($_POST['admin_pass']) &&
    isset($_POST['new_pass'])   &&
    isset($_POST['c_new_pass']) &&
    isset($_POST['r_user_id'])) {
    
    include '../../DB_connection.php';
    include "../data/registrar_office.php";
    include "../data/admin.php";

    $admin_pass = $_POST['admin_pass'];
    $new_pass = $_POST['new_pass'];
    $c_new_pass = $_POST['c_new_pass'];

    $r_user_id = $_POST['r_user_id'];
    $id = $_SESSION['admin_id'];
    
    $data = 'r_user_id='.$r_user_id.'#change_password';

    if (empty($admin_pass)) {
		$em  = " پسورد ادمین را وارد کنید";
		header("Location: ../registrar-office-edit.php?perror=$em&$data");
		exit;
	}else if (empty($new_pass)) {
		$em  = " پسورد جدید را وارد کنید";
		header("Location: ../registrar-office-edit.php?perror=$em&$data");
		exit;
	}else if (empty($c_new_pass)) {
		$em  = "تایید پسورد ";
		header("Location: ../registrar-office-edit.php?perror=$em&$data");
		exit;
	}else if ($new_pass !== $c_new_pass) {
        $em  = "پسورد جدید و قدیمی مطابقت ندارند ";
        header("Location: ../registrar-office-edit.php?perror=$em&$data");
        exit;
    }else if (!adminPasswordVerify($admin_pass, $conn, $id)) {
        $em  = "پسورد ادمین اشتباه میباشد ";
        header("Location: ../registrar-office-edit.php?perror=$em&$data");
        exit;
    }else {
        // hashing the password
        $new_pass = password_hash($new_pass, PASSWORD_DEFAULT);

        $sql = "UPDATE registrar_office SET
                password = ?
                WHERE r_user_id=?";

        $stmt = $conn->prepare($sql);
        $stmt->execute([$new_pass, $r_user_id]);
        $sm = "پسورد با موفقیت بروزرسانی گردید!!";
        header("Location: ../registrar-office-edit.php?psuccess=$sm&$data");
        exit;
	}
    
  }else {
  	$em = "         مشکلی پیش آمده است ! ";
    header("Location: ../registrar-office.php?error=$em&$data");
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
