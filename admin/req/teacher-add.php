<?php 
session_start();
if (isset($_SESSION['admin_id']) && 
    isset($_SESSION['role'])) {

    if ($_SESSION['role'] == 'Admin') {
    	

if (isset($_POST['fname']) &&
    isset($_POST['lname']) &&
    isset($_POST['username']) &&
    isset($_POST['pass'])     &&
    isset($_POST['address'])  &&
    isset($_POST['employee_number']) &&
    isset($_POST['phone_number'])  &&
    isset($_POST['qualification']) &&
    isset($_POST['email_address']) &&
    isset($_POST['classes'])        &&
    isset($_POST['date_of_birth']) &&
    isset($_POST['subjects'])) {
    
    include '../../DB_connection.php';
    include "../data/teacher.php";

    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $uname = $_POST['username'];
    $pass = $_POST['pass'];

    $address = $_POST['address'];
    $employee_number = $_POST['employee_number'];
    $phone_number = $_POST['phone_number'];
    $qualification = $_POST['qualification'];
    $email_address = $_POST['email_address'];
    $gender = $_POST['gender'];
    $date_of_birth = $_POST['date_of_birth'];

    $classes = "";
    foreach ($_POST['classes'] as $class) {
    	$classes .=$class;
    }

    $subjects = "";
    foreach ($_POST['subjects'] as $subject) {
    	$subjects .=$subject;
    }

    $data = 'uname='.$uname.'&fname='.$fname.'&lname='.$lname.'&address='.$address.'&en='.$employee_number.'&pn='.$phone_number.'&qf='.$qualification.'&email='.$email_address;

    if (empty($fname)) {
		$em  = "نام خود را وارد کنید";
		header("Location: ../teacher-add.php?error=$em&$data");
		exit;
	}else if (empty($lname)) {
		$em  = " نام خانوادگی خود را وارد کنید";
		header("Location: ../teacher-add.php?error=$em&$data");
		exit;
	}else if (empty($uname)) {
		$em  = "نام کاربری خود را وارد کنید";
		header("Location: ../teacher-add.php?error=$em&$data");
		exit;
	}else if (!unameIsUnique($uname, $conn)) {
		$em  = " نام کاربری تکراری میباشد ! نام دیگری را امتحان کنید";
		header("Location: ../teacher-add.php?error=$em&$data");
		exit;
	}else if (empty($pass)) {
		$em  = " پسورد خود را وارد کنید";
		header("Location: ../teacher-add.php?error=$em&$data");
		exit;
	}else if (empty($address)) {
        $em  = " آدرس خود را وارد کنید";
        header("Location: ../teacher-add.php?error=$em&$data");
        exit;
    }else if (empty($employee_number)) {
        $em  = " شماره کارمندی را وارد کنید ";
        header("Location: ../teacher-add.php?error=$em&$data");
        exit;
    }else if (empty($phone_number)) {
        $em  = " شماره تماس خود را وارد کنید ";
        header("Location: ../teacher-add.php?error=$em&$data");
        exit;
    }else if (empty($qualification)) {
        $em  = "Qualification is required";
        header("Location: ../teacher-add.php?error=$em&$data");
        exit;
    }else if (empty($email_address)) {
        $em  = " آدرس ایمیل   خود را وارد کنید";
        header("Location: ../teacher-add.php?error=$em&$data");
        exit;
    }else if (empty($gender)) {
        $em  = " جنسیت خود را تایین کنی";
        header("Location: ../teacher-add.php?error=$em&$data");
        exit;
    }else if (empty($date_of_birth)) {
        $em  = " تاریخ تولد خود را وارد کنید";
        header("Location: ../teacher-add.php?error=$em&$data");
        exit;
    }else if (empty($pass)) {
        $em  = " پسورد خود را وارد کنید";
        header("Location: ../teacher-add.php?error=$em&$data");
        exit;
    }else {
        // hashing the password
        $pass = password_hash($pass, PASSWORD_DEFAULT);

        $sql  = "INSERT INTO
                 teachers(username, password, class, fname, lname, subjects, address, employee_number, date_of_birth, phone_number, qualification, gender, email_address)
                 VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$uname, $pass, $classes, $fname, $lname, $subjects, $address, $employee_number, $date_of_birth, $phone_number, $qualification, $gender, $email_address]);
        $sm = "  دبیر جدید با موفقیت ایجاد گردید";
        header("Location: ../teacher-add.php?success=$sm");
        exit;
	}
    
  }else {
  	$em = " مشکلی پیش آمده است";
    header("Location: ../teacher-add.php?error=$em");
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
