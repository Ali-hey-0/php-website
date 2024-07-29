<?php 
session_start();
if (isset($_SESSION['admin_id']) && 
    isset($_SESSION['role'])) {

    if ($_SESSION['role'] == 'Admin') {
    	

if (isset($_POST['fname'])      &&
    isset($_POST['lname'])      &&
    isset($_POST['username'])   &&
    isset($_POST['r_user_id']) &&
    isset($_POST['address'])  &&
    isset($_POST['employee_number']) &&
    isset($_POST['phone_number'])  &&
    isset($_POST['qualification']) &&
    isset($_POST['email_address']) &&
    isset($_POST['gender'])        &&
    isset($_POST['date_of_birth'])) {
    
    include '../../DB_connection.php';
    include "../data/registrar_office.php";

    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $uname = $_POST['username'];

    $address = $_POST['address'];
    $employee_number = $_POST['employee_number'];
    $phone_number = $_POST['phone_number'];
    $qualification = $_POST['qualification'];
    $email_address = $_POST['email_address'];
    $gender = $_POST['gender'];
    $date_of_birth = $_POST['date_of_birth'];

    $r_user_id = $_POST['r_user_id'];
    

    $data = 'r_user_id='.$r_user_id;

    if (empty($fname)) {
		$em  = "نام خود را وارد کنید";
		header("Location: ../registrar-office-edit.php?error=$em&$data");
		exit;
	}else if (empty($lname)) {
		$em  = " نام خانوادگی خود را وارد کنید";
		header("Location: ../registrar-office-edit.php?error=$em&$data");
		exit;
	}else if (empty($uname)) {
		$em  = "نام کاربری خود را وارد کنید";
		header("Location: ../registrar-office-edit.php?error=$em&$data");
		exit;
	}else if (!unameIsUnique($uname, $conn, $r_user_id)) {
		$em  =  "نام کاربری تکراری میباشد ! نام دیگری را امتحان کنید";
		header("Location: ../registrar-office-edit.php?error=$em&$data");
		exit;
	}else if (empty($address)) {
        $em  = "آدرس خود را وارد کنید";
        header("Location: ../registrar-office-edit.php?error=$em&$data");
        exit;
    }else if (empty($employee_number)) {
        $em  = "شماره کارمندی را وارد کنید";
        header("Location: ../registrar-office-edit.php?error=$em&$data");
        exit;
    }else if (empty($phone_number)) {
        $em  = " شماره تماس  خود را وارد کنید";
        header("Location: ../registrar-office-edit.php?error=$em&$data");
        exit;
    }else if (empty($qualification)) {
        $em  = "Qualification is required";
        header("Location: ../registrar-office-edit.php?error=$em&$data");
        exit;
    }else if (empty($email_address)) {
        $em  = " آدرس ایمیل   خود را وارد کنید";
        header("Location: ../registrar-office-edit.php?error=$em&$data");
        exit;
    }else if (empty($gender)) {
        $em  = "جنیست خود را مشخص کنید ";
        header("Location: ../registrar-office-edit.php?error=$em&$data");
        exit;
    }else if (empty($date_of_birth)) {
        $em  = " تاریخ تولد خود را وارد کنید";
        header("Location: ../registrar-office-edit.php?error=$em&$data");
        exit;
    }else {
        $sql = "UPDATE registrar_office SET
                username = ?, fname=?, lname=?,
                address = ?, employee_number=?, date_of_birth = ?, phone_number = ?, qualification = ?,gender=?, email_address = ?
                WHERE r_user_id=?";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$uname, $fname, $lname, $address, $employee_number, $date_of_birth, $phone_number, $qualification, $gender, $email_address, $r_user_id]);
        $sm = "با موفقیت بروزرسانی گردید!";
        header("Location: ../registrar-office-edit.php?success=$sm&$data");
        exit;
	}
    
  }else {
  	$em = " مشکلی پیش آمده است";
    header("Location: ../registrar-office.php?error=$em");
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
