-- SmallJS example database for MySQL
--
-- Table names are capitalized, like the SmallJS code uses them.
-- On Linux table names are case sensitive by default, so they must match exactly.
-- Existing tables are dropped first, so the script can be run again.

CREATE DATABASE IF NOT EXISTS `smalljs`;
USE `smalljs`;

DROP TABLE IF EXISTS `Type`, `Order`, `Person`, `Product`;

-- Type

CREATE TABLE `Type` (
	`id` int NOT NULL AUTO_INCREMENT,
	`string` varchar( 80 ) NOT NULL,
	`integer` int NOT NULL,
	`float` double NOT NULL,
	`date` varchar( 80 ) NOT NULL,
	`boolean` tinyint NOT NULL,
	`binary` blob NOT NULL,
	`anil` int DEFAULT NULL,
	PRIMARY KEY ( `id` )
 );

-- Person

CREATE TABLE `Person` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar( 32 ) NOT NULL,
	`password` varchar( 64 ) DEFAULT NULL,
	`salt` int DEFAULT NULL,
	PRIMARY KEY ( `id` ),
	UNIQUE KEY `Name_UNIQUE` ( `name` )
 );

INSERT INTO `Person` VALUES
	( 1, 'John', '3faa016d7bff29d2a5cefda632f42899c3d9e955f8c28e0994ee316d000082a9', 858185 ),
	( 2, 'Michael', '086ef341030ba97592ad54629f7773daca2a1b58b6ec481179887010ecdf8870', 351360 ),
	( 3, 'Robert', '35e2b3530c3b7b2c7c0ae6670a1a6eb60a2e9e57c3c393f4a0ceaf11e71351ff', 484813 );

-- Product

CREATE TABLE `Product` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar( 32 ) NOT NULL,
	`price` int DEFAULT NULL,
	PRIMARY KEY ( `id` ),
	UNIQUE KEY `name_UNIQUE` ( `name` )
 );

INSERT INTO `Product` VALUES
	( 1, 'Apple', 100 ),
	( 2, 'Orange', 150 ),
	( 3, 'Mango', 220 );

-- Order

CREATE TABLE `Order` (
	`id` int NOT NULL AUTO_INCREMENT,
	`person` int NOT NULL,
	`product` int NOT NULL,
	`amount` int NOT NULL,
	PRIMARY KEY ( `id` ),
	KEY `product_idx` ( `product` ),
	KEY `person_idx` ( `person` ),
	CONSTRAINT `person` FOREIGN KEY ( `person` ) REFERENCES `Person` ( `id` ),
	CONSTRAINT `product` FOREIGN KEY ( `product` ) REFERENCES `Product` ( `id` )
 );

INSERT INTO `Order` VALUES
	( 1, 1, 1, 10 ),
	( 2, 1, 2, 5 ),
	( 3, 2, 3, 2 );
