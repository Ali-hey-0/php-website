<?php
session_start();
if (
  isset($_SESSION['admin_id']) &&
  isset($_SESSION['role'])
) {

  if ($_SESSION['role'] == 'Admin') {
    include "../DB_connection.php";
    include "data/class.php";
    include "data/grade.php";
    include "data/section.php";
    $classes = getAllClasses($conn);
?>
    <!DOCTYPE html>
    <html lang="fa" dir="rtl">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Admin - Class</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css">
      <link rel="stylesheet" href="../css/style.css">
      <link rel="icon" href="../logo.png">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link rel="stylesheet" href="../css/class.css">
    </head>

    <body id="classes">
      <?php
      include "inc/navbar.php";
      if ($classes != 0) {
      ?>
        <div class="container mt-5">
          <a href="class-add.php" class="btn btn-dark">افزودن کلاس جدید </a>

          <?php if (isset($_GET['error'])) { ?>
            <div class="alert alert-danger mt-3 n-table" role="alert">
              <?= $_GET['error'] ?>
            </div>
          <?php } ?>

          <?php if (isset($_GET['success'])) { ?>
            <div class="alert alert-info mt-3 n-table" role="alert">
              <?= $_GET['success'] ?>
            </div>
          <?php } ?>

          <div class="table-responsive">
            <table class="table table-bordered mt-3 n-table">
              <thead class="bg-dark ">
                <tr class="bg-dark text-white">
                  <th class="bg-dark text-white" scope="col">#</th>
                  <th class="bg-dark text-white" scope="col">کلاس</th>
                  <th class="bg-dark text-white" scope="col">تغیررات</th>
                </tr>
              </thead>
              <tbody>
                <?php $i = 0;
                foreach ($classes as $class) {
                  $i++;  ?>
                  <tr class="bg-dark text-white">
                    <th class="bg-dark text-white" scope=" row"><?= $i ?></th>
                    <td class="bg-dark text-white">
                      <?php
                      $grade  = getGradeById($class['grade'], $conn);
                      $section = getSectioById($class['section'], $conn);
                      echo $grade['grade_code'] . '-' . $grade['grade'] . $section['section'];
                      ?>
                    </td>
                    <td class="bg-dark text-white d-flex justify-content-around ">
                      <a href=" class-edit.php?class_id=<?= $class['class_id'] ?>" class="btn btn-warning">تغییر </a>
                      <a href="class-delete.php?class_id=<?= $class['class_id'] ?>" class="btn btn-danger">جذف </a>
                    </td>
                  </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        <?php } else { ?>
          <div class="alert alert-info .w-450 m-5" role="alert">
            خالی !
          </div>
        <?php } ?>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
          $(document).ready(function() {
            $("#navLinks li:nth-child(6) a").addClass('active');
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