<?php
session_start();
if (
  isset($_SESSION['admin_id']) &&
  isset($_SESSION['role'])
) {

  if ($_SESSION['role'] == 'Admin') {
    include "../DB_connection.php";
    include "data/section.php";
    $sections = getAllSections($conn);
?>
    <!DOCTYPE html>
    <html lang="fa" dir="rtl">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Admin - Section</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css">
      <link rel="stylesheet" href="../css/style.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link rel="stylesheet" href="../css/teacher.css">
    </head>

    <body id="section-part">
      <?php
      include "inc/navbar.php";
      if ($sections != 0) {
      ?>
        <div class="container mt-5">
          <a href="section-add.php" class="btn btn-dark">افزودن بخش جدید</a>

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
              <thead>
                <tr>
                  <th class=" text-white" scope="col">#</th>
                  <th class=" text-white" scope="col">بخش</th>
                </tr>
              </thead>
              <tbody>
                <?php $i = 0;
                foreach ($sections as $section) {
                  $i++;  ?>
                  <tr>
                    <th class=" text-white" scope="row"><?= $i ?></th>
                    <td class=" text-white">
                      <?php
                      echo $section['section'];
                      ?>
                    </td>
                    <td class=" text-white">
                      <a href="section-edit.php?section_id=<?= $section['section_id'] ?>" class="btn btn-warning">تغییر</a>

                      <a href="section-delete.php?section_id=<?= $section['section_id'] ?>" class="btn btn-danger">حذف</a>
                    </td>
                  </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        <?php } else { ?>
          <div class="alert alert-info .w-450 m-5" role="alert">
            خالی!
          </div>
        <?php } ?>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
          $(document).ready(function() {
            $("#navLinks li:nth-child(5) a").addClass('active');
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