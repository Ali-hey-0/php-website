<?php  

if (isset($_POST['email']) &&
    isset($_POST['full_name']) &&
    isset($_POST['message'])) {

    include "../DB_connection.php";
	
	$email     = $_POST['email'];
	$full_name = $_POST['full_name'];
	$message   = $_POST['message'];

	if (empty($email)) {
		$em  = "ایمیل خود را وارد کنید ";
		header("Location: ../index.php?error=$em#contact");
		exit;
	}else if (empty($full_name)) {
		$em  = "نام و نام خانوادگی خود را وارد کنید ";
		header("Location: ../index.php?error=$em#contact");
		exit;
	}else if (empty($message)) {
		$em  = "پیام خود را وارد کنید ";
		header("Location: ../index.php?error=$em#contact");
		exit;
	}else {
       $sql  = "INSERT INTO
                 message (sender_full_name, sender_email, message)
                 VALUES(?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$full_name, $email, $message]);
        $sm = "پیام با موفقیت ارسال شد !";
        header("Location: ../index.php?success=$sm#contact");
        exit;
	}

}else{
	header("Location: ../login.php");
	exit;
}