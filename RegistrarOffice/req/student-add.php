<?php 
session_start();
if (isset($_SESSION['r_user_id']) && 
    isset($_SESSION['role'])) {

    if ($_SESSION['role'] == 'Registrar Office') {
    	

if (isset($_POST['fname']) &&
    isset($_POST['lname']) &&
    isset($_POST['username']) &&
    isset($_POST['pass'])     &&
    isset($_POST['address'])  &&
    isset($_POST['gender'])   &&
    isset($_POST['email_address']) &&
    isset($_POST['date_of_birth']) &&
    isset($_POST['parent_fname'])  &&
    isset($_POST['parent_lname'])  &&
    isset($_POST['parent_phone_number']) &&
    isset($_POST['section']) &&
    isset($_POST['grade'])) {
    
    include '../../DB_connection.php';
    include "../data/student.php";

    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $uname = $_POST['username'];
    $pass = $_POST['pass'];

    $address = $_POST['address'];
    $gender = $_POST['gender'];
    $email_address = $_POST['email_address'];
    $date_of_birth = $_POST['date_of_birth'];
    $parent_fname = $_POST['parent_fname'];
    $parent_lname = $_POST['parent_lname'];
    $parent_phone_number = $_POST['parent_phone_number'];

    $grade = $_POST['grade'];
    $section = $_POST['section'];
    

    $data = 'uname='.$uname.'&fname='.$fname.'&lname='.$lname.'&address='.$address.'&gender='.$email_address.'&pfn='.$parent_fname.'&pln='.$parent_lname.'&ppn='.$parent_phone_number;

    if (empty($fname)) {
		$em  = "نام خود را وارد کنید ";
		header("Location: ../student-add.php?error=$em&$data");
		exit;
	}else if (empty($lname)) {
		$em  = " نام خانوادگی خود را وارد کنید";
		header("Location: ../student-add.php?error=$em&$data");
		exit;
	}else if (empty($uname)) {
		$em  = " نام کاربری خود را وارد کنید";
		header("Location: ../student-add.php?error=$em&$data");
		exit;
	}else if (!unameIsUnique($uname, $conn)) {
		$em  = " نام کاربری تکراری میباشد ! نام دیگری را امتحان کنید ";
		header("Location: ../student-add.php?error=$em&$data");
		exit;
	}else if (empty($pass)) {
		$em  = " پسورد خود را وارد کنید";
		header("Location: ../student-add.php?error=$em&$data");
		exit;
	}else if (empty($address)) {
        $em  = " آدرس  خود را وارد کنید";
        header("Location: ../student-add.php?error=$em&$data");
        exit;
    }else if (empty($gender)) {
        $em  = "جنیست خود را مشخص کنید ";
        header("Location: ../student-add.php?error=$em&$data");
        exit;
    }else if (empty($email_address)) {
        $em  = " آدرس ایمیل   خود را وارد کنید";
        header("Location: ../student-add.php?error=$em&$data");
        exit;
    }else if (empty($date_of_birth)) {
        $em  = " تاریخ تولد  خود را وارد کنید";
        header("Location: ../student-add.php?error=$em&$data");
        exit;
    }else if (empty($parent_fname)) {
        $em  = " نام والدین  خود را وارد کنید";
        header("Location: ../student-add.php?error=$em&$data");
        exit;
    }else if (empty($parent_lname)) {
        $em  = " نام خانوادگی والدین  خود را وارد کنید";
        header("Location: ../student-add.php?error=$em&$data");
        exit;
    }else if (empty($parent_phone_number)) {
        $em  = " شماره تماس  والدین  خود را وارد کنید";
        header("Location: ../student-add.php?error=$em&$data");
        exit;
    }else if (empty($section)) {
        $em  = "بخش را وارد بفرمایید ";
        header("Location: ../student-add.php?error=$em&$data");
        exit;
    }else {
        // hashing the password
        $pass = password_hash($pass, PASSWORD_DEFAULT);
        $sql  = "INSERT INTO
                 students(username, password, fname, lname, grade, section, address, gender, email_address, date_of_birth, parent_fname, parent_lname, parent_phone_number)
                 VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$uname, $pass, $fname, $lname, $grade, $section, $address, $gender, $email_address, $date_of_birth, $parent_fname, $parent_lname, $parent_phone_number]);
        $sm = " دانش آموز جدید با موفقیت ایجاد گردید! ";
        header("Location: ../student-add.php?success=$sm");
        exit;
	}
    
  }else {
  	$em = "مشکلی پیش آمده است";
    header("Location: ../student-add.php?error=$em");
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
