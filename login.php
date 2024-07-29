<!DOCTYPE html>
<html lang="fa" dir="rtl">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>ورود</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="css/style.css">
	<link rel="icon" href="./img/Schools Vector Design Images, School Icon, School Icons, School, Vector PNG Image For Free Download.jfif">
</head>

<body class="body-login ">
	<div class="black-fill"><br /> <br />
		<div class="d-flex justify-content-center align-items-center flex-column">
			<form class="login " method="post" action="req/login.php">

				<div class="text-center">
					<img src="./img/Schools Vector Design Images, School Icon, School Icons, School, Vector PNG Image For Free Download.jfif" width="100">
				</div>
				<h3>ورود</h3>
				<?php if (isset($_GET['error'])) { ?>
					<div class="alert alert-danger" role="alert">
						<?= $_GET['error'] ?>
					</div>
				<?php } ?>
				<div class="mb-3">
					<label class="form-label">نام کاربری </label>
					<input type="text" class="form-control" name="uname">
				</div>

				<div class="mb-3">
					<label class="form-label">رمز عبور </label>
					<input type="password" class="form-control" name="pass">
				</div>

				<div class="mb-3">
					<label class="form-label">ورود به عنوان : </label>
					<select class="form-control" name="role">
						<option value="1">Admin</option>
						<option value="3">دانش آموز</option>
						<option value="2">دبیر</option>
						<option value="4">دفتر ثبت </option>
					</select>
				</div>

				<div class="d-flex justify-content-between">
					<button type="submit" class="btn btn-primary">ورود</button>
					<a href="index.php" class="btn btn-dark">خانه</a>
				</div>
			</form>

			<br /><br />
			<div class="text-center text-light">
        	Copyright &copy; 2024 Shahed Shahid Khoshnam rights reserved.
        </div>

		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>