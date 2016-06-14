-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 14, 2016 at 01:44 PM
-- Server version: 5.5.49-MariaDB-1ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamecase`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `expire_gifts` ()  BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;

SELECT COUNT(*) FROM gifts INTO n;
SET i=0;
WHILE i<n DO 
	SELECT id,expire_day  INTO @id, @expire_day FROM gifts LIMIT i,1;
	UPDATE gifts_sent SET status = 'expired' WHERE gift_id = @id and date < NOW() - INTERVAL @expire_day DAY;
	SET i = i + 1;	
END WHILE;

End$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `gifts`
--

CREATE TABLE `gifts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('active','passive') NOT NULL DEFAULT 'active',
  `send_daily_max` smallint(5) UNSIGNED DEFAULT NULL,
  `claim_daily_max` smallint(5) UNSIGNED DEFAULT NULL,
  `expire_day` smallint(5) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gifts`
--

INSERT INTO `gifts` (`id`, `name`, `status`, `send_daily_max`, `claim_daily_max`, `expire_day`) VALUES
(1, 'Coin', 'active', 1, NULL, 7),
(2, 'Food', 'active', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `gifts_claimed`
--

CREATE TABLE `gifts_claimed` (
  `id` int(10) UNSIGNED NOT NULL,
  `claimer_id` int(10) UNSIGNED NOT NULL,
  `from_id` int(10) UNSIGNED NOT NULL,
  `gift_id` int(10) UNSIGNED NOT NULL,
  `date` datetime DEFAULT NULL,
  `status` enum('sent','seen','accepted','rejected') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gifts_claimed`
--

INSERT INTO `gifts_claimed` (`id`, `claimer_id`, `from_id`, `gift_id`, `date`, `status`) VALUES
(1, 2, 1, 2, '2016-06-12 00:00:00', 'rejected'),
(2, 1, 2, 1, '2016-06-13 00:00:00', 'accepted'),
(3, 1, 1, 1, '2016-06-13 13:22:06', ''),
(4, 1, 1, 1, '2016-06-13 13:22:09', NULL),
(5, 1, 1, 1, '2016-06-13 15:14:19', 'accepted'),
(6, 1, 1, 1, '2016-06-13 15:14:20', 'accepted'),
(7, 1, 1, 1, '2016-06-13 15:15:02', 'accepted'),
(8, 1, 1, 1, '2016-06-13 15:19:44', 'accepted'),
(9, 1, 1, 1, '2016-06-13 15:19:45', 'rejected'),
(10, 1, 1, 1, '2016-06-13 15:19:46', 'accepted'),
(11, 1, 1, 1, '2016-06-13 15:19:47', 'rejected'),
(12, 1, 1, 2, '2016-06-13 15:20:22', 'accepted'),
(13, 1, 1, 2, '2016-06-13 15:20:23', 'rejected'),
(14, 1, 1, 2, '2016-06-13 15:20:24', 'accepted'),
(15, 1, 1, 2, '2016-06-13 15:20:25', 'rejected'),
(16, 1, 1, 2, '2016-06-13 15:20:26', 'rejected'),
(17, 1, 1, 2, '2016-06-13 15:20:27', 'accepted'),
(18, 1, 1, 2, '2016-06-13 15:20:28', 'rejected'),
(19, 1, 1, 2, '2016-06-13 15:20:28', 'accepted'),
(20, 1, 1, 2, '2016-06-13 15:20:29', 'rejected'),
(21, 1, 1, 2, '2016-06-13 15:20:30', 'rejected'),
(22, 1, 1, 2, '2016-06-13 15:20:30', 'accepted'),
(23, 1, 1, 2, '2016-06-13 15:20:49', 'accepted'),
(24, 1, 1, 1, '2016-06-13 15:21:05', 'rejected'),
(25, 1, 1, 2, '2016-06-13 15:21:09', 'accepted'),
(26, 1, 1, 2, '2016-06-13 15:21:39', 'rejected'),
(27, 1, 1, 2, '2016-06-13 15:22:52', 'accepted'),
(28, 1, 1, 2, '2016-06-13 15:23:36', 'accepted'),
(29, 1, 1, 2, '2016-06-13 15:23:55', 'accepted'),
(30, 1, 1, 2, '2016-06-13 15:24:06', 'rejected'),
(31, 1, 1, 2, '2016-06-13 15:24:22', 'rejected'),
(32, 1, 1, 2, '2016-06-13 15:24:52', 'rejected'),
(33, 1, 1, 2, '2016-06-13 15:25:54', 'accepted'),
(34, 1, 1, 2, '2016-06-13 15:27:56', 'rejected'),
(35, 1, 1, 2, '2016-06-13 15:27:57', 'rejected'),
(36, 1, 1, 2, '2016-06-13 15:27:57', 'accepted'),
(37, 1, 1, 2, '2016-06-13 15:27:59', 'accepted'),
(38, 1, 1, 2, '2016-06-13 15:28:22', 'accepted'),
(39, 1, 1, 2, '2016-06-13 15:28:24', 'accepted'),
(40, 1, 1, 2, '2016-06-13 15:28:31', 'accepted'),
(41, 1, 1, 2, '2016-06-13 15:28:33', 'accepted'),
(42, 1, 1, 2, '2016-06-13 15:28:36', 'accepted'),
(43, 1, 1, 2, '2016-06-13 15:28:48', 'rejected'),
(44, 1, 1, 2, '2016-06-13 15:29:08', 'accepted'),
(45, 1, 1, 2, '2016-06-13 15:29:09', 'accepted'),
(46, 1, 1, 2, '2016-06-13 15:29:37', 'accepted'),
(47, 1, 1, 2, '2016-06-13 15:30:12', 'rejected'),
(48, 1, 1, 2, '2016-06-13 15:30:22', 'accepted'),
(49, 1, 1, 2, '2016-06-13 15:31:18', 'rejected'),
(50, 1, 1, 2, '2016-06-13 15:31:19', 'accepted'),
(51, 1, 1, 2, '2016-06-13 15:31:19', ''),
(52, 1, 1, 2, '2016-06-13 15:31:54', ''),
(53, 1, 1, 2, '2016-06-13 15:31:55', ''),
(54, 1, 1, 1, '2016-06-13 15:33:16', ''),
(55, 1, 1, 1, '2016-06-13 15:33:17', 'accepted'),
(56, 1, 2, 1, '2016-06-13 17:05:16', 'seen'),
(57, 1, 2, 1, '2016-06-13 17:05:20', 'seen'),
(58, 1, 3, 1, '2016-06-13 17:05:23', 'sent'),
(59, 1, 3, 1, '2016-06-13 17:05:25', 'sent'),
(60, 1, 3, 1, '2016-06-13 17:05:38', 'sent'),
(61, 1, 3, 1, '2016-06-13 17:05:40', 'sent'),
(62, 1, 2, 1, '2016-06-13 17:05:41', 'seen'),
(63, 1, 2, 1, '2016-06-13 17:05:42', 'seen'),
(64, 1, 2, 1, '2016-06-13 17:06:31', 'seen'),
(65, 1, 2, 1, '2016-06-13 17:06:40', 'seen'),
(66, 1, 2, 1, '2016-06-13 17:06:42', 'seen'),
(67, 1, 2, 1, '2016-06-13 17:06:42', 'seen'),
(68, 1, 3, 1, '2016-06-13 17:06:43', 'sent'),
(69, 1, 3, 1, '2016-06-13 17:06:44', 'sent'),
(70, 1, 3, 1, '2016-06-13 17:06:44', 'sent'),
(71, 3, 1, 1, '2016-06-13 17:10:59', ''),
(72, 3, 1, 1, '2016-06-13 17:11:01', ''),
(73, 3, 1, 1, '2016-06-13 17:11:13', ''),
(74, 3, 2, 1, '2016-06-13 17:11:17', 'seen'),
(75, 3, 1, 2, '2016-06-13 17:11:22', ''),
(76, 3, 1, 1, '2016-06-13 17:12:20', ''),
(77, 1, 2, 1, '2016-06-14 08:56:50', 'seen'),
(78, 1, 2, 1, '2016-06-14 08:56:51', 'seen'),
(79, 1, 3, 1, '2016-06-14 08:56:55', 'sent'),
(80, 1, 3, 1, '2016-06-14 08:56:56', 'seen'),
(81, 1, 3, 1, '2016-06-14 08:59:10', 'seen'),
(82, 1, 2, 1, '2016-06-14 08:59:11', 'seen'),
(83, 1, 2, 1, '2016-06-14 08:59:12', 'seen'),
(84, 1, 3, 1, '2016-06-14 08:59:17', 'seen'),
(85, 1, 2, 1, '2016-06-14 08:59:18', 'seen'),
(86, 1, 2, 1, '2016-06-14 10:47:24', 'seen'),
(87, 1, 3, 1, '2016-06-14 10:47:25', 'seen'),
(88, 1, 2, 1, '2016-06-14 10:51:00', 'seen'),
(89, 1, 2, 1, '2016-06-14 12:04:19', 'seen'),
(90, 1, 2, 1, '2016-06-14 12:04:19', 'seen'),
(91, 1, 2, 1, '2016-06-14 12:04:19', 'accepted'),
(92, 1, 2, 1, '2016-06-14 12:04:20', 'accepted'),
(93, 1, 2, 1, '2016-06-14 12:04:20', 'accepted'),
(94, 1, 2, 1, '2016-06-14 12:04:20', 'accepted'),
(95, 1, 2, 1, '2016-06-14 12:04:20', 'accepted'),
(96, 1, 3, 1, '2016-06-14 12:04:21', 'seen'),
(97, 1, 3, 1, '2016-06-14 12:04:21', 'seen'),
(98, 1, 3, 1, '2016-06-14 12:04:21', 'seen'),
(99, 1, 3, 1, '2016-06-14 12:04:21', 'seen'),
(100, 1, 2, 2, '2016-06-14 12:04:25', 'accepted'),
(101, 1, 2, 1, '2016-06-14 12:10:34', 'rejected'),
(102, 1, 3, 1, '2016-06-14 12:10:35', 'seen'),
(103, 1, 2, 1, '2016-06-14 12:25:47', 'accepted'),
(104, 1, 3, 1, '2016-06-14 12:25:48', 'seen'),
(105, 3, 1, 1, '2016-06-14 12:27:35', 'seen'),
(106, 3, 1, 2, '2016-06-14 12:27:43', 'accepted'),
(107, 1, 3, 1, '2016-06-14 12:28:18', 'sent'),
(108, 1, 2, 1, '2016-06-14 12:28:18', 'sent'),
(109, 1, 2, 1, '2016-06-14 12:28:57', 'sent'),
(110, 1, 3, 1, '2016-06-14 12:28:58', 'sent');

-- --------------------------------------------------------

--
-- Table structure for table `gifts_sent`
--

CREATE TABLE `gifts_sent` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender_id` int(10) UNSIGNED NOT NULL,
  `to_id` int(10) UNSIGNED NOT NULL,
  `gift_id` int(10) UNSIGNED NOT NULL,
  `date` datetime DEFAULT NULL,
  `status` enum('active','expired') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gifts_sent`
--

INSERT INTO `gifts_sent` (`id`, `sender_id`, `to_id`, `gift_id`, `date`, `status`) VALUES
(1, 1, 1, 1, '2016-04-17 11:31:16', 'expired'),
(2, 1, 1, 2, '2016-06-12 14:42:22', 'expired'),
(5, 1, 2, 1, '2016-06-13 13:34:08', 'active'),
(6, 1, 1, 1, '2016-06-13 14:57:08', 'active'),
(8, 1, 2, 1, '2016-06-13 14:57:16', 'active'),
(9, 1, 2, 1, '2016-06-13 15:05:04', 'active'),
(10, 1, 2, 1, '2016-06-13 15:06:53', 'active'),
(11, 1, 2, 1, '2016-06-13 15:06:54', 'active'),
(12, 1, 2, 2, '2016-06-13 15:33:32', 'active'),
(13, 1, 2, 2, '2016-06-13 15:33:35', 'active'),
(21, 1, 2, 2, '2016-06-13 17:04:22', 'active'),
(22, 1, 3, 2, '2016-06-13 17:04:23', 'active'),
(23, 1, 3, 2, '2016-06-13 17:04:24', 'active'),
(24, 1, 3, 2, '2016-06-13 17:04:24', 'active'),
(25, 1, 2, 2, '2016-06-13 17:04:25', 'active'),
(26, 1, 2, 2, '2016-06-13 17:04:25', 'active'),
(27, 1, 2, 2, '2016-06-13 17:04:25', 'active'),
(28, 1, 3, 2, '2016-06-13 17:04:26', 'active'),
(29, 1, 3, 2, '2016-06-13 17:04:26', 'active'),
(30, 1, 2, 2, '2016-06-13 17:04:26', 'active'),
(31, 1, 2, 2, '2016-06-13 17:04:26', 'active'),
(32, 1, 2, 2, '2016-06-13 17:04:27', 'active'),
(33, 1, 2, 2, '2016-06-13 17:04:27', 'active'),
(34, 1, 2, 2, '2016-06-13 17:04:27', 'active'),
(35, 1, 2, 2, '2016-06-13 17:04:53', 'active'),
(36, 1, 2, 2, '2016-06-13 17:06:53', 'active'),
(37, 1, 3, 2, '2016-06-13 17:06:54', 'active'),
(38, 3, 1, 1, '2016-06-13 17:11:03', 'active'),
(39, 3, 1, 2, '2016-06-13 17:11:20', 'active'),
(40, 3, 1, 2, '2016-06-13 17:11:21', 'active'),
(41, 3, 1, 2, '2016-06-13 17:11:21', 'active'),
(42, 1, 2, 1, '2016-06-14 08:56:38', 'active'),
(43, 1, 2, 2, '2016-06-14 08:56:46', 'active'),
(44, 1, 2, 2, '2016-06-14 08:56:47', 'active'),
(45, 1, 2, 2, '2016-06-14 08:56:47', 'active'),
(46, 1, 1, 1, '2016-06-14 11:57:36', 'active'),
(47, 1, 1, 1, '2016-06-14 11:57:44', 'active'),
(48, 1, 1, 1, '2016-06-14 11:57:47', 'active'),
(49, 1, 1, 1, '2016-06-14 11:57:47', 'active'),
(50, 1, 1, 1, '2016-06-14 11:57:51', 'active'),
(51, 1, 1, 1, '2016-06-14 11:57:57', 'active'),
(52, 1, 1, 1, '2016-06-14 11:58:06', 'active'),
(53, 1, 1, 1, '2016-06-14 11:58:47', 'active'),
(54, 1, 1, 1, '2016-06-14 11:58:52', 'active'),
(55, 1, 1, 1, '2016-06-14 11:58:54', 'active'),
(56, 1, 3, 1, '2016-06-14 12:00:03', 'active'),
(57, 1, 3, 2, '2016-06-14 12:00:09', 'active'),
(58, 1, 3, 1, '2016-06-14 12:00:16', 'active'),
(59, 1, 3, 1, '2016-06-14 12:00:20', 'active'),
(60, 1, 3, 1, '2016-06-14 12:00:26', 'active'),
(61, 1, 1, 1, '2016-06-14 12:00:37', 'active'),
(62, 1, 1, 2, '2016-06-14 12:03:38', 'active'),
(63, 1, 1, 2, '2016-06-14 12:03:46', 'active'),
(64, 1, 2, 1, '2016-06-14 12:04:16', 'active'),
(65, 1, 2, 1, '2016-06-14 12:04:17', 'active'),
(66, 1, 2, 1, '2016-06-14 12:04:17', 'active'),
(67, 1, 3, 1, '2016-06-14 12:04:18', 'active'),
(68, 1, 3, 1, '2016-06-14 12:04:18', 'active'),
(69, 1, 3, 1, '2016-06-14 12:04:18', 'active'),
(70, 1, 2, 2, '2016-06-14 12:04:24', 'active'),
(71, 1, 2, 2, '2016-06-14 12:04:24', 'active'),
(72, 1, 2, 2, '2016-06-14 12:04:24', 'active'),
(73, 1, 3, 2, '2016-06-14 12:04:26', 'active'),
(74, 1, 3, 2, '2016-06-14 12:04:27', 'active'),
(75, 1, 3, 2, '2016-06-14 12:04:27', 'active'),
(76, 1, 2, 1, '2016-06-14 12:06:23', 'active'),
(77, 1, 2, 1, '2016-06-14 12:06:25', 'active'),
(78, 1, 2, 1, '2016-06-14 12:09:36', 'active'),
(79, 1, 2, 1, '2016-06-14 12:10:23', 'active'),
(80, 1, 2, 1, '2016-06-14 12:10:32', 'active'),
(81, 1, 3, 1, '2016-06-14 12:10:34', 'active'),
(82, 1, 1, 2, '2016-06-14 12:10:40', 'active'),
(83, 1, 1, 2, '2016-06-14 12:10:43', 'active'),
(84, 1, 1, 2, '2016-06-14 12:11:15', 'active'),
(85, 1, 1, 2, '2016-06-14 12:11:16', 'active'),
(86, 1, 1, 2, '2016-06-14 12:11:17', 'active'),
(87, 1, 1, 2, '2016-06-14 12:11:17', 'active'),
(88, 1, 1, 2, '2016-06-14 12:11:17', 'active'),
(89, 1, 1, 2, '2016-06-14 12:11:18', 'active'),
(90, 1, 1, 2, '2016-06-14 12:11:18', 'active'),
(91, 1, 1, 2, '2016-06-14 12:11:19', 'active'),
(92, 1, 1, 2, '2016-06-14 12:11:19', 'active'),
(93, 1, 1, 2, '2016-06-14 12:13:46', 'active'),
(94, 1, 1, 2, '2016-06-14 12:14:07', 'active'),
(95, 1, 1, 2, '2016-06-14 12:17:46', 'active'),
(96, 1, 1, 2, '2016-06-14 12:21:09', 'active'),
(97, 1, 1, 2, '2016-06-14 12:21:13', 'active'),
(98, 1, 1, 2, '2016-06-14 12:21:15', 'active'),
(99, 1, 1, 2, '2016-06-14 12:23:42', 'active'),
(100, 1, 1, 2, '2016-06-14 12:23:44', 'active'),
(101, 1, 1, 2, '2016-06-14 12:23:47', 'active'),
(102, 1, 1, 2, '2016-06-14 12:23:48', 'active'),
(103, 1, 1, 2, '2016-06-14 12:23:50', 'active'),
(104, 1, 1, 2, '2016-06-14 12:23:51', 'active'),
(105, 1, 1, 1, '2016-06-14 12:23:52', 'active'),
(106, 1, 1, 1, '2016-06-14 12:23:53', 'active'),
(107, 1, 1, 1, '2016-06-14 12:23:55', 'active'),
(108, 1, 1, 1, '2016-06-14 12:23:56', 'active'),
(109, 1, 1, 1, '2016-06-14 12:23:56', 'active'),
(110, 1, 2, 1, '2016-06-14 12:25:07', 'active'),
(111, 1, 3, 1, '2016-06-14 12:25:09', 'active'),
(112, 1, 2, 1, '2016-06-14 12:25:46', 'active'),
(113, 1, 2, 1, '2016-06-14 12:25:47', 'active'),
(114, 1, 3, 1, '2016-06-14 12:25:48', 'active'),
(115, 2, 1, 1, '2016-06-14 12:26:17', 'active'),
(116, 2, 1, 2, '2016-06-14 12:26:27', 'active'),
(117, 2, 1, 1, '2016-06-14 12:26:27', 'active'),
(118, 2, 1, 1, '2016-06-14 12:26:28', 'active'),
(119, 2, 1, 1, '2016-06-14 12:26:28', 'active'),
(120, 2, 1, 1, '2016-06-14 12:26:32', 'active'),
(121, 2, 1, 1, '2016-06-14 12:26:33', 'active'),
(122, 3, 1, 1, '2016-06-14 12:27:11', 'active'),
(123, 3, 1, 1, '2016-06-14 12:27:31', 'active'),
(124, 3, 1, 1, '2016-06-14 12:27:48', 'active'),
(125, 3, 2, 1, '2016-06-14 12:27:52', 'active'),
(126, 3, 1, 2, '2016-06-14 12:27:55', 'active'),
(127, 1, 3, 2, '2016-06-14 12:29:00', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `nickname` varchar(64) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nickname`, `name`, `password`) VALUES
(1, 'isteyen', 'İsteyen User', '202cb962ac59075b964b07152d234b70'),
(2, 'istenen', 'İstenen User', '202cb962ac59075b964b07152d234b70'),
(3, 'tarafsiz', 'Tarafsız User', '202cb962ac59075b964b07152d234b70');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gifts`
--
ALTER TABLE `gifts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gifts_claimed`
--
ALTER TABLE `gifts_claimed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gifts_claimed_users_FK` (`claimer_id`),
  ADD KEY `gifts_claimed_users2_FK` (`from_id`),
  ADD KEY `gifts_claimed_gifts_FK` (`gift_id`),
  ADD KEY `gifts_claimed_status_IDX` (`status`);

--
-- Indexes for table `gifts_sent`
--
ALTER TABLE `gifts_sent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gifts_sent_gifts_FK` (`gift_id`),
  ADD KEY `gifts_sent_users_FK` (`sender_id`),
  ADD KEY `gifts_sent_users2_FK` (`to_id`),
  ADD KEY `gifts_sent_status_IDX` (`status`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gifts`
--
ALTER TABLE `gifts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `gifts_claimed`
--
ALTER TABLE `gifts_claimed`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;
--
-- AUTO_INCREMENT for table `gifts_sent`
--
ALTER TABLE `gifts_sent`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `gifts_claimed`
--
ALTER TABLE `gifts_claimed`
  ADD CONSTRAINT `gifts_claimed_gifts_FK` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`),
  ADD CONSTRAINT `gifts_claimed_users2_FK` FOREIGN KEY (`from_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `gifts_claimed_users_FK` FOREIGN KEY (`claimer_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `gifts_sent`
--
ALTER TABLE `gifts_sent`
  ADD CONSTRAINT `gifts_sent_users2_FK` FOREIGN KEY (`to_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `gifts_sent_gifts_FK` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`),
  ADD CONSTRAINT `gifts_sent_users_FK` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `expire_gifts` ON SCHEDULE EVERY 10 MINUTE STARTS '2016-06-14 13:44:13' ON COMPLETION NOT PRESERVE ENABLE DO call expire_gifts()$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
