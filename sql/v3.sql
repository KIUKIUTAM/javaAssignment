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
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `bakery_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `state` tinyint NOT NULL COMMENT '0=Pending, 1=Approved by borrowed shop, 2=Approved by warehouse, 3=Rejected',
  PRIMARY KEY (`id`),
  KEY `idx_borrow_bakery` (`bakery_id`),
  KEY `idx_borrow_state` (`state`),
  KEY `fruit_borrow_record_ibfk_3_idx` (`borrow_bakery_id`),
  KEY `fruit_borrow_record_ibfk_4_idx` (`stock_id`),
  CONSTRAINT `fruit_borrow_record_ibfk_2` FOREIGN KEY (`bakery_id`) REFERENCES `bakery` (`id`),
  CONSTRAINT `fruit_borrow_record_ibfk_3` FOREIGN KEY (`borrow_bakery_id`) REFERENCES `bakery` (`id`),
  CONSTRAINT `fruit_borrow_record_ibfk_4` FOREIGN KEY (`stock_id`) REFERENCES `fruit_stock_record` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approve_date` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reserve_fruit` (`fruit_id`),
  KEY `idx_reserve_bakery` (`bakery_id`),
  KEY `idx_reserve_state` (`state`),
  CONSTRAINT `fruit_reserve_record_ibfk_1` FOREIGN KEY (`fruit_id`) REFERENCES `fruits` (`id`),
  CONSTRAINT `fruit_reserve_record_ibfk_2` FOREIGN KEY (`bakery_id`) REFERENCES `bakery` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `city_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `fruits_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `role` enum('management','warehouse','bakery') NOT NULL,
  `store_id` int DEFAULT NULL COMMENT 'Only for bakery staff',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `bakery` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-27  0:13:01
