-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 28, 2015 at 08:44 AM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `hotel`
--

-- --------------------------------------------------------

--
-- Table structure for table `attribute`
--

CREATE TABLE IF NOT EXISTS `attribute` (
`id` int(11) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `unique` tinyint(1) NOT NULL DEFAULT '0',
  `nullable` tinyint(1) NOT NULL DEFAULT '1',
  `scope` int(11) NOT NULL DEFAULT '1'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `attribute`
--

INSERT INTO `attribute` (`id`, `code`, `label`, `type`, `sort_order`, `unit`, `unique`, `nullable`, `scope`) VALUES
(1, 'sbeds', 'Number of single beds', 'integer', 1, NULL, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `attribute_option_values`
--

CREATE TABLE IF NOT EXISTS `attribute_option_values` (
`id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `text` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE IF NOT EXISTS `business` (
`id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `company_name` varchar(100) DEFAULT NULL,
  `address` text,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contact_first_name` varchar(50) DEFAULT NULL,
  `contact_last_name` varchar(50) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`id`, `name`, `description`, `company_name`, `address`, `phone`, `email`, `contact_first_name`, `contact_last_name`) VALUES
(1, 'My hotel business', 'This is my small b&b hotel. You could hire some stuff here too. ', 'Si & Co', 'Krunska 22', '+381 11 222 333', 'mojhotel@mail.rs', 'SiniÅ¡a', 'RistiÄ‡');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
`id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE IF NOT EXISTS `clients` (
`id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL,
  `country` varchar(10) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `title` varchar(4) DEFAULT NULL,
  `guest_class` varchar(10) DEFAULT NULL,
  `title_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity`
--

CREATE TABLE IF NOT EXISTS `entity` (
`id` int(11) NOT NULL,
  `definition_id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `guid` varchar(10) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity`
--

INSERT INTO `entity` (`id`, `definition_id`, `status`, `guid`, `status_id`) VALUES
(1, 1, NULL, '101', 1),
(2, 1, NULL, '102', 1),
(3, 2, NULL, '201', 1),
(4, 2, NULL, '202', 1);

-- --------------------------------------------------------

--
-- Table structure for table `entity_category`
--

CREATE TABLE IF NOT EXISTS `entity_category` (
`id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_definition`
--

CREATE TABLE IF NOT EXISTS `entity_definition` (
`id` int(11) NOT NULL,
  `entity_type_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `pax` smallint(6) DEFAULT '1'
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity_definition`
--

INSERT INTO `entity_definition` (`id`, `entity_type_id`, `name`, `code`, `description`, `price`, `pax`) VALUES
(1, 1, 'Single Room', 'SINGLE', 'Single Room', NULL, 1),
(2, 1, 'Twin Room', 'TWIN', 'Twin Room', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `entity_definition_value_boolean`
--

CREATE TABLE IF NOT EXISTS `entity_definition_value_boolean` (
`id` int(11) NOT NULL,
  `entity_definition_id` int(11) DEFAULT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `value` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_definition_value_character`
--

CREATE TABLE IF NOT EXISTS `entity_definition_value_character` (
`id` int(11) NOT NULL,
  `entity_definition_id` int(11) DEFAULT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_definition_value_double`
--

CREATE TABLE IF NOT EXISTS `entity_definition_value_double` (
`id` int(11) NOT NULL,
  `entity_definition_id` int(11) DEFAULT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `value` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_definition_value_integer`
--

CREATE TABLE IF NOT EXISTS `entity_definition_value_integer` (
`id` int(11) NOT NULL,
  `entity_definition_id` int(11) DEFAULT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity_definition_value_integer`
--

INSERT INTO `entity_definition_value_integer` (`id`, `entity_definition_id`, `attribute_id`, `value`) VALUES
(1, 1, 1, 1),
(2, 2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `entity_definition_value_select`
--

CREATE TABLE IF NOT EXISTS `entity_definition_value_select` (
`id` int(11) NOT NULL,
  `entity_definition_id` int(11) DEFAULT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_definition_value_text`
--

CREATE TABLE IF NOT EXISTS `entity_definition_value_text` (
`id` int(11) NOT NULL,
  `entity_definition_id` int(11) DEFAULT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `value` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_definition_value_timestamp`
--

CREATE TABLE IF NOT EXISTS `entity_definition_value_timestamp` (
`id` int(11) NOT NULL,
  `entity_definition_id` int(11) DEFAULT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `value` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_type`
--

CREATE TABLE IF NOT EXISTS `entity_type` (
`id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `time_resolution` int(11) DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity_type`
--

INSERT INTO `entity_type` (`id`, `name`, `description`, `time_resolution`) VALUES
(1, 'ACUNIT', 'Accomodation unit, a room, an apartment, a suite.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `entity_type_attribute`
--

CREATE TABLE IF NOT EXISTS `entity_type_attribute` (
`id` int(11) NOT NULL,
  `entity_type_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity_type_attribute`
--

INSERT INTO `entity_type_attribute` (`id`, `entity_type_id`, `attribute_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `entity_value_boolean`
--

CREATE TABLE IF NOT EXISTS `entity_value_boolean` (
`id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_value_character`
--

CREATE TABLE IF NOT EXISTS `entity_value_character` (
`id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_value_double`
--

CREATE TABLE IF NOT EXISTS `entity_value_double` (
`id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_value_integer`
--

CREATE TABLE IF NOT EXISTS `entity_value_integer` (
`id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_value_select`
--

CREATE TABLE IF NOT EXISTS `entity_value_select` (
`id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_value_text`
--

CREATE TABLE IF NOT EXISTS `entity_value_text` (
`id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `entity_value_timestamp`
--

CREATE TABLE IF NOT EXISTS `entity_value_timestamp` (
`id` int(11) NOT NULL,
  `attribute_id` int(11) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `value` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE IF NOT EXISTS `features` (
`id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `features_entity_definitions`
--

CREATE TABLE IF NOT EXISTS `features_entity_definitions` (
`id` int(11) NOT NULL,
  `feature_id` int(11) DEFAULT NULL,
  `entity_definition_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `financial_plan`
--

CREATE TABLE IF NOT EXISTS `financial_plan` (
`id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `financial_plan_entity_definition_price`
--

CREATE TABLE IF NOT EXISTS `financial_plan_entity_definition_price` (
`id` int(11) NOT NULL,
  `financial_plan_id` int(11) DEFAULT NULL,
  `entity_definition_id` int(11) DEFAULT NULL,
  `price_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE IF NOT EXISTS `price` (
`id` int(11) NOT NULL,
  `value` double DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE IF NOT EXISTS `reservations` (
`id` int(11) NOT NULL,
  `reservation_id` varchar(100) NOT NULL,
  `status` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `client_id` int(11) NOT NULL,
  `pax_a` smallint(6) DEFAULT '0',
  `pax_y` smallint(6) DEFAULT '0',
  `pax_c` smallint(6) DEFAULT '0',
  `comment` text,
  `status_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_entity`
--

CREATE TABLE IF NOT EXISTS `reservation_entity` (
`id` int(11) NOT NULL,
  `guest_id` int(11) DEFAULT NULL,
  `entity_id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `date_start` bigint(20) NOT NULL,
  `date_end` int(11) NOT NULL,
  `date_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_to` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_status`
--

CREATE TABLE IF NOT EXISTS `reservation_status` (
`id` int(11) NOT NULL,
  `statustext` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE IF NOT EXISTS `role` (
`id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`, `description`) VALUES
(1, 'sysadmin', 'System administrator'),
(2, 'poweruser', 'Power user'),
(3, 'user', 'Common user.');

-- --------------------------------------------------------

--
-- Table structure for table `role_task`
--

CREATE TABLE IF NOT EXISTS `role_task` (
`id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `task_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE IF NOT EXISTS `status` (
`id` int(11) NOT NULL,
  `value` varchar(50) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `value`) VALUES
(1, 'Ready'),
(2, 'Occupied');

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE IF NOT EXISTS `task` (
`id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `title`
--

CREATE TABLE IF NOT EXISTS `title` (
`id` int(11) NOT NULL,
  `title` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT '1'
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `role_id`) VALUES
(1, 'Sinisa Ristic', '0cc175b9c0f1b6a831c399e269772661', 'sinisa.ristic@gmail.com', 1),
(2, 'Gaga', '0cc175b9c0f1b6a831c399e269772661', 'gaga@mail.rs', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attribute`
--
ALTER TABLE `attribute`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attribute_option_values`
--
ALTER TABLE `attribute_option_values`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `entity`
--
ALTER TABLE `entity`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_definition_id` (`definition_id`);

--
-- Indexes for table `entity_category`
--
ALTER TABLE `entity_category`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `entity_definition`
--
ALTER TABLE `entity_definition`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_type_id` (`entity_type_id`);

--
-- Indexes for table `entity_definition_value_boolean`
--
ALTER TABLE `entity_definition_value_boolean`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_definition_id` (`entity_definition_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_definition_value_character`
--
ALTER TABLE `entity_definition_value_character`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_definition_id` (`entity_definition_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_definition_value_double`
--
ALTER TABLE `entity_definition_value_double`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_definition_id` (`entity_definition_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_definition_value_integer`
--
ALTER TABLE `entity_definition_value_integer`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_definition_id` (`entity_definition_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_definition_value_select`
--
ALTER TABLE `entity_definition_value_select`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_definition_id` (`entity_definition_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_definition_value_text`
--
ALTER TABLE `entity_definition_value_text`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_definition_id` (`entity_definition_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_definition_value_timestamp`
--
ALTER TABLE `entity_definition_value_timestamp`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_definition_id` (`entity_definition_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_type`
--
ALTER TABLE `entity_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `entity_type_attribute`
--
ALTER TABLE `entity_type_attribute`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_value_boolean`
--
ALTER TABLE `entity_value_boolean`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_id` (`entity_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_value_character`
--
ALTER TABLE `entity_value_character`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_id` (`entity_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_value_double`
--
ALTER TABLE `entity_value_double`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_id` (`entity_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_value_integer`
--
ALTER TABLE `entity_value_integer`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_id` (`entity_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_value_select`
--
ALTER TABLE `entity_value_select`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_id` (`entity_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_value_text`
--
ALTER TABLE `entity_value_text`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_id` (`entity_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `entity_value_timestamp`
--
ALTER TABLE `entity_value_timestamp`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_id` (`entity_id`), ADD KEY `fk_attribute_id` (`attribute_id`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `features_entity_definitions`
--
ALTER TABLE `features_entity_definitions`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `financial_plan`
--
ALTER TABLE `financial_plan`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `financial_plan_entity_definition_price`
--
ALTER TABLE `financial_plan_entity_definition_price`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservation_entity`
--
ALTER TABLE `reservation_entity`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_entity_id` (`entity_id`), ADD KEY `fk_reservation_id` (`reservation_id`);

--
-- Indexes for table `reservation_status`
--
ALTER TABLE `reservation_status`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_task`
--
ALTER TABLE `role_task`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `title`
--
ALTER TABLE `title`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attribute`
--
ALTER TABLE `attribute`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `attribute_option_values`
--
ALTER TABLE `attribute_option_values`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity`
--
ALTER TABLE `entity`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `entity_category`
--
ALTER TABLE `entity_category`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_definition`
--
ALTER TABLE `entity_definition`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `entity_definition_value_boolean`
--
ALTER TABLE `entity_definition_value_boolean`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_definition_value_character`
--
ALTER TABLE `entity_definition_value_character`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_definition_value_double`
--
ALTER TABLE `entity_definition_value_double`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_definition_value_integer`
--
ALTER TABLE `entity_definition_value_integer`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `entity_definition_value_select`
--
ALTER TABLE `entity_definition_value_select`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_definition_value_text`
--
ALTER TABLE `entity_definition_value_text`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_definition_value_timestamp`
--
ALTER TABLE `entity_definition_value_timestamp`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_type`
--
ALTER TABLE `entity_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `entity_type_attribute`
--
ALTER TABLE `entity_type_attribute`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `entity_value_boolean`
--
ALTER TABLE `entity_value_boolean`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_value_character`
--
ALTER TABLE `entity_value_character`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_value_double`
--
ALTER TABLE `entity_value_double`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_value_integer`
--
ALTER TABLE `entity_value_integer`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_value_select`
--
ALTER TABLE `entity_value_select`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_value_text`
--
ALTER TABLE `entity_value_text`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `entity_value_timestamp`
--
ALTER TABLE `entity_value_timestamp`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `features`
--
ALTER TABLE `features`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `features_entity_definitions`
--
ALTER TABLE `features_entity_definitions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `financial_plan`
--
ALTER TABLE `financial_plan`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `financial_plan_entity_definition_price`
--
ALTER TABLE `financial_plan_entity_definition_price`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `price`
--
ALTER TABLE `price`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reservation_entity`
--
ALTER TABLE `reservation_entity`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reservation_status`
--
ALTER TABLE `reservation_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `role_task`
--
ALTER TABLE `role_task`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `task`
--
ALTER TABLE `task`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `title`
--
ALTER TABLE `title`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
