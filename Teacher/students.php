<?php
session_start();
if (
  isset($_SESSION['teacher_id']) &&
  isset($_SESSION['role'])
) {

  if ($_SESSION['role'] == 'Teacher') {
    include "../DB_connection.php";
    include "data/class.php";
    include "data/grade.php";
    include "data/section.php";
    include "data/teacher.php";

    $teacher_id = $_SESSION['teacher_id'];
    $teacher = getTeacherById($teacher_id, $conn);
    $classes = getAllClasses($conn);
?>
    <!DOCTYPE html>
    <html lang="fa" dir="rtl">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Teachers - Students</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css">
      <link rel="stylesheet" href="../css/style.css">
      <link rel="icon" href="../logo.png">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link rel="stylesheet" href="../css/teacher-student.css">
    </head>

    <body id="teacher-student">
      <?php
      include "inc/navbar.php";
      if ($classes != 0) {
      ?>
        <div class="container mt-5 ">

          <div class="table-responsive">
            <table class="table table-bordered mt-3 n-table bg-dark text-white">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">کلاس</th>
                </tr>
              </thead>
              <tbody>
                <?php $i = 0;
                foreach ($classes as $class) {
                ?>


                  <?php
                  $classesx = str_split(trim($teacher['class']));
                  $grade  = getGradeById($class['grade'], $conn);
                  $section = getSectioById($class['section'], $conn);
                  $c = $grade['grade_code'] . '-' . $grade['grade'] . $section['section'];
                  foreach ($classesx as $class_id) {
                    if ($class_id == $class['class_id']) {
                      $i++; ?>
                      <tr>
                        <th scope="row"><?= $i ?></th>
                        <td> <a href="students_of_class.php?class_id=<?= $class['class_id'] ?>">
                            <?php echo $c; ?>
                          </a>
                        </td>
                      </tr>

                  <?php
                    }
                  }


                  ?>

                <?php } ?>
              </tbody>
            </table>
          </div>
        <?php } else { ?>
          <div class="alert alert-info .w-450 m-5" role="alert">
            موردی یافت نشد!
          </div>
        <?php } ?>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
          $(document).ready(function() {
            $("#navLinks li:nth-child(3) a").addClass('active');
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