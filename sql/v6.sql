CREATE DATABASE  IF NOT EXISTS `bakery_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bakery_management`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bakery_management
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bakery`
--

DROP TABLE IF EXISTS `bakery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bakery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `city_id` int NOT NULL,
  `location` varchar(255) NOT NULL,
  `usa_warehouse_distance` float NOT NULL DEFAULT '0' COMMENT 'Distance from 123 Industrial Ave, Brooklyn, NY (km)',
  `japan_warehouse_distance` float NOT NULL DEFAULT '0' COMMENT 'Distance from 1-1 Shibuya Crossing, Tokyo (km)',
  `hk_warehouse_distance` float NOT NULL DEFAULT '0' COMMENT 'Distance from 88 Victoria Peak Rd, Hong Kong (km)',
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `bakery_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bakery`
--

LOCK TABLES `bakery` WRITE;
/*!40000 ALTER TABLE `bakery` DISABLE KEYS */;
INSERT INTO `bakery` VALUES (1,'Main Street Bakery',1,'123 Main St, New York',7.5,10850,12950),(2,'Downtown Bakery',2,'456 Central Ave, Los Angeles',3900,8300,12400),(3,'Central Bakery',3,'789 Market St, Chicago',1150,10100,12400),(4,'Northside Bakery',4,'101 North Rd, Houston',2300,9500,12900),(5,'Southside Bakery',5,'202 South Blvd, Phoenix',3400,9200,12500),(6,'Liberty Bakeshop',1,'42 Broadway, New York',7.5,10850,12950),(7,'Hollywood Bread Co.',2,'1560 Sunset Blvd, Los Angeles',3900,8300,12400),(8,'Windy City Pastries',3,'500 W Jackson Blvd, Chicago',1150,10100,12400),(9,'Space City Bakery',4,'3000 NASA Parkway, Houston',2300,9500,12900),(10,'Desert Flour Bakery',5,'650 E Van Buren St, Phoenix',3400,9200,12500),(11,'Tokyo Artisan Bread',10,'1-2-3 Ginza, Chuo-ku, Tokyo',10850,6,2900),(12,'Shinjuku Boulangerie',10,'3-34-1 Shinjuku, Tokyo',10850,4,2900),(13,'Yokohama French Bakery',11,'2-1 Minato Mirai, Yokohama',10850,35,2900),(14,'Dotonbori Bakery',12,'1-6-18 Dotonbori, Osaka',10850,400,2900),(15,'Kyoto Traditional Bread',16,'584 Nakanocho, Kyoto',10850,370,2900),(16,'Kobe Sweet Bakery',15,'1-1-1 Sannomiya, Kobe',10850,430,2900),(17,'Central HK Bakery',19,'15 Queen\'s Road Central, Hong Kong',12950,2900,4),(18,'Tsim Sha Tsui Bakery',19,'22 Nathan Road, Tsim Sha Tsui',12950,2900,6),(19,'Kowloon City Bakery',20,'45 Nga Tsin Wai Road, Kowloon',12950,2900,8.5),(20,'Wan Chai Bread House',19,'89 Hennessy Road, Wan Chai',12950,2900,5);
/*!40000 ALTER TABLE `bakery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centre_warehouse`
--

DROP TABLE IF EXISTS `centre_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centre_warehouse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centre_warehouse`
--

LOCK TABLES `centre_warehouse` WRITE;
/*!40000 ALTER TABLE `centre_warehouse` DISABLE KEYS */;
INSERT INTO `centre_warehouse` VALUES (1,'New York Central Warehouse','123 Industrial Ave, Brooklyn, NY'),(2,'Tokyo Main Warehouse','1-1 Shibuya Crossing, Tokyo'),(3,'Hong Kong Central Depot','88 Victoria Peak Rd, Hong Kong');
/*!40000 ALTER TABLE `centre_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `cities_chk_1` CHECK ((`country` in (_utf8mb4'USA',_utf8mb4'Japan',_utf8mb4'Hong Kong')))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'New York','USA'),(2,'Los Angeles','USA'),(3,'Chicago','USA'),(4,'Houston','USA'),(5,'Phoenix','USA'),(6,'Philadelphia','USA'),(7,'San Antonio','USA'),(8,'San Diego','USA'),(9,'Dallas','USA'),(10,'Tokyo','Japan'),(11,'Yokohama','Japan'),(12,'Osaka','Japan'),(13,'Nagoya','Japan'),(14,'Sapporo','Japan'),(15,'Kobe','Japan'),(16,'Kyoto','Japan'),(17,'Fukuoka','Japan'),(18,'Kawasaki','Japan'),(19,'Hong Kong','Hong Kong'),(20,'Kowloon','Hong Kong');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fruit_borrow_record`
--

DROP TABLE IF EXISTS `fruit_borrow_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fruit_borrow_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock_id` int NOT NULL,
  `bakery_id` int NOT NULL,
  `borrow_bakery_id` int NOT NULL,
  `state` int NOT NULL COMMENT '0=Pending, 1=Approved by borrowed shop, 2=Approved by warehouse, 3=Rejected',
  PRIMARY KEY (`id`),
  KEY `idx_borrow_bakery` (`bakery_id`),
  KEY `idx_borrow_state` (`state`),
  KEY `fruit_borrow_record_ibfk_3_idx` (`borrow_bakery_id`),
  KEY `fruit_borrow_record_ibfk_4_idx` (`stock_id`),
  CONSTRAINT `fruit_borrow_record_ibfk_2` FOREIGN KEY (`bakery_id`) REFERENCES `bakery` (`id`),
  CONSTRAINT `fruit_borrow_record_ibfk_3` FOREIGN KEY (`borrow_bakery_id`) REFERENCES `bakery` (`id`),
  CONSTRAINT `fruit_borrow_record_ibfk_4` FOREIGN KEY (`stock_id`) REFERENCES `fruit_stock_record` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fruit_borrow_record`
--

LOCK TABLES `fruit_borrow_record` WRITE;
/*!40000 ALTER TABLE `fruit_borrow_record` DISABLE KEYS */;
INSERT INTO `fruit_borrow_record` VALUES (1,57,2,7,0),(2,12,7,2,2),(3,57,2,7,0),(4,93,2,7,0),(5,57,2,7,0),(6,57,2,7,0),(7,135,2,7,0),(8,93,2,7,0),(9,93,2,7,0),(10,135,2,7,0),(11,93,2,7,0);
/*!40000 ALTER TABLE `fruit_borrow_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fruit_reserve_record`
--

DROP TABLE IF EXISTS `fruit_reserve_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fruit_reserve_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fruit_id` int NOT NULL,
  `bakery_id` int NOT NULL,
  `state` tinyint NOT NULL COMMENT '0=Pending, 1=Approved, 2=Rejected',
  `quantity` double NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `arrival_date` timestamp NULL DEFAULT NULL,
  `origin_to_warehouse` double DEFAULT NULL,
  `warehouse_ro_store` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reserve_fruit` (`fruit_id`),
  KEY `idx_reserve_bakery` (`bakery_id`),
  KEY `idx_reserve_state` (`state`),
  CONSTRAINT `fruit_reserve_record_ibfk_1` FOREIGN KEY (`fruit_id`) REFERENCES `fruits` (`id`),
  CONSTRAINT `fruit_reserve_record_ibfk_2` FOREIGN KEY (`bakery_id`) REFERENCES `bakery` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fruit_reserve_record`
--

LOCK TABLES `fruit_reserve_record` WRITE;
/*!40000 ALTER TABLE `fruit_reserve_record` DISABLE KEYS */;
INSERT INTO `fruit_reserve_record` VALUES (1,1,2,2,200,'2025-04-25 20:47:33',NULL,10,NULL),(2,1,2,6,20,'2025-04-25 21:23:21',NULL,NULL,NULL),(3,1,2,6,20,'2025-04-25 21:24:35',NULL,5700,NULL),(4,1,2,6,20,'2025-04-25 21:27:12',NULL,NULL,NULL),(5,1,2,6,20,'2025-04-25 22:02:23',NULL,NULL,NULL),(6,1,2,6,2,'2025-04-25 22:07:07',NULL,NULL,NULL),(7,1,2,6,22,'2025-04-26 07:48:55',NULL,NULL,NULL),(8,1,2,5,3,'2025-04-26 09:47:40',NULL,NULL,NULL),(9,1,2,5,1,'2025-04-26 09:50:19',NULL,NULL,NULL),(10,1,2,3,200,'2025-04-27 02:23:55',NULL,NULL,NULL),(11,3,2,3,22,'2025-04-27 02:25:28',NULL,NULL,NULL),(12,20,2,6,9999,'2025-04-27 03:32:57',NULL,NULL,NULL),(13,15,2,3,222,'2025-04-27 03:57:54',NULL,NULL,NULL),(14,1,2,3,333,'2025-04-27 03:59:50',NULL,NULL,NULL),(18,12,2,2,1314,'2025-04-27 13:15:22','2025-04-28 00:00:00',11000,NULL),(20,1,2,3,10000,'2025-04-27 13:53:23','2025-04-27 00:00:00',10,NULL),(21,4,2,2,12,'2025-04-27 14:09:10','2025-04-28 00:00:00',12500,NULL),(22,11,2,2,1,'2025-04-27 14:11:16','2025-04-28 00:00:00',14000,NULL),(23,1,2,3,1,'2025-04-27 14:14:23','2025-04-27 00:00:00',10,NULL);
/*!40000 ALTER TABLE `fruit_reserve_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fruit_stock_record`
--

DROP TABLE IF EXISTS `fruit_stock_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fruit_stock_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fruit_id` int NOT NULL,
  `bakery_id` int NOT NULL,
  `quantity_kg` decimal(10,2) NOT NULL,
  `expired_date` date NOT NULL,
  `borrow_record` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `borrow_record` (`borrow_record`),
  KEY `idx_fruits_stock_fruit` (`fruit_id`),
  KEY `idx_fruits_stock_bakery` (`bakery_id`),
  KEY `idx_fruits_stock_expiry` (`expired_date`),
  CONSTRAINT `fruit_stock_record_ibfk_1` FOREIGN KEY (`fruit_id`) REFERENCES `fruits` (`id`),
  CONSTRAINT `fruit_stock_record_ibfk_2` FOREIGN KEY (`bakery_id`) REFERENCES `bakery` (`id`),
  CONSTRAINT `fruit_stock_record_ibfk_3` FOREIGN KEY (`borrow_record`) REFERENCES `bakery` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fruit_stock_record`
--

LOCK TABLES `fruit_stock_record` WRITE;
/*!40000 ALTER TABLE `fruit_stock_record` DISABLE KEYS */;
INSERT INTO `fruit_stock_record` VALUES (1,3,2,200.00,'2025-04-27',NULL,'2025-04-26 13:23:03','2025-04-26 13:23:03'),(2,1,1,25.50,'2024-03-15',NULL,'2024-01-12 14:05:00','2024-02-10 09:30:00'),(3,3,1,18.75,'2024-03-20',NULL,'2024-01-14 09:35:00','2024-02-05 11:20:00'),(4,5,1,12.30,'2024-03-10',NULL,'2024-01-17 13:25:00','2024-02-12 14:15:00'),(5,2,2,30.00,'2024-03-18',NULL,'2024-01-15 10:00:00','2024-02-08 10:45:00'),(6,4,2,22.40,'2024-03-22',NULL,'2024-01-18 11:30:00','2024-02-10 08:15:00'),(7,6,2,15.75,'2024-03-15',NULL,'2024-01-20 14:00:00','2024-02-15 13:30:00'),(8,7,3,20.50,'2024-03-12',NULL,'2024-01-22 09:00:00','2024-02-12 10:20:00'),(9,9,3,28.60,'2024-03-25',NULL,'2024-01-25 11:45:00','2024-02-18 15:40:00'),(10,11,3,14.25,'2024-03-08',NULL,'2024-01-28 08:30:00','2024-02-20 09:15:00'),(11,8,4,17.80,'2024-03-17',NULL,'2024-01-30 10:15:00','2024-02-15 11:50:00'),(12,10,4,24.30,'2024-03-20',7,'2024-02-02 13:20:00','2025-04-26 18:55:42'),(13,12,4,19.50,'2024-03-14',NULL,'2024-02-05 15:45:00','2024-02-20 10:10:00'),(14,13,5,21.75,'2024-03-19',NULL,'2024-02-08 09:30:00','2024-02-22 16:20:00'),(15,15,5,16.40,'2024-03-16',NULL,'2024-02-10 11:15:00','2024-02-25 09:45:00'),(16,17,5,23.90,'2024-03-21',NULL,'2024-02-12 14:50:00','2024-02-28 13:15:00'),(17,5,2,8.50,'2024-03-12',1,'2024-02-15 10:30:00','2024-02-15 10:30:00'),(18,7,1,6.25,'2024-03-15',3,'2024-02-18 11:45:00','2024-02-18 11:45:00'),(19,9,4,10.00,'2024-03-18',5,'2024-02-20 14:20:00','2024-02-20 14:20:00'),(20,3,1,5.20,'2024-03-01',NULL,'2024-02-25 09:15:00','2024-02-25 09:15:00'),(21,6,2,3.75,'2024-03-02',NULL,'2024-02-26 10:40:00','2024-02-26 10:40:00'),(22,12,4,4.80,'2024-03-03',NULL,'2024-02-28 13:05:00','2024-02-28 13:05:00'),(23,1,1,25.50,'2024-06-15',NULL,'2024-03-01 08:00:00','2024-03-10 09:30:00'),(24,2,1,18.75,'2024-06-20',NULL,'2024-03-01 09:15:00','2024-03-05 11:20:00'),(25,3,2,30.00,'2024-06-18',NULL,'2024-03-02 10:00:00','2024-03-08 10:45:00'),(26,4,2,22.40,'2024-06-22',NULL,'2024-03-02 11:30:00','2024-03-10 08:15:00'),(27,5,3,20.50,'2024-06-12',NULL,'2024-03-03 08:00:00','2024-03-12 10:20:00'),(28,6,3,15.75,'2024-06-15',NULL,'2024-03-03 14:00:00','2024-03-15 13:30:00'),(29,7,4,17.80,'2024-06-17',NULL,'2024-03-04 10:15:00','2024-03-15 11:50:00'),(30,8,4,24.30,'2024-06-20',NULL,'2024-03-04 13:20:00','2024-03-18 14:30:00'),(31,9,5,21.75,'2024-06-19',NULL,'2024-03-05 09:30:00','2024-03-22 16:20:00'),(32,10,5,16.40,'2024-06-16',NULL,'2024-03-05 11:15:00','2024-03-25 09:45:00'),(33,11,11,28.60,'2024-06-25',NULL,'2024-03-06 08:30:00','2024-03-18 15:40:00'),(34,12,11,14.25,'2024-06-08',NULL,'2024-03-06 09:15:00','2024-03-20 09:15:00'),(35,13,12,19.50,'2024-06-14',NULL,'2024-03-07 10:45:00','2024-03-20 10:10:00'),(36,14,12,23.90,'2024-06-21',NULL,'2024-03-07 13:15:00','2024-03-28 13:15:00'),(37,15,13,12.30,'2024-06-10',NULL,'2024-03-08 08:00:00','2024-03-12 14:15:00'),(38,16,13,18.75,'2024-06-20',NULL,'2024-03-08 09:35:00','2024-03-05 11:20:00'),(39,17,14,30.00,'2024-06-18',NULL,'2024-03-09 10:00:00','2024-03-08 10:45:00'),(40,18,14,22.40,'2024-06-22',NULL,'2024-03-09 11:30:00','2024-03-10 08:15:00'),(41,19,15,20.50,'2024-06-12',NULL,'2024-03-10 08:00:00','2024-03-12 10:20:00'),(42,20,15,15.75,'2024-06-15',NULL,'2024-03-10 14:00:00','2024-03-15 13:30:00'),(43,1,17,17.80,'2024-06-17',NULL,'2024-03-11 10:15:00','2024-03-15 11:50:00'),(44,2,17,24.30,'2024-06-20',NULL,'2024-03-11 13:20:00','2024-03-18 14:30:00'),(45,3,18,21.75,'2024-06-19',NULL,'2024-03-12 09:30:00','2024-03-22 16:20:00'),(46,4,18,16.40,'2024-06-16',NULL,'2024-03-12 11:15:00','2024-03-25 09:45:00'),(47,5,19,28.60,'2024-06-25',NULL,'2024-03-13 08:30:00','2024-03-18 15:40:00'),(48,6,19,14.25,'2024-06-08',NULL,'2024-03-13 09:15:00','2024-03-20 09:15:00'),(49,7,20,19.50,'2024-06-14',NULL,'2024-03-14 10:45:00','2024-03-20 10:10:00'),(50,8,20,23.90,'2024-06-21',NULL,'2024-03-14 13:15:00','2024-03-28 13:15:00'),(51,9,1,8.50,'2024-06-12',11,'2024-03-15 10:30:00','2024-03-15 10:30:00'),(52,10,2,6.25,'2024-06-15',12,'2024-03-16 11:45:00','2024-03-16 11:45:00'),(53,11,3,10.00,'2024-06-18',13,'2024-03-17 14:20:00','2024-03-17 14:20:00'),(54,12,4,7.75,'2024-06-19',14,'2024-03-18 09:45:00','2024-03-18 09:45:00'),(55,13,5,9.25,'2024-06-20',15,'2024-03-19 11:30:00','2024-03-19 11:30:00'),(56,14,6,5.20,'2024-03-25',NULL,'2024-03-20 09:15:00','2024-03-20 09:15:00'),(57,15,7,3.75,'2024-03-26',NULL,'2024-03-21 10:40:00','2024-03-21 10:40:00'),(58,16,8,4.80,'2024-03-27',NULL,'2024-03-22 13:05:00','2024-03-22 13:05:00'),(59,17,9,6.30,'2024-03-28',NULL,'2024-03-23 14:30:00','2024-03-23 14:30:00'),(60,18,10,5.50,'2024-03-29',NULL,'2024-03-24 15:45:00','2024-03-24 15:45:00'),(61,19,11,12.75,'2024-06-30',NULL,'2024-03-25 08:00:00','2024-03-25 08:00:00'),(62,20,12,18.25,'2024-06-28',NULL,'2024-03-26 09:30:00','2024-03-26 09:30:00'),(63,1,13,15.50,'2024-06-25',NULL,'2024-03-27 10:45:00','2024-03-27 10:45:00'),(64,2,14,20.75,'2024-06-22',NULL,'2024-03-28 11:15:00','2024-03-28 11:15:00'),(65,3,15,14.25,'2024-06-20',NULL,'2024-03-29 13:30:00','2024-03-29 13:30:00'),(66,4,16,16.75,'2024-06-18',NULL,'2024-03-30 14:45:00','2024-03-30 14:45:00'),(67,5,17,19.50,'2024-06-15',NULL,'2024-03-31 15:00:00','2024-03-31 15:00:00'),(68,6,18,22.25,'2024-06-12',NULL,'2024-04-01 16:15:00','2024-04-01 16:15:00'),(69,7,19,13.75,'2024-06-10',NULL,'2024-04-02 17:30:00','2024-04-02 17:30:00'),(70,8,20,17.25,'2024-06-08',NULL,'2024-04-03 18:45:00','2024-04-03 18:45:00'),(71,1,1,32.50,'2024-07-10',NULL,'2024-04-01 08:15:00','2024-04-10 09:45:00'),(72,2,1,28.75,'2024-07-12',NULL,'2024-04-01 09:30:00','2024-04-05 10:20:00'),(73,3,2,35.20,'2024-07-15',NULL,'2024-04-02 10:45:00','2024-04-08 11:15:00'),(74,4,2,24.60,'2024-07-18',NULL,'2024-04-02 12:00:00','2024-04-10 08:45:00'),(75,5,3,40.25,'2024-07-20',NULL,'2024-04-03 08:30:00','2024-04-12 10:30:00'),(76,6,11,18.90,'2024-07-05',NULL,'2024-04-03 14:15:00','2024-04-15 13:45:00'),(77,7,11,22.40,'2024-07-08',NULL,'2024-04-04 10:30:00','2024-04-15 14:20:00'),(78,8,12,27.80,'2024-07-12',NULL,'2024-04-04 13:45:00','2024-04-18 15:30:00'),(79,9,12,31.25,'2024-07-15',NULL,'2024-04-05 09:00:00','2024-04-22 16:45:00'),(80,10,13,19.75,'2024-07-18',NULL,'2024-04-05 11:15:00','2024-04-25 10:15:00'),(81,11,4,12.50,'2024-07-10',11,'2024-04-06 10:00:00','2024-04-06 10:00:00'),(82,12,5,9.75,'2024-07-12',12,'2024-04-07 11:30:00','2024-04-07 11:30:00'),(83,13,6,15.25,'2024-07-15',13,'2024-04-08 14:45:00','2024-04-08 14:45:00'),(84,14,7,11.80,'2024-07-18',14,'2024-04-09 09:15:00','2024-04-09 09:15:00'),(85,15,8,14.50,'2024-07-20',15,'2024-04-10 12:30:00','2024-04-10 12:30:00'),(86,16,17,25.40,'2024-07-22',NULL,'2024-04-11 08:45:00','2024-04-15 11:50:00'),(87,17,17,30.75,'2024-07-25',NULL,'2024-04-11 10:00:00','2024-04-18 14:15:00'),(88,18,18,22.90,'2024-07-28',NULL,'2024-04-12 13:15:00','2024-04-20 09:30:00'),(89,19,18,18.60,'2024-07-30',NULL,'2024-04-13 15:30:00','2024-04-22 16:45:00'),(90,20,19,27.25,'2024-08-01',NULL,'2024-04-14 09:45:00','2024-04-25 10:00:00'),(91,1,6,45.50,'2024-07-05',NULL,'2024-04-15 08:00:00','2024-04-20 11:30:00'),(92,2,6,38.75,'2024-07-08',NULL,'2024-04-15 09:15:00','2024-04-18 10:45:00'),(93,3,7,42.00,'2024-07-10',NULL,'2024-04-16 10:30:00','2024-04-22 09:15:00'),(94,4,7,36.40,'2024-07-12',NULL,'2024-04-16 12:45:00','2024-04-25 14:30:00'),(95,5,8,50.25,'2024-07-15',NULL,'2024-04-17 08:30:00','2024-04-28 16:20:00'),(96,6,14,28.90,'2024-07-18',NULL,'2024-04-18 14:15:00','2024-04-25 13:45:00'),(97,7,14,32.40,'2024-07-20',NULL,'2024-04-19 10:30:00','2024-04-28 15:20:00'),(98,8,15,24.80,'2024-07-22',NULL,'2024-04-20 13:45:00','2024-04-30 09:30:00'),(99,9,15,29.25,'2024-07-25',NULL,'2024-04-21 09:00:00','2024-05-02 11:45:00'),(100,10,16,21.75,'2024-07-28',NULL,'2024-04-22 11:15:00','2024-05-05 14:15:00'),(101,11,9,8.50,'2024-05-10',NULL,'2024-04-23 10:00:00','2024-04-23 10:00:00'),(102,12,9,6.75,'2024-05-12',NULL,'2024-04-24 11:30:00','2024-04-24 11:30:00'),(103,13,10,9.25,'2024-05-15',NULL,'2024-04-25 14:45:00','2024-04-25 14:45:00'),(104,14,10,7.80,'2024-05-18',NULL,'2024-04-26 09:15:00','2024-04-26 09:15:00'),(105,15,11,10.50,'2024-05-20',NULL,'2024-04-27 12:30:00','2024-04-27 12:30:00'),(106,16,12,15.40,'2024-07-30',17,'2024-04-28 08:45:00','2024-04-28 08:45:00'),(107,17,13,12.75,'2024-08-01',18,'2024-04-29 10:00:00','2024-04-29 10:00:00'),(108,18,14,18.90,'2024-08-05',19,'2024-04-30 13:15:00','2024-04-30 13:15:00'),(109,19,15,14.60,'2024-08-08',20,'2024-05-01 15:30:00','2024-05-01 15:30:00'),(110,20,16,17.25,'2024-08-10',1,'2024-05-02 09:45:00','2024-05-02 09:45:00'),(111,1,2,22.50,'2024-07-25',NULL,'2024-05-03 08:00:00','2024-05-10 11:30:00'),(112,2,3,18.75,'2024-07-28',NULL,'2024-05-03 09:15:00','2024-05-08 10:45:00'),(113,3,4,30.00,'2024-07-30',NULL,'2024-05-04 10:30:00','2024-05-12 09:15:00'),(114,4,5,24.60,'2024-08-01',NULL,'2024-05-04 12:45:00','2024-05-15 14:30:00'),(115,5,6,35.25,'2024-08-05',NULL,'2024-05-05 08:30:00','2024-05-18 16:20:00'),(116,6,7,28.90,'2024-08-08',NULL,'2024-05-06 14:15:00','2024-05-15 13:45:00'),(117,7,8,32.40,'2024-08-10',NULL,'2024-05-07 10:30:00','2024-05-18 15:20:00'),(118,8,9,24.80,'2024-08-12',NULL,'2024-05-08 13:45:00','2024-05-20 09:30:00'),(119,9,10,29.25,'2024-08-15',NULL,'2024-05-09 09:00:00','2024-05-22 11:45:00'),(120,10,11,21.75,'2024-08-18',NULL,'2024-05-10 11:15:00','2024-05-25 14:15:00'),(121,11,12,15.50,'2024-08-20',NULL,'2024-05-11 10:00:00','2024-05-11 10:00:00'),(122,12,13,12.75,'2024-08-22',NULL,'2024-05-12 11:30:00','2024-05-12 11:30:00'),(123,13,14,18.25,'2024-08-25',NULL,'2024-05-13 14:45:00','2024-05-13 14:45:00'),(124,14,15,14.80,'2024-08-28',NULL,'2024-05-14 09:15:00','2024-05-14 09:15:00'),(125,15,16,17.50,'2024-08-30',NULL,'2024-05-15 12:30:00','2024-05-15 12:30:00'),(126,16,17,10.40,'2024-05-25',NULL,'2024-05-16 08:45:00','2024-05-16 08:45:00'),(127,17,18,8.75,'2024-05-28',NULL,'2024-05-17 10:00:00','2024-05-17 10:00:00'),(128,18,19,12.90,'2024-05-30',NULL,'2024-05-18 13:15:00','2024-05-18 13:15:00'),(129,19,20,9.60,'2024-06-01',NULL,'2024-05-19 15:30:00','2024-05-19 15:30:00'),(130,20,1,14.25,'2024-06-05',NULL,'2024-05-20 09:45:00','2024-05-20 09:45:00'),(131,1,3,42.50,'2024-09-10',NULL,'2024-05-21 08:00:00','2024-05-30 11:30:00'),(132,2,4,38.75,'2024-09-12',NULL,'2024-05-21 09:15:00','2024-05-28 10:45:00'),(133,3,5,45.00,'2024-09-15',NULL,'2024-05-22 10:30:00','2024-06-02 09:15:00'),(134,4,6,39.60,'2024-09-18',NULL,'2024-05-22 12:45:00','2024-06-05 14:30:00'),(135,5,7,52.25,'2024-09-20',NULL,'2024-05-23 08:30:00','2024-06-08 16:20:00'),(136,6,8,35.90,'2024-09-22',NULL,'2024-05-24 14:15:00','2024-06-05 13:45:00'),(137,7,9,40.40,'2024-09-25',NULL,'2024-05-25 10:30:00','2024-06-08 15:20:00'),(138,8,10,32.80,'2024-09-28',NULL,'2024-05-26 13:45:00','2024-06-10 09:30:00'),(139,9,11,37.25,'2024-10-01',NULL,'2024-05-27 09:00:00','2024-06-12 11:45:00'),(140,10,12,29.75,'2024-10-05',NULL,'2024-05-28 11:15:00','2024-06-15 14:15:00'),(141,11,13,22.50,'2024-10-10',NULL,'2024-05-29 10:00:00','2024-05-29 10:00:00'),(142,12,14,19.75,'2024-10-12',NULL,'2024-05-30 11:30:00','2024-05-30 11:30:00'),(143,13,15,25.25,'2024-10-15',NULL,'2024-05-31 14:45:00','2024-05-31 14:45:00'),(144,14,16,21.80,'2024-10-18',NULL,'2024-06-01 09:15:00','2024-06-01 09:15:00'),(145,15,17,24.50,'2024-10-20',NULL,'2024-06-02 12:30:00','2024-06-02 12:30:00'),(146,1,2,20.00,'2025-06-01',NULL,'2025-04-27 03:32:27','2025-04-27 03:32:27'),(147,20,2,9999.00,'2025-05-07',NULL,'2025-04-27 03:33:22','2025-04-27 03:33:22'),(148,1,2,22.00,'2025-06-01',NULL,'2025-04-27 04:00:53','2025-04-27 04:00:53');
/*!40000 ALTER TABLE `fruit_stock_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fruits`
--

DROP TABLE IF EXISTS `fruits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fruits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fruit_name` varchar(50) NOT NULL,
  `shelf_life` int NOT NULL COMMENT 'Shelf life in days',
  `city_name` varchar(50) NOT NULL,
  `usa_warehouse_distance` float NOT NULL DEFAULT '0' COMMENT 'Distance from 123 Industrial Ave, Brooklyn, NY (km)',
  `japan_warehouse_distance` float NOT NULL DEFAULT '0' COMMENT 'Distance from 1-1 Shibuya Crossing, Tokyo (km)',
  `hk_warehouse_distance` float NOT NULL DEFAULT '0' COMMENT 'Distance from 88 Victoria Peak Rd, Hong Kong (km)',
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fruits`
--

LOCK TABLES `fruits` WRITE;
/*!40000 ALTER TABLE `fruits` DISABLE KEYS */;
INSERT INTO `fruits` VALUES (1,'Apple',35,'New York, USA',10,10800,12900),(2,'Banana',12,'Quito, Ecuador',4700,14000,17000),(3,'Orange',19,'Seville, Spain',5700,11000,10500),(4,'Grapes',15,'Cape Town, South Africa',12500,14000,11500),(5,'Strawberry',10,'Oxnard, California, USA',4000,8800,11500),(6,'Blueberry',12,'Vancouver, Canada',3900,7500,10200),(7,'Pineapple',19,'Honolulu, Hawaii, USA',8000,6200,8900),(8,'Mango',15,'Mumbai, India',12500,6700,4300),(9,'Peach',12,'Atlanta, Georgia, USA',1200,11000,13500),(10,'Pear',25,'Yakima, Washington, USA',3800,8000,10500),(11,'Kiwi',26,'Auckland, New Zealand',14000,8800,9200),(12,'Watermelon',19,'Beijing, China',11000,2100,2000),(13,'Cantaloupe',15,'Yuma, Arizona, USA',3500,9500,12000),(14,'Honeydew',15,'Hermosillo, Mexico',3500,10000,12500),(15,'Plum',12,'Santiago, Chile',8200,17000,18500),(16,'Cherry',10,'Traverse City, Michigan, USA',1000,10000,12500),(17,'Apricot',12,'Malatya, Turkey',8800,8500,7500),(18,'Nectarine',12,'Fresno, California, USA',3900,8500,11500),(19,'Papaya',12,'Rio de Janeiro, Brazil',7700,18500,17500),(20,'Guava',10,'Havana, Cuba',2100,12000,14500);
/*!40000 ALTER TABLE `fruits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` char(64) NOT NULL COMMENT 'SHA-256 hashed',
  `role` enum('management','warehouse','bakery','none') NOT NULL,
  `store_id` int DEFAULT NULL COMMENT 'Only for bakery staff',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `bakery` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'admin','Tam Tsz Kiu','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','management',NULL),(2,'rw123','Robert Warehouse','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','warehouse',NULL),(3,'js123','Jennifer Stock','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','warehouse',NULL),(4,'ts123','Thomas Storage','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','none',NULL),(5,'ji123','Jessica Inventory','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','warehouse',NULL),(6,'dl123','Daniel Logistics','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','warehouse',NULL),(7,'jb123','John Baker','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','bakery',1),(8,'ss123','Sarah Smith','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','bakery',2),(9,'mj123','Mike Johnson','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','bakery',3),(10,'eb123','Emily Davis','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','bakery',4),(11,'dw123','David Wilson','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8','bakery',5);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-27 22:49:46
