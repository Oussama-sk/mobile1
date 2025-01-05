-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: fdb1029.awardspace.net
-- Generation Time: Jan 05, 2025 at 08:43 PM
-- Server version: 8.0.32
-- PHP Version: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `4564966_mobile`
--

-- --------------------------------------------------------

--
-- Table structure for table `color`
--

CREATE TABLE `color` (
  `id` int NOT NULL,
  `passtest` tinyint(1) NOT NULL,
  `testid` int NOT NULL,
  `answer` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `color`
--

INSERT INTO `color` (`id`, `passtest`, `testid`, `answer`) VALUES
(11, 1, 1, 3),
(12, 0, 2, 3),
(13, 1, 3, 5),
(14, 0, 4, 2),
(15, 0, 5, 0),
(16, 0, 6, 1),
(17, 0, 7, 1),
(18, 0, 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `low`
--

CREATE TABLE `low` (
  `id` int NOT NULL,
  `passtest` tinyint(1) NOT NULL,
  `testid` int NOT NULL,
  `answer` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `low`
--

INSERT INTO `low` (`id`, `passtest`, `testid`, `answer`) VALUES
(11, 0, 1, 2),
(12, 1, 2, 4),
(13, 1, 3, 5),
(14, 0, 4, 2),
(15, 0, 5, 0),
(16, 0, 6, 1),
(17, 0, 7, 1),
(18, 0, 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int NOT NULL,
  `date` date NOT NULL,
  `userid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `date`, `userid`) VALUES
(1, '2025-01-04', 4),
(2, '2025-01-04', 7),
(3, '2025-01-04', 5),
(4, '2025-01-04', 6),
(5, '2025-01-04', 7),
(6, '2025-01-04', 7),
(7, '2025-01-05', 8),
(8, '2025-01-05', 7);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `username` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`) VALUES
(4, 'testuser', 'test@example.com', '$2y$10$D8n4QlPvVqMNX1Z9Iolk0u8KiozXh0/whVfC/gBkTlnwpiZqMLCJi'),
(5, 'hadi', 'h@h', '$2y$10$otVlHrXN7VF1wOiOCePQi.gD85FaXc5f2Y4aTv9HBQA.IusyvyY1m'),
(6, 'ali', 'a@a', '$2y$10$n5v8Wpf7WqV/TowOLQOVluNmf5M8Nkom2SyXvhwXkhsnr7Oe6zlom'),
(7, '1', '1@1', '$2y$10$r.lKAfZXPpBmlYQ1LyvCIudjWc1OGw3VmWD3RCYQnrIuWMNSjZbIy'),
(8, 'a', 'a@a', '$2y$10$qp8KKeTGXgMpeHvKuibOseGNqv0uo5udhwJg69QQMbi0gwyW7zd7G');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `color`
--
ALTER TABLE `color`
  ADD PRIMARY KEY (`id`),
  ADD KEY `testid` (`testid`);

--
-- Indexes for table `low`
--
ALTER TABLE `low`
  ADD PRIMARY KEY (`id`),
  ADD KEY `testid` (`testid`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `color`
--
ALTER TABLE `color`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `low`
--
ALTER TABLE `low`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `color`
--
ALTER TABLE `color`
  ADD CONSTRAINT `color_ibfk_1` FOREIGN KEY (`testid`) REFERENCES `test` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `low`
--
ALTER TABLE `low`
  ADD CONSTRAINT `low_ibfk_1` FOREIGN KEY (`testid`) REFERENCES `test` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `test_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
