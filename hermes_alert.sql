-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 22, 2017 at 08:47 AM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hermes_alert`
--

-- --------------------------------------------------------

--
-- Table structure for table `tweet`
--

CREATE TABLE `tweet` (
  `tweet_id` int(11) NOT NULL,
  `tweet_text` text NOT NULL,
  `tweet_createdAt` date DEFAULT NULL,
  `tweet_lang` float DEFAULT NULL,
  `tweet_long` float DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_location` text,
  `user_timeZone` text,
  `place_id` int(11) DEFAULT NULL,
  `place_name` text,
  `place_countryCode` text,
  `place_country` text,
  `place_lang` float DEFAULT NULL,
  `place_long` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tweet`
--

INSERT INTO `tweet` (`tweet_id`, `tweet_text`, `tweet_createdAt`, `tweet_lang`, `tweet_long`, `user_id`, `user_location`, `user_timeZone`, `place_id`, `place_name`, `place_countryCode`, `place_country`, `place_lang`, `place_long`) VALUES
(45343, 'handsome vishwa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(122234, 'testing ballerina lang <3 <3 :3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tweet`
--
ALTER TABLE `tweet`
  ADD PRIMARY KEY (`tweet_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
