<?php
session_start();
if (
  isset($_SESSION['admin_id']) &&
  isset($_SESSION['role'])     &&
  isset($_GET['student_id'])
) {

  if ($_SESSION['role'] == 'Admin') {

    include "../DB_connection.php";
    include "data/subject.php";
    include "data/grade.php";
    include "data/student.php";
    include "data/section.php";
    $subjects = getAllSubjects($conn);
    $grades = getAllGrades($conn);
    $sections = getAllsections($conn);

    $student_id = $_GET['student_id'];
    $student = getStudentById($student_id, $conn);

    if ($student == 0) {
      header("Location: student.php");
      exit;
    }


?>
    <!DOCTYPE html>
    <html lang="fa" dir="rtl">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Admin - Edit Student</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css">
      <link rel="stylesheet" href="../css/style.css">
      <link rel="icon" href="../logo.png">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <body>
      <?php
      include "inc/navbar.php";
      ?>
      <div class="container mt-5">
        <a href="student.php" class="btn btn-dark">بازکشت</a>

        <form method="post" class="shadow p-3 mt-5 form-w" action="req/student-edit.php">
          <h3>تغییر اطلاعات دانش آموز</h3>
          <hr>
          <?php if (isset($_GET['error'])) { ?>
            <div class="alert alert-danger" role="alert">
              <?= $_GET['error'] ?>
            </div>
          <?php } ?>
          <?php if (isset($_GET['success'])) { ?>
            <div class="alert alert-success" role="alert">
              <?= $_GET['success'] ?>
            </div>
          <?php } ?>
          <div class="mb-3">
            <label class="form-label">نام</label>
            <input type="text" class="form-control" value="<?= $student['fname'] ?>" name="fname">
          </div>
          <div class="mb-3">
            <label class="form-label">نام خانوادگی</label>
            <input type="text" class="form-control" value="<?= $student['lname'] ?>" name="lname">
          </div>
          <div class="mb-3">
            <label class="form-label">آدرس</label>
            <input type="text" class="form-control" value="<?= $student['address'] ?>" name="address">
          </div>
          <div class="mb-3">
            <label class="form-label">آدرس ایمیل</label>
            <input type="text" class="form-control" value="<?= $student['email_address'] ?>" name="email_address">
          </div>
          <div class="mb-3">
            <label class="form-label">تاریخ تولد</label>
            <input type="date" class="form-control" value="<?= $student['date_of_birth'] ?>" name="date_of_birth">
          </div>
          <div class="mb-3">
            <label class="form-label">جنسیت</label><br>
            <input type="radio" value="Male" <?php if ($student['gender'] == 'Male') echo 'checked';  ?> name="gender"> مرد
            &nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" value="Female" <?php if ($student['gender'] == 'Female') echo 'checked';  ?> name="gender"> زن
          </div>

          <div class="mb-3">
            <label class="form-label">نام کاربری</label>
            <input type="text" class="form-control" value="<?= $student['username'] ?>" name="username">
          </div>
          <input type="text" value="<?= $student['student_id'] ?>" name="student_id" hidden>

          <div class="mb-3">
            <label class="form-label">مقطع تحصیلی</label>
            <div class="row row-cols-5">
              <?php
              $grade_ids = str_split(trim($student['grade']));
              foreach ($grades as $grade) {
                $checked = 0;
                foreach ($grade_ids as $grade_id) {
                  if ($grade_id == $grade['grade_id']) {
                    $checked = 1;
                  }
                }
              ?>
                <div class="col">
                  <input type="radio" name="grade" <?php if ($checked) echo "checked"; ?> value="<?= $grade['grade_id'] ?>">
                  <?= $grade['grade_code'] ?>-<?= $grade['grade'] ?>
                </div>
              <?php } ?>

            </div>
          </div>

          <div class="mb-3">
            <label class="form-label">بخش</label>
            <div class="row row-cols-5">
              <?php
              $section_ids = str_split(trim($student['section']));
              foreach ($sections as $section) {
                $checked = 0;
                foreach ($section_ids as $section_id) {
                  if ($section_id == $section['section_id']) {
                    $checked = 1;
                  }
                }
              ?>
                <div class="col">
                  <input type="radio" name="section" <?php if ($checked) echo "checked"; ?> value="<?= $section['section_id'] ?>">
                  <?= $section['section'] ?>
                </div>
              <?php } ?>

            </div>
          </div>
          <br>
          <hr>

          <div class="mb-3">
            <label class="form-label">نام والدین </label>
            <input type="text" class="form-control" value="<?= $student['parent_fname'] ?>" name="parent_fname">
          </div>
          <div class="mb-3">
            <label class="form-label">نام خانوادگی والدین </label>
            <input type="text" class="form-control" value="<?= $student['parent_lname'] ?>" name="parent_lname">
          </div>
          <div class="mb-3">
            <label class="form-label">شماره تماس والدین </label>
            <input type="text" class="form-control" value="<?= $student['parent_phone_number'] ?>" name="parent_phone_number">
          </div>



          <button type="submit" class="btn btn-primary">
            آپدیت</button>
        </form>

        <form method="post" class="shadow p-3 my-5 form-w" action="req/student-change.php" id="change_password">
          <h3>تغییر پسوورد</h3>
          <hr>
          <?php if (isset($_GET['perror'])) { ?>
            <div class="alert alert-danger" role="alert">
              <?= $_GET['perror'] ?>
            </div>
          <?php } ?>
          <?php if (isset($_GET['psuccess'])) { ?>
            <div class="alert alert-success" role="alert">
              <?= $_GET['psuccess'] ?>
            </div>
          <?php } ?>

          <div class="mb-3">
            <div class="mb-3">
              <label class="form-label">پسوورد ادمین</label>
              <input type="password" class="form-control" name="admin_pass">
            </div>

            <label class="form-label">پسوورد جدید </label>
            <div class="input-group mb-3">
              <input type="text" class="form-control" name="new_pass" id="passInput">
              <button class="btn btn-secondary" id="gBtn">
                Random</button>
            </div>

          </div>
          <input type="text" value="<?= $student['student_id'] ?>" name="student_id" hidden>

          <div class="mb-3">
            <label class="form-label">تایید پسوورد </label>
            <input type="text" class="form-control" name="c_new_pass" id="passInput2">
          </div>
          <button type="submit" class="btn btn-primary">
            تغییر</button>
        </form>
      </div>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
      <script>
        $(document).ready(function() {
          $("#navLinks li:nth-child(3) a").addClass('active');
        });

        function makePass(length) {
          var result = '';
          var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
          var charactersLength = characters.length;
          for (var i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() *
              charactersLength));

          }
          var passInput = document.getElementById('passInput');
          var passInput2 = document.getElementById('passInput2');
          passInput.value = result;
          passInput2.value = result;
        }

        var gBtn = document.getElementById('gBtn');
        gBtn.addEventListener('click', function(e) {
          e.preventDefault();
          makePass(4);
        });
      </script>

    </body>

    </html>
<?php

  } else {
    header("Location: student.php");
    exit;
  }
} else {
  header("Location: student.php");
  exit;
}

?>