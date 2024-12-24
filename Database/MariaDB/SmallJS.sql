-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.7.1-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for smalljs
DROP DATABASE IF EXISTS `smalljs`;
CREATE DATABASE IF NOT EXISTS `smalljs` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `smalljs`;

-- Dumping structure for table smalljs.order
DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_order_person` (`person`),
  KEY `FK_order_product` (`product`),
  CONSTRAINT `FK_order_person` FOREIGN KEY (`person`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order_product` FOREIGN KEY (`product`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table smalljs.order: ~3 rows (approximately)
INSERT INTO `order` (`id`, `person`, `product`, `amount`) VALUES
	(1, 1, 1, 10),
	(2, 1, 2, 5),
	(3, 2, 3, 2);

-- Dumping structure for table smalljs.person
DROP TABLE IF EXISTS `person`;
CREATE TABLE IF NOT EXISTS `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `salt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=508 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table smalljs.person: ~3 rows (approximately)
INSERT INTO `person` (`id`, `name`, `password`, `salt`) VALUES
	(1, 'John', '3faa016d7bff29d2a5cefda632f42899c3d9e955f8c28e0994ee316d000082a9', 858185),
	(2, 'Michael', '086ef341030ba97592ad54629f7773daca2a1b58b6ec481179887010ecdf8870', 351360),
	(3, 'Robert', '35e2b3530c3b7b2c7c0ae6670a1a6eb60a2e9e57c3c393f4a0ceaf11e71351ff', 484813);

-- Dumping structure for table smalljs.product
DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table smalljs.product: ~3 rows (approximately)
INSERT INTO `product` (`id`, `name`, `price`) VALUES
	(1, 'Apple', 100),
	(2, 'Orange', 150),
	(3, 'Mango', 220);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
