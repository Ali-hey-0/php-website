<?php
session_start();
if (
  isset($_SESSION['teacher_id']) &&
  isset($_SESSION['role'])
) {

  if ($_SESSION['role'] == 'Teacher') {
    include "../DB_connection.php";
    include "data/teacher.php";
    include "data/subject.php";
    include "data/grade.php";
    include "data/section.php";
    include "data/class.php";


    $teacher_id = $_SESSION['teacher_id'];
    $teacher = getTeacherById($teacher_id, $conn);
?>
    <!DOCTYPE html>
    <html lang="fa" dir="rtl">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Teacher - Home</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css">
      <link rel="stylesheet" href="../css/style.css">
      <link rel="icon" href="../logo.png">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <body>
      <?php
      include "inc/navbar.php";

      if ($teacher != 0) {
      ?>
        <div class="container mt-5">
          <div class="card" style="width: 22rem;">
            <img src="../img/teacher-<?= $teacher['gender'] ?>.png" class="card-img-top" alt="...">
            <div class="card-body">
              <h5 class="card-title text-center">@<?= $teacher['username'] ?></h5>
            </div>
            <ul class="list-group list-group-flush">
              <li class="list-group-item">نام : <?= $teacher['fname'] ?></li>
              <li class="list-group-item"> نام خانوادگی : <?= $teacher['lname'] ?></li>
              <li class="list-group-item">نام کاربری : <?= $teacher['username'] ?></li>

              <li class="list-group-item">شماره کارمندی : <?= $teacher['employee_number'] ?></li>
              <li class="list-group-item">آدرس : <?= $teacher['address'] ?></li>
              <li class="list-group-item">تاریخ تولد: <?= $teacher['date_of_birth'] ?></li>
              <li class="list-group-item">شماره موبایل: <?= $teacher['phone_number'] ?></li>
              <li class="list-group-item">صلاحیت: <?= $teacher['qualification'] ?></li>
              <li class="list-group-item">آدرس ایمیل : <?= $teacher['email_address'] ?></li>
              <li class="list-group-item">جنسیت : <?= $teacher['gender'] ?></li>
              <li class="list-group-item">تاریخ پیوستن : <?= $teacher['date_of_joined'] ?></li>

              <li class="list-group-item">عنوان :
                <?php
                $s = '';
                $subjects = str_split(trim($teacher['subjects']));
                foreach ($subjects as $subject) {
                  $s_temp = getSubjectById($subject, $conn);
                  if ($s_temp != 0)
                    $s .= $s_temp['subject_code'] . ', ';
                }
                echo $s;
                ?>
              </li>
              <li class="list-group-item">کلاس:
                <?php
                $c = '';
                $classes = str_split(trim($teacher['class']));

                foreach ($classes as $class_id) {
                  $class = getClassById($class_id, $conn);

                  $c_temp = getGradeById($class['grade'], $conn);
                  $section = getSectioById($class['section'], $conn);
                  if ($c_temp != 0)
                    $c .= $c_temp['grade_code'] . '-' .
                      $c_temp['grade'] . $section['section'] . ', ';
                }
                echo $c;

                ?>
              </li>

            </ul>
          </div>
        </div>
      <?php
      } else {
        header("Location: logout.php?error=An error occurred");
        exit;
      }
      ?>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
      <script>
        $(document).ready(function() {
          $("#navLinks li:nth-child(1) a").addClass('active');
        });
      </script>
    </body>

    </html>
<?php

  } else {
    header("Location: ../login.php");
    exit;
  }
} else {
  header("Location: ../login.php");
  exit;
}

?>