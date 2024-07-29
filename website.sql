-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2024 at 04:31 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `website`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertRandomStudents` ()   BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 1000 DO
        INSERT INTO students (
            username, password, fname, lname, grade, section, address, gender, email_address, date_of_birth, date_of_joined, parent_fname, parent_lname, parent_phone_number
        )
        VALUES (
            CONCAT('user', LPAD(FLOOR(RAND() * 1000000), 6, '0')),
            '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', -- Example hashed password
            ELT(FLOOR(1 + (RAND() * 6)), 'John', 'Jane', 'Jim', 'Jill', 'Joe', 'Jenny'),
            ELT(FLOOR(1 + (RAND() * 6)), 'Doe', 'Smith', 'Johnson', 'Williams', 'Brown', 'Jones'),
            FLOOR(1 + (RAND() * 3)), -- Random grade 1, 2, or 3
            FLOOR(1 + (RAND() * 4)), -- Random section 1, 2, 3, or 4
            ELT(FLOOR(1 + (RAND() * 5)), 'New York', 'California', 'Texas', 'Florida', 'Illinois'),
            ELT(FLOOR(1 + (RAND() * 2)), 'Male', 'Female'),
            CONCAT('user', LPAD(FLOOR(RAND() * 1000000), 6, '0'), '@example.com'),
            DATE_ADD('2000-01-01', INTERVAL FLOOR(RAND() * 8000) DAY),
            NOW(),
            ELT(FLOOR(1 + (RAND() * 6)), 'John', 'Jane', 'Jim', 'Jill', 'Joe', 'Jenny'),
            ELT(FLOOR(1 + (RAND() * 6)), 'Doe', 'Smith', 'Johnson', 'Williams', 'Brown', 'Jones'),
            CONCAT('+1', LPAD(FLOOR(RAND() * 10000000), 7, '0'))
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertRandomTeachers` ()   BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE first_name VARCHAR(255);
    DECLARE last_name VARCHAR(255);
    DECLARE full_name VARCHAR(255);

    WHILE i < 30 DO
        -- Randomly select first and last names from the lists
        SET first_name = ELT(FLOOR(1 + (RAND() * 20)), 'John', 'Jane', 'Jim', 'Jill', 'Joe', 'Jenny', 'Bob', 'Charlie', 'Dave', 'amir', 'Frank','ali', 'Grace', 'Hank', 'Irene', 'Jack', 'Karen', 'Leo', 'Mona', 'Nick');
        SET last_name = ELT(FLOOR(1 + (RAND() * 20)), 'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Miller', 'Davis', 'Garcia', 'Rodriguez', 'Wilson', 'Martinez', 'Anderson', 'Taylor', 'Thomas', 'Hernandez', 'Moore', 'Martin', 'Jackson', 'Thompson', 'White');
        
        SET full_name = CONCAT(first_name, ' ', last_name);

        -- Insert into the teachers table
        INSERT INTO teachers (
            username, password, fname, lname, address, gender, email_address, date_of_birth, date_of_joined, phone_number
        )
        VALUES (
            full_name,
            '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', -- Example hashed password
            first_name,
            last_name,
            ELT(FLOOR(1 + (RAND() * 5)), 'New York', 'California', 'Texas', 'Florida', 'Illinois'),
            ELT(FLOOR(1 + (RAND() * 2)), 'Male', 'Female'),
            CONCAT(REPLACE(LOWER(full_name), ' ', '.'), '@example.com'),
            DATE_ADD('1970-01-01', INTERVAL FLOOR(RAND() * 20000) DAY),
            NOW(),
            CONCAT('+1', LPAD(FLOOR(RAND() * 10000000), 7, '0'))
        );

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(127) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fname` varchar(127) NOT NULL,
  `lname` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `password`, `fname`, `lname`) VALUES
(1, 'ali', '$2y$10$Ym.5K4IHc/G6/7VvSts.0up4qecgeWn5846q9OqngDcRWJlaa6VHS', 'ali', 'heydari');

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `class_id` int(11) NOT NULL,
  `grade` int(11) NOT NULL,
  `section` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`class_id`, `grade`, `section`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `grade_id` int(11) NOT NULL,
  `grade` varchar(31) NOT NULL,
  `grade_code` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`grade_id`, `grade`, `grade_code`) VALUES
(1, 'دهم', ''),
(2, 'یازدهم', ''),
(3, 'دوازدهم', '');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `message_id` int(11) NOT NULL,
  `sender_full_name` varchar(100) NOT NULL,
  `sender_email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `date_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`message_id`, `sender_full_name`, `sender_email`, `message`, `date_time`) VALUES
(1, 'ali heydari', 'es@gmail.com', 'Hello, world', '2023-02-17 23:39:15'),
(2, 'John doe', 'es@gmail.com', 'Hi', '2023-02-17 23:49:19'),
(3, 'John doe', 'es@gmail.com', 'hi,', '2023-02-17 23:49:36'),
(4, 'علی حیدری ', 'aliheydasri1381doc@gmail.com', 'با عرض سلام و خسته نباشید خدمت همکاران گرامی', '2024-07-29 04:19:31');

-- --------------------------------------------------------

--
-- Table structure for table `registrar_office`
--

CREATE TABLE `registrar_office` (
  `r_user_id` int(11) NOT NULL,
  `username` varchar(127) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fname` varchar(31) NOT NULL,
  `lname` varchar(31) NOT NULL,
  `address` varchar(31) NOT NULL,
  `employee_number` int(11) NOT NULL,
  `date_of_birth` date NOT NULL,
  `phone_number` varchar(31) NOT NULL,
  `qualification` varchar(31) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `date_of_joined` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registrar_office`
--

INSERT INTO `registrar_office` (`r_user_id`, `username`, `password`, `fname`, `lname`, `address`, `employee_number`, `date_of_birth`, `phone_number`, `qualification`, `gender`, `email_address`, `date_of_joined`) VALUES
(1, 'ali', '$2y$10$P4sUdWWlhveZXzYhDaMN4OMRosp4zIeo40F3PkhqHozRUfauUONzy', 'ali', 'heydari', 'zanjan', 843583, '2022-10-04', '+12328324092', 'diploma', 'Male', 'james@j.com', '2022-10-23 01:03:25'),
(2, 'oliver2', '$2y$10$7XhzOu.3OgHPFv7hKjvfUu3waU.8j6xTASj4yIWMfo...k/p8yvvS', 'Oliver2', 'Noah', 'California,  Los angeles', 6546, '1999-06-11', '09457396789', 'BSc, BA', 'Male', 'ov@ab.com', '2022-11-12 23:06:18'),
(4, 'CEO', '$2y$10$jpOIJJrsfYRtcPWr21Ct2O9Oe0BCvob6ldGUZbPM4.No2ZvKBQGrW', 'َabozar ', 'kalantary', 'zanjan-shahrak carmandan', 23, '2024-07-28', '09121414764', 'right', 'Male', 'kalantary@gmail.com', '2024-07-28 23:38:05');

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `section_id` int(11) NOT NULL,
  `section` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`section_id`, `section`) VALUES
(1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `current_year` int(11) NOT NULL,
  `current_semester` varchar(11) NOT NULL,
  `school_name` varchar(100) NOT NULL,
  `slogan` varchar(300) NOT NULL,
  `about` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `current_year`, `current_semester`, `school_name`, `slogan`, `about`) VALUES
(1, 2024, 'II', 'شاهد شهید خوشنام', 'به دنبال حقیقت باش،به دنبال عقلانیت و درک تخصصی.هرگز آموزش رو متوقف نکن.زندگی تو را صدا می زند.\n\n', 'مدارس شاهد از جمله مدارس نمونه ای هستند که در سراسر ایران وجود دارند. دانش آموزان پس از ثبت نام موقت ، باید برای ثبت نام قطعی به مدرسه مورد نظر خود به همراه مدارک لازم برای ثبت نام مراجعه کنند. به همین جهت برای سهولت بیش تر در ثبت نام ، لیستی از مدارس شاهد زنجان پسرانه و دخترانه را به همراه آدرس و شماره تلفن برای شما قرار دادیم. چنانچه شما متقاضی ثبت نام مدارس شاهد زنجان هستید می توانید از بین مدارس نام برده شده در جدول زیر ، نزدیک ترین مدرسه به محل سکونت خود را انتخاب کرده و جهت ثبت نام به همان مدرسه مراجعه کنید.');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `username` varchar(127) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fname` varchar(127) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `grade` int(11) NOT NULL,
  `section` int(11) NOT NULL,
  `address` varchar(31) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `date_of_joined` timestamp NULL DEFAULT current_timestamp(),
  `parent_fname` varchar(127) NOT NULL,
  `parent_lname` varchar(127) NOT NULL,
  `parent_phone_number` varchar(31) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `username`, `password`, `fname`, `lname`, `grade`, `section`, `address`, `gender`, `email_address`, `date_of_birth`, `date_of_joined`, `parent_fname`, `parent_lname`, `parent_phone_number`) VALUES
(6, 'ali', '$2y$10$mmckO3LQvFboyRlB3DrCruYFIotyTK0q9EuRn8YOOIql4YtwHgqgy', 'ali', 'heydari', 3, 1, 'shahrak qarb', 'Male', 'aliheydari1381doc@gmail.com', '2003-03-06', '2024-07-28 15:15:40', 'hasan', 'heydari', '09196993985'),
(7, 'amirhossein', '$2y$10$X4qMuc/axCHTw2z1IvCfmuspkuM754bwo4WBmykGI5y2x7yXCqF.a', 'amir', 'ahmadi', 1, 1, 'zanjan, shahrak qarb', 'Male', 'amir@gmail.com', '2005-03-22', '2024-07-28 20:02:19', 'farhad', 'ahmadi', '09195197204'),
(8, 'user992423', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 3, 'Illinois', 'Female', 'user003318@example.com', '2019-01-15', '2024-07-29 00:00:28', 'Jim', 'Doe', '+13708192'),
(9, 'user625223', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 1, 'California', 'Female', 'user273616@example.com', '2015-01-13', '2024-07-29 00:00:28', 'Jill', 'Jones', '+11533344'),
(10, 'user774219', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 4, 'Texas', 'Female', 'user344522@example.com', '2000-12-04', '2024-07-29 00:00:28', 'Jane', 'Brown', '+12763090'),
(11, 'user095832', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 2, 'Florida', 'Female', 'user239060@example.com', '2015-07-24', '2024-07-29 00:00:28', 'Jenny', 'Doe', '+17143343'),
(12, 'user439987', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 2, 'Illinois', 'Male', 'user042141@example.com', '2004-01-01', '2024-07-29 00:00:28', 'Joe', 'Johnson', '+15795796'),
(13, 'user732995', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 3, 'Illinois', 'Female', 'user194485@example.com', '2012-10-24', '2024-07-29 00:00:28', 'Jim', 'Jones', '+17394622'),
(14, 'user838808', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 2, 'Illinois', 'Female', 'user719813@example.com', '2017-07-04', '2024-07-29 00:00:28', 'Jenny', 'Brown', '+14327373'),
(15, 'user796680', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 3, 'New York', 'Male', 'user485015@example.com', '2004-03-23', '2024-07-29 00:00:28', 'Jill', 'Jones', '+13151776'),
(16, 'user669699', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 1, 'Illinois', 'Male', 'user621932@example.com', '2013-10-29', '2024-07-29 00:00:28', 'Jane', 'Williams', '+19283796'),
(17, 'user961376', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 3, 'Illinois', 'Female', 'user601630@example.com', '2000-07-20', '2024-07-29 00:00:28', 'Jane', 'Williams', '+16833026'),
(18, 'user828828', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 1, 'California', 'Female', 'user435961@example.com', '2011-08-15', '2024-07-29 00:00:28', 'Jim', 'Doe', '+16325661'),
(19, 'user762175', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 2, 'California', 'Male', 'user217488@example.com', '2001-07-19', '2024-07-29 00:00:28', 'Joe', 'Smith', '+13570365'),
(20, 'user909593', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 2, 'Illinois', 'Male', 'user586862@example.com', '2007-06-23', '2024-07-29 00:00:28', 'Jenny', 'Brown', '+16900375'),
(21, 'user333574', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 1, 4, 'Texas', 'Female', 'user552644@example.com', '2010-08-19', '2024-07-29 00:00:28', 'Joe', 'Johnson', '+16443256'),
(22, 'user050157', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 4, 'Florida', 'Female', 'user948448@example.com', '2007-04-08', '2024-07-29 00:00:28', 'Joe', 'Doe', '+19207947'),
(23, 'user387165', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 4, 'Texas', 'Male', 'user241994@example.com', '2012-12-24', '2024-07-29 00:00:28', 'Jane', 'Johnson', '+13366926'),
(24, 'user453744', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 3, 'Texas', 'Male', 'user950246@example.com', '2007-05-22', '2024-07-29 00:00:28', 'Jenny', 'Smith', '+13280011'),
(25, 'user138763', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 2, 2, 'Florida', 'Male', 'user748974@example.com', '2015-09-08', '2024-07-29 00:00:28', 'Jim', 'Williams', '+16077776'),
(26, 'user472780', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 1, 'California', 'Male', 'user436860@example.com', '2006-05-31', '2024-07-29 00:00:28', 'John', 'Jones', '+19801641'),
(27, 'user236857', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 3, 3, 'California', 'Male', 'user640472@example.com', '2018-07-06', '2024-07-29 00:00:28', 'Jane', 'Jones', '+10241162'),
(28, 'user157739', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 2, 3, 'New York', 'Male', 'user038748@example.com', '2011-04-16', '2024-07-29 00:00:28', 'Jim', 'Brown', '+14121227'),
(29, 'user783363', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 4, 'New York', 'Male', 'user895763@example.com', '2005-09-01', '2024-07-29 00:00:28', 'Jill', 'Smith', '+14700451'),
(30, 'user575701', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 2, 'Texas', 'Female', 'user264120@example.com', '2010-07-29', '2024-07-29 00:00:28', 'Jill', 'Williams', '+14347330'),
(31, 'user193811', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 2, 'Florida', 'Male', 'user653741@example.com', '2005-02-02', '2024-07-29 00:00:28', 'Jane', 'Smith', '+19352453'),
(32, 'user753287', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 3, 3, 'California', 'Female', 'user034850@example.com', '2011-06-02', '2024-07-29 00:00:28', 'Jill', 'Jones', '+12277427'),
(33, 'user298146', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 1, 'California', 'Male', 'user019190@example.com', '2020-10-11', '2024-07-29 00:00:28', 'Joe', 'Williams', '+18570121'),
(34, 'user536458', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 1, 'Florida', 'Female', 'user039216@example.com', '2010-04-11', '2024-07-29 00:00:28', 'Jane', 'Brown', '+19904279'),
(35, 'user746405', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 1, 'Texas', 'Male', 'user093056@example.com', '2005-08-08', '2024-07-29 00:00:28', 'Jenny', 'Smith', '+11554123'),
(36, 'user084485', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 3, 2, 'New York', 'Male', 'user130120@example.com', '2021-03-13', '2024-07-29 00:00:28', 'Jim', 'Johnson', '+13538503'),
(37, 'user749316', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 3, 'Florida', 'Male', 'user338446@example.com', '2021-03-28', '2024-07-29 00:00:28', 'Joe', 'Smith', '+17838395'),
(38, 'user149223', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 2, 3, 'Illinois', 'Male', 'user397593@example.com', '2017-06-18', '2024-07-29 00:00:28', 'Joe', 'Williams', '+15057824'),
(39, 'user796420', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 3, 'New York', 'Female', 'user497662@example.com', '2004-05-18', '2024-07-29 00:00:28', 'Jill', 'Jones', '+11537509'),
(40, 'user963931', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 2, 'Illinois', 'Male', 'user639158@example.com', '2001-02-17', '2024-07-29 00:00:28', 'Jim', 'Williams', '+17311260'),
(41, 'user002723', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 3, 'Florida', 'Male', 'user307585@example.com', '2015-02-01', '2024-07-29 00:00:28', 'Jill', 'Williams', '+11406935'),
(42, 'user080308', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 2, 3, 'Florida', 'Male', 'user428646@example.com', '2004-06-29', '2024-07-29 00:00:28', 'Joe', 'Doe', '+12011664'),
(43, 'user753228', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 1, 3, 'Illinois', 'Male', 'user660352@example.com', '2003-10-15', '2024-07-29 00:00:28', 'Jenny', 'Jones', '+18409423'),
(44, 'user510072', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 3, 4, 'Illinois', 'Female', 'user344974@example.com', '2020-01-02', '2024-07-29 00:00:28', 'Jill', 'Jones', '+19956586'),
(45, 'user224015', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 4, 'Texas', 'Male', 'user185716@example.com', '2016-05-10', '2024-07-29 00:00:28', 'Jane', 'Williams', '+16903341'),
(46, 'user518985', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 3, 'California', 'Male', 'user455721@example.com', '2007-03-22', '2024-07-29 00:00:28', 'Jane', 'Johnson', '+12420855'),
(47, 'user958942', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 1, 'Florida', 'Female', 'user198156@example.com', '2009-01-11', '2024-07-29 00:00:28', 'Jim', 'Doe', '+10948766'),
(48, 'user176356', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 1, 'Illinois', 'Female', 'user080259@example.com', '2013-02-18', '2024-07-29 00:00:28', 'Joe', 'Jones', '+16749109'),
(49, 'user405658', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 3, 'Illinois', 'Female', 'user077058@example.com', '2017-12-29', '2024-07-29 00:00:28', 'Jenny', 'Jones', '+19636352'),
(50, 'user061948', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 3, 'Florida', 'Male', 'user759669@example.com', '2008-03-17', '2024-07-29 00:00:28', 'Jill', 'Jones', '+14675449'),
(51, 'user786238', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 2, 'New York', 'Female', 'user437604@example.com', '2011-11-04', '2024-07-29 00:00:28', 'Jim', 'Smith', '+14860624'),
(52, 'user435300', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 3, 'Florida', 'Male', 'user427527@example.com', '2016-10-05', '2024-07-29 00:00:28', 'Jill', 'Johnson', '+14911073'),
(53, 'user181402', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 1, 'Florida', 'Female', 'user523900@example.com', '2010-07-27', '2024-07-29 00:00:28', 'Jenny', 'Brown', '+12674874'),
(54, 'user062804', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 2, 'California', 'Male', 'user449575@example.com', '2008-06-07', '2024-07-29 00:00:29', 'Jill', 'Brown', '+19087291'),
(55, 'user360575', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 2, 'Florida', 'Female', 'user921405@example.com', '2021-04-12', '2024-07-29 00:00:29', 'John', 'Williams', '+14827625'),
(56, 'user755958', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 3, 3, 'New York', 'Female', 'user036983@example.com', '2011-04-08', '2024-07-29 00:00:29', 'Jim', 'Brown', '+14304859'),
(57, 'user863927', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 3, 'California', 'Female', 'user863882@example.com', '2014-03-30', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+17684033'),
(58, 'user792657', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 1, 'California', 'Female', 'user395189@example.com', '2002-01-29', '2024-07-29 00:00:29', 'Jane', 'Doe', '+19334875'),
(59, 'user187221', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 3, 'New York', 'Male', 'user708141@example.com', '2010-12-04', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+16478077'),
(60, 'user185198', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 1, 'New York', 'Male', 'user158524@example.com', '2011-09-27', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+14493809'),
(61, 'user010066', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 1, 'California', 'Female', 'user539961@example.com', '2004-02-05', '2024-07-29 00:00:29', 'Jane', 'Doe', '+11334534'),
(62, 'user619427', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 1, 2, 'Texas', 'Male', 'user112613@example.com', '2015-03-21', '2024-07-29 00:00:29', 'John', 'Williams', '+15747393'),
(63, 'user083649', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 2, 'New York', 'Female', 'user226773@example.com', '2012-05-12', '2024-07-29 00:00:29', 'John', 'Doe', '+16542881'),
(64, 'user223528', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 4, 'Texas', 'Male', 'user913417@example.com', '2003-01-29', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+10727221'),
(65, 'user186910', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 3, 'Florida', 'Female', 'user311937@example.com', '2001-03-03', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+14889389'),
(66, 'user954832', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 2, 1, 'Texas', 'Male', 'user025808@example.com', '2001-08-11', '2024-07-29 00:00:29', 'Jane', 'Smith', '+12809700'),
(67, 'user713960', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 4, 'Illinois', 'Male', 'user039698@example.com', '2006-07-17', '2024-07-29 00:00:29', 'Jim', 'Jones', '+17576523'),
(68, 'user859623', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 3, 'California', 'Female', 'user725208@example.com', '2001-03-15', '2024-07-29 00:00:29', 'John', 'Smith', '+13538812'),
(69, 'user778900', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 3, 'Florida', 'Male', 'user636660@example.com', '2018-02-14', '2024-07-29 00:00:29', 'Jane', 'Williams', '+15861615'),
(70, 'user970216', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 4, 'California', 'Female', 'user510846@example.com', '2021-11-03', '2024-07-29 00:00:29', 'Jim', 'Smith', '+10214515'),
(71, 'user277843', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 3, 'Florida', 'Female', 'user178082@example.com', '2007-09-22', '2024-07-29 00:00:29', 'Jane', 'Doe', '+17553176'),
(72, 'user510528', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 2, 3, 'Florida', 'Male', 'user520651@example.com', '2002-11-06', '2024-07-29 00:00:29', 'John', 'Doe', '+19921809'),
(73, 'user806623', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 1, 'California', 'Female', 'user473129@example.com', '2018-02-25', '2024-07-29 00:00:29', 'Joe', 'Doe', '+15136158'),
(74, 'user155214', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 1, 'Illinois', 'Female', 'user837561@example.com', '2011-10-02', '2024-07-29 00:00:29', 'Jane', 'Smith', '+16956294'),
(75, 'user754420', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 2, 'California', 'Male', 'user798288@example.com', '2001-08-18', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+13793077'),
(76, 'user910269', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 1, 'Florida', 'Female', 'user626031@example.com', '2021-01-18', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+19873485'),
(77, 'user674915', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 3, 'California', 'Female', 'user552728@example.com', '2020-12-20', '2024-07-29 00:00:29', 'John', 'Brown', '+14757734'),
(78, 'user061266', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 2, 'New York', 'Female', 'user283841@example.com', '2016-05-25', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+13938179'),
(79, 'user327162', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'Texas', 'Male', 'user436431@example.com', '2009-12-28', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+15321521'),
(80, 'user192624', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 1, 'New York', 'Female', 'user693971@example.com', '2011-08-21', '2024-07-29 00:00:29', 'Jill', 'Smith', '+16747136'),
(81, 'user534170', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 1, 'California', 'Female', 'user124089@example.com', '2005-11-03', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+11404567'),
(82, 'user688374', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 3, 'New York', 'Male', 'user637437@example.com', '2018-07-28', '2024-07-29 00:00:29', 'Jane', 'Doe', '+14832794'),
(83, 'user137145', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 2, 'California', 'Female', 'user265649@example.com', '2014-07-05', '2024-07-29 00:00:29', 'Jill', 'Williams', '+13937911'),
(84, 'user205715', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 2, 4, 'Illinois', 'Female', 'user702179@example.com', '2011-03-01', '2024-07-29 00:00:29', 'Jim', 'Brown', '+10734585'),
(85, 'user328084', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 1, 2, 'California', 'Female', 'user724718@example.com', '2010-01-12', '2024-07-29 00:00:29', 'John', 'Smith', '+16785858'),
(86, 'user777257', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 3, 'California', 'Male', 'user128193@example.com', '2020-07-22', '2024-07-29 00:00:29', 'Jane', 'Brown', '+16975664'),
(87, 'user314957', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 1, 'Texas', 'Male', 'user887389@example.com', '2007-12-17', '2024-07-29 00:00:29', 'John', 'Brown', '+19646174'),
(88, 'user764737', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 4, 'California', 'Male', 'user812466@example.com', '2011-11-15', '2024-07-29 00:00:29', 'Jane', 'Brown', '+18693687'),
(89, 'user134337', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 1, 'Florida', 'Male', 'user190884@example.com', '2016-05-14', '2024-07-29 00:00:29', 'John', 'Williams', '+13937058'),
(90, 'user237515', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 2, 4, 'Illinois', 'Female', 'user849894@example.com', '2009-05-18', '2024-07-29 00:00:29', 'Jill', 'Brown', '+15809848'),
(91, 'user892435', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 2, 'Illinois', 'Female', 'user609361@example.com', '2013-05-06', '2024-07-29 00:00:29', 'Jane', 'Smith', '+16663361'),
(92, 'user538665', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 2, 'Texas', 'Male', 'user920395@example.com', '2009-05-15', '2024-07-29 00:00:29', 'Jim', 'Williams', '+18986809'),
(93, 'user673773', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 2, 'New York', 'Male', 'user767683@example.com', '2010-10-03', '2024-07-29 00:00:29', 'John', 'Smith', '+19788132'),
(94, 'user033182', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 3, 'California', 'Male', 'user577799@example.com', '2009-05-22', '2024-07-29 00:00:29', 'Jim', 'Brown', '+15852752'),
(95, 'user637640', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 3, 4, 'New York', 'Female', 'user642415@example.com', '2009-03-21', '2024-07-29 00:00:29', 'Jane', 'Williams', '+15874210'),
(96, 'user065469', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 2, 2, 'Texas', 'Male', 'user701182@example.com', '2018-10-03', '2024-07-29 00:00:29', 'Jane', 'Smith', '+10714940'),
(97, 'user394161', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 3, 4, 'New York', 'Male', 'user467519@example.com', '2018-10-03', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+14963316'),
(98, 'user001374', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 2, 1, 'Texas', 'Female', 'user628534@example.com', '2017-09-22', '2024-07-29 00:00:29', 'John', 'Johnson', '+13997976'),
(99, 'user869536', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 3, 'Illinois', 'Male', 'user835523@example.com', '2021-06-07', '2024-07-29 00:00:29', 'Jim', 'Jones', '+18215130'),
(100, 'user119173', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 3, 'Florida', 'Female', 'user297812@example.com', '2016-09-24', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+19219857'),
(101, 'user589151', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 1, 'Florida', 'Female', 'user903277@example.com', '2018-05-30', '2024-07-29 00:00:29', 'Jim', 'Jones', '+12403521'),
(102, 'user369878', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 1, 4, 'New York', 'Male', 'user947508@example.com', '2013-11-20', '2024-07-29 00:00:29', 'Jane', 'Brown', '+16989704'),
(103, 'user285586', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 3, 'Illinois', 'Male', 'user929435@example.com', '2002-02-17', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19036881'),
(104, 'user919201', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 3, 2, 'Illinois', 'Female', 'user292656@example.com', '2011-11-20', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+12417483'),
(105, 'user559683', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 1, 1, 'Texas', 'Male', 'user002351@example.com', '2018-10-23', '2024-07-29 00:00:29', 'Jane', 'Jones', '+14294899'),
(106, 'user573378', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 1, 'New York', 'Male', 'user949475@example.com', '2006-04-13', '2024-07-29 00:00:29', 'Jill', 'Doe', '+15773710'),
(107, 'user686708', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 2, 'New York', 'Female', 'user089023@example.com', '2014-12-11', '2024-07-29 00:00:29', 'John', 'Brown', '+19422050'),
(108, 'user685799', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 4, 'Illinois', 'Female', 'user834330@example.com', '2000-03-28', '2024-07-29 00:00:29', 'Jill', 'Brown', '+19731759'),
(109, 'user688927', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 2, 'Texas', 'Female', 'user134774@example.com', '2000-07-22', '2024-07-29 00:00:29', 'Joe', 'Williams', '+15253061'),
(110, 'user009826', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 1, 2, 'Florida', 'Female', 'user751545@example.com', '2008-01-31', '2024-07-29 00:00:29', 'Jill', 'Jones', '+14552608'),
(111, 'user740279', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 1, 1, 'California', 'Male', 'user931266@example.com', '2012-09-27', '2024-07-29 00:00:29', 'John', 'Brown', '+17994737'),
(112, 'user511075', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 1, 'Texas', 'Male', 'user150333@example.com', '2006-05-25', '2024-07-29 00:00:29', 'John', 'Smith', '+18254298'),
(113, 'user614986', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 2, 'Texas', 'Male', 'user409898@example.com', '2021-03-24', '2024-07-29 00:00:29', 'Jill', 'Smith', '+10184934'),
(114, 'user572232', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 4, 'Texas', 'Female', 'user026691@example.com', '2011-08-20', '2024-07-29 00:00:29', 'Jill', 'Smith', '+16959960'),
(115, 'user626319', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 4, 'California', 'Male', 'user300695@example.com', '2015-09-26', '2024-07-29 00:00:29', 'Joe', 'Smith', '+14016459'),
(116, 'user125440', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 4, 'Illinois', 'Male', 'user486696@example.com', '2013-08-07', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+18708468'),
(117, 'user271094', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 3, 'Texas', 'Female', 'user841017@example.com', '2009-04-29', '2024-07-29 00:00:29', 'Jill', 'Brown', '+19449207'),
(118, 'user466844', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 3, 'California', 'Male', 'user463938@example.com', '2013-10-25', '2024-07-29 00:00:29', 'Joe', 'Jones', '+13110884'),
(119, 'user796380', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 1, 'Illinois', 'Male', 'user446382@example.com', '2019-09-18', '2024-07-29 00:00:29', 'John', 'Doe', '+10387672'),
(120, 'user881039', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 2, 'New York', 'Male', 'user934210@example.com', '2008-09-13', '2024-07-29 00:00:29', 'Jane', 'Brown', '+10812591'),
(121, 'user226989', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 3, 'Florida', 'Female', 'user317028@example.com', '2016-09-09', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+14702588'),
(122, 'user322700', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 4, 'Illinois', 'Female', 'user382948@example.com', '2008-05-27', '2024-07-29 00:00:29', 'Joe', 'Brown', '+11754366'),
(123, 'user786681', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 4, 'California', 'Male', 'user271784@example.com', '2014-06-01', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+15922278'),
(124, 'user749543', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 1, 4, 'Texas', 'Male', 'user052463@example.com', '2005-12-10', '2024-07-29 00:00:29', 'Jane', 'Smith', '+13072170'),
(125, 'user993708', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 4, 'Illinois', 'Male', 'user320167@example.com', '2018-11-05', '2024-07-29 00:00:29', 'Jim', 'Doe', '+16145653'),
(126, 'user688670', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 3, 'Illinois', 'Male', 'user015694@example.com', '2019-07-01', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+15307152'),
(127, 'user608329', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 3, 'Texas', 'Female', 'user088274@example.com', '2007-06-05', '2024-07-29 00:00:29', 'Jim', 'Doe', '+13885282'),
(128, 'user534292', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 1, 4, 'Florida', 'Female', 'user954912@example.com', '2010-03-15', '2024-07-29 00:00:29', 'Jim', 'Jones', '+12244197'),
(129, 'user351997', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 1, 'New York', 'Female', 'user262488@example.com', '2001-09-22', '2024-07-29 00:00:29', 'Jill', 'Brown', '+11571088'),
(130, 'user399956', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 4, 'New York', 'Male', 'user239891@example.com', '2004-01-01', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+15183242'),
(131, 'user332246', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 1, 'Florida', 'Male', 'user436604@example.com', '2002-12-22', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+10814686'),
(132, 'user094271', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 2, 2, 'Illinois', 'Female', 'user943603@example.com', '2009-06-18', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+17697532'),
(133, 'user793654', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 1, 'California', 'Male', 'user220825@example.com', '2020-10-21', '2024-07-29 00:00:29', 'John', 'Williams', '+16694202'),
(134, 'user588484', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 4, 'California', 'Male', 'user214706@example.com', '2019-11-11', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+19752344'),
(135, 'user689259', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 4, 'Texas', 'Female', 'user185605@example.com', '2007-07-13', '2024-07-29 00:00:29', 'John', 'Brown', '+14103750'),
(136, 'user713782', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 4, 'Florida', 'Female', 'user302924@example.com', '2009-04-08', '2024-07-29 00:00:29', 'Jane', 'Brown', '+12091818'),
(137, 'user747563', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 1, 'New York', 'Female', 'user943573@example.com', '2005-12-04', '2024-07-29 00:00:29', 'Jill', 'Brown', '+14331359'),
(138, 'user765507', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 3, 'Illinois', 'Male', 'user642203@example.com', '2011-06-11', '2024-07-29 00:00:29', 'Joe', 'Jones', '+12414045'),
(139, 'user628589', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 3, 2, 'New York', 'Female', 'user108773@example.com', '2010-05-21', '2024-07-29 00:00:29', 'John', 'Brown', '+18643900'),
(140, 'user923419', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 2, 'Florida', 'Male', 'user540989@example.com', '2010-07-05', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+18770434'),
(141, 'user062006', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 2, 'Illinois', 'Female', 'user931690@example.com', '2006-08-05', '2024-07-29 00:00:29', 'Joe', 'Williams', '+11039622'),
(142, 'user579512', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 2, 'California', 'Female', 'user487595@example.com', '2005-09-24', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+16809597'),
(143, 'user073866', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 1, 'Texas', 'Female', 'user203884@example.com', '2005-08-16', '2024-07-29 00:00:29', 'Joe', 'Williams', '+19432379'),
(144, 'user939680', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 1, 3, 'Texas', 'Female', 'user080301@example.com', '2014-11-18', '2024-07-29 00:00:29', 'John', 'Brown', '+12486690'),
(145, 'user012644', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 3, 2, 'New York', 'Female', 'user510412@example.com', '2004-05-05', '2024-07-29 00:00:29', 'Jim', 'Brown', '+11564926'),
(146, 'user659600', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 2, 1, 'Illinois', 'Female', 'user733117@example.com', '2000-11-18', '2024-07-29 00:00:29', 'John', 'Jones', '+14414910'),
(147, 'user538813', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'Florida', 'Male', 'user012628@example.com', '2021-04-04', '2024-07-29 00:00:29', 'Joe', 'Doe', '+13705452'),
(148, 'user363474', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 1, 'New York', 'Male', 'user411369@example.com', '2015-07-03', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+10954430'),
(149, 'user270687', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 3, 'California', 'Female', 'user969726@example.com', '2020-04-08', '2024-07-29 00:00:29', 'Joe', 'Brown', '+19173073'),
(150, 'user143482', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 2, 'Illinois', 'Male', 'user076040@example.com', '2016-05-08', '2024-07-29 00:00:29', 'Jill', 'Smith', '+19082485'),
(151, 'user687519', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 2, 'Florida', 'Male', 'user319356@example.com', '2010-12-26', '2024-07-29 00:00:29', 'Jill', 'Smith', '+15745289'),
(152, 'user138047', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 3, 'New York', 'Female', 'user548041@example.com', '2021-07-06', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+11361756'),
(153, 'user518994', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 2, 'California', 'Male', 'user656418@example.com', '2005-12-13', '2024-07-29 00:00:29', 'Jim', 'Doe', '+14851850'),
(154, 'user034428', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 4, 'California', 'Female', 'user948483@example.com', '2019-04-27', '2024-07-29 00:00:29', 'Jill', 'Smith', '+11983405'),
(155, 'user455727', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 4, 'Florida', 'Female', 'user778580@example.com', '2020-07-04', '2024-07-29 00:00:29', 'Jim', 'Jones', '+15593161'),
(156, 'user038898', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 3, 3, 'New York', 'Male', 'user387140@example.com', '2017-02-02', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+15735112'),
(157, 'user791659', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 2, 2, 'Florida', 'Male', 'user636460@example.com', '2019-03-31', '2024-07-29 00:00:29', 'Jim', 'Brown', '+14739327'),
(158, 'user013528', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 2, 'California', 'Male', 'user555384@example.com', '2011-03-24', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+10377426'),
(159, 'user352111', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 2, 'Texas', 'Male', 'user090199@example.com', '2014-07-24', '2024-07-29 00:00:29', 'John', 'Smith', '+12098696'),
(160, 'user226637', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 4, 'California', 'Male', 'user940505@example.com', '2001-07-14', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+15842393'),
(161, 'user618662', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 3, 'Illinois', 'Male', 'user786841@example.com', '2019-06-30', '2024-07-29 00:00:29', 'John', 'Brown', '+16215395'),
(162, 'user773426', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 1, 'Florida', 'Male', 'user346887@example.com', '2009-09-16', '2024-07-29 00:00:29', 'Jane', 'Williams', '+12155977'),
(163, 'user432437', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 2, 'Texas', 'Male', 'user823321@example.com', '2013-10-07', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+13752240'),
(164, 'user439764', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 4, 'Texas', 'Male', 'user011777@example.com', '2013-02-02', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+19993904'),
(165, 'user082070', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 3, 'New York', 'Female', 'user129512@example.com', '2009-04-06', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+16283267'),
(166, 'user057843', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 3, 'Illinois', 'Male', 'user879759@example.com', '2020-09-09', '2024-07-29 00:00:29', 'John', 'Williams', '+16853617'),
(167, 'user663710', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 3, 1, 'New York', 'Female', 'user265613@example.com', '2013-09-05', '2024-07-29 00:00:29', 'Jane', 'Brown', '+17986744'),
(168, 'user727823', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 1, 'Illinois', 'Female', 'user029228@example.com', '2016-02-26', '2024-07-29 00:00:29', 'Jill', 'Brown', '+11407118'),
(169, 'user338774', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 3, 2, 'Texas', 'Female', 'user148768@example.com', '2021-09-21', '2024-07-29 00:00:29', 'Jill', 'Williams', '+14001882'),
(170, 'user238176', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 1, 2, 'New York', 'Female', 'user089085@example.com', '2006-09-14', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+11980792'),
(171, 'user797879', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 4, 'California', 'Male', 'user734488@example.com', '2004-12-28', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+11801513'),
(172, 'user907245', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 1, 3, 'Florida', 'Male', 'user733004@example.com', '2012-02-19', '2024-07-29 00:00:29', 'Jill', 'Smith', '+12562567'),
(173, 'user699322', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 4, 'California', 'Female', 'user538556@example.com', '2019-05-08', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+13838671'),
(174, 'user846090', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 3, 'New York', 'Female', 'user794461@example.com', '2001-12-09', '2024-07-29 00:00:29', 'John', 'Doe', '+19846870'),
(175, 'user825111', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 4, 'Illinois', 'Male', 'user156590@example.com', '2011-04-14', '2024-07-29 00:00:29', 'John', 'Jones', '+16137510'),
(176, 'user108845', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 3, 'Texas', 'Female', 'user932490@example.com', '2013-05-10', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+13882744'),
(177, 'user655500', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 2, 'California', 'Male', 'user275526@example.com', '2007-03-23', '2024-07-29 00:00:29', 'Joe', 'Doe', '+11446579'),
(178, 'user356289', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 2, 'Texas', 'Male', 'user202832@example.com', '2018-10-29', '2024-07-29 00:00:29', 'Joe', 'Jones', '+12669271'),
(179, 'user734144', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 1, 'Texas', 'Male', 'user789846@example.com', '2000-11-15', '2024-07-29 00:00:29', 'Joe', 'Doe', '+16657338'),
(180, 'user234816', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 2, 'Texas', 'Male', 'user703306@example.com', '2020-06-17', '2024-07-29 00:00:29', 'Jill', 'Doe', '+13307210'),
(181, 'user645232', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 3, 'Illinois', 'Male', 'user255071@example.com', '2018-09-28', '2024-07-29 00:00:29', 'Jill', 'Jones', '+14589151'),
(182, 'user295110', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 3, 4, 'California', 'Female', 'user084780@example.com', '2000-06-30', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+15643392'),
(183, 'user136289', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 3, 4, 'Texas', 'Male', 'user780719@example.com', '2014-08-24', '2024-07-29 00:00:29', 'John', 'Jones', '+19941024'),
(184, 'user972101', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 2, 'New York', 'Female', 'user918694@example.com', '2021-11-17', '2024-07-29 00:00:29', 'Jane', 'Smith', '+12616158'),
(185, 'user721965', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 3, 'Florida', 'Male', 'user579610@example.com', '2012-06-25', '2024-07-29 00:00:29', 'John', 'Jones', '+18839425'),
(186, 'user890358', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 1, 'Texas', 'Male', 'user046812@example.com', '2018-01-27', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+13034669'),
(187, 'user161328', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 2, 'Texas', 'Male', 'user420189@example.com', '2017-06-20', '2024-07-29 00:00:29', 'Joe', 'Smith', '+10372212'),
(188, 'user454612', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 2, 'Texas', 'Male', 'user907278@example.com', '2017-04-01', '2024-07-29 00:00:29', 'Jane', 'Brown', '+19408636'),
(189, 'user550775', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 1, 'Illinois', 'Male', 'user538287@example.com', '2019-10-13', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+12724100'),
(190, 'user976993', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 4, 'California', 'Male', 'user451811@example.com', '2020-02-02', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+13098856'),
(191, 'user348910', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 2, 'Illinois', 'Male', 'user961658@example.com', '2010-11-10', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+16300294'),
(192, 'user703028', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 1, 4, 'California', 'Male', 'user544023@example.com', '2006-03-10', '2024-07-29 00:00:29', 'Joe', 'Doe', '+19333708'),
(193, 'user501924', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 2, 'New York', 'Female', 'user941240@example.com', '2001-12-13', '2024-07-29 00:00:29', 'Jill', 'Jones', '+13409560'),
(194, 'user181163', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 4, 'Texas', 'Female', 'user029812@example.com', '2000-11-23', '2024-07-29 00:00:29', 'John', 'Johnson', '+19242027'),
(195, 'user258780', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 2, 2, 'Texas', 'Female', 'user392270@example.com', '2002-04-14', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+10226419'),
(196, 'user878806', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 4, 'Illinois', 'Female', 'user519268@example.com', '2013-11-01', '2024-07-29 00:00:29', 'Jill', 'Doe', '+17341548'),
(197, 'user349564', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 3, 'Texas', 'Female', 'user284305@example.com', '2015-01-10', '2024-07-29 00:00:29', 'Jill', 'Brown', '+14124784'),
(198, 'user575525', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 4, 'Illinois', 'Female', 'user401314@example.com', '2006-08-03', '2024-07-29 00:00:29', 'Jane', 'Williams', '+10918451'),
(199, 'user663770', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 2, 'Texas', 'Female', 'user325576@example.com', '2005-08-21', '2024-07-29 00:00:29', 'Jane', 'Brown', '+19645590'),
(200, 'user485609', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 3, 'New York', 'Female', 'user775149@example.com', '2020-03-29', '2024-07-29 00:00:29', 'Jane', 'Brown', '+16423723'),
(201, 'user094138', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 2, 'Texas', 'Male', 'user452720@example.com', '2015-06-03', '2024-07-29 00:00:29', 'John', 'Brown', '+10082232'),
(202, 'user944136', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 1, 4, 'Texas', 'Female', 'user865952@example.com', '2016-05-15', '2024-07-29 00:00:29', 'John', 'Johnson', '+18523338'),
(203, 'user899604', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 1, 'Texas', 'Male', 'user436867@example.com', '2000-11-15', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+19663499'),
(204, 'user851062', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'New York', 'Female', 'user353797@example.com', '2010-05-07', '2024-07-29 00:00:29', 'Jane', 'Doe', '+15366042'),
(205, 'user419089', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 2, 2, 'New York', 'Male', 'user934020@example.com', '2003-11-16', '2024-07-29 00:00:29', 'John', 'Jones', '+11582720'),
(206, 'user148185', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 2, 3, 'Florida', 'Female', 'user829003@example.com', '2012-03-12', '2024-07-29 00:00:29', 'Jane', 'Brown', '+11862843'),
(207, 'user484642', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 1, 'California', 'Female', 'user872592@example.com', '2011-05-26', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+18535849'),
(208, 'user183539', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 4, 'Florida', 'Male', 'user035422@example.com', '2002-11-11', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+10793246'),
(209, 'user363942', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 2, 1, 'California', 'Male', 'user891688@example.com', '2012-01-16', '2024-07-29 00:00:29', 'John', 'Brown', '+13805737'),
(210, 'user741346', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 3, 'Illinois', 'Female', 'user524739@example.com', '2005-08-25', '2024-07-29 00:00:29', 'Joe', 'Brown', '+18707581'),
(211, 'user943538', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 1, 3, 'California', 'Female', 'user449568@example.com', '2017-08-14', '2024-07-29 00:00:29', 'Joe', 'Jones', '+17460212'),
(212, 'user870606', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 2, 'Illinois', 'Male', 'user850887@example.com', '2020-04-09', '2024-07-29 00:00:29', 'John', 'Williams', '+17683726'),
(213, 'user045710', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 3, 'Florida', 'Male', 'user822593@example.com', '2013-12-05', '2024-07-29 00:00:29', 'Joe', 'Williams', '+11265539'),
(214, 'user675057', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 1, 'Illinois', 'Male', 'user571801@example.com', '2018-05-30', '2024-07-29 00:00:29', 'Jim', 'Jones', '+11174284'),
(215, 'user839076', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 3, 3, 'Florida', 'Male', 'user464031@example.com', '2008-09-23', '2024-07-29 00:00:29', 'Jill', 'Brown', '+12384497'),
(216, 'user767783', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 1, 'Florida', 'Male', 'user881484@example.com', '2003-12-18', '2024-07-29 00:00:29', 'Jane', 'Brown', '+10083855'),
(217, 'user768731', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 1, 'Florida', 'Male', 'user595480@example.com', '2021-11-25', '2024-07-29 00:00:29', 'Jane', 'Doe', '+16923544'),
(218, 'user262516', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 1, 'Texas', 'Male', 'user490846@example.com', '2005-04-22', '2024-07-29 00:00:29', 'Joe', 'Jones', '+16246902'),
(219, 'user218313', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 2, 'Florida', 'Female', 'user401765@example.com', '2005-04-20', '2024-07-29 00:00:29', 'John', 'Smith', '+14785834'),
(220, 'user496817', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 4, 'New York', 'Male', 'user851567@example.com', '2018-03-01', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+15864130'),
(221, 'user514378', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 1, 2, 'Florida', 'Male', 'user303051@example.com', '2002-12-11', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+17687148'),
(222, 'user609023', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 1, 'Florida', 'Male', 'user596057@example.com', '2000-06-09', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+15617944'),
(223, 'user310456', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 4, 'New York', 'Female', 'user801971@example.com', '2012-10-09', '2024-07-29 00:00:29', 'Jill', 'Brown', '+14702582'),
(224, 'user951325', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 1, 'California', 'Male', 'user140424@example.com', '2009-06-13', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+17173071'),
(225, 'user431623', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 1, 'Texas', 'Male', 'user959443@example.com', '2019-04-27', '2024-07-29 00:00:29', 'Jill', 'Doe', '+14681510'),
(226, 'user302725', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 3, 2, 'California', 'Female', 'user373400@example.com', '2016-10-29', '2024-07-29 00:00:29', 'Joe', 'Smith', '+13424734'),
(227, 'user808696', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 1, 1, 'New York', 'Female', 'user717156@example.com', '2012-12-20', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19290575'),
(228, 'user830472', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 4, 'Florida', 'Female', 'user684113@example.com', '2004-02-29', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+19074715'),
(229, 'user776239', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 4, 'Florida', 'Male', 'user908123@example.com', '2011-03-17', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+16685928'),
(230, 'user441015', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 4, 'Illinois', 'Female', 'user735871@example.com', '2016-07-08', '2024-07-29 00:00:29', 'Jill', 'Williams', '+10854958'),
(231, 'user761707', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 3, 1, 'Florida', 'Female', 'user858941@example.com', '2006-12-03', '2024-07-29 00:00:29', 'John', 'Doe', '+13384192');
INSERT INTO `students` (`student_id`, `username`, `password`, `fname`, `lname`, `grade`, `section`, `address`, `gender`, `email_address`, `date_of_birth`, `date_of_joined`, `parent_fname`, `parent_lname`, `parent_phone_number`) VALUES
(232, 'user482518', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 2, 4, 'Illinois', 'Male', 'user309051@example.com', '2016-12-21', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+12161860'),
(233, 'user846178', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 2, 'New York', 'Female', 'user201446@example.com', '2001-05-01', '2024-07-29 00:00:29', 'Joe', 'Smith', '+14816836'),
(234, 'user459910', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 4, 'Texas', 'Female', 'user815853@example.com', '2005-03-31', '2024-07-29 00:00:29', 'Joe', 'Doe', '+19064495'),
(235, 'user438460', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 4, 'Texas', 'Male', 'user617459@example.com', '2018-10-13', '2024-07-29 00:00:29', 'Jim', 'Williams', '+17120742'),
(236, 'user749728', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 3, 'Illinois', 'Female', 'user276358@example.com', '2012-05-12', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+13820384'),
(237, 'user093354', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 2, 'Texas', 'Female', 'user426060@example.com', '2015-04-12', '2024-07-29 00:00:29', 'Jane', 'Jones', '+11530908'),
(238, 'user895824', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 4, 'Illinois', 'Female', 'user354407@example.com', '2011-01-26', '2024-07-29 00:00:29', 'Jim', 'Brown', '+16198238'),
(239, 'user692641', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 3, 'Texas', 'Female', 'user938162@example.com', '2012-10-10', '2024-07-29 00:00:29', 'John', 'Brown', '+14932173'),
(240, 'user186681', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 4, 'California', 'Female', 'user625105@example.com', '2010-02-13', '2024-07-29 00:00:29', 'Jim', 'Brown', '+16338781'),
(241, 'user806553', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 1, 'Florida', 'Male', 'user482745@example.com', '2020-09-07', '2024-07-29 00:00:29', 'Jane', 'Williams', '+18618108'),
(242, 'user698718', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 1, 'California', 'Male', 'user250290@example.com', '2003-06-14', '2024-07-29 00:00:29', 'John', 'Brown', '+14543684'),
(243, 'user132243', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 3, 'California', 'Male', 'user367147@example.com', '2012-10-26', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+13695018'),
(244, 'user740918', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 3, 'Florida', 'Male', 'user131242@example.com', '2013-10-03', '2024-07-29 00:00:29', 'Joe', 'Jones', '+10018713'),
(245, 'user464576', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 1, 2, 'California', 'Male', 'user701869@example.com', '2009-09-19', '2024-07-29 00:00:29', 'John', 'Smith', '+18313839'),
(246, 'user454574', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 1, 4, 'Illinois', 'Female', 'user095841@example.com', '2002-09-22', '2024-07-29 00:00:29', 'Jim', 'Smith', '+15019320'),
(247, 'user605548', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 2, 3, 'Illinois', 'Female', 'user392961@example.com', '2002-08-14', '2024-07-29 00:00:29', 'Jim', 'Brown', '+14213510'),
(248, 'user900028', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 3, 1, 'New York', 'Male', 'user753363@example.com', '2004-10-30', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+12274247'),
(249, 'user484150', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 1, 'New York', 'Female', 'user169516@example.com', '2018-08-02', '2024-07-29 00:00:29', 'Joe', 'Doe', '+14216564'),
(250, 'user733964', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 1, 'Texas', 'Female', 'user619006@example.com', '2004-04-06', '2024-07-29 00:00:29', 'John', 'Jones', '+16381465'),
(251, 'user198551', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 2, 'Texas', 'Male', 'user752635@example.com', '2002-06-03', '2024-07-29 00:00:29', 'Jane', 'Doe', '+18309186'),
(252, 'user725076', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 3, 'Texas', 'Female', 'user966733@example.com', '2012-09-07', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+12193627'),
(253, 'user372778', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 4, 'Illinois', 'Female', 'user294723@example.com', '2000-05-25', '2024-07-29 00:00:29', 'Jane', 'Jones', '+12705841'),
(254, 'user418908', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 1, 'California', 'Female', 'user735819@example.com', '2011-12-27', '2024-07-29 00:00:29', 'Jill', 'Doe', '+14272352'),
(255, 'user127766', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 2, 'Florida', 'Female', 'user918220@example.com', '2005-11-07', '2024-07-29 00:00:29', 'Jill', 'Doe', '+17848560'),
(256, 'user606635', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 3, 2, 'Florida', 'Male', 'user057317@example.com', '2005-10-25', '2024-07-29 00:00:29', 'John', 'Jones', '+14439355'),
(257, 'user272915', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 1, 'Florida', 'Female', 'user165144@example.com', '2008-12-06', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+18426832'),
(258, 'user729271', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 1, 'Texas', 'Male', 'user376959@example.com', '2014-11-07', '2024-07-29 00:00:29', 'Jane', 'Smith', '+15407512'),
(259, 'user911932', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 4, 'Texas', 'Female', 'user988801@example.com', '2005-07-10', '2024-07-29 00:00:29', 'Jane', 'Brown', '+16956252'),
(260, 'user330713', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 1, 'Texas', 'Female', 'user387046@example.com', '2003-07-10', '2024-07-29 00:00:29', 'Jill', 'Brown', '+17295726'),
(261, 'user453099', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 3, 2, 'California', 'Male', 'user092249@example.com', '2020-02-26', '2024-07-29 00:00:29', 'Jane', 'Jones', '+13349880'),
(262, 'user089872', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 2, 'New York', 'Female', 'user904472@example.com', '2020-02-08', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+15106188'),
(263, 'user669272', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 1, 'California', 'Male', 'user490649@example.com', '2010-01-02', '2024-07-29 00:00:29', 'Joe', 'Brown', '+10100885'),
(264, 'user982985', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 1, 'Florida', 'Female', 'user390633@example.com', '2006-08-07', '2024-07-29 00:00:29', 'Jim', 'Brown', '+18449375'),
(265, 'user915138', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 2, 'Illinois', 'Male', 'user650197@example.com', '2000-09-07', '2024-07-29 00:00:29', 'Jane', 'Jones', '+10634708'),
(266, 'user508353', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 4, 'Illinois', 'Female', 'user706963@example.com', '2013-10-04', '2024-07-29 00:00:29', 'John', 'Smith', '+10228003'),
(267, 'user463803', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 2, 1, 'California', 'Female', 'user031821@example.com', '2003-09-04', '2024-07-29 00:00:29', 'Joe', 'Smith', '+18385457'),
(268, 'user551448', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 1, 3, 'Florida', 'Female', 'user042950@example.com', '2008-12-30', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+11978412'),
(269, 'user804611', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 3, 'California', 'Female', 'user524002@example.com', '2009-10-17', '2024-07-29 00:00:29', 'Jill', 'Jones', '+19034898'),
(270, 'user579822', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 3, 'Illinois', 'Female', 'user135011@example.com', '2021-02-07', '2024-07-29 00:00:29', 'Jim', 'Smith', '+16302874'),
(271, 'user630017', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 1, 'Texas', 'Male', 'user619988@example.com', '2010-08-18', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+11880614'),
(272, 'user807348', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 3, 'New York', 'Male', 'user869347@example.com', '2002-03-02', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+10190834'),
(273, 'user688294', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 1, 'Illinois', 'Female', 'user530544@example.com', '2012-05-09', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+15681423'),
(274, 'user488380', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 4, 'Texas', 'Female', 'user241112@example.com', '2001-07-28', '2024-07-29 00:00:29', 'Jill', 'Jones', '+19054956'),
(275, 'user640185', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 1, 4, 'Florida', 'Male', 'user478843@example.com', '2001-09-15', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+17979765'),
(276, 'user395643', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 2, 'California', 'Female', 'user805897@example.com', '2007-11-13', '2024-07-29 00:00:29', 'Jim', 'Brown', '+19307095'),
(277, 'user214552', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 2, 'Florida', 'Female', 'user414935@example.com', '2001-11-29', '2024-07-29 00:00:29', 'Jane', 'Brown', '+19118082'),
(278, 'user466524', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 4, 'California', 'Female', 'user317542@example.com', '2014-08-22', '2024-07-29 00:00:29', 'Jim', 'Jones', '+15408557'),
(279, 'user878832', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 2, 'New York', 'Female', 'user039468@example.com', '2003-09-04', '2024-07-29 00:00:29', 'Joe', 'Doe', '+13401017'),
(280, 'user398996', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 2, 2, 'Illinois', 'Female', 'user538639@example.com', '2002-02-14', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+16571579'),
(281, 'user127871', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 3, 1, 'Florida', 'Female', 'user722142@example.com', '2019-04-06', '2024-07-29 00:00:29', 'Jane', 'Williams', '+18899783'),
(282, 'user900079', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 2, 'New York', 'Male', 'user683663@example.com', '2016-09-03', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+12063284'),
(283, 'user547490', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 1, 'Texas', 'Female', 'user407136@example.com', '2018-05-09', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+17389235'),
(284, 'user707807', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 4, 'New York', 'Female', 'user308860@example.com', '2008-12-30', '2024-07-29 00:00:29', 'John', 'Johnson', '+16444252'),
(285, 'user005812', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 3, 'Texas', 'Male', 'user716838@example.com', '2004-09-26', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+12424439'),
(286, 'user190481', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 1, 4, 'Florida', 'Male', 'user743191@example.com', '2010-09-05', '2024-07-29 00:00:29', 'Jane', 'Williams', '+12677153'),
(287, 'user603127', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 2, 'New York', 'Female', 'user677498@example.com', '2012-01-17', '2024-07-29 00:00:29', 'Joe', 'Jones', '+15238596'),
(288, 'user814539', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 4, 'Illinois', 'Female', 'user192242@example.com', '2008-05-14', '2024-07-29 00:00:29', 'Jim', 'Williams', '+16137076'),
(289, 'user499313', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 2, 'Florida', 'Female', 'user321231@example.com', '2017-12-29', '2024-07-29 00:00:29', 'John', 'Smith', '+18425292'),
(290, 'user448155', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 1, 'Illinois', 'Male', 'user714571@example.com', '2013-02-09', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+17054353'),
(291, 'user175186', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 3, 'Florida', 'Female', 'user669712@example.com', '2008-04-28', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+19079227'),
(292, 'user590459', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 3, 'New York', 'Female', 'user037939@example.com', '2000-08-13', '2024-07-29 00:00:29', 'John', 'Doe', '+11794088'),
(293, 'user740054', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 3, 'California', 'Male', 'user685681@example.com', '2021-03-05', '2024-07-29 00:00:29', 'Joe', 'Jones', '+15892897'),
(294, 'user994518', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 4, 'California', 'Male', 'user325828@example.com', '2011-01-06', '2024-07-29 00:00:29', 'Jill', 'Smith', '+12788898'),
(295, 'user859724', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 1, 'Illinois', 'Male', 'user033567@example.com', '2015-03-28', '2024-07-29 00:00:29', 'Jim', 'Brown', '+18766722'),
(296, 'user977262', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 3, 4, 'California', 'Female', 'user996788@example.com', '2000-10-08', '2024-07-29 00:00:29', 'Jane', 'Brown', '+15496712'),
(297, 'user285007', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 4, 'New York', 'Male', 'user985409@example.com', '2013-12-07', '2024-07-29 00:00:29', 'Jane', 'Smith', '+14057655'),
(298, 'user380421', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 2, 4, 'Florida', 'Male', 'user432183@example.com', '2015-05-14', '2024-07-29 00:00:29', 'Jane', 'Jones', '+11217791'),
(299, 'user755797', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 2, 'Florida', 'Female', 'user963278@example.com', '2018-04-01', '2024-07-29 00:00:29', 'Jane', 'Jones', '+15736395'),
(300, 'user227294', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 2, 'New York', 'Male', 'user883539@example.com', '2020-12-25', '2024-07-29 00:00:29', 'John', 'Brown', '+16978954'),
(301, 'user019710', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 3, 1, 'California', 'Male', 'user779312@example.com', '2016-08-08', '2024-07-29 00:00:29', 'Jim', 'Jones', '+15810034'),
(302, 'user942170', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 4, 'California', 'Male', 'user791591@example.com', '2019-07-21', '2024-07-29 00:00:29', 'John', 'Brown', '+15622346'),
(303, 'user514053', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 1, 'Illinois', 'Male', 'user022015@example.com', '2002-10-13', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+16166138'),
(304, 'user688545', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 4, 'California', 'Female', 'user405585@example.com', '2002-10-02', '2024-07-29 00:00:29', 'Jim', 'Brown', '+11755612'),
(305, 'user831075', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 2, 4, 'California', 'Female', 'user020346@example.com', '2017-03-26', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+14030062'),
(306, 'user001910', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 4, 'Illinois', 'Female', 'user362816@example.com', '2000-06-30', '2024-07-29 00:00:29', 'John', 'Doe', '+12144047'),
(307, 'user897930', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 1, 1, 'California', 'Female', 'user996102@example.com', '2001-08-15', '2024-07-29 00:00:29', 'Jim', 'Brown', '+12975175'),
(308, 'user421056', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 2, 2, 'New York', 'Female', 'user834430@example.com', '2018-11-08', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+17063551'),
(309, 'user266425', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 3, 3, 'California', 'Male', 'user791799@example.com', '2015-06-02', '2024-07-29 00:00:29', 'John', 'Williams', '+16176334'),
(310, 'user257646', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 2, 'Florida', 'Male', 'user380636@example.com', '2016-08-04', '2024-07-29 00:00:29', 'Jill', 'Jones', '+18408228'),
(311, 'user337526', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 2, 'California', 'Female', 'user640238@example.com', '2012-08-05', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+13757734'),
(312, 'user735074', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 3, 'Florida', 'Female', 'user195427@example.com', '2001-09-16', '2024-07-29 00:00:29', 'Joe', 'Brown', '+15207618'),
(313, 'user243809', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 3, 2, 'New York', 'Female', 'user354624@example.com', '2011-07-05', '2024-07-29 00:00:29', 'Jill', 'Smith', '+15123953'),
(314, 'user840475', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 3, 'Texas', 'Male', 'user775377@example.com', '2010-02-17', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+17632751'),
(315, 'user182883', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 3, 2, 'California', 'Female', 'user416362@example.com', '2009-05-01', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+19915604'),
(316, 'user577082', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 2, 2, 'New York', 'Female', 'user972223@example.com', '2009-08-27', '2024-07-29 00:00:29', 'Jane', 'Doe', '+17047211'),
(317, 'user184009', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 2, 'New York', 'Female', 'user374840@example.com', '2003-05-31', '2024-07-29 00:00:29', 'Jill', 'Brown', '+10601155'),
(318, 'user886580', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 1, 2, 'Florida', 'Female', 'user461088@example.com', '2006-11-08', '2024-07-29 00:00:29', 'Jane', 'Jones', '+12939600'),
(319, 'user567173', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 2, 1, 'Texas', 'Male', 'user874197@example.com', '2001-10-06', '2024-07-29 00:00:29', 'Joe', 'Williams', '+19592144'),
(320, 'user815881', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 1, 2, 'Illinois', 'Male', 'user090002@example.com', '2008-11-21', '2024-07-29 00:00:29', 'Joe', 'Williams', '+16267754'),
(321, 'user390115', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 4, 'Texas', 'Female', 'user208701@example.com', '2002-10-21', '2024-07-29 00:00:29', 'John', 'Brown', '+13859500'),
(322, 'user873144', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 1, 'New York', 'Female', 'user012820@example.com', '2011-12-01', '2024-07-29 00:00:29', 'Joe', 'Brown', '+18398549'),
(323, 'user868023', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 3, 'California', 'Male', 'user877841@example.com', '2001-06-28', '2024-07-29 00:00:29', 'Joe', 'Smith', '+15243207'),
(324, 'user635178', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 2, 'Texas', 'Female', 'user258411@example.com', '2019-10-30', '2024-07-29 00:00:29', 'Joe', 'Doe', '+19527727'),
(325, 'user639502', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 1, 'Texas', 'Male', 'user153361@example.com', '2018-01-17', '2024-07-29 00:00:29', 'Jill', 'Brown', '+11523658'),
(326, 'user283109', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 2, 'California', 'Male', 'user514260@example.com', '2001-12-04', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+14136585'),
(327, 'user405592', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 1, 4, 'California', 'Male', 'user313891@example.com', '2005-12-09', '2024-07-29 00:00:29', 'Jim', 'Smith', '+10512504'),
(328, 'user479328', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 2, 'Florida', 'Male', 'user564632@example.com', '2016-09-17', '2024-07-29 00:00:29', 'John', 'Smith', '+12199019'),
(329, 'user149522', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 3, 2, 'California', 'Male', 'user255389@example.com', '2011-03-05', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+16147498'),
(330, 'user892064', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 3, 'Florida', 'Female', 'user421651@example.com', '2020-05-25', '2024-07-29 00:00:29', 'Jim', 'Doe', '+16424681'),
(331, 'user722270', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 2, 'Illinois', 'Female', 'user953292@example.com', '2004-04-20', '2024-07-29 00:00:29', 'John', 'Doe', '+17417047'),
(332, 'user643585', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 4, 'Florida', 'Female', 'user434210@example.com', '2003-07-17', '2024-07-29 00:00:29', 'Jill', 'Doe', '+16996652'),
(333, 'user368337', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 3, 1, 'Florida', 'Male', 'user569487@example.com', '2006-06-13', '2024-07-29 00:00:29', 'Joe', 'Jones', '+13908098'),
(334, 'user144344', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 3, 'Texas', 'Female', 'user649626@example.com', '2006-12-21', '2024-07-29 00:00:29', 'Jill', 'Smith', '+13621905'),
(335, 'user037012', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 4, 'Florida', 'Female', 'user434196@example.com', '2008-07-16', '2024-07-29 00:00:29', 'Jill', 'Doe', '+13913665'),
(336, 'user756832', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 1, 'Illinois', 'Male', 'user917544@example.com', '2007-12-31', '2024-07-29 00:00:29', 'John', 'Smith', '+11402601'),
(337, 'user884687', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 4, 'Illinois', 'Male', 'user972531@example.com', '2008-01-20', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+17385036'),
(338, 'user192347', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 2, 1, 'California', 'Male', 'user563469@example.com', '2017-02-24', '2024-07-29 00:00:29', 'Jane', 'Brown', '+12003218'),
(339, 'user676742', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 3, 'California', 'Male', 'user557818@example.com', '2021-02-06', '2024-07-29 00:00:29', 'John', 'Brown', '+17150326'),
(340, 'user087000', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 1, 4, 'Florida', 'Male', 'user095475@example.com', '2000-06-29', '2024-07-29 00:00:29', 'Joe', 'Doe', '+18411550'),
(341, 'user013672', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 4, 'Illinois', 'Male', 'user323457@example.com', '2019-05-06', '2024-07-29 00:00:29', 'Jim', 'Williams', '+15494295'),
(342, 'user015964', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 1, 4, 'Illinois', 'Female', 'user713359@example.com', '2018-04-02', '2024-07-29 00:00:29', 'John', 'Williams', '+10858974'),
(343, 'user529999', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 2, 'Texas', 'Male', 'user527783@example.com', '2004-04-25', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+18916635'),
(344, 'user199368', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 2, 'Illinois', 'Female', 'user703052@example.com', '2000-07-08', '2024-07-29 00:00:29', 'John', 'Jones', '+18432769'),
(345, 'user294242', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 1, 'New York', 'Female', 'user483854@example.com', '2000-08-28', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+19242779'),
(346, 'user408815', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 4, 'Texas', 'Female', 'user590298@example.com', '2013-10-13', '2024-07-29 00:00:29', 'Jim', 'Jones', '+18252852'),
(347, 'user155026', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 1, 'California', 'Female', 'user866899@example.com', '2017-11-22', '2024-07-29 00:00:29', 'Jim', 'Jones', '+13961776'),
(348, 'user071766', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 3, 2, 'New York', 'Female', 'user756741@example.com', '2016-11-18', '2024-07-29 00:00:29', 'Jill', 'Williams', '+12835138'),
(349, 'user596432', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 3, 1, 'Illinois', 'Female', 'user612976@example.com', '2012-05-29', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+13652253'),
(350, 'user018169', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 2, 2, 'Illinois', 'Male', 'user490146@example.com', '2018-04-01', '2024-07-29 00:00:29', 'Joe', 'Jones', '+18024728'),
(351, 'user079048', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 2, 3, 'Texas', 'Female', 'user402325@example.com', '2006-04-17', '2024-07-29 00:00:29', 'Jane', 'Smith', '+17423520'),
(352, 'user852985', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 1, 2, 'California', 'Male', 'user033309@example.com', '2001-01-15', '2024-07-29 00:00:29', 'John', 'Williams', '+13165164'),
(353, 'user944812', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 1, 'Texas', 'Female', 'user771636@example.com', '2006-04-23', '2024-07-29 00:00:29', 'John', 'Brown', '+14375327'),
(354, 'user899456', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 1, 'New York', 'Male', 'user479603@example.com', '2003-08-31', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+12372617'),
(355, 'user728338', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 2, 'Florida', 'Female', 'user567216@example.com', '2020-06-24', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+13903616'),
(356, 'user765403', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 4, 'New York', 'Male', 'user054852@example.com', '2008-08-26', '2024-07-29 00:00:29', 'Joe', 'Jones', '+19058000'),
(357, 'user926623', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 4, 'Texas', 'Female', 'user153155@example.com', '2014-11-29', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+15722791'),
(358, 'user817437', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 1, 'Texas', 'Female', 'user588785@example.com', '2010-08-12', '2024-07-29 00:00:29', 'Jill', 'Brown', '+11768774'),
(359, 'user396328', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 3, 'Texas', 'Male', 'user891031@example.com', '2000-01-23', '2024-07-29 00:00:29', 'Jim', 'Brown', '+14616479'),
(360, 'user217267', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 2, 'Illinois', 'Female', 'user489481@example.com', '2018-07-06', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19867432'),
(361, 'user178210', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 3, 3, 'Illinois', 'Female', 'user175534@example.com', '2002-09-03', '2024-07-29 00:00:29', 'John', 'Doe', '+10066426'),
(362, 'user878931', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'Florida', 'Male', 'user077933@example.com', '2003-06-17', '2024-07-29 00:00:29', 'Jill', 'Smith', '+18625377'),
(363, 'user394372', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 2, 'Florida', 'Male', 'user630640@example.com', '2000-01-31', '2024-07-29 00:00:29', 'John', 'Williams', '+17407842'),
(364, 'user830514', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 3, 'Florida', 'Male', 'user430946@example.com', '2015-11-01', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+12398915'),
(365, 'user875883', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 2, 4, 'California', 'Male', 'user569862@example.com', '2011-09-01', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+19989714'),
(366, 'user478110', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 2, 4, 'Florida', 'Male', 'user596075@example.com', '2010-11-21', '2024-07-29 00:00:29', 'Joe', 'Jones', '+18954138'),
(367, 'user483601', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 3, 'Texas', 'Female', 'user258899@example.com', '2015-04-28', '2024-07-29 00:00:29', 'Joe', 'Williams', '+13688007'),
(368, 'user324933', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 2, 4, 'California', 'Male', 'user162751@example.com', '2010-02-06', '2024-07-29 00:00:29', 'Joe', 'Brown', '+10717817'),
(369, 'user243956', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 2, 2, 'California', 'Male', 'user527469@example.com', '2004-06-07', '2024-07-29 00:00:29', 'Jim', 'Williams', '+14186481'),
(370, 'user468442', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 3, 2, 'Florida', 'Male', 'user943719@example.com', '2012-01-31', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+11207331'),
(371, 'user662511', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 3, 3, 'Illinois', 'Female', 'user009801@example.com', '2018-10-09', '2024-07-29 00:00:29', 'Jane', 'Brown', '+17733516'),
(372, 'user742177', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 1, 'California', 'Male', 'user079314@example.com', '2016-07-14', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+14866456'),
(373, 'user174879', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 2, 4, 'Florida', 'Female', 'user354195@example.com', '2003-03-05', '2024-07-29 00:00:29', 'Jill', 'Jones', '+13970967'),
(374, 'user354975', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 1, 'Texas', 'Female', 'user249839@example.com', '2012-05-04', '2024-07-29 00:00:29', 'John', 'Williams', '+10343368'),
(375, 'user229545', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 1, 'Illinois', 'Male', 'user633615@example.com', '2000-07-17', '2024-07-29 00:00:29', 'Jane', 'Doe', '+15441859'),
(376, 'user592096', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 1, 1, 'California', 'Female', 'user108110@example.com', '2013-03-14', '2024-07-29 00:00:29', 'Joe', 'Williams', '+11163865'),
(377, 'user672054', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 3, 'New York', 'Female', 'user708363@example.com', '2015-04-28', '2024-07-29 00:00:29', 'Jim', 'Brown', '+17122420'),
(378, 'user262416', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 2, 'Illinois', 'Female', 'user405693@example.com', '2002-05-15', '2024-07-29 00:00:29', 'Jane', 'Smith', '+15061051'),
(379, 'user643534', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 3, 4, 'Florida', 'Male', 'user381117@example.com', '2003-02-12', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+13605385'),
(380, 'user564102', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 4, 'Texas', 'Male', 'user212925@example.com', '2003-03-04', '2024-07-29 00:00:29', 'John', 'Jones', '+17017168'),
(381, 'user534265', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 3, 'California', 'Female', 'user751721@example.com', '2021-02-17', '2024-07-29 00:00:29', 'Jill', 'Jones', '+10421387'),
(382, 'user361529', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 2, 4, 'Texas', 'Male', 'user084902@example.com', '2006-12-03', '2024-07-29 00:00:29', 'Jane', 'Brown', '+14267631'),
(383, 'user091252', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 2, 3, 'Illinois', 'Female', 'user838905@example.com', '2020-11-03', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+10306111'),
(384, 'user100722', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 2, 'Florida', 'Male', 'user575889@example.com', '2009-12-10', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+11206003'),
(385, 'user554510', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 2, 'Illinois', 'Female', 'user803083@example.com', '2008-10-24', '2024-07-29 00:00:29', 'Jill', 'Brown', '+12294603'),
(386, 'user724205', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 4, 'New York', 'Female', 'user118564@example.com', '2000-07-23', '2024-07-29 00:00:29', 'Joe', 'Brown', '+16030924'),
(387, 'user663801', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 3, 'California', 'Female', 'user307760@example.com', '2013-08-13', '2024-07-29 00:00:29', 'Jane', 'Doe', '+17432269'),
(388, 'user537380', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 4, 'Illinois', 'Male', 'user187424@example.com', '2019-07-21', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+14308904'),
(389, 'user674240', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 4, 'Illinois', 'Female', 'user724573@example.com', '2018-10-25', '2024-07-29 00:00:29', 'John', 'Doe', '+17889185'),
(390, 'user852392', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 4, 'California', 'Female', 'user753238@example.com', '2016-03-31', '2024-07-29 00:00:29', 'Jim', 'Doe', '+17627532'),
(391, 'user746881', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 1, 'Florida', 'Female', 'user155754@example.com', '2008-04-30', '2024-07-29 00:00:29', 'Jim', 'Doe', '+18462922'),
(392, 'user142288', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 1, 'New York', 'Male', 'user571230@example.com', '2010-02-22', '2024-07-29 00:00:29', 'Jill', 'Williams', '+12971768'),
(393, 'user623954', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 3, 'Texas', 'Male', 'user988445@example.com', '2013-04-17', '2024-07-29 00:00:29', 'John', 'Williams', '+14161587'),
(394, 'user506788', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 3, 'California', 'Female', 'user989599@example.com', '2003-11-15', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+14804477'),
(395, 'user266795', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 2, 1, 'New York', 'Female', 'user242576@example.com', '2003-11-06', '2024-07-29 00:00:29', 'John', 'Smith', '+16853040'),
(396, 'user743585', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 4, 'Illinois', 'Female', 'user319955@example.com', '2006-05-13', '2024-07-29 00:00:29', 'Jim', 'Williams', '+14875785'),
(397, 'user657929', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 1, 'Florida', 'Male', 'user321740@example.com', '2007-12-08', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+11877840'),
(398, 'user502554', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 1, 'New York', 'Male', 'user475193@example.com', '2007-05-26', '2024-07-29 00:00:29', 'Jane', 'Smith', '+17275047'),
(399, 'user726934', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 1, 4, 'Florida', 'Female', 'user973795@example.com', '2007-02-03', '2024-07-29 00:00:29', 'Joe', 'Williams', '+14928372'),
(400, 'user912557', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 1, 4, 'California', 'Female', 'user925619@example.com', '2016-11-12', '2024-07-29 00:00:29', 'John', 'Doe', '+10634614'),
(401, 'user147163', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 1, 'New York', 'Male', 'user539407@example.com', '2011-05-28', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+18591498'),
(402, 'user207371', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 4, 'Florida', 'Male', 'user173201@example.com', '2011-07-23', '2024-07-29 00:00:29', 'John', 'Doe', '+16999217'),
(403, 'user465670', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 4, 'Florida', 'Female', 'user350581@example.com', '2020-09-17', '2024-07-29 00:00:29', 'Joe', 'Williams', '+16967862'),
(404, 'user848299', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 2, 2, 'New York', 'Male', 'user561206@example.com', '2008-04-09', '2024-07-29 00:00:29', 'Jane', 'Jones', '+18462522'),
(405, 'user554310', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 3, 3, 'California', 'Female', 'user198618@example.com', '2005-07-04', '2024-07-29 00:00:29', 'Jill', 'Williams', '+17724215'),
(406, 'user208760', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 1, 'Florida', 'Female', 'user832801@example.com', '2010-07-04', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+16003894'),
(407, 'user822130', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 1, 'California', 'Female', 'user873264@example.com', '2012-02-12', '2024-07-29 00:00:29', 'John', 'Doe', '+19176396'),
(408, 'user374528', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 3, 'California', 'Male', 'user165500@example.com', '2007-01-03', '2024-07-29 00:00:29', 'John', 'Williams', '+14691966'),
(409, 'user678904', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 2, 4, 'New York', 'Female', 'user413629@example.com', '2002-08-12', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+10326886'),
(410, 'user903848', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 2, 'Florida', 'Male', 'user266892@example.com', '2012-08-19', '2024-07-29 00:00:29', 'John', 'Brown', '+11795522'),
(411, 'user840195', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 2, 'Texas', 'Female', 'user519787@example.com', '2006-09-22', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+18697133'),
(412, 'user469579', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 1, 'California', 'Male', 'user216348@example.com', '2021-05-04', '2024-07-29 00:00:29', 'Jane', 'Smith', '+12840473'),
(413, 'user848959', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 2, 'Florida', 'Male', 'user081962@example.com', '2004-06-12', '2024-07-29 00:00:29', 'Joe', 'Smith', '+18849775'),
(414, 'user708598', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 3, 3, 'California', 'Female', 'user881915@example.com', '2017-07-20', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+19203025'),
(415, 'user399669', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 1, 1, 'California', 'Female', 'user890529@example.com', '2020-09-06', '2024-07-29 00:00:29', 'John', 'Johnson', '+19290708'),
(416, 'user398495', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 2, 1, 'California', 'Male', 'user428898@example.com', '2004-05-02', '2024-07-29 00:00:29', 'Joe', 'Jones', '+14989364'),
(417, 'user729728', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 2, 'New York', 'Female', 'user870492@example.com', '2017-07-17', '2024-07-29 00:00:29', 'Jim', 'Williams', '+16313029'),
(418, 'user470452', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 2, 'California', 'Male', 'user130585@example.com', '2006-01-17', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+16025947'),
(419, 'user672461', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 2, 'New York', 'Female', 'user803811@example.com', '2010-04-17', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+15886445'),
(420, 'user101546', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 4, 'Texas', 'Female', 'user471078@example.com', '2009-12-14', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+10746637'),
(421, 'user582948', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 1, 'California', 'Male', 'user107595@example.com', '2004-03-26', '2024-07-29 00:00:29', 'Jill', 'Williams', '+12651215'),
(422, 'user407573', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 1, 1, 'New York', 'Female', 'user480771@example.com', '2005-12-04', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+19675125'),
(423, 'user618633', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 2, 'Florida', 'Male', 'user244775@example.com', '2019-08-11', '2024-07-29 00:00:29', 'Joe', 'Doe', '+18977658'),
(424, 'user414309', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 1, 3, 'Florida', 'Male', 'user939041@example.com', '2013-03-27', '2024-07-29 00:00:29', 'Jane', 'Smith', '+14345215'),
(425, 'user543757', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 3, 'Illinois', 'Female', 'user436396@example.com', '2008-05-08', '2024-07-29 00:00:29', 'Jill', 'Jones', '+14236877'),
(426, 'user588844', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 3, 1, 'Texas', 'Male', 'user725370@example.com', '2019-06-30', '2024-07-29 00:00:29', 'Jane', 'Brown', '+16807903'),
(427, 'user301981', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 2, 'New York', 'Male', 'user202866@example.com', '2000-03-02', '2024-07-29 00:00:29', 'Jim', 'Doe', '+13380955'),
(428, 'user314198', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 1, 'New York', 'Male', 'user974083@example.com', '2000-06-25', '2024-07-29 00:00:29', 'Jane', 'Jones', '+18100739'),
(429, 'user425467', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 1, 'Illinois', 'Female', 'user800787@example.com', '2008-02-12', '2024-07-29 00:00:29', 'Jim', 'Doe', '+13501996'),
(430, 'user330187', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 1, 1, 'Texas', 'Male', 'user984253@example.com', '2011-12-22', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19711169'),
(431, 'user068023', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 1, 'New York', 'Female', 'user754159@example.com', '2018-02-13', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+18237230'),
(432, 'user450692', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 3, 'Texas', 'Female', 'user654145@example.com', '2016-08-14', '2024-07-29 00:00:29', 'Joe', 'Jones', '+19158241'),
(433, 'user932487', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 2, 'Texas', 'Male', 'user499352@example.com', '2021-02-24', '2024-07-29 00:00:29', 'Jane', 'Brown', '+17819035'),
(434, 'user645799', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 2, 'California', 'Male', 'user324564@example.com', '2001-01-03', '2024-07-29 00:00:29', 'Jane', 'Doe', '+19514531'),
(435, 'user324785', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 3, 'New York', 'Female', 'user067046@example.com', '2012-02-22', '2024-07-29 00:00:29', 'Jill', 'Smith', '+12422453'),
(436, 'user638395', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 1, 'California', 'Female', 'user544458@example.com', '2003-12-25', '2024-07-29 00:00:29', 'Jane', 'Jones', '+13396049'),
(437, 'user197866', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 1, 'Texas', 'Male', 'user996376@example.com', '2021-10-11', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+17021485'),
(438, 'user720760', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'New York', 'Female', 'user875534@example.com', '2009-10-21', '2024-07-29 00:00:29', 'Jill', 'Brown', '+17408117'),
(439, 'user558670', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 2, 'California', 'Male', 'user771746@example.com', '2019-05-19', '2024-07-29 00:00:29', 'John', 'Jones', '+11202181'),
(440, 'user933239', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 2, 'Illinois', 'Female', 'user381700@example.com', '2019-06-27', '2024-07-29 00:00:29', 'Jane', 'Jones', '+13293934'),
(441, 'user103202', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 2, 'Texas', 'Male', 'user353402@example.com', '2015-07-11', '2024-07-29 00:00:29', 'Jim', 'Smith', '+10136653'),
(442, 'user189089', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 2, 'New York', 'Female', 'user023792@example.com', '2014-03-27', '2024-07-29 00:00:29', 'Jane', 'Jones', '+11707749'),
(443, 'user030734', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 4, 'Texas', 'Male', 'user641104@example.com', '2000-08-13', '2024-07-29 00:00:29', 'Jane', 'Doe', '+13614401'),
(444, 'user798942', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 4, 'Florida', 'Female', 'user977174@example.com', '2020-04-20', '2024-07-29 00:00:29', 'Joe', 'Brown', '+15686364'),
(445, 'user636012', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 1, 'Florida', 'Male', 'user612498@example.com', '2015-04-17', '2024-07-29 00:00:29', 'Jill', 'Smith', '+19020546'),
(446, 'user992926', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 3, 1, 'Florida', 'Female', 'user716801@example.com', '2018-06-10', '2024-07-29 00:00:29', 'John', 'Brown', '+16807522'),
(447, 'user088071', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 1, 'Florida', 'Female', 'user800265@example.com', '2004-10-25', '2024-07-29 00:00:29', 'Joe', 'Jones', '+10821518'),
(448, 'user902932', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 2, 4, 'California', 'Male', 'user657979@example.com', '2018-07-01', '2024-07-29 00:00:29', 'Jane', 'Brown', '+18026594'),
(449, 'user884120', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 4, 'New York', 'Male', 'user436134@example.com', '2021-06-18', '2024-07-29 00:00:29', 'Jill', 'Doe', '+13069057'),
(450, 'user486289', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 2, 'California', 'Male', 'user158100@example.com', '2003-07-19', '2024-07-29 00:00:29', 'Jim', 'Smith', '+19473872'),
(451, 'user165002', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 2, 'Illinois', 'Male', 'user922148@example.com', '2011-07-28', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+13334044'),
(452, 'user291246', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 1, 'Texas', 'Male', 'user641128@example.com', '2011-03-05', '2024-07-29 00:00:29', 'Jill', 'Williams', '+11478168'),
(453, 'user921323', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 3, 3, 'New York', 'Female', 'user070968@example.com', '2004-12-29', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+19876211'),
(454, 'user075669', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 2, 'California', 'Male', 'user935560@example.com', '2009-12-15', '2024-07-29 00:00:29', 'Jim', 'Jones', '+14406512'),
(455, 'user299431', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 2, 4, 'California', 'Female', 'user830230@example.com', '2006-01-11', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+13627569'),
(456, 'user001252', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 1, 1, 'New York', 'Male', 'user323552@example.com', '2005-04-20', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+16424064');
INSERT INTO `students` (`student_id`, `username`, `password`, `fname`, `lname`, `grade`, `section`, `address`, `gender`, `email_address`, `date_of_birth`, `date_of_joined`, `parent_fname`, `parent_lname`, `parent_phone_number`) VALUES
(457, 'user795121', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 1, 'New York', 'Female', 'user193087@example.com', '2007-02-08', '2024-07-29 00:00:29', 'John', 'Smith', '+10762003'),
(458, 'user658166', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 2, 'Illinois', 'Female', 'user163281@example.com', '2020-08-24', '2024-07-29 00:00:29', 'Jane', 'Smith', '+17806294'),
(459, 'user032122', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 3, 'Florida', 'Female', 'user592117@example.com', '2007-06-07', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+11585417'),
(460, 'user040863', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 3, 'California', 'Male', 'user639987@example.com', '2002-07-04', '2024-07-29 00:00:29', 'Jill', 'Jones', '+16322104'),
(461, 'user407737', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 3, 'Illinois', 'Female', 'user950397@example.com', '2012-06-10', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+12401339'),
(462, 'user476132', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 2, 'California', 'Female', 'user187741@example.com', '2008-09-09', '2024-07-29 00:00:29', 'Jim', 'Jones', '+13087983'),
(463, 'user800962', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 3, 3, 'Florida', 'Male', 'user772040@example.com', '2003-07-03', '2024-07-29 00:00:29', 'Jim', 'Jones', '+12397506'),
(464, 'user384449', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 4, 'Texas', 'Female', 'user407105@example.com', '2008-01-15', '2024-07-29 00:00:29', 'Jill', 'Jones', '+10017151'),
(465, 'user102378', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 2, 'New York', 'Male', 'user040374@example.com', '2009-06-04', '2024-07-29 00:00:29', 'John', 'Jones', '+12141145'),
(466, 'user487395', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 1, 2, 'New York', 'Female', 'user307055@example.com', '2021-05-19', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+14697617'),
(467, 'user739590', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 1, 3, 'California', 'Female', 'user025193@example.com', '2008-11-16', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+18420644'),
(468, 'user593302', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 3, 'Illinois', 'Female', 'user890871@example.com', '2011-06-07', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+17848849'),
(469, 'user566919', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 1, 'Florida', 'Male', 'user275442@example.com', '2002-05-09', '2024-07-29 00:00:29', 'Joe', 'Smith', '+10252083'),
(470, 'user431572', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 2, 2, 'Florida', 'Male', 'user068678@example.com', '2016-07-30', '2024-07-29 00:00:29', 'Jill', 'Williams', '+13730651'),
(471, 'user000218', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 4, 'Florida', 'Female', 'user441562@example.com', '2013-03-20', '2024-07-29 00:00:29', 'Joe', 'Williams', '+11835803'),
(472, 'user961240', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 4, 'Texas', 'Male', 'user246207@example.com', '2015-12-30', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+11271722'),
(473, 'user516533', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 3, 1, 'New York', 'Male', 'user015575@example.com', '2007-12-15', '2024-07-29 00:00:29', 'Joe', 'Brown', '+14804632'),
(474, 'user128924', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 2, 4, 'California', 'Female', 'user372104@example.com', '2007-10-06', '2024-07-29 00:00:29', 'Jill', 'Smith', '+11116075'),
(475, 'user910600', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 3, 'Florida', 'Female', 'user296537@example.com', '2009-03-11', '2024-07-29 00:00:29', 'Jane', 'Brown', '+12975167'),
(476, 'user133313', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 3, 'Texas', 'Female', 'user750999@example.com', '2014-06-27', '2024-07-29 00:00:29', 'John', 'Smith', '+12666746'),
(477, 'user476200', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 4, 'Illinois', 'Male', 'user397109@example.com', '2007-01-29', '2024-07-29 00:00:29', 'Jim', 'Doe', '+14918395'),
(478, 'user999963', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 2, 4, 'Texas', 'Female', 'user710123@example.com', '2002-07-23', '2024-07-29 00:00:29', 'Jim', 'Jones', '+12267944'),
(479, 'user381463', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 1, 2, 'New York', 'Male', 'user428788@example.com', '2002-05-30', '2024-07-29 00:00:29', 'Jane', 'Jones', '+11597906'),
(480, 'user827605', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 4, 'Texas', 'Female', 'user240259@example.com', '2020-01-29', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+12257430'),
(481, 'user440714', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 4, 'Florida', 'Female', 'user039457@example.com', '2007-12-28', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+10549242'),
(482, 'user971241', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 3, 'Illinois', 'Male', 'user087508@example.com', '2017-06-15', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19355513'),
(483, 'user016339', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 3, 1, 'Illinois', 'Male', 'user640731@example.com', '2002-06-26', '2024-07-29 00:00:29', 'Jill', 'Jones', '+14939291'),
(484, 'user811765', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 1, 'Florida', 'Female', 'user814762@example.com', '2008-10-25', '2024-07-29 00:00:29', 'Jill', 'Williams', '+14703293'),
(485, 'user445989', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 1, 2, 'Illinois', 'Male', 'user144798@example.com', '2006-11-07', '2024-07-29 00:00:29', 'John', 'Brown', '+11597887'),
(486, 'user669736', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 2, 'Florida', 'Male', 'user113327@example.com', '2019-05-11', '2024-07-29 00:00:29', 'John', 'Brown', '+14821245'),
(487, 'user179046', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 4, 'Texas', 'Male', 'user830187@example.com', '2005-08-01', '2024-07-29 00:00:29', 'Joe', 'Doe', '+14323152'),
(488, 'user690228', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 1, 1, 'California', 'Male', 'user334464@example.com', '2005-03-21', '2024-07-29 00:00:29', 'Jane', 'Smith', '+15683143'),
(489, 'user161567', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 3, 1, 'New York', 'Female', 'user146688@example.com', '2003-11-27', '2024-07-29 00:00:29', 'Jim', 'Brown', '+12598549'),
(490, 'user130515', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 2, 'Illinois', 'Male', 'user191144@example.com', '2019-05-18', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+14329885'),
(491, 'user374838', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 4, 'Texas', 'Male', 'user047867@example.com', '2017-12-21', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+17927241'),
(492, 'user961546', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 2, 'Florida', 'Male', 'user078235@example.com', '2017-01-06', '2024-07-29 00:00:29', 'Jill', 'Jones', '+16412430'),
(493, 'user451908', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 2, 1, 'Texas', 'Female', 'user049170@example.com', '2013-07-18', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+15120758'),
(494, 'user952171', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 2, 'Texas', 'Male', 'user647486@example.com', '2003-02-04', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+16877942'),
(495, 'user251173', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 3, 'New York', 'Female', 'user491677@example.com', '2015-07-05', '2024-07-29 00:00:29', 'John', 'Smith', '+18133469'),
(496, 'user461399', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 4, 'New York', 'Female', 'user285584@example.com', '2006-07-26', '2024-07-29 00:00:29', 'Jill', 'Smith', '+16361686'),
(497, 'user242743', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 4, 'Florida', 'Male', 'user685322@example.com', '2009-10-05', '2024-07-29 00:00:29', 'Jane', 'Williams', '+11109251'),
(498, 'user977445', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 1, 'New York', 'Female', 'user948276@example.com', '2004-09-14', '2024-07-29 00:00:29', 'Jane', 'Williams', '+18225983'),
(499, 'user606656', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 3, 'California', 'Female', 'user285874@example.com', '2016-09-02', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+14450900'),
(500, 'user851431', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 2, 2, 'California', 'Female', 'user888216@example.com', '2021-11-23', '2024-07-29 00:00:29', 'Jim', 'Brown', '+13458067'),
(501, 'user720941', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 2, 2, 'Texas', 'Female', 'user492561@example.com', '2021-04-29', '2024-07-29 00:00:29', 'Jim', 'Doe', '+19874159'),
(502, 'user841638', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 4, 'Florida', 'Male', 'user678886@example.com', '2019-05-13', '2024-07-29 00:00:29', 'Jim', 'Smith', '+11775523'),
(503, 'user090832', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 3, 'New York', 'Male', 'user968830@example.com', '2014-03-06', '2024-07-29 00:00:29', 'Jane', 'Brown', '+15468725'),
(504, 'user612585', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'New York', 'Female', 'user686926@example.com', '2012-08-10', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+13542310'),
(505, 'user686731', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 4, 'New York', 'Male', 'user375052@example.com', '2000-11-08', '2024-07-29 00:00:29', 'John', 'Smith', '+19623924'),
(506, 'user107781', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 4, 'Illinois', 'Female', 'user461649@example.com', '2020-02-23', '2024-07-29 00:00:29', 'Jane', 'Smith', '+19184006'),
(507, 'user655076', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 2, 1, 'New York', 'Female', 'user508362@example.com', '2007-05-08', '2024-07-29 00:00:29', 'John', 'Brown', '+13281917'),
(508, 'user368979', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 2, 'Florida', 'Male', 'user010597@example.com', '2016-09-22', '2024-07-29 00:00:29', 'Joe', 'Williams', '+18504292'),
(509, 'user325970', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 4, 'California', 'Male', 'user831819@example.com', '2005-05-13', '2024-07-29 00:00:29', 'Joe', 'Jones', '+13693668'),
(510, 'user112565', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 4, 'Illinois', 'Male', 'user287168@example.com', '2018-06-03', '2024-07-29 00:00:29', 'Jim', 'Smith', '+19459473'),
(511, 'user143492', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 1, 'Illinois', 'Male', 'user728369@example.com', '2009-08-17', '2024-07-29 00:00:29', 'John', 'Brown', '+16898521'),
(512, 'user212121', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 1, 'Illinois', 'Female', 'user241608@example.com', '2005-11-16', '2024-07-29 00:00:29', 'Jill', 'Smith', '+15432426'),
(513, 'user880167', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 1, 'Texas', 'Male', 'user336951@example.com', '2002-07-23', '2024-07-29 00:00:29', 'Jill', 'Williams', '+18584726'),
(514, 'user745497', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 1, 1, 'Florida', 'Female', 'user406855@example.com', '2006-01-14', '2024-07-29 00:00:29', 'John', 'Jones', '+13405209'),
(515, 'user813871', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 4, 'Texas', 'Male', 'user697166@example.com', '2021-11-11', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+18142827'),
(516, 'user563907', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 3, 3, 'California', 'Male', 'user225917@example.com', '2021-01-17', '2024-07-29 00:00:29', 'John', 'Brown', '+13793400'),
(517, 'user640534', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 4, 'Illinois', 'Female', 'user598405@example.com', '2009-05-27', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+12899518'),
(518, 'user043363', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 1, 'Texas', 'Male', 'user576241@example.com', '2012-01-04', '2024-07-29 00:00:29', 'John', 'Johnson', '+10529303'),
(519, 'user010241', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 1, 'New York', 'Male', 'user209652@example.com', '2017-01-14', '2024-07-29 00:00:29', 'Jane', 'Jones', '+10647371'),
(520, 'user415743', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 1, 3, 'California', 'Female', 'user228121@example.com', '2006-09-28', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+11868592'),
(521, 'user883658', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 2, 1, 'Illinois', 'Male', 'user764498@example.com', '2018-03-09', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+14186992'),
(522, 'user698143', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 1, 'Illinois', 'Male', 'user564677@example.com', '2019-11-08', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+18395890'),
(523, 'user785821', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 1, 'Illinois', 'Female', 'user360158@example.com', '2017-12-13', '2024-07-29 00:00:29', 'John', 'Williams', '+10831943'),
(524, 'user535302', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 2, 1, 'New York', 'Female', 'user726619@example.com', '2019-10-12', '2024-07-29 00:00:29', 'Jim', 'Jones', '+18377186'),
(525, 'user281797', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 2, 3, 'New York', 'Female', 'user250040@example.com', '2012-01-20', '2024-07-29 00:00:29', 'John', 'Johnson', '+17741260'),
(526, 'user803834', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 1, 'Illinois', 'Male', 'user568864@example.com', '2015-02-18', '2024-07-29 00:00:29', 'Joe', 'Brown', '+10940893'),
(527, 'user467415', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 2, 'California', 'Female', 'user124568@example.com', '2017-02-07', '2024-07-29 00:00:29', 'Jill', 'Smith', '+19648872'),
(528, 'user889987', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 1, 'Texas', 'Male', 'user981342@example.com', '2001-11-21', '2024-07-29 00:00:29', 'Jim', 'Smith', '+14309382'),
(529, 'user618579', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 1, 'Illinois', 'Male', 'user920899@example.com', '2003-07-27', '2024-07-29 00:00:29', 'John', 'Brown', '+16964737'),
(530, 'user171209', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 3, 'Florida', 'Male', 'user688882@example.com', '2019-01-20', '2024-07-29 00:00:29', 'Jane', 'Brown', '+11747536'),
(531, 'user459734', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 1, 'Florida', 'Female', 'user227084@example.com', '2011-05-27', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+14644542'),
(532, 'user184925', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 2, 'Texas', 'Male', 'user870455@example.com', '2021-06-09', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+15347439'),
(533, 'user244246', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 3, 2, 'Florida', 'Male', 'user912247@example.com', '2019-03-23', '2024-07-29 00:00:29', 'Jill', 'Williams', '+11682097'),
(534, 'user967428', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 3, 'California', 'Male', 'user105344@example.com', '2020-12-21', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+10190310'),
(535, 'user634219', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 4, 'Illinois', 'Male', 'user661446@example.com', '2020-07-05', '2024-07-29 00:00:29', 'Joe', 'Brown', '+13004733'),
(536, 'user466488', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 1, 'California', 'Male', 'user087002@example.com', '2016-11-23', '2024-07-29 00:00:29', 'Jill', 'Williams', '+15402076'),
(537, 'user704186', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 1, 'Texas', 'Female', 'user945954@example.com', '2004-05-29', '2024-07-29 00:00:29', 'Jane', 'Smith', '+16956957'),
(538, 'user757024', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 2, 'Florida', 'Female', 'user120885@example.com', '2012-12-26', '2024-07-29 00:00:29', 'Jill', 'Smith', '+13522466'),
(539, 'user066075', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 1, 3, 'New York', 'Female', 'user375935@example.com', '2006-07-21', '2024-07-29 00:00:29', 'Jim', 'Jones', '+16061118'),
(540, 'user204726', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 4, 'Florida', 'Male', 'user747408@example.com', '2008-03-16', '2024-07-29 00:00:29', 'Jill', 'Doe', '+12670316'),
(541, 'user238693', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'Texas', 'Female', 'user140369@example.com', '2013-03-11', '2024-07-29 00:00:29', 'Jill', 'Doe', '+19503038'),
(542, 'user318993', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 3, 'Texas', 'Male', 'user441038@example.com', '2017-10-06', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19476010'),
(543, 'user050997', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 4, 'New York', 'Female', 'user203384@example.com', '2008-11-27', '2024-07-29 00:00:29', 'Jim', 'Jones', '+12107596'),
(544, 'user365542', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 2, 'Florida', 'Male', 'user963396@example.com', '2010-08-01', '2024-07-29 00:00:29', 'Jill', 'Smith', '+13144740'),
(545, 'user037734', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 4, 'Texas', 'Male', 'user028949@example.com', '2002-12-01', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+17442959'),
(546, 'user232338', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 4, 'Florida', 'Female', 'user084471@example.com', '2012-08-12', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+11363950'),
(547, 'user473088', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 3, 'California', 'Female', 'user838882@example.com', '2012-11-16', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+14864693'),
(548, 'user379120', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 2, 'California', 'Female', 'user555984@example.com', '2004-07-19', '2024-07-29 00:00:29', 'Jim', 'Smith', '+10327992'),
(549, 'user477685', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 1, 'Texas', 'Male', 'user225643@example.com', '2002-09-24', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+19484591'),
(550, 'user669922', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 3, 'California', 'Male', 'user386378@example.com', '2012-02-02', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+19357189'),
(551, 'user635919', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 2, 'New York', 'Male', 'user845236@example.com', '2012-02-20', '2024-07-29 00:00:29', 'Jane', 'Williams', '+18672601'),
(552, 'user792055', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 1, 4, 'Illinois', 'Male', 'user854778@example.com', '2021-01-02', '2024-07-29 00:00:29', 'Jane', 'Smith', '+16924270'),
(553, 'user631217', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 1, 4, 'California', 'Male', 'user956292@example.com', '2004-07-10', '2024-07-29 00:00:29', 'John', 'Smith', '+15085539'),
(554, 'user942514', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 3, 'Illinois', 'Male', 'user982976@example.com', '2009-06-24', '2024-07-29 00:00:29', 'Jane', 'Brown', '+12448781'),
(555, 'user889832', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 1, 'Florida', 'Female', 'user799048@example.com', '2016-10-02', '2024-07-29 00:00:29', 'Jim', 'Jones', '+19325580'),
(556, 'user133613', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 4, 'Illinois', 'Female', 'user026563@example.com', '2006-01-11', '2024-07-29 00:00:29', 'Jane', 'Williams', '+14068679'),
(557, 'user055340', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 2, 3, 'New York', 'Female', 'user625416@example.com', '2014-01-29', '2024-07-29 00:00:29', 'Jim', 'Brown', '+17914334'),
(558, 'user674079', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 1, 'California', 'Male', 'user312752@example.com', '2009-11-19', '2024-07-29 00:00:29', 'Jane', 'Smith', '+12333569'),
(559, 'user453790', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 3, 1, 'California', 'Male', 'user126573@example.com', '2007-06-19', '2024-07-29 00:00:29', 'Jane', 'Williams', '+10231987'),
(560, 'user318271', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 3, 3, 'Florida', 'Female', 'user838126@example.com', '2018-05-18', '2024-07-29 00:00:29', 'Joe', 'Jones', '+13955075'),
(561, 'user314466', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 3, 4, 'New York', 'Male', 'user369302@example.com', '2006-10-29', '2024-07-29 00:00:29', 'Jim', 'Smith', '+12311111'),
(562, 'user206431', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 2, 3, 'Florida', 'Male', 'user941853@example.com', '2013-03-14', '2024-07-29 00:00:29', 'Jane', 'Doe', '+10889896'),
(563, 'user053753', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 3, 'Texas', 'Male', 'user818119@example.com', '2009-11-05', '2024-07-29 00:00:29', 'Joe', 'Williams', '+17165937'),
(564, 'user724412', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 2, 1, 'Florida', 'Male', 'user693596@example.com', '2008-05-09', '2024-07-29 00:00:29', 'Joe', 'Jones', '+14582247'),
(565, 'user328764', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 3, 4, 'California', 'Male', 'user387390@example.com', '2000-04-16', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+17005942'),
(566, 'user054362', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 3, 'New York', 'Female', 'user596391@example.com', '2007-05-17', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+16208772'),
(567, 'user722432', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 3, 'Florida', 'Female', 'user755679@example.com', '2011-07-26', '2024-07-29 00:00:29', 'Jim', 'Smith', '+12890207'),
(568, 'user599994', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 3, 1, 'California', 'Female', 'user556809@example.com', '2013-02-11', '2024-07-29 00:00:29', 'Jane', 'Brown', '+11331889'),
(569, 'user203923', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 2, 'Texas', 'Male', 'user932826@example.com', '2009-07-15', '2024-07-29 00:00:29', 'Jim', 'Williams', '+17951783'),
(570, 'user217568', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 2, 'California', 'Male', 'user802916@example.com', '2015-07-02', '2024-07-29 00:00:29', 'John', 'Williams', '+12365139'),
(571, 'user607346', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 4, 'Florida', 'Female', 'user040365@example.com', '2005-11-07', '2024-07-29 00:00:29', 'Jane', 'Smith', '+17139341'),
(572, 'user755047', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 2, 'Illinois', 'Male', 'user354260@example.com', '2012-05-01', '2024-07-29 00:00:29', 'Joe', 'Doe', '+11124821'),
(573, 'user340106', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 1, 'Texas', 'Female', 'user884747@example.com', '2005-10-12', '2024-07-29 00:00:29', 'Jill', 'Williams', '+16793594'),
(574, 'user791510', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 1, 'Texas', 'Male', 'user991756@example.com', '2015-03-05', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+13574287'),
(575, 'user693221', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 3, 'Texas', 'Female', 'user199727@example.com', '2008-02-09', '2024-07-29 00:00:29', 'Jane', 'Doe', '+19808105'),
(576, 'user462880', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 1, 4, 'California', 'Female', 'user923366@example.com', '2010-06-03', '2024-07-29 00:00:29', 'Jill', 'Williams', '+12631868'),
(577, 'user461586', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 4, 'Texas', 'Female', 'user461697@example.com', '2008-09-28', '2024-07-29 00:00:29', 'Jill', 'Jones', '+14490936'),
(578, 'user676651', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 2, 4, 'Illinois', 'Male', 'user715707@example.com', '2008-06-21', '2024-07-29 00:00:29', 'Joe', 'Brown', '+15126205'),
(579, 'user238836', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 3, 3, 'California', 'Male', 'user264066@example.com', '2002-03-21', '2024-07-29 00:00:29', 'Joe', 'Smith', '+11967156'),
(580, 'user179656', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 2, 'Illinois', 'Female', 'user908484@example.com', '2020-01-02', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+17989189'),
(581, 'user601796', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 2, 'Illinois', 'Male', 'user888092@example.com', '2002-05-28', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+18149304'),
(582, 'user793379', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 1, 'Texas', 'Male', 'user880022@example.com', '2002-03-10', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+14075397'),
(583, 'user046335', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 4, 'Texas', 'Male', 'user953424@example.com', '2010-11-10', '2024-07-29 00:00:29', 'Jill', 'Williams', '+11789927'),
(584, 'user073480', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 1, 'Florida', 'Male', 'user816115@example.com', '2020-05-07', '2024-07-29 00:00:29', 'Jane', 'Smith', '+13926056'),
(585, 'user373372', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 2, 4, 'Texas', 'Female', 'user737410@example.com', '2019-11-30', '2024-07-29 00:00:29', 'Jim', 'Jones', '+16996925'),
(586, 'user678358', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 1, 'California', 'Female', 'user984648@example.com', '2009-07-10', '2024-07-29 00:00:29', 'Jane', 'Brown', '+13250751'),
(587, 'user233675', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 3, 4, 'Texas', 'Male', 'user946269@example.com', '2000-11-10', '2024-07-29 00:00:29', 'Jim', 'Brown', '+12861758'),
(588, 'user414716', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 2, 1, 'Florida', 'Female', 'user923864@example.com', '2015-02-07', '2024-07-29 00:00:29', 'Joe', 'Smith', '+15345292'),
(589, 'user734625', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 2, 1, 'New York', 'Male', 'user797466@example.com', '2021-05-25', '2024-07-29 00:00:29', 'Jim', 'Williams', '+11821957'),
(590, 'user314981', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 4, 'Illinois', 'Male', 'user383245@example.com', '2017-12-23', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+16851682'),
(591, 'user496746', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 4, 'Texas', 'Male', 'user157953@example.com', '2005-10-10', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+16205057'),
(592, 'user810449', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 1, 3, 'New York', 'Male', 'user218539@example.com', '2006-09-24', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+17759910'),
(593, 'user428195', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 4, 'Texas', 'Male', 'user025592@example.com', '2014-01-19', '2024-07-29 00:00:29', 'John', 'Brown', '+12583646'),
(594, 'user101032', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 2, 3, 'Illinois', 'Female', 'user372782@example.com', '2021-09-22', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+16332922'),
(595, 'user471801', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 2, 'California', 'Male', 'user876554@example.com', '2019-04-09', '2024-07-29 00:00:29', 'Joe', 'Smith', '+17280900'),
(596, 'user018820', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 1, 'Florida', 'Male', 'user774845@example.com', '2005-05-29', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+13208778'),
(597, 'user173437', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 2, 'Texas', 'Male', 'user429541@example.com', '2011-08-23', '2024-07-29 00:00:29', 'Jim', 'Smith', '+11457771'),
(598, 'user977158', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 1, 'Illinois', 'Male', 'user788141@example.com', '2021-10-10', '2024-07-29 00:00:29', 'Jill', 'Doe', '+14250917'),
(599, 'user979190', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 2, 'Florida', 'Female', 'user251428@example.com', '2010-09-21', '2024-07-29 00:00:29', 'Joe', 'Jones', '+19124192'),
(600, 'user566460', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 3, 'Texas', 'Male', 'user860382@example.com', '2013-04-27', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+19913249'),
(601, 'user534325', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 1, 'New York', 'Male', 'user100786@example.com', '2016-03-09', '2024-07-29 00:00:29', 'Jim', 'Brown', '+15545108'),
(602, 'user532960', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 4, 'Florida', 'Male', 'user580203@example.com', '2000-08-05', '2024-07-29 00:00:29', 'Jim', 'Jones', '+12952422'),
(603, 'user786921', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 3, 'Florida', 'Male', 'user233410@example.com', '2016-01-06', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+10625865'),
(604, 'user554649', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 1, 'California', 'Female', 'user349395@example.com', '2000-10-18', '2024-07-29 00:00:29', 'John', 'Williams', '+14027734'),
(605, 'user330876', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 3, 3, 'New York', 'Male', 'user999645@example.com', '2016-05-13', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+10109160'),
(606, 'user720982', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 4, 'Texas', 'Male', 'user221712@example.com', '2000-03-31', '2024-07-29 00:00:29', 'Jim', 'Jones', '+14423816'),
(607, 'user441845', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 3, 3, 'Illinois', 'Male', 'user081432@example.com', '2009-07-07', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+18989822'),
(608, 'user485134', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 1, 'Florida', 'Male', 'user115513@example.com', '2015-03-29', '2024-07-29 00:00:29', 'John', 'Williams', '+14735544'),
(609, 'user645549', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 1, 'New York', 'Male', 'user549137@example.com', '2013-04-22', '2024-07-29 00:00:29', 'Jim', 'Doe', '+14724686'),
(610, 'user976415', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 3, 'Florida', 'Female', 'user498049@example.com', '2004-05-18', '2024-07-29 00:00:29', 'Jill', 'Jones', '+11278158'),
(611, 'user851943', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 2, 1, 'Texas', 'Female', 'user739339@example.com', '2021-09-01', '2024-07-29 00:00:29', 'Joe', 'Brown', '+11895697'),
(612, 'user922606', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 2, 'New York', 'Female', 'user283592@example.com', '2011-04-17', '2024-07-29 00:00:29', 'Joe', 'Doe', '+12583788'),
(613, 'user028484', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 1, 'New York', 'Male', 'user044678@example.com', '2017-11-03', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+14329303'),
(614, 'user415258', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 3, 2, 'Florida', 'Female', 'user464441@example.com', '2014-10-02', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+13322100'),
(615, 'user107939', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 2, 'California', 'Male', 'user714206@example.com', '2011-03-09', '2024-07-29 00:00:29', 'Jim', 'Williams', '+13766422'),
(616, 'user317852', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 3, 'California', 'Male', 'user284997@example.com', '2003-04-12', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+14094779'),
(617, 'user993596', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 3, 'California', 'Male', 'user417553@example.com', '2015-03-31', '2024-07-29 00:00:29', 'Jane', 'Doe', '+15636055'),
(618, 'user670451', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 3, 'Texas', 'Male', 'user100137@example.com', '2000-08-29', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+12599916'),
(619, 'user812899', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 1, 2, 'Florida', 'Male', 'user571869@example.com', '2019-01-12', '2024-07-29 00:00:29', 'Jill', 'Williams', '+18070082'),
(620, 'user418367', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 2, 1, 'New York', 'Male', 'user081415@example.com', '2011-07-31', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+18543348'),
(621, 'user040298', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 4, 'Florida', 'Male', 'user485740@example.com', '2012-03-08', '2024-07-29 00:00:29', 'Jane', 'Jones', '+17879421'),
(622, 'user083403', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 3, 3, 'Illinois', 'Male', 'user451802@example.com', '2009-01-25', '2024-07-29 00:00:29', 'Joe', 'Smith', '+15154368'),
(623, 'user581238', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 1, 4, 'Texas', 'Male', 'user461362@example.com', '2014-06-06', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+11390123'),
(624, 'user973533', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'Illinois', 'Female', 'user377414@example.com', '2002-10-22', '2024-07-29 00:00:29', 'Jill', 'Doe', '+12705173'),
(625, 'user874432', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 3, 'New York', 'Female', 'user483842@example.com', '2004-03-22', '2024-07-29 00:00:29', 'Jill', 'Jones', '+13893210'),
(626, 'user989906', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 4, 'Texas', 'Female', 'user108240@example.com', '2015-07-04', '2024-07-29 00:00:29', 'Jane', 'Jones', '+11086045'),
(627, 'user691071', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 3, 'New York', 'Male', 'user183253@example.com', '2016-07-17', '2024-07-29 00:00:29', 'Jane', 'Jones', '+16594350'),
(628, 'user693320', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 3, 'New York', 'Female', 'user134944@example.com', '2012-10-12', '2024-07-29 00:00:29', 'Jill', 'Brown', '+15265068'),
(629, 'user193797', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 1, 'New York', 'Female', 'user195992@example.com', '2020-11-19', '2024-07-29 00:00:29', 'Jane', 'Doe', '+16561681'),
(630, 'user163130', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 3, 'Illinois', 'Female', 'user110954@example.com', '2002-04-19', '2024-07-29 00:00:29', 'Jane', 'Williams', '+16459088'),
(631, 'user296730', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 2, 'Florida', 'Female', 'user571492@example.com', '2013-09-13', '2024-07-29 00:00:29', 'Jim', 'Smith', '+17066391'),
(632, 'user965521', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 1, 3, 'California', 'Female', 'user391002@example.com', '2009-06-08', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+11168883'),
(633, 'user748801', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 4, 'Texas', 'Female', 'user116993@example.com', '2001-07-18', '2024-07-29 00:00:29', 'John', 'Brown', '+19849749'),
(634, 'user530297', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 1, 'Florida', 'Male', 'user094078@example.com', '2014-03-08', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+13068817'),
(635, 'user030465', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 4, 'New York', 'Male', 'user680803@example.com', '2005-09-02', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+16712587'),
(636, 'user898944', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 2, 'Texas', 'Male', 'user790174@example.com', '2012-04-19', '2024-07-29 00:00:29', 'Jim', 'Williams', '+11984287'),
(637, 'user485823', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 1, 'Texas', 'Male', 'user463334@example.com', '2021-11-16', '2024-07-29 00:00:29', 'Jill', 'Doe', '+13102705'),
(638, 'user477585', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 3, 4, 'Illinois', 'Female', 'user072600@example.com', '2017-05-19', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+15913930'),
(639, 'user852622', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 3, 1, 'Illinois', 'Male', 'user831721@example.com', '2002-04-08', '2024-07-29 00:00:29', 'John', 'Brown', '+19408674'),
(640, 'user299424', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 2, 2, 'Texas', 'Female', 'user187839@example.com', '2014-03-17', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+12328857'),
(641, 'user800371', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 4, 'Illinois', 'Female', 'user176709@example.com', '2003-04-29', '2024-07-29 00:00:29', 'Jane', 'Brown', '+17592918'),
(642, 'user728809', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 1, 3, 'New York', 'Male', 'user907880@example.com', '2019-09-01', '2024-07-29 00:00:29', 'Joe', 'Doe', '+13877631'),
(643, 'user526913', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 4, 'Texas', 'Female', 'user894308@example.com', '2015-01-08', '2024-07-29 00:00:29', 'Joe', 'Brown', '+11280501'),
(644, 'user620353', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 1, 'Florida', 'Female', 'user036506@example.com', '2015-03-09', '2024-07-29 00:00:29', 'Jim', 'Brown', '+14603055'),
(645, 'user182188', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 2, 'Illinois', 'Male', 'user944762@example.com', '2017-10-23', '2024-07-29 00:00:29', 'Jane', 'Brown', '+19030311'),
(646, 'user355936', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 1, 'Texas', 'Female', 'user240156@example.com', '2014-12-17', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+10434178'),
(647, 'user940055', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 1, 'California', 'Female', 'user292143@example.com', '2001-10-24', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+15913356'),
(648, 'user633607', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 1, 3, 'Texas', 'Male', 'user537261@example.com', '2011-05-24', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+19534806'),
(649, 'user615319', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 4, 'New York', 'Male', 'user074880@example.com', '2001-02-28', '2024-07-29 00:00:29', 'John', 'Doe', '+11044158'),
(650, 'user385692', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 4, 'Florida', 'Female', 'user552781@example.com', '2003-10-12', '2024-07-29 00:00:29', 'Jane', 'Williams', '+19106100'),
(651, 'user038570', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 2, 2, 'Texas', 'Male', 'user679427@example.com', '2003-09-26', '2024-07-29 00:00:29', 'Joe', 'Williams', '+13629007'),
(652, 'user130450', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 4, 'California', 'Female', 'user977357@example.com', '2011-10-04', '2024-07-29 00:00:29', 'Joe', 'Doe', '+14867443'),
(653, 'user988552', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 3, 'Florida', 'Male', 'user647637@example.com', '2007-05-27', '2024-07-29 00:00:29', 'Joe', 'Brown', '+13612985'),
(654, 'user645394', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 4, 'Texas', 'Female', 'user842160@example.com', '2010-01-22', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+10512923'),
(655, 'user839617', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 4, 'Florida', 'Female', 'user612663@example.com', '2005-12-23', '2024-07-29 00:00:29', 'Jill', 'Brown', '+14989674'),
(656, 'user046862', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 4, 'California', 'Male', 'user967403@example.com', '2017-11-16', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+16937504'),
(657, 'user130360', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 3, 'California', 'Male', 'user492108@example.com', '2017-07-04', '2024-07-29 00:00:29', 'Jill', 'Smith', '+14563764'),
(658, 'user671549', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 3, 'Illinois', 'Female', 'user011840@example.com', '2003-01-04', '2024-07-29 00:00:29', 'Jill', 'Jones', '+12791718'),
(659, 'user854970', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 1, 'California', 'Female', 'user715978@example.com', '2012-09-29', '2024-07-29 00:00:29', 'Joe', 'Doe', '+10334936'),
(660, 'user975838', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 3, 'California', 'Male', 'user758027@example.com', '2005-07-15', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+19824486'),
(661, 'user341277', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 3, 'New York', 'Male', 'user264375@example.com', '2018-04-03', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+17236757'),
(662, 'user511252', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 4, 'Illinois', 'Female', 'user979940@example.com', '2016-12-09', '2024-07-29 00:00:29', 'Jenny', 'Smith', '+18007691'),
(663, 'user054098', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 1, 4, 'Florida', 'Female', 'user129791@example.com', '2016-10-05', '2024-07-29 00:00:29', 'Jim', 'Jones', '+11414984'),
(664, 'user035365', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 1, 1, 'Florida', 'Female', 'user687486@example.com', '2006-07-27', '2024-07-29 00:00:29', 'Jim', 'Smith', '+11196019'),
(665, 'user739271', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 2, 'California', 'Male', 'user929683@example.com', '2013-10-26', '2024-07-29 00:00:29', 'Jim', 'Jones', '+15782264'),
(666, 'user086213', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 2, 'California', 'Female', 'user528955@example.com', '2001-08-23', '2024-07-29 00:00:29', 'Joe', 'Brown', '+12201353'),
(667, 'user949367', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 3, 'Florida', 'Male', 'user897950@example.com', '2016-04-21', '2024-07-29 00:00:29', 'John', 'Jones', '+14547398'),
(668, 'user550048', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 2, 'New York', 'Male', 'user091628@example.com', '2021-08-24', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+18456074'),
(669, 'user120331', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 1, 'California', 'Male', 'user660154@example.com', '2019-10-02', '2024-07-29 00:00:29', 'Jill', 'Jones', '+10961830'),
(670, 'user672277', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 3, 'New York', 'Male', 'user988175@example.com', '2000-01-16', '2024-07-29 00:00:29', 'John', 'Smith', '+19613332'),
(671, 'user148874', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 4, 'Texas', 'Female', 'user551262@example.com', '2021-09-16', '2024-07-29 00:00:29', 'Jane', 'Williams', '+17799463'),
(672, 'user287850', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 3, 2, 'Florida', 'Female', 'user012861@example.com', '2016-02-07', '2024-07-29 00:00:29', 'Jill', 'Jones', '+19938938'),
(673, 'user025903', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 3, 2, 'New York', 'Male', 'user778598@example.com', '2014-11-12', '2024-07-29 00:00:29', 'John', 'Smith', '+10915012'),
(674, 'user698499', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 1, 3, 'New York', 'Female', 'user805967@example.com', '2004-02-12', '2024-07-29 00:00:29', 'Jill', 'Doe', '+16549804'),
(675, 'user143196', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 2, 4, 'California', 'Male', 'user551711@example.com', '2008-02-18', '2024-07-29 00:00:29', 'Jane', 'Jones', '+18666026'),
(676, 'user650019', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 4, 'Florida', 'Female', 'user553601@example.com', '2020-11-01', '2024-07-29 00:00:29', 'John', 'Williams', '+18398150'),
(677, 'user322553', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 3, 'California', 'Male', 'user661889@example.com', '2019-03-17', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+16267598'),
(678, 'user039281', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 2, 'New York', 'Male', 'user638244@example.com', '2013-09-13', '2024-07-29 00:00:29', 'Jane', 'Smith', '+13031854'),
(679, 'user950579', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 2, 'New York', 'Female', 'user555944@example.com', '2000-07-29', '2024-07-29 00:00:29', 'Jim', 'Smith', '+18107606'),
(680, 'user332311', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 4, 'New York', 'Female', 'user698400@example.com', '2003-06-03', '2024-07-29 00:00:29', 'Joe', 'Jones', '+17409898'),
(681, 'user826256', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 2, 4, 'New York', 'Female', 'user034021@example.com', '2015-09-22', '2024-07-29 00:00:29', 'Jim', 'Smith', '+19538625'),
(682, 'user919727', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 2, 'California', 'Female', 'user509477@example.com', '2009-10-12', '2024-07-29 00:00:29', 'Joe', 'Smith', '+17985534');
INSERT INTO `students` (`student_id`, `username`, `password`, `fname`, `lname`, `grade`, `section`, `address`, `gender`, `email_address`, `date_of_birth`, `date_of_joined`, `parent_fname`, `parent_lname`, `parent_phone_number`) VALUES
(683, 'user445691', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 3, 'Texas', 'Female', 'user536225@example.com', '2002-01-09', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+13924319'),
(684, 'user990214', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 1, 'California', 'Female', 'user495391@example.com', '2019-10-17', '2024-07-29 00:00:29', 'John', 'Johnson', '+11557795'),
(685, 'user427233', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 2, 'Florida', 'Female', 'user233414@example.com', '2008-12-03', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+13003059'),
(686, 'user114932', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 2, 'Illinois', 'Female', 'user422029@example.com', '2017-09-01', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+17866325'),
(687, 'user679456', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 2, 3, 'Florida', 'Male', 'user578521@example.com', '2012-10-20', '2024-07-29 00:00:29', 'Jane', 'Smith', '+13541351'),
(688, 'user220853', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 2, 'New York', 'Female', 'user917757@example.com', '2011-04-27', '2024-07-29 00:00:29', 'Joe', 'Williams', '+15291355'),
(689, 'user832400', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 3, 'Florida', 'Female', 'user341599@example.com', '2019-11-11', '2024-07-29 00:00:29', 'Jill', 'Brown', '+16048389'),
(690, 'user544311', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 1, 'Illinois', 'Female', 'user061843@example.com', '2016-03-15', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+12026842'),
(691, 'user967247', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 4, 'Florida', 'Female', 'user977849@example.com', '2011-03-09', '2024-07-29 00:00:29', 'Jill', 'Williams', '+19825911'),
(692, 'user207094', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 3, 'Illinois', 'Male', 'user676501@example.com', '2014-04-20', '2024-07-29 00:00:29', 'Jane', 'Smith', '+13824260'),
(693, 'user259111', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 4, 'Florida', 'Male', 'user819352@example.com', '2021-02-21', '2024-07-29 00:00:29', 'Jim', 'Jones', '+16225623'),
(694, 'user276426', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 3, 'Florida', 'Male', 'user348296@example.com', '2000-02-18', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+15858264'),
(695, 'user204115', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 3, 'Texas', 'Female', 'user716587@example.com', '2016-11-19', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19478993'),
(696, 'user101550', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 1, 2, 'Florida', 'Male', 'user688430@example.com', '2001-01-23', '2024-07-29 00:00:29', 'Jane', 'Brown', '+11728280'),
(697, 'user641302', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 1, 'Florida', 'Male', 'user371435@example.com', '2015-03-23', '2024-07-29 00:00:29', 'Jim', 'Brown', '+15161275'),
(698, 'user421156', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 3, 1, 'Illinois', 'Male', 'user484923@example.com', '2013-10-10', '2024-07-29 00:00:29', 'Joe', 'Williams', '+17470166'),
(699, 'user044747', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 3, 2, 'New York', 'Female', 'user619728@example.com', '2004-12-31', '2024-07-29 00:00:29', 'Jane', 'Brown', '+17872406'),
(700, 'user755615', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 3, 'Illinois', 'Female', 'user410620@example.com', '2002-07-21', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+19700188'),
(701, 'user636604', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 4, 'California', 'Male', 'user912302@example.com', '2013-11-15', '2024-07-29 00:00:29', 'Jim', 'Smith', '+19659297'),
(702, 'user075460', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 2, 3, 'Florida', 'Male', 'user927462@example.com', '2012-07-27', '2024-07-29 00:00:29', 'John', 'Brown', '+13104989'),
(703, 'user409153', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 4, 'New York', 'Male', 'user042463@example.com', '2020-12-12', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+10558007'),
(704, 'user067189', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 3, 3, 'Florida', 'Male', 'user629590@example.com', '2012-03-03', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+12377448'),
(705, 'user844640', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 3, 'Illinois', 'Male', 'user291029@example.com', '2020-08-20', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+12970460'),
(706, 'user399141', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 3, 'New York', 'Male', 'user444507@example.com', '2007-03-30', '2024-07-29 00:00:29', 'Jane', 'Williams', '+10787131'),
(707, 'user570405', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 3, 4, 'California', 'Male', 'user388211@example.com', '2015-07-08', '2024-07-29 00:00:29', 'Jim', 'Brown', '+16845245'),
(708, 'user131846', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 2, 4, 'New York', 'Male', 'user516389@example.com', '2000-06-26', '2024-07-29 00:00:29', 'Jill', 'Brown', '+10282774'),
(709, 'user913031', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 2, 'California', 'Male', 'user685438@example.com', '2004-02-02', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+15018494'),
(710, 'user028799', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 4, 'Illinois', 'Male', 'user899033@example.com', '2011-01-23', '2024-07-29 00:00:29', 'Joe', 'Williams', '+16471092'),
(711, 'user356273', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 2, 'New York', 'Male', 'user494802@example.com', '2011-02-19', '2024-07-29 00:00:29', 'John', 'Brown', '+16393936'),
(712, 'user909820', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 4, 'Florida', 'Male', 'user120219@example.com', '2008-05-14', '2024-07-29 00:00:29', 'Jill', 'Williams', '+13641022'),
(713, 'user012421', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 2, 'New York', 'Female', 'user726885@example.com', '2017-07-26', '2024-07-29 00:00:29', 'Joe', 'Brown', '+12263266'),
(714, 'user901998', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 2, 'Illinois', 'Female', 'user709612@example.com', '2001-03-21', '2024-07-29 00:00:29', 'John', 'Williams', '+14601800'),
(715, 'user555105', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 2, 4, 'California', 'Male', 'user271427@example.com', '2003-10-30', '2024-07-29 00:00:29', 'John', 'Brown', '+16880051'),
(716, 'user120088', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 1, 'New York', 'Female', 'user307910@example.com', '2005-04-14', '2024-07-29 00:00:29', 'Jane', 'Brown', '+16048431'),
(717, 'user952000', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 2, 4, 'California', 'Female', 'user516074@example.com', '2017-04-10', '2024-07-29 00:00:29', 'Jim', 'Williams', '+18585389'),
(718, 'user466740', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 1, 'New York', 'Female', 'user608464@example.com', '2008-12-31', '2024-07-29 00:00:29', 'Jane', 'Jones', '+18806829'),
(719, 'user662249', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 4, 'Illinois', 'Male', 'user171050@example.com', '2004-11-10', '2024-07-29 00:00:29', 'Jill', 'Smith', '+17898300'),
(720, 'user001951', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 3, 'California', 'Male', 'user447398@example.com', '2017-08-12', '2024-07-29 00:00:29', 'Joe', 'Jones', '+18706281'),
(721, 'user408922', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 1, 'Texas', 'Female', 'user950903@example.com', '2004-01-25', '2024-07-29 00:00:29', 'John', 'Brown', '+18765964'),
(722, 'user921102', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 2, 4, 'Texas', 'Male', 'user734954@example.com', '2009-06-14', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+14893217'),
(723, 'user037907', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 1, 'California', 'Male', 'user329933@example.com', '2006-01-11', '2024-07-29 00:00:29', 'Jim', 'Doe', '+13796457'),
(724, 'user574215', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 3, 'Florida', 'Male', 'user644437@example.com', '2004-07-06', '2024-07-29 00:00:29', 'John', 'Jones', '+10390655'),
(725, 'user597666', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 1, 2, 'Illinois', 'Female', 'user444712@example.com', '2013-10-05', '2024-07-29 00:00:29', 'Joe', 'Doe', '+13341549'),
(726, 'user217344', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 3, 'Texas', 'Female', 'user495933@example.com', '2014-03-29', '2024-07-29 00:00:29', 'Joe', 'Jones', '+10335340'),
(727, 'user574156', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 2, 'California', 'Male', 'user020920@example.com', '2000-08-15', '2024-07-29 00:00:29', 'John', 'Smith', '+13163911'),
(728, 'user649573', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 3, 3, 'New York', 'Female', 'user255174@example.com', '2005-08-10', '2024-07-29 00:00:29', 'Jill', 'Brown', '+14855028'),
(729, 'user009489', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 3, 'Illinois', 'Male', 'user085665@example.com', '2004-04-07', '2024-07-29 00:00:29', 'Joe', 'Doe', '+18573820'),
(730, 'user281372', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 1, 3, 'California', 'Female', 'user659822@example.com', '2015-12-21', '2024-07-29 00:00:29', 'Jill', 'Doe', '+17221184'),
(731, 'user177903', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 4, 'New York', 'Male', 'user184759@example.com', '2010-08-13', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+18485253'),
(732, 'user569276', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 1, 'Florida', 'Female', 'user243278@example.com', '2009-12-11', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+10745677'),
(733, 'user355712', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 1, 'Texas', 'Male', 'user781408@example.com', '2013-11-03', '2024-07-29 00:00:29', 'Joe', 'Smith', '+14559345'),
(734, 'user738770', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 1, 'Illinois', 'Male', 'user447850@example.com', '2002-09-17', '2024-07-29 00:00:29', 'Jane', 'Doe', '+12025298'),
(735, 'user995356', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 2, 'California', 'Male', 'user409786@example.com', '2013-08-13', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+10146434'),
(736, 'user482067', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 3, 4, 'Texas', 'Male', 'user492582@example.com', '2006-12-21', '2024-07-29 00:00:29', 'John', 'Williams', '+17286237'),
(737, 'user801135', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 1, 1, 'Illinois', 'Female', 'user406636@example.com', '2009-05-28', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+19589073'),
(738, 'user750058', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 3, 2, 'Texas', 'Male', 'user253852@example.com', '2016-12-06', '2024-07-29 00:00:29', 'John', 'Smith', '+16866266'),
(739, 'user834402', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 3, 3, 'New York', 'Female', 'user547354@example.com', '2002-04-08', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+17183138'),
(740, 'user383733', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 1, 1, 'Illinois', 'Male', 'user585761@example.com', '2021-05-29', '2024-07-29 00:00:29', 'John', 'Brown', '+11923284'),
(741, 'user812796', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 3, 'Texas', 'Female', 'user458629@example.com', '2018-09-29', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+10298321'),
(742, 'user305814', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 3, 'Florida', 'Male', 'user214670@example.com', '2017-10-05', '2024-07-29 00:00:29', 'Jim', 'Williams', '+18705956'),
(743, 'user491424', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 4, 'Florida', 'Female', 'user014468@example.com', '2013-09-28', '2024-07-29 00:00:29', 'John', 'Williams', '+16530928'),
(744, 'user504664', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 2, 'Illinois', 'Male', 'user860372@example.com', '2018-03-14', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+11524143'),
(745, 'user638393', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 3, 'Texas', 'Female', 'user342700@example.com', '2006-07-30', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+19172752'),
(746, 'user183229', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 3, 'Illinois', 'Male', 'user972984@example.com', '2015-05-22', '2024-07-29 00:00:29', 'Jill', 'Jones', '+15322939'),
(747, 'user072594', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 3, 4, 'Florida', 'Male', 'user312388@example.com', '2017-12-08', '2024-07-29 00:00:29', 'John', 'Smith', '+11763540'),
(748, 'user892898', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 4, 'New York', 'Female', 'user514789@example.com', '2005-08-23', '2024-07-29 00:00:29', 'Joe', 'Jones', '+15064185'),
(749, 'user688707', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 1, 2, 'Florida', 'Female', 'user223988@example.com', '2000-10-06', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+15343295'),
(750, 'user446291', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 1, 'Illinois', 'Female', 'user988215@example.com', '2009-02-07', '2024-07-29 00:00:29', 'John', 'Smith', '+12675295'),
(751, 'user372359', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 1, 'New York', 'Male', 'user332539@example.com', '2015-03-13', '2024-07-29 00:00:29', 'Jim', 'Smith', '+19671375'),
(752, 'user006563', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 3, 1, 'Illinois', 'Male', 'user484240@example.com', '2016-07-26', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+19033394'),
(753, 'user381498', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 2, 3, 'New York', 'Male', 'user151440@example.com', '2008-08-29', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+15678222'),
(754, 'user557606', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 1, 'Florida', 'Female', 'user253137@example.com', '2006-10-05', '2024-07-29 00:00:29', 'Joe', 'Jones', '+16221280'),
(755, 'user125749', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 1, 'Illinois', 'Male', 'user428864@example.com', '2016-04-16', '2024-07-29 00:00:29', 'Jim', 'Jones', '+13526273'),
(756, 'user973542', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 3, 'Florida', 'Female', 'user553641@example.com', '2010-03-08', '2024-07-29 00:00:29', 'Jill', 'Jones', '+16325162'),
(757, 'user387938', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 2, 'Florida', 'Male', 'user847940@example.com', '2015-09-09', '2024-07-29 00:00:29', 'John', 'Doe', '+10865145'),
(758, 'user312645', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 3, 1, 'New York', 'Female', 'user033034@example.com', '2012-04-07', '2024-07-29 00:00:29', 'Joe', 'Brown', '+10297815'),
(759, 'user668472', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 4, 'Illinois', 'Male', 'user555864@example.com', '2010-12-28', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+19810052'),
(760, 'user802169', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 3, 'New York', 'Male', 'user249950@example.com', '2019-02-18', '2024-07-29 00:00:29', 'Jill', 'Johnson', '+14891141'),
(761, 'user040018', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 4, 'California', 'Female', 'user807995@example.com', '2009-07-12', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+10067627'),
(762, 'user677035', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 4, 'California', 'Male', 'user545970@example.com', '2006-05-19', '2024-07-29 00:00:29', 'Joe', 'Smith', '+16365518'),
(763, 'user527643', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 2, 'Florida', 'Female', 'user427623@example.com', '2013-01-25', '2024-07-29 00:00:29', 'Joe', 'Brown', '+14678205'),
(764, 'user196853', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 1, 'Texas', 'Female', 'user056964@example.com', '2005-05-31', '2024-07-29 00:00:29', 'John', 'Williams', '+17197338'),
(765, 'user850073', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 3, 'New York', 'Male', 'user019153@example.com', '2018-09-22', '2024-07-29 00:00:29', 'Jane', 'Williams', '+19493126'),
(766, 'user186499', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 3, 'Texas', 'Female', 'user657638@example.com', '2006-11-21', '2024-07-29 00:00:29', 'Jill', 'Doe', '+14805361'),
(767, 'user234427', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 4, 'Illinois', 'Male', 'user507153@example.com', '2006-02-05', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+19833142'),
(768, 'user358906', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 3, 'New York', 'Male', 'user037463@example.com', '2019-09-04', '2024-07-29 00:00:29', 'Jim', 'Smith', '+18658435'),
(769, 'user727320', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 3, 3, 'Florida', 'Male', 'user644174@example.com', '2004-01-16', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+10188162'),
(770, 'user900186', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 1, 4, 'California', 'Female', 'user105760@example.com', '2005-01-18', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+19289002'),
(771, 'user182669', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 4, 'Florida', 'Female', 'user598725@example.com', '2015-06-24', '2024-07-29 00:00:29', 'Joe', 'Williams', '+16223542'),
(772, 'user411011', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 3, 'Florida', 'Female', 'user549773@example.com', '2001-06-08', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19431791'),
(773, 'user128722', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 3, 4, 'California', 'Female', 'user326565@example.com', '2003-04-17', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+17301032'),
(774, 'user422741', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 4, 'New York', 'Male', 'user821196@example.com', '2014-10-03', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+18053498'),
(775, 'user514433', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 3, 4, 'California', 'Female', 'user073482@example.com', '2015-03-11', '2024-07-29 00:00:29', 'Jane', 'Doe', '+10388939'),
(776, 'user725847', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 4, 'Florida', 'Male', 'user107950@example.com', '2002-01-01', '2024-07-29 00:00:29', 'John', 'Johnson', '+15577943'),
(777, 'user614672', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 2, 2, 'Texas', 'Female', 'user579914@example.com', '2013-06-06', '2024-07-29 00:00:29', 'Jane', 'Brown', '+19730411'),
(778, 'user494744', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 1, 'Illinois', 'Male', 'user728016@example.com', '2011-03-14', '2024-07-29 00:00:29', 'Jim', 'Smith', '+15285736'),
(779, 'user654919', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 1, 'New York', 'Female', 'user876665@example.com', '2019-04-20', '2024-07-29 00:00:29', 'Joe', 'Smith', '+18480237'),
(780, 'user535071', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 3, 1, 'California', 'Female', 'user059486@example.com', '2015-05-01', '2024-07-29 00:00:29', 'Jane', 'Williams', '+15622838'),
(781, 'user296375', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 4, 'Florida', 'Female', 'user871067@example.com', '2012-08-05', '2024-07-29 00:00:29', 'Jane', 'Williams', '+11354741'),
(782, 'user924763', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 3, 3, 'California', 'Female', 'user577249@example.com', '2002-02-20', '2024-07-29 00:00:29', 'Joe', 'Johnson', '+11873721'),
(783, 'user461873', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 2, 3, 'Illinois', 'Male', 'user242259@example.com', '2019-04-15', '2024-07-29 00:00:29', 'Joe', 'Brown', '+16693339'),
(784, 'user127732', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 3, 2, 'Texas', 'Male', 'user563985@example.com', '2002-07-17', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+18050004'),
(785, 'user742761', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 2, 'Texas', 'Female', 'user094134@example.com', '2019-01-06', '2024-07-29 00:00:29', 'John', 'Brown', '+12670346'),
(786, 'user269392', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 1, 'Texas', 'Male', 'user392508@example.com', '2010-03-05', '2024-07-29 00:00:29', 'John', 'Smith', '+12227279'),
(787, 'user118974', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 1, 'New York', 'Female', 'user620799@example.com', '2003-01-08', '2024-07-29 00:00:29', 'Joe', 'Brown', '+11307941'),
(788, 'user486421', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 2, 3, 'Florida', 'Male', 'user535596@example.com', '2009-09-29', '2024-07-29 00:00:29', 'Jill', 'Brown', '+19209567'),
(789, 'user339873', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 2, 3, 'New York', 'Male', 'user559370@example.com', '2003-08-31', '2024-07-29 00:00:29', 'John', 'Smith', '+19729284'),
(790, 'user995986', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 2, 1, 'New York', 'Female', 'user260711@example.com', '2014-09-15', '2024-07-29 00:00:29', 'Jill', 'Jones', '+15828048'),
(791, 'user328943', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 2, 'Illinois', 'Female', 'user866664@example.com', '2015-06-06', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+17236256'),
(792, 'user123821', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 1, 2, 'New York', 'Female', 'user686254@example.com', '2012-01-28', '2024-07-29 00:00:29', 'Joe', 'Jones', '+10782936'),
(793, 'user888794', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 1, 'California', 'Male', 'user627547@example.com', '2017-01-18', '2024-07-29 00:00:29', 'John', 'Brown', '+15302621'),
(794, 'user516272', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 1, 'New York', 'Female', 'user698608@example.com', '2014-06-24', '2024-07-29 00:00:29', 'Jane', 'Doe', '+16909076'),
(795, 'user263094', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 3, 'California', 'Male', 'user192077@example.com', '2015-05-14', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+19654305'),
(796, 'user171608', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 1, 'Texas', 'Male', 'user245186@example.com', '2019-02-14', '2024-07-29 00:00:29', 'Jill', 'Williams', '+17637235'),
(797, 'user226345', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 1, 4, 'California', 'Female', 'user420258@example.com', '2003-03-27', '2024-07-29 00:00:29', 'Jim', 'Jones', '+12889824'),
(798, 'user612136', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 1, 'Florida', 'Female', 'user065258@example.com', '2015-01-12', '2024-07-29 00:00:29', 'Jane', 'Doe', '+18957486'),
(799, 'user116582', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 3, 2, 'New York', 'Male', 'user322127@example.com', '2013-11-27', '2024-07-29 00:00:29', 'Jane', 'Doe', '+10610331'),
(800, 'user893370', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 4, 'Texas', 'Male', 'user864756@example.com', '2013-04-02', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+14089727'),
(801, 'user023416', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 1, 'Texas', 'Female', 'user571539@example.com', '2021-08-28', '2024-07-29 00:00:29', 'Jane', 'Smith', '+12172259'),
(802, 'user542638', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 1, 1, 'Texas', 'Male', 'user731273@example.com', '2006-08-20', '2024-07-29 00:00:29', 'Jane', 'Brown', '+15106498'),
(803, 'user469712', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 3, 3, 'New York', 'Female', 'user112851@example.com', '2019-01-21', '2024-07-29 00:00:29', 'John', 'Johnson', '+12079605'),
(804, 'user693841', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 3, 'Illinois', 'Male', 'user156952@example.com', '2011-01-11', '2024-07-29 00:00:29', 'John', 'Brown', '+14844347'),
(805, 'user246533', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 2, 4, 'Texas', 'Male', 'user418102@example.com', '2011-12-04', '2024-07-29 00:00:29', 'Jim', 'Brown', '+11225945'),
(806, 'user497630', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 3, 'Texas', 'Male', 'user072392@example.com', '2012-11-06', '2024-07-29 00:00:29', 'Joe', 'Brown', '+19524432'),
(807, 'user301952', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 3, 1, 'Florida', 'Female', 'user574130@example.com', '2011-01-29', '2024-07-29 00:00:29', 'Joe', 'Williams', '+11614522'),
(808, 'user258204', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 3, 'California', 'Female', 'user561771@example.com', '2001-05-20', '2024-07-29 00:00:29', 'Jill', 'Jones', '+19271706'),
(809, 'user744309', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 2, 1, 'California', 'Male', 'user918801@example.com', '2000-06-16', '2024-07-29 00:00:29', 'Jim', 'Brown', '+13454874'),
(810, 'user693489', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 1, 1, 'Florida', 'Female', 'user210971@example.com', '2004-05-07', '2024-07-29 00:00:29', 'Jim', 'Smith', '+19410016'),
(811, 'user092431', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 3, 'New York', 'Male', 'user257147@example.com', '2017-08-21', '2024-07-29 00:00:29', 'Jane', 'Jones', '+15376271'),
(812, 'user105900', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 1, 'Florida', 'Male', 'user428488@example.com', '2004-04-06', '2024-07-29 00:00:29', 'Joe', 'Jones', '+12192227'),
(813, 'user525836', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 3, 'Texas', 'Female', 'user876804@example.com', '2008-05-11', '2024-07-29 00:00:29', 'Jane', 'Smith', '+13931507'),
(814, 'user229236', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 3, 3, 'New York', 'Male', 'user681218@example.com', '2019-06-19', '2024-07-29 00:00:29', 'Jim', 'Smith', '+14667102'),
(815, 'user333744', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 3, 2, 'Florida', 'Male', 'user887668@example.com', '2017-01-16', '2024-07-29 00:00:29', 'Jane', 'Brown', '+13362056'),
(816, 'user269546', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 2, 'Illinois', 'Male', 'user932209@example.com', '2007-01-09', '2024-07-29 00:00:29', 'Joe', 'Doe', '+19394238'),
(817, 'user481214', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 3, 1, 'California', 'Male', 'user594707@example.com', '2016-03-29', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+12012594'),
(818, 'user822566', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 1, 'Florida', 'Female', 'user915243@example.com', '2013-12-22', '2024-07-29 00:00:29', 'Jim', 'Smith', '+12125264'),
(819, 'user134616', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 2, 'New York', 'Male', 'user104685@example.com', '2012-09-14', '2024-07-29 00:00:29', 'Jill', 'Smith', '+11963155'),
(820, 'user408562', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 1, 'New York', 'Female', 'user933633@example.com', '2003-07-26', '2024-07-29 00:00:29', 'John', 'Williams', '+18467571'),
(821, 'user502098', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 1, 'Florida', 'Female', 'user396925@example.com', '2009-10-15', '2024-07-29 00:00:29', 'John', 'Jones', '+12629006'),
(822, 'user677635', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 1, 1, 'New York', 'Female', 'user926720@example.com', '2016-11-06', '2024-07-29 00:00:29', 'John', 'Doe', '+19236558'),
(823, 'user544324', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 3, 2, 'Florida', 'Male', 'user290452@example.com', '2014-01-30', '2024-07-29 00:00:29', 'Jim', 'Brown', '+19092502'),
(824, 'user182701', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 3, 'Illinois', 'Female', 'user078734@example.com', '2002-07-29', '2024-07-29 00:00:29', 'Jim', 'Johnson', '+19683044'),
(825, 'user627989', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 3, 4, 'New York', 'Male', 'user124097@example.com', '2005-12-23', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+17429890'),
(826, 'user282427', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 4, 'Texas', 'Female', 'user938711@example.com', '2003-08-12', '2024-07-29 00:00:29', 'John', 'Williams', '+17162038'),
(827, 'user935702', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 3, 'New York', 'Female', 'user437255@example.com', '2013-09-13', '2024-07-29 00:00:29', 'Joe', 'Smith', '+15722245'),
(828, 'user248653', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 3, 'Texas', 'Female', 'user017240@example.com', '2020-12-04', '2024-07-29 00:00:29', 'Joe', 'Brown', '+16342471'),
(829, 'user884322', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 1, 4, 'New York', 'Male', 'user179651@example.com', '2009-12-25', '2024-07-29 00:00:29', 'Joe', 'Smith', '+14460560'),
(830, 'user230369', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 2, 1, 'New York', 'Male', 'user654848@example.com', '2000-08-19', '2024-07-29 00:00:29', 'Jane', 'Brown', '+15325702'),
(831, 'user218721', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 3, 'Texas', 'Male', 'user565827@example.com', '2013-06-26', '2024-07-29 00:00:29', 'Jim', 'Doe', '+11401632'),
(832, 'user531523', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 1, 2, 'Texas', 'Male', 'user317037@example.com', '2002-01-20', '2024-07-29 00:00:29', 'Jill', 'Smith', '+19849504'),
(833, 'user001733', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 4, 'Texas', 'Female', 'user410799@example.com', '2006-01-16', '2024-07-29 00:00:29', 'John', 'Jones', '+11066469'),
(834, 'user803619', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 2, 'Texas', 'Female', 'user042977@example.com', '2001-05-08', '2024-07-29 00:00:29', 'Jane', 'Brown', '+10206594'),
(835, 'user968089', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 1, 'Texas', 'Male', 'user844842@example.com', '2009-07-29', '2024-07-29 00:00:29', 'Jill', 'Jones', '+17752079'),
(836, 'user038187', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 3, 'New York', 'Male', 'user388578@example.com', '2014-05-16', '2024-07-29 00:00:29', 'John', 'Williams', '+16918587'),
(837, 'user636793', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 3, 2, 'Illinois', 'Male', 'user570534@example.com', '2012-11-20', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+12458551'),
(838, 'user066752', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 1, 'Illinois', 'Male', 'user537366@example.com', '2010-09-17', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+10001302'),
(839, 'user900280', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 2, 1, 'California', 'Male', 'user669527@example.com', '2020-09-20', '2024-07-29 00:00:29', 'Joe', 'Brown', '+16885741'),
(840, 'user130474', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 3, 1, 'Florida', 'Male', 'user803120@example.com', '2016-12-19', '2024-07-29 00:00:29', 'Jim', 'Jones', '+15846104'),
(841, 'user937399', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 2, 4, 'Texas', 'Male', 'user387855@example.com', '2008-09-07', '2024-07-29 00:00:29', 'Joe', 'Jones', '+10751887'),
(842, 'user656167', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 2, 4, 'Texas', 'Male', 'user994141@example.com', '2010-12-01', '2024-07-29 00:00:29', 'Jill', 'Doe', '+17430923'),
(843, 'user551572', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 4, 'Illinois', 'Female', 'user663833@example.com', '2016-01-29', '2024-07-29 00:00:29', 'Joe', 'Smith', '+19188319'),
(844, 'user021386', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 2, 4, 'California', 'Female', 'user947643@example.com', '2003-04-01', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+15453875'),
(845, 'user582151', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 1, 3, 'California', 'Female', 'user759454@example.com', '2018-02-13', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+14759327'),
(846, 'user948849', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 3, 2, 'New York', 'Female', 'user539973@example.com', '2012-05-26', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+11517912'),
(847, 'user687839', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 1, 'California', 'Female', 'user702748@example.com', '2018-11-25', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+15941863'),
(848, 'user643154', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 3, 3, 'Illinois', 'Male', 'user855054@example.com', '2008-02-09', '2024-07-29 00:00:29', 'Jane', 'Smith', '+17333931'),
(849, 'user712615', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 1, 2, 'California', 'Male', 'user601657@example.com', '2001-03-16', '2024-07-29 00:00:29', 'Jim', 'Smith', '+15158051'),
(850, 'user023473', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 3, 'Texas', 'Male', 'user317921@example.com', '2014-01-14', '2024-07-29 00:00:29', 'Jane', 'Smith', '+19101130'),
(851, 'user552469', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 3, 'Florida', 'Male', 'user373820@example.com', '2010-11-10', '2024-07-29 00:00:29', 'Jim', 'Smith', '+14287006'),
(852, 'user242727', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 1, 'New York', 'Female', 'user633205@example.com', '2005-07-16', '2024-07-29 00:00:29', 'Jim', 'Doe', '+12331492'),
(853, 'user969141', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 4, 'Florida', 'Male', 'user558673@example.com', '2020-11-01', '2024-07-29 00:00:29', 'John', 'Williams', '+14968746'),
(854, 'user841780', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 3, 'Illinois', 'Male', 'user935840@example.com', '2016-06-29', '2024-07-29 00:00:29', 'Jenny', 'Williams', '+17809406'),
(855, 'user311596', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 4, 'New York', 'Male', 'user181623@example.com', '2018-07-20', '2024-07-29 00:00:29', 'Joe', 'Jones', '+14706179'),
(856, 'user629170', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 3, 1, 'Illinois', 'Female', 'user557661@example.com', '2005-06-05', '2024-07-29 00:00:29', 'Jill', 'Doe', '+17329208'),
(857, 'user406253', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 1, 2, 'Florida', 'Female', 'user540259@example.com', '2010-11-05', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+13836171'),
(858, 'user548825', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 1, 'California', 'Female', 'user066184@example.com', '2001-07-16', '2024-07-29 00:00:29', 'John', 'Williams', '+13099305'),
(859, 'user888427', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 1, 'California', 'Female', 'user110974@example.com', '2014-06-26', '2024-07-29 00:00:29', 'Jenny', 'Jones', '+15003916'),
(860, 'user849171', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 2, 3, 'Texas', 'Female', 'user840743@example.com', '2001-12-24', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+10976273'),
(861, 'user356098', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 4, 'Illinois', 'Male', 'user467673@example.com', '2012-03-22', '2024-07-29 00:00:29', 'Jim', 'Smith', '+11514202'),
(862, 'user968940', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 1, 1, 'Texas', 'Male', 'user799334@example.com', '2003-02-04', '2024-07-29 00:00:29', 'Jane', 'Doe', '+16695754'),
(863, 'user990634', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 3, 2, 'Illinois', 'Female', 'user741788@example.com', '2012-03-21', '2024-07-29 00:00:29', 'Jill', 'Doe', '+10512190'),
(864, 'user809091', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 2, 2, 'New York', 'Female', 'user596317@example.com', '2011-12-07', '2024-07-29 00:00:29', 'Jenny', 'Doe', '+13959450'),
(865, 'user859366', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 2, 3, 'Florida', 'Male', 'user976129@example.com', '2015-06-24', '2024-07-29 00:00:29', 'Jill', 'Jones', '+17108232'),
(866, 'user838528', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 2, 'Florida', 'Male', 'user263819@example.com', '2004-12-14', '2024-07-29 00:00:29', 'Jim', 'Doe', '+10728909'),
(867, 'user309926', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 2, 4, 'New York', 'Male', 'user955426@example.com', '2003-02-15', '2024-07-29 00:00:29', 'Jenny', 'Brown', '+14996743'),
(868, 'user073444', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 3, 3, 'New York', 'Female', 'user093608@example.com', '2015-10-08', '2024-07-29 00:00:29', 'Jane', 'Johnson', '+12099865'),
(869, 'user750549', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 1, 'California', 'Male', 'user969946@example.com', '2006-08-23', '2024-07-29 00:00:29', 'Jill', 'Doe', '+18017234'),
(870, 'user635149', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 2, 'New York', 'Female', 'user990928@example.com', '2006-06-01', '2024-07-29 00:00:29', 'Jim', 'Williams', '+14267855'),
(871, 'user392527', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 4, 'New York', 'Male', 'user358771@example.com', '2005-06-30', '2024-07-29 00:00:29', 'Jane', 'Doe', '+11570903'),
(872, 'user370415', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Brown', 3, 3, 'New York', 'Female', 'user057255@example.com', '2002-09-26', '2024-07-29 00:00:29', 'Jim', 'Jones', '+10954401'),
(873, 'user804182', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 3, 'California', 'Male', 'user988865@example.com', '2010-09-19', '2024-07-29 00:00:29', 'Jim', 'Jones', '+12178834'),
(874, 'user294907', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 2, 3, 'Florida', 'Female', 'user480585@example.com', '2014-07-15', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+13294103'),
(875, 'user471593', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 1, 4, 'Illinois', 'Male', 'user998203@example.com', '2015-10-07', '2024-07-29 00:00:29', 'Jill', 'Jones', '+15002537'),
(876, 'user913150', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 3, 4, 'California', 'Female', 'user735253@example.com', '2018-04-20', '2024-07-29 00:00:29', 'Jenny', 'Johnson', '+18573991'),
(877, 'user222323', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 3, 'California', 'Female', 'user162880@example.com', '2001-01-13', '2024-07-29 00:00:29', 'Joe', 'Williams', '+17437953'),
(878, 'user926515', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 3, 4, 'New York', 'Male', 'user227439@example.com', '2007-07-26', '2024-07-29 00:00:29', 'John', 'Smith', '+18034536'),
(879, 'user454630', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 4, 'California', 'Female', 'user482889@example.com', '2007-12-05', '2024-07-29 00:00:29', 'Jim', 'Brown', '+15097436'),
(880, 'user393380', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 3, 'Illinois', 'Female', 'user436653@example.com', '2006-10-30', '2024-07-29 00:00:29', 'Jane', 'Smith', '+17991609'),
(881, 'user068293', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 3, 1, 'Florida', 'Female', 'user202979@example.com', '2003-08-24', '2024-07-29 00:00:30', 'Jane', 'Williams', '+14187024'),
(882, 'user240083', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 1, 4, 'Florida', 'Male', 'user631555@example.com', '2020-07-29', '2024-07-29 00:00:30', 'Joe', 'Smith', '+15616092'),
(883, 'user226759', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 2, 3, 'New York', 'Female', 'user765639@example.com', '2021-02-12', '2024-07-29 00:00:30', 'Jill', 'Brown', '+10611447'),
(884, 'user126225', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 3, 1, 'New York', 'Male', 'user907497@example.com', '2007-10-12', '2024-07-29 00:00:30', 'John', 'Smith', '+18469925'),
(885, 'user630659', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 3, 'Florida', 'Female', 'user212744@example.com', '2010-05-26', '2024-07-29 00:00:30', 'Joe', 'Smith', '+10693143'),
(886, 'user580182', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 3, 'New York', 'Female', 'user482688@example.com', '2004-04-04', '2024-07-29 00:00:30', 'Jill', 'Doe', '+16149550'),
(887, 'user962303', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 3, 2, 'New York', 'Female', 'user504743@example.com', '2018-03-24', '2024-07-29 00:00:30', 'Jill', 'Brown', '+17493356'),
(888, 'user532568', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 1, 2, 'Illinois', 'Female', 'user598264@example.com', '2000-10-23', '2024-07-29 00:00:30', 'Jim', 'Jones', '+10362321'),
(889, 'user656415', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 1, 'Illinois', 'Female', 'user145447@example.com', '2011-10-10', '2024-07-29 00:00:30', 'Jane', 'Williams', '+14672937'),
(890, 'user403598', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 4, 'Illinois', 'Male', 'user823144@example.com', '2015-01-06', '2024-07-29 00:00:30', 'Jenny', 'Brown', '+17973870'),
(891, 'user783753', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 2, 'New York', 'Male', 'user786908@example.com', '2009-08-11', '2024-07-29 00:00:30', 'Jenny', 'Jones', '+17540494'),
(892, 'user217543', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 1, 'Florida', 'Male', 'user399997@example.com', '2017-01-01', '2024-07-29 00:00:30', 'Joe', 'Doe', '+13517130'),
(893, 'user520534', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 1, 3, 'Texas', 'Female', 'user062475@example.com', '2009-01-21', '2024-07-29 00:00:30', 'Jenny', 'Doe', '+11705461'),
(894, 'user365188', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 2, 4, 'Texas', 'Male', 'user019787@example.com', '2018-05-18', '2024-07-29 00:00:30', 'John', 'Doe', '+14035862'),
(895, 'user531199', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 1, 'Florida', 'Female', 'user073779@example.com', '2018-06-25', '2024-07-29 00:00:30', 'Jenny', 'Johnson', '+12948699'),
(896, 'user101323', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 2, 'Texas', 'Male', 'user461551@example.com', '2001-12-14', '2024-07-29 00:00:30', 'John', 'Doe', '+10058490'),
(897, 'user915859', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 4, 'Florida', 'Female', 'user392350@example.com', '2004-06-05', '2024-07-29 00:00:30', 'Jenny', 'Williams', '+13076399'),
(898, 'user853098', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 1, 'Illinois', 'Male', 'user930629@example.com', '2002-12-03', '2024-07-29 00:00:30', 'Jenny', 'Jones', '+12589441'),
(899, 'user363443', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 2, 4, 'Illinois', 'Male', 'user868656@example.com', '2020-06-29', '2024-07-29 00:00:30', 'John', 'Williams', '+15634149'),
(900, 'user148164', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 1, 'Texas', 'Male', 'user700305@example.com', '2018-09-30', '2024-07-29 00:00:30', 'Jane', 'Smith', '+10988729'),
(901, 'user512782', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Brown', 1, 3, 'New York', 'Male', 'user718067@example.com', '2018-04-22', '2024-07-29 00:00:30', 'John', 'Williams', '+10118652'),
(902, 'user207257', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 3, 2, 'California', 'Female', 'user908453@example.com', '2017-10-14', '2024-07-29 00:00:30', 'Jim', 'Smith', '+11873160'),
(903, 'user221342', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 1, 'Florida', 'Male', 'user802207@example.com', '2009-04-13', '2024-07-29 00:00:30', 'Joe', 'Smith', '+13205465'),
(904, 'user727628', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 1, 'California', 'Female', 'user286914@example.com', '2019-07-28', '2024-07-29 00:00:30', 'Jill', 'Johnson', '+19498974'),
(905, 'user687031', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 2, 'Florida', 'Male', 'user210390@example.com', '2016-06-25', '2024-07-29 00:00:30', 'John', 'Johnson', '+16060770'),
(906, 'user829935', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 3, 3, 'New York', 'Male', 'user992951@example.com', '2020-01-09', '2024-07-29 00:00:30', 'Jill', 'Smith', '+13145711'),
(907, 'user918216', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 2, 4, 'New York', 'Female', 'user326433@example.com', '2010-09-23', '2024-07-29 00:00:30', 'Jim', 'Jones', '+19919840'),
(908, 'user318740', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 3, 'Illinois', 'Male', 'user273897@example.com', '2020-05-24', '2024-07-29 00:00:30', 'Jenny', 'Johnson', '+13854725');
INSERT INTO `students` (`student_id`, `username`, `password`, `fname`, `lname`, `grade`, `section`, `address`, `gender`, `email_address`, `date_of_birth`, `date_of_joined`, `parent_fname`, `parent_lname`, `parent_phone_number`) VALUES
(909, 'user794448', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 1, 1, 'California', 'Male', 'user539048@example.com', '2011-04-13', '2024-07-29 00:00:30', 'Jenny', 'Smith', '+13520202'),
(910, 'user024351', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 1, 3, 'Illinois', 'Female', 'user946799@example.com', '2010-10-12', '2024-07-29 00:00:30', 'Jill', 'Williams', '+12674295'),
(911, 'user459872', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 1, 4, 'California', 'Female', 'user224718@example.com', '2007-10-22', '2024-07-29 00:00:30', 'John', 'Johnson', '+10352433'),
(912, 'user760130', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 4, 'Texas', 'Male', 'user146432@example.com', '2012-12-07', '2024-07-29 00:00:30', 'Jill', 'Brown', '+14360018'),
(913, 'user794355', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 3, 'New York', 'Female', 'user535726@example.com', '2021-10-07', '2024-07-29 00:00:30', 'Jim', 'Brown', '+10574482'),
(914, 'user801078', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 1, 2, 'Texas', 'Male', 'user990777@example.com', '2004-11-07', '2024-07-29 00:00:30', 'John', 'Doe', '+16526195'),
(915, 'user228088', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 2, 'Florida', 'Male', 'user403194@example.com', '2012-05-16', '2024-07-29 00:00:30', 'Jill', 'Johnson', '+10581754'),
(916, 'user148789', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 2, 'Texas', 'Female', 'user616425@example.com', '2005-02-11', '2024-07-29 00:00:30', 'Jane', 'Jones', '+15050278'),
(917, 'user848693', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 1, 1, 'New York', 'Female', 'user962443@example.com', '2021-05-26', '2024-07-29 00:00:30', 'Jenny', 'Doe', '+12975948'),
(918, 'user313245', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 2, 'New York', 'Female', 'user060165@example.com', '2012-06-23', '2024-07-29 00:00:30', 'Joe', 'Williams', '+11515278'),
(919, 'user864226', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 2, 'New York', 'Female', 'user259191@example.com', '2002-12-18', '2024-07-29 00:00:30', 'Jenny', 'Doe', '+17477766'),
(920, 'user472064', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 2, 4, 'California', 'Female', 'user485359@example.com', '2008-03-16', '2024-07-29 00:00:30', 'Jim', 'Jones', '+15556794'),
(921, 'user894302', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 2, 'New York', 'Female', 'user375671@example.com', '2003-11-03', '2024-07-29 00:00:30', 'Joe', 'Smith', '+18573859'),
(922, 'user623594', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 3, 'Texas', 'Male', 'user884239@example.com', '2021-02-19', '2024-07-29 00:00:30', 'Jane', 'Jones', '+13176507'),
(923, 'user687323', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 1, 3, 'Illinois', 'Female', 'user738501@example.com', '2021-04-08', '2024-07-29 00:00:30', 'Jill', 'Smith', '+15104767'),
(924, 'user694382', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 1, 3, 'Florida', 'Male', 'user934998@example.com', '2020-10-13', '2024-07-29 00:00:30', 'Jenny', 'Jones', '+14392472'),
(925, 'user641234', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 3, 1, 'Florida', 'Female', 'user363363@example.com', '2006-05-07', '2024-07-29 00:00:30', 'Jim', 'Jones', '+15512013'),
(926, 'user979040', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 2, 'Florida', 'Female', 'user301743@example.com', '2015-07-18', '2024-07-29 00:00:30', 'Jill', 'Doe', '+15012840'),
(927, 'user248252', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 2, 3, 'Illinois', 'Male', 'user631861@example.com', '2009-11-29', '2024-07-29 00:00:30', 'Jim', 'Johnson', '+12908111'),
(928, 'user018536', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 3, 'Florida', 'Female', 'user081600@example.com', '2015-10-09', '2024-07-29 00:00:30', 'Jim', 'Williams', '+10249839'),
(929, 'user269566', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Williams', 3, 1, 'Florida', 'Female', 'user219412@example.com', '2012-03-20', '2024-07-29 00:00:30', 'John', 'Jones', '+15072418'),
(930, 'user596731', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 1, 2, 'Illinois', 'Female', 'user473140@example.com', '2020-05-17', '2024-07-29 00:00:30', 'Jane', 'Johnson', '+11520050'),
(931, 'user651007', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 4, 'California', 'Male', 'user673934@example.com', '2019-07-17', '2024-07-29 00:00:30', 'Jim', 'Williams', '+12763827'),
(932, 'user825809', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 4, 'California', 'Female', 'user856129@example.com', '2013-08-16', '2024-07-29 00:00:30', 'Jill', 'Jones', '+15922457'),
(933, 'user430336', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Williams', 3, 1, 'Florida', 'Female', 'user293632@example.com', '2017-12-08', '2024-07-29 00:00:30', 'Jane', 'Williams', '+14200854'),
(934, 'user263481', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 1, 'California', 'Male', 'user611736@example.com', '2004-01-12', '2024-07-29 00:00:30', 'John', 'Jones', '+11152076'),
(935, 'user953360', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 3, 1, 'Texas', 'Female', 'user844876@example.com', '2015-10-04', '2024-07-29 00:00:30', 'John', 'Doe', '+15845812'),
(936, 'user459566', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 2, 'Texas', 'Female', 'user864317@example.com', '2004-06-14', '2024-07-29 00:00:30', 'Jim', 'Williams', '+12701850'),
(937, 'user826273', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 4, 'Florida', 'Female', 'user774708@example.com', '2011-02-02', '2024-07-29 00:00:30', 'Jane', 'Williams', '+19629773'),
(938, 'user264276', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 2, 3, 'Texas', 'Female', 'user582020@example.com', '2007-12-16', '2024-07-29 00:00:30', 'John', 'Smith', '+10989304'),
(939, 'user708619', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 3, 'Florida', 'Male', 'user769725@example.com', '2017-01-11', '2024-07-29 00:00:30', 'Jill', 'Williams', '+10698680'),
(940, 'user665561', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 2, 'Florida', 'Male', 'user981977@example.com', '2016-01-22', '2024-07-29 00:00:30', 'Joe', 'Johnson', '+18388089'),
(941, 'user995081', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Smith', 1, 4, 'New York', 'Female', 'user816766@example.com', '2012-06-28', '2024-07-29 00:00:30', 'Jim', 'Smith', '+12745470'),
(942, 'user485596', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Williams', 1, 2, 'Florida', 'Female', 'user728327@example.com', '2004-05-14', '2024-07-29 00:00:30', 'Joe', 'Johnson', '+18795352'),
(943, 'user007741', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 3, 2, 'Texas', 'Female', 'user080757@example.com', '2008-03-04', '2024-07-29 00:00:30', 'Jill', 'Jones', '+11280081'),
(944, 'user640147', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 2, 2, 'Texas', 'Female', 'user976221@example.com', '2000-08-13', '2024-07-29 00:00:30', 'Jane', 'Jones', '+12437071'),
(945, 'user290550', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 2, 'California', 'Female', 'user793600@example.com', '2006-02-22', '2024-07-29 00:00:30', 'John', 'Smith', '+12799795'),
(946, 'user591894', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Brown', 3, 2, 'California', 'Male', 'user042515@example.com', '2018-02-07', '2024-07-29 00:00:30', 'John', 'Williams', '+17215374'),
(947, 'user964895', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 1, 'Illinois', 'Male', 'user517140@example.com', '2005-12-27', '2024-07-29 00:00:30', 'Joe', 'Smith', '+18459059'),
(948, 'user453549', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 1, 2, 'California', 'Male', 'user761782@example.com', '2016-12-30', '2024-07-29 00:00:30', 'Jill', 'Williams', '+14439354'),
(949, 'user282791', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Williams', 2, 1, 'New York', 'Female', 'user998657@example.com', '2004-01-26', '2024-07-29 00:00:30', 'Jenny', 'Doe', '+17362585'),
(950, 'user360405', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 2, 3, 'Illinois', 'Female', 'user741093@example.com', '2021-11-11', '2024-07-29 00:00:30', 'Joe', 'Jones', '+19163515'),
(951, 'user050097', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 1, 2, 'Illinois', 'Male', 'user822447@example.com', '2021-02-21', '2024-07-29 00:00:30', 'Jim', 'Jones', '+14178494'),
(952, 'user392443', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 3, 2, 'New York', 'Female', 'user665986@example.com', '2002-11-06', '2024-07-29 00:00:30', 'Jill', 'Jones', '+14000559'),
(953, 'user386083', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 1, 4, 'Florida', 'Female', 'user671624@example.com', '2017-08-19', '2024-07-29 00:00:30', 'John', 'Williams', '+11510580'),
(954, 'user846117', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Johnson', 2, 1, 'Illinois', 'Male', 'user846945@example.com', '2001-03-04', '2024-07-29 00:00:30', 'Joe', 'Johnson', '+11852755'),
(955, 'user507106', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 3, 3, 'New York', 'Male', 'user803309@example.com', '2017-12-12', '2024-07-29 00:00:30', 'Joe', 'Jones', '+18307593'),
(956, 'user218026', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Johnson', 3, 2, 'California', 'Female', 'user358369@example.com', '2015-01-04', '2024-07-29 00:00:30', 'Jim', 'Brown', '+14496641'),
(957, 'user146154', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Johnson', 1, 3, 'Texas', 'Female', 'user527919@example.com', '2018-04-02', '2024-07-29 00:00:30', 'Jill', 'Johnson', '+13211147'),
(958, 'user363941', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Smith', 2, 2, 'Texas', 'Female', 'user641857@example.com', '2005-12-01', '2024-07-29 00:00:30', 'Jim', 'Smith', '+13032835'),
(959, 'user568974', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 2, 'California', 'Female', 'user727922@example.com', '2002-09-22', '2024-07-29 00:00:30', 'Jim', 'Brown', '+17740840'),
(960, 'user417249', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 2, 1, 'Texas', 'Female', 'user659638@example.com', '2006-07-12', '2024-07-29 00:00:30', 'Jill', 'Williams', '+17744715'),
(961, 'user887664', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 1, 2, 'New York', 'Male', 'user336850@example.com', '2010-01-12', '2024-07-29 00:00:30', 'Jane', 'Doe', '+12843514'),
(962, 'user347524', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Johnson', 1, 1, 'Florida', 'Male', 'user912502@example.com', '2006-01-11', '2024-07-29 00:00:30', 'Jill', 'Johnson', '+19284486'),
(963, 'user534976', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 2, 1, 'California', 'Male', 'user796270@example.com', '2010-04-06', '2024-07-29 00:00:30', 'Jenny', 'Johnson', '+19604664'),
(964, 'user708766', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 3, 1, 'Illinois', 'Male', 'user327237@example.com', '2020-11-14', '2024-07-29 00:00:30', 'Joe', 'Doe', '+19358663'),
(965, 'user508032', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 2, 1, 'Illinois', 'Female', 'user301817@example.com', '2013-11-23', '2024-07-29 00:00:30', 'Jane', 'Johnson', '+13525019'),
(966, 'user470800', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 2, 1, 'New York', 'Male', 'user545051@example.com', '2005-03-17', '2024-07-29 00:00:30', 'Jill', 'Doe', '+16178160'),
(967, 'user921448', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Doe', 3, 4, 'Florida', 'Male', 'user226418@example.com', '2020-12-16', '2024-07-29 00:00:30', 'John', 'Williams', '+19622365'),
(968, 'user844367', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Doe', 3, 1, 'Texas', 'Female', 'user656246@example.com', '2020-04-25', '2024-07-29 00:00:30', 'Joe', 'Williams', '+18029634'),
(969, 'user329011', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 1, 3, 'Illinois', 'Female', 'user302907@example.com', '2014-03-31', '2024-07-29 00:00:30', 'Jim', 'Brown', '+17988197'),
(970, 'user696650', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 2, 'Illinois', 'Female', 'user962957@example.com', '2020-03-14', '2024-07-29 00:00:30', 'Joe', 'Jones', '+10609671'),
(971, 'user767747', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Jones', 3, 3, 'Texas', 'Male', 'user951051@example.com', '2000-04-01', '2024-07-29 00:00:30', 'Jane', 'Jones', '+13212249'),
(972, 'user645746', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Johnson', 1, 3, 'California', 'Male', 'user724741@example.com', '2002-09-09', '2024-07-29 00:00:30', 'Jim', 'Brown', '+18391582'),
(973, 'user700123', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 1, 'Texas', 'Male', 'user677228@example.com', '2012-02-23', '2024-07-29 00:00:30', 'Joe', 'Doe', '+19816943'),
(974, 'user785868', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 3, 3, 'Texas', 'Male', 'user396190@example.com', '2019-05-08', '2024-07-29 00:00:30', 'Jane', 'Johnson', '+17767880'),
(975, 'user406472', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 2, 4, 'California', 'Female', 'user059493@example.com', '2021-04-07', '2024-07-29 00:00:30', 'Joe', 'Johnson', '+13091953'),
(976, 'user143599', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 1, 3, 'California', 'Female', 'user567371@example.com', '2001-05-21', '2024-07-29 00:00:30', 'Jill', 'Jones', '+15716840'),
(977, 'user209070', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 1, 3, 'Texas', 'Female', 'user480724@example.com', '2000-01-04', '2024-07-29 00:00:30', 'Jill', 'Brown', '+13119015'),
(978, 'user164516', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 1, 2, 'Illinois', 'Male', 'user677473@example.com', '2005-08-30', '2024-07-29 00:00:30', 'Jane', 'Williams', '+18448667'),
(979, 'user649212', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Williams', 3, 3, 'Illinois', 'Female', 'user061529@example.com', '2011-10-15', '2024-07-29 00:00:30', 'Jill', 'Jones', '+10721283'),
(980, 'user605437', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Smith', 3, 1, 'New York', 'Male', 'user508192@example.com', '2002-06-12', '2024-07-29 00:00:30', 'John', 'Brown', '+10638596'),
(981, 'user820579', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 3, 2, 'Illinois', 'Male', 'user749379@example.com', '2011-11-18', '2024-07-29 00:00:30', 'Jim', 'Brown', '+10730885'),
(982, 'user286247', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Smith', 2, 1, 'New York', 'Female', 'user866777@example.com', '2017-08-27', '2024-07-29 00:00:30', 'Jim', 'Brown', '+13639031'),
(983, 'user627656', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 2, 4, 'New York', 'Female', 'user674518@example.com', '2019-01-07', '2024-07-29 00:00:30', 'Jane', 'Jones', '+19687328'),
(984, 'user890270', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 2, 1, 'California', 'Male', 'user825298@example.com', '2017-06-19', '2024-07-29 00:00:30', 'Jill', 'Doe', '+12911471'),
(985, 'user960315', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 1, 4, 'Illinois', 'Male', 'user313209@example.com', '2020-04-11', '2024-07-29 00:00:30', 'Joe', 'Brown', '+12745710'),
(986, 'user367680', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Jones', 3, 1, 'California', 'Female', 'user876547@example.com', '2005-10-11', '2024-07-29 00:00:30', 'Joe', 'Williams', '+12142730'),
(987, 'user101445', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Doe', 2, 2, 'Florida', 'Female', 'user536673@example.com', '2000-07-19', '2024-07-29 00:00:30', 'Jill', 'Williams', '+19585713'),
(988, 'user290369', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 1, 3, 'Illinois', 'Female', 'user915061@example.com', '2009-07-17', '2024-07-29 00:00:30', 'Jim', 'Jones', '+19934836'),
(989, 'user391735', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 2, 1, 'Texas', 'Male', 'user732021@example.com', '2013-05-29', '2024-07-29 00:00:30', 'Jenny', 'Johnson', '+18456878'),
(990, 'user764132', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 3, 'California', 'Female', 'user080430@example.com', '2016-10-25', '2024-07-29 00:00:30', 'Jill', 'Brown', '+16340488'),
(991, 'user113801', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Jones', 3, 4, 'California', 'Male', 'user260431@example.com', '2004-01-08', '2024-07-29 00:00:30', 'John', 'Doe', '+12521057'),
(992, 'user863329', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Smith', 2, 2, 'New York', 'Female', 'user995835@example.com', '2007-10-11', '2024-07-29 00:00:30', 'Joe', 'Jones', '+10096198'),
(993, 'user423914', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Smith', 2, 3, 'California', 'Female', 'user696547@example.com', '2020-10-25', '2024-07-29 00:00:30', 'Jill', 'Johnson', '+13224890'),
(994, 'user226080', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Doe', 1, 3, 'California', 'Male', 'user204659@example.com', '2020-04-19', '2024-07-29 00:00:30', 'John', 'Smith', '+15350148'),
(995, 'user718354', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Brown', 3, 2, 'Illinois', 'Male', 'user591566@example.com', '2006-04-26', '2024-07-29 00:00:30', 'Joe', 'Johnson', '+13557685'),
(996, 'user364131', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 1, 3, 'California', 'Male', 'user512646@example.com', '2005-03-19', '2024-07-29 00:00:30', 'Jill', 'Williams', '+17859345'),
(997, 'user283399', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'John', 'Johnson', 1, 4, 'Texas', 'Male', 'user910663@example.com', '2004-09-06', '2024-07-29 00:00:30', 'Jim', 'Doe', '+12082008'),
(998, 'user909372', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 2, 3, 'New York', 'Male', 'user784680@example.com', '2017-05-16', '2024-07-29 00:00:30', 'Jill', 'Brown', '+15664855'),
(999, 'user790878', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 1, 'Illinois', 'Male', 'user795155@example.com', '2002-12-17', '2024-07-29 00:00:30', 'Jane', 'Doe', '+13589689'),
(1000, 'user656954', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Doe', 3, 2, 'Florida', 'Female', 'user457629@example.com', '2021-11-21', '2024-07-29 00:00:30', 'Jill', 'Doe', '+17473522'),
(1001, 'user364201', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Brown', 1, 4, 'Illinois', 'Male', 'user405142@example.com', '2017-05-30', '2024-07-29 00:00:30', 'Joe', 'Johnson', '+17795563'),
(1002, 'user663389', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Jones', 2, 1, 'New York', 'Female', 'user818414@example.com', '2015-07-21', '2024-07-29 00:00:30', 'John', 'Johnson', '+14392969'),
(1003, 'user161904', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jim', 'Jones', 2, 1, 'Illinois', 'Female', 'user258299@example.com', '2009-12-23', '2024-07-29 00:00:30', 'Jill', 'Doe', '+12260286'),
(1004, 'user689720', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Joe', 'Brown', 2, 3, 'Texas', 'Female', 'user407337@example.com', '2012-05-06', '2024-07-29 00:00:30', 'Jill', 'Smith', '+16645328'),
(1005, 'user450521', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jane', 'Jones', 3, 4, 'Texas', 'Male', 'user733764@example.com', '2010-02-16', '2024-07-29 00:00:30', 'John', 'Smith', '+15079848'),
(1006, 'user035062', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jill', 'Doe', 3, 3, 'Texas', 'Male', 'user589312@example.com', '2018-08-27', '2024-07-29 00:00:30', 'Jim', 'Jones', '+10187407'),
(1007, 'user399269', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', 'Jenny', 'Williams', 3, 4, 'Florida', 'Female', 'user436146@example.com', '2000-07-03', '2024-07-29 00:00:30', 'Joe', 'Jones', '+14051545');

-- --------------------------------------------------------

--
-- Table structure for table `student_score`
--

CREATE TABLE `student_score` (
  `id` int(11) NOT NULL,
  `semester` varchar(100) NOT NULL,
  `year` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `results` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_score`
--

INSERT INTO `student_score` (`id`, `semester`, `year`, `student_id`, `teacher_id`, `subject_id`, `results`) VALUES
(1, 'II', 2021, 1, 1, 1, '10 15,15 20,10 10,10 20,30 35'),
(2, 'II', 2023, 1, 1, 4, '15 20,4 5'),
(3, 'I', 2022, 1, 1, 5, '10 20,50 50'),
(4, 'I', 2024, 1, 112, 1, '10 20,15 25'),
(5, 'II', 2024, 2, 112, 2, '20 30,10 20'),
(6, 'I', 2024, 3, 112, 3, '15 25,20 30'),
(7, 'II', 2024, 4, 112, 4, '12 18,22 27'),
(8, 'I', 2024, 5, 112, 5, '17 28,24 31'),
(9, 'II', 2024, 6, 112, 6, '19 27,30 40'),
(10, 'I', 2024, 7, 112, 7, '16 26,25 35'),
(11, 'II', 2024, 8, 112, 1, '14 22,20 30'),
(12, 'I', 2024, 9, 112, 2, '18 25,15 20'),
(13, 'II', 2024, 10, 112, 3, '20 30,10 25'),
(14, 'I', 2024, 11, 112, 4, '12 22,23 28'),
(15, 'II', 2024, 12, 112, 5, '17 26,22 30'),
(16, 'I', 2024, 13, 112, 6, '14 20,30 35'),
(17, 'II', 2024, 14, 112, 7, '16 24,28 32'),
(18, 'I', 2024, 15, 112, 1, '13 22,25 30'),
(19, 'II', 2024, 16, 112, 2, '19 27,20 25'),
(20, 'I', 2024, 17, 112, 3, '18 28,22 30'),
(21, 'II', 2024, 18, 112, 4, '12 20,25 35'),
(22, 'I', 2024, 19, 112, 5, '20 30,18 25'),
(23, 'II', 2024, 20, 112, 6, '14 22,24 32'),
(24, 'I', 2024, 21, 112, 7, '16 26,27 34'),
(25, 'II', 2024, 22, 112, 1, '15 25,28 33'),
(26, 'I', 2024, 23, 112, 2, '17 24,22 31'),
(27, 'II', 2024, 24, 112, 3, '20 30,25 35'),
(28, 'I', 2024, 25, 112, 4, '14 22,26 30'),
(29, 'II', 2024, 26, 112, 5, '19 28,20 30'),
(30, 'I', 2024, 27, 112, 6, '16 24,22 35'),
(31, 'II', 2024, 28, 112, 7, '18 26,25 32'),
(32, 'I', 2024, 29, 112, 1, '13 22,20 30'),
(33, 'II', 2024, 30, 112, 2, '20 28,15 25'),
(34, 'I', 2024, 31, 112, 3, '17 26,22 34'),
(35, 'II', 2024, 32, 112, 4, '14 22,30 35'),
(36, 'I', 2024, 33, 112, 5, '16 24,25 31'),
(37, 'II', 2024, 34, 112, 6, '18 28,20 30'),
(38, 'I', 2024, 35, 112, 7, '12 22,28 35'),
(39, 'II', 2024, 36, 112, 1, '19 27,25 34'),
(40, 'I', 2024, 37, 112, 2, '20 30,18 25'),
(41, 'II', 2024, 38, 112, 3, '14 22,27 33'),
(42, 'I', 2024, 39, 112, 4, '16 24,25 30'),
(43, 'II', 2024, 40, 112, 5, '18 26,20 32'),
(44, 'I', 2024, 41, 112, 6, '12 22,28 35'),
(45, 'II', 2024, 42, 112, 7, '19 27,24 31'),
(46, 'I', 2024, 43, 112, 1, '20 30,22 35'),
(47, 'II', 2024, 44, 112, 2, '15 25,20 28'),
(48, 'I', 2024, 45, 112, 3, '14 22,30 35'),
(49, 'II', 2024, 46, 112, 4, '16 24,28 34'),
(50, 'I', 2024, 47, 112, 5, '18 26,22 30'),
(51, 'II', 2024, 48, 112, 6, '12 22,25 35'),
(52, 'I', 2024, 49, 112, 7, '20 30,17 25'),
(53, 'II', 2024, 50, 112, 1, '19 27,20 30'),
(54, 'I', 2024, 51, 112, 2, '14 22,28 35'),
(55, 'II', 2024, 52, 112, 3, '16 24,25 32'),
(56, 'I', 2024, 53, 112, 4, '18 26,20 30'),
(57, 'II', 2024, 54, 112, 5, '20 30,22 35'),
(58, 'I', 2024, 55, 112, 6, '12 22,27 33'),
(59, 'II', 2024, 56, 112, 7, '19 27,24 32'),
(60, 'I', 2024, 57, 112, 1, '20 30,22 35'),
(61, 'II', 2024, 58, 112, 2, '15 25,20 30'),
(62, 'I', 2024, 59, 112, 3, '14 22,28 35'),
(63, 'II', 2024, 60, 112, 4, '16 24,25 30'),
(64, 'I', 2024, 61, 112, 5, '18 26,20 32'),
(65, 'II', 2024, 62, 112, 6, '12 22,25 35'),
(66, 'I', 2024, 63, 112, 7, '20 30,17 25'),
(67, 'II', 2024, 64, 112, 1, '19 27,20 28'),
(68, 'I', 2024, 65, 112, 2, '14 22,28 34'),
(69, 'II', 2024, 66, 112, 3, '16 24,25 35'),
(70, 'I', 2024, 67, 112, 4, '18 26,22 30'),
(71, 'II', 2024, 68, 112, 5, '20 30,22 35'),
(72, 'I', 2024, 69, 112, 6, '12 22,27 33'),
(73, 'II', 2024, 70, 112, 7, '19 27,24 31'),
(74, 'I', 2024, 71, 112, 1, '20 30,22 35'),
(75, 'II', 2024, 72, 112, 2, '15 25,20 30'),
(76, 'I', 2024, 73, 112, 3, '14 22,28 35'),
(77, 'II', 2024, 74, 112, 4, '16 24,25 30'),
(78, 'I', 2024, 75, 112, 5, '18 26,20 32'),
(79, 'II', 2024, 76, 112, 6, '12 22,27 35'),
(80, 'I', 2024, 77, 112, 7, '20 30,17 25'),
(81, 'II', 2024, 78, 112, 1, '19 27,20 30'),
(82, 'I', 2024, 79, 112, 2, '14 22,28 34'),
(83, 'II', 2024, 80, 112, 3, '16 24,25 32'),
(84, 'I', 2024, 81, 112, 4, '18 26,20 30'),
(85, 'II', 2024, 82, 112, 5, '20 30,22 35'),
(86, 'I', 2024, 83, 112, 6, '12 22,27 33'),
(87, 'II', 2024, 84, 112, 7, '19 27,24 31'),
(88, 'I', 2024, 85, 112, 1, '20 30,22 35'),
(89, 'II', 2024, 86, 112, 2, '15 25,20 30'),
(90, 'I', 2024, 87, 112, 3, '14 22,28 34'),
(91, 'II', 2024, 88, 112, 4, '16 24,25 30'),
(92, 'I', 2024, 89, 112, 5, '18 26,20 32'),
(93, 'II', 2024, 90, 112, 6, '12 22,27 35'),
(94, 'I', 2024, 91, 112, 7, '20 30,17 25'),
(95, 'II', 2024, 92, 112, 1, '19 27,20 30'),
(96, 'I', 2024, 93, 112, 2, '14 22,28 34'),
(97, 'II', 2024, 94, 112, 3, '16 24,25 32'),
(98, 'I', 2024, 95, 112, 4, '18 26,20 30'),
(99, 'II', 2024, 96, 112, 5, '20 30,22 35'),
(100, 'I', 2024, 97, 112, 6, '12 22,27 35'),
(101, 'II', 2024, 98, 112, 7, '19 27,24 31'),
(102, 'I', 2024, 99, 112, 1, '20 30,22 35'),
(103, 'II', 2024, 100, 112, 2, '15 25,20 30');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject` varchar(31) NOT NULL,
  `subject_code` varchar(31) NOT NULL,
  `grade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject`, `subject_code`, `grade`) VALUES
(1, 'Math', 'MATH', 1),
(2, 'Physics', 'PHY', 1),
(3, 'English', 'ENG', 1),
(4, 'Biology', 'BIO', 1),
(5, 'Chemistry', 'CHEM', 1),
(6, 'Programming', 'PROG', 1),
(7, 'Geometry', 'GEO', 1),
(10, 'Literature', 'LIT', 1),
(11, 'History', 'HIST', 1),
(13, 'Philosophy', 'PHIL', 1);

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL,
  `username` varchar(127) NOT NULL,
  `password` varchar(255) NOT NULL,
  `class` varchar(31) NOT NULL,
  `fname` varchar(127) NOT NULL,
  `lname` varchar(127) NOT NULL,
  `subjects` varchar(31) NOT NULL,
  `address` varchar(31) NOT NULL,
  `employee_number` int(11) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `phone_number` varchar(31) NOT NULL,
  `qualification` varchar(127) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `email_address` varchar(255) NOT NULL,
  `date_of_joined` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `username`, `password`, `class`, `fname`, `lname`, `subjects`, `address`, `employee_number`, `date_of_birth`, `phone_number`, `qualification`, `gender`, `email_address`, `date_of_joined`) VALUES
(51, 'Jane Garcia', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jane', 'Garcia', '', 'Florida', 0, '1987-09-07', '+17843008', '', 'Male', 'jane.garcia@example.com', '2024-07-29 03:47:40'),
(52, 'Nick Rodriguez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Nick', 'Rodriguez', '', 'New York', 0, '1976-08-17', '+13825034', '', 'Female', 'nick.rodriguez@example.com', '2024-07-29 03:47:40'),
(53, 'Eva Anderson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Eva', 'Anderson', '', 'California', 0, '2007-11-02', '+16116460', '', 'Female', 'eva.anderson@example.com', '2024-07-29 03:47:40'),
(54, 'Nick Johnson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Nick', 'Johnson', '', 'Texas', 0, '2006-11-24', '+16608717', '', 'Male', 'nick.johnson@example.com', '2024-07-29 03:47:40'),
(55, 'Jenny Rodriguez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jenny', 'Rodriguez', '', 'California', 0, '1989-06-07', '+10024340', '', 'Male', 'jenny.rodriguez@example.com', '2024-07-29 03:47:40'),
(56, 'Mona Hernandez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Mona', 'Hernandez', '', 'Illinois', 0, '2016-05-22', '+16710355', '', 'Female', 'mona.hernandez@example.com', '2024-07-29 03:47:40'),
(57, 'Karen Johnson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Karen', 'Johnson', '', 'Illinois', 0, '1998-11-10', '+16173695', '', 'Male', 'karen.johnson@example.com', '2024-07-29 03:47:40'),
(58, 'Eva Thomas', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Eva', 'Thomas', '', 'Illinois', 0, '2019-10-21', '+16423841', '', 'Male', 'eva.thomas@example.com', '2024-07-29 03:47:40'),
(59, 'Dave Wilson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Dave', 'Wilson', '', 'Illinois', 0, '2003-08-28', '+15076599', '', 'Female', 'dave.wilson@example.com', '2024-07-29 03:47:40'),
(60, 'Hank Thompson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Hank', 'Thompson', '', 'Florida', 0, '1988-09-22', '+13118654', '', 'Male', 'hank.thompson@example.com', '2024-07-29 03:47:40'),
(61, 'Eva Hernandez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Eva', 'Hernandez', '', 'New York', 0, '1983-11-12', '+10142026', '', 'Male', 'eva.hernandez@example.com', '2024-07-29 03:47:40'),
(62, 'Alice Martinez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Alice', 'Martinez', '', 'Florida', 0, '1989-01-21', '+17801972', '', 'Female', 'alice.martinez@example.com', '2024-07-29 03:47:40'),
(63, 'Leo Thompson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Leo', 'Thompson', '', 'New York', 0, '1975-07-14', '+17780422', '', 'Female', 'leo.thompson@example.com', '2024-07-29 03:47:40'),
(64, 'Frank Taylor', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Frank', 'Taylor', '', 'California', 0, '1991-08-08', '+16925440', '', 'Male', 'frank.taylor@example.com', '2024-07-29 03:47:40'),
(65, 'Jenny Davis', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jenny', 'Davis', '', 'Florida', 0, '2015-06-08', '+16920771', '', 'Female', 'jenny.davis@example.com', '2024-07-29 03:47:40'),
(66, 'Nick Moore', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Nick', 'Moore', '', 'Illinois', 0, '2022-08-16', '+10568943', '', 'Female', 'nick.moore@example.com', '2024-07-29 03:47:40'),
(67, 'Charlie Martin', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Charlie', 'Martin', '', 'Illinois', 0, '2020-10-28', '+15274610', '', 'Male', 'charlie.martin@example.com', '2024-07-29 03:47:40'),
(68, 'Leo Thomas', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Leo', 'Thomas', '', 'Illinois', 0, '1996-06-03', '+17922950', '', 'Male', 'leo.thomas@example.com', '2024-07-29 03:47:40'),
(69, 'Eva Brown', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Eva', 'Brown', '', 'Texas', 0, '1991-09-21', '+13853853', '', 'Female', 'eva.brown@example.com', '2024-07-29 03:47:40'),
(70, 'Irene Martinez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Irene', 'Martinez', '', 'Texas', 0, '2000-06-19', '+10723790', '', 'Female', 'irene.martinez@example.com', '2024-07-29 03:47:40'),
(71, 'Hank Jones', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Hank', 'Jones', '', 'New York', 0, '2007-12-12', '+13716953', '', 'Male', 'hank.jones@example.com', '2024-07-29 03:47:40'),
(72, 'Jack Moore', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jack', 'Moore', '', 'Texas', 0, '2020-05-30', '+10145407', '', 'Female', 'jack.moore@example.com', '2024-07-29 03:47:40'),
(74, 'Jim Rodriguez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jim', 'Rodriguez', '', 'Illinois', 0, '1990-10-06', '+12272754', '', 'Male', 'jim.rodriguez@example.com', '2024-07-29 03:48:46'),
(75, 'John Garcia', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'John', 'Garcia', '', 'Florida', 0, '1995-01-24', '+14028486', '', 'Male', 'john.garcia@example.com', '2024-07-29 03:49:51'),
(76, 'Hank White', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Hank', 'White', '', 'New York', 0, '1989-10-09', '+18816224', '', 'Male', 'hank.white@example.com', '2024-07-29 03:49:51'),
(77, 'Bob White', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Bob', 'White', '', 'Illinois', 0, '2004-05-18', '+10996621', '', 'Female', 'bob.white@example.com', '2024-07-29 03:49:51'),
(78, 'Hank Moore', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Hank', 'Moore', '', 'New York', 0, '1972-08-05', '+17534881', '', 'Female', 'hank.moore@example.com', '2024-07-29 03:49:51'),
(79, 'Hank Jackson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Hank', 'Jackson', '', 'Texas', 0, '2024-10-03', '+19824982', '', 'Female', 'hank.jackson@example.com', '2024-07-29 03:49:51'),
(80, 'Nick Taylor', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Nick', 'Taylor', '', 'California', 0, '1983-02-06', '+16413075', '', 'Female', 'nick.taylor@example.com', '2024-07-29 03:49:51'),
(81, 'Eva Martinez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Eva', 'Martinez', '', 'New York', 0, '1979-03-16', '+14963511', '', 'Male', 'eva.martinez@example.com', '2024-07-29 03:49:51'),
(82, 'Bob Williams', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Bob', 'Williams', '', 'Florida', 0, '2016-12-30', '+16620556', '', 'Male', 'bob.williams@example.com', '2024-07-29 03:50:51'),
(83, 'Irene Thomas', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Irene', 'Thomas', '', 'California', 0, '1975-03-25', '+19735485', '', 'Male', 'irene.thomas@example.com', '2024-07-29 03:50:51'),
(84, 'ali White', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'ali', 'White', '', 'New York', 0, '1985-05-07', '+15005891', '', 'Female', 'ali.white@example.com', '2024-07-29 03:50:51'),
(85, 'Hank Martin', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Hank', 'Martin', '', 'New York', 0, '1976-07-10', '+10220420', '', 'Female', 'hank.martin@example.com', '2024-07-29 03:50:51'),
(86, 'Jack Thomas', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jack', 'Thomas', '', 'California', 0, '2004-06-06', '+19493128', '', 'Male', 'jack.thomas@example.com', '2024-07-29 03:50:51'),
(87, 'Leo Wilson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Leo', 'Wilson', '', 'Florida', 0, '1986-04-03', '+12707524', '', 'Male', 'leo.wilson@example.com', '2024-07-29 03:50:51'),
(89, 'Jim Garcia', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jim', 'Garcia', '', 'California', 0, '2005-06-15', '+10014063', '', 'Female', 'jim.garcia@example.com', '2024-07-29 03:51:11'),
(90, 'Jane Davis', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jane', 'Davis', '', 'Texas', 0, '1971-09-18', '+10163041', '', 'Male', 'jane.davis@example.com', '2024-07-29 03:51:11'),
(91, 'Nick Jackson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Nick', 'Jackson', '', 'Texas', 0, '1988-11-13', '+14413724', '', 'Female', 'nick.jackson@example.com', '2024-07-29 03:51:11'),
(92, 'Jill Martinez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jill', 'Martinez', '', 'New York', 0, '1970-01-05', '+10639966', '', 'Male', 'jill.martinez@example.com', '2024-07-29 03:51:11'),
(93, 'Bob Rodriguez', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Bob', 'Rodriguez', '', 'New York', 0, '1988-05-20', '+13627108', '', 'Male', 'bob.rodriguez@example.com', '2024-07-29 03:51:11'),
(94, 'Karen Thompson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Karen', 'Thompson', '', 'California', 0, '1992-12-28', '+11096722', '', 'Female', 'karen.thompson@example.com', '2024-07-29 03:51:11'),
(95, 'Jenny Williams', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jenny', 'Williams', '', 'Florida', 0, '2015-03-31', '+15638225', '', 'Male', 'jenny.williams@example.com', '2024-07-29 03:51:11'),
(96, 'Bob Smith', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Bob', 'Smith', '', 'New York', 0, '1996-05-14', '+10672107', '', 'Male', 'bob.smith@example.com', '2024-07-29 03:51:11'),
(97, 'Leo Miller', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Leo', 'Miller', '', 'Florida', 0, '1994-08-21', '+14928189', '', 'Male', 'leo.miller@example.com', '2024-07-29 03:51:11'),
(98, 'Jim Johnson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jim', 'Johnson', '', 'New York', 0, '1985-07-29', '+14323823', '', 'Male', 'jim.johnson@example.com', '2024-07-29 03:51:11'),
(99, 'Bob Jones', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Bob', 'Jones', '', 'California', 0, '2024-07-06', '+16333124', '', 'Female', 'bob.jones@example.com', '2024-07-29 03:51:11'),
(100, 'Jill Smith', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jill', 'Smith', '', 'Texas', 0, '1977-10-10', '+17945104', '', 'Male', 'jill.smith@example.com', '2024-07-29 03:51:11'),
(101, 'Frank Davis', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Frank', 'Davis', '', 'New York', 0, '1978-05-26', '+12785201', '', 'Male', 'frank.davis@example.com', '2024-07-29 03:51:11'),
(102, 'Mona Martin', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Mona', 'Martin', '', 'California', 0, '2023-06-11', '+12909714', '', 'Male', 'mona.martin@example.com', '2024-07-29 03:51:11'),
(103, 'Frank Moore', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Frank', 'Moore', '', 'California', 0, '2003-04-21', '+14636709', '', 'Female', 'frank.moore@example.com', '2024-07-29 03:51:11'),
(104, 'amir Johnson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'amir', 'Johnson', '', 'Illinois', 0, '2017-01-03', '+13379904', '', 'Male', 'amir.johnson@example.com', '2024-07-29 03:51:11'),
(105, 'Jim Anderson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Jim', 'Anderson', '', 'Texas', 0, '1998-05-22', '+18711284', '', 'Female', 'jim.anderson@example.com', '2024-07-29 03:51:11'),
(106, 'Karen Garcia', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Karen', 'Garcia', '', 'Texas', 0, '1974-06-29', '+17864962', '', 'Female', 'karen.garcia@example.com', '2024-07-29 03:51:11'),
(107, 'Hank Johnson', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Hank', 'Johnson', '', 'California', 0, '2002-05-06', '+10525647', '', 'Male', 'hank.johnson@example.com', '2024-07-29 03:51:11'),
(108, 'amir Miller', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'amir', 'Miller', '', 'New York', 0, '2010-04-02', '+12200463', '', 'Male', 'amir.miller@example.com', '2024-07-29 03:51:11'),
(109, 'Leo Martin', '$2y$10$JruTW/rNZ6CVO4nxYWCrn.GJpiIKMACEPYrK00S7Dk/fkbJIdYau2', '', 'Leo', 'Martin', '', 'California', 0, '1987-05-02', '+10944560', '', 'Male', 'leo.martin@example.com', '2024-07-29 03:51:11'),
(112, 'Mostafa', '$2y$10$oFWHwgSo.Bu.FMw1rBcMPuYwVguvbsk6b2KDfQCcOB3MmRdm1UmUu', '123', 'mostafa', 'abbasi', '1', 'zanjan', 1225, '1989-10-24', '091048863496', 'right', 'Male', 'mostafaabbasi@gmail.com', '2024-07-29 03:57:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`grade_id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `registrar_office`
--
ALTER TABLE `registrar_office`
  ADD PRIMARY KEY (`r_user_id`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`section_id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `student_score`
--
ALTER TABLE `student_score`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `grade_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `registrar_office`
--
ALTER TABLE `registrar_office`
  MODIFY `r_user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `section`
--
ALTER TABLE `section`
  MODIFY `section_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1008;

--
-- AUTO_INCREMENT for table `student_score`
--
ALTER TABLE `student_score`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
