-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: iraci
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `id_Book` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `bookingDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guests` tinytext,
  `bookingPeriod` varchar(9) NOT NULL COMMENT 'FULL, AM, PM',
  `cost` decimal(6,2) NOT NULL,
  `canceled` tinyint NOT NULL DEFAULT '0',
  `checkIn` timestamp NULL DEFAULT NULL,
  `checkOut` timestamp NULL DEFAULT NULL,
  `User_id_User` int NOT NULL,
  PRIMARY KEY (`id_Book`),
  KEY `fk_Book_User_idx` (`User_id_User`),
  CONSTRAINT `fk_Book_User` FOREIGN KEY (`User_id_User`) REFERENCES `user` (`id_User`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'2020-12-14','2020-12-14 10:14:38',NULL,'Full',15.00,1,'2020-12-22 16:08:12','2020-12-22 16:18:34',1),(2,'2020-12-18','2020-12-17 19:24:35',NULL,'Full',45.00,1,'2020-12-18 09:30:11','2020-12-18 17:31:01',1),(3,'2020-12-22','2020-12-21 22:24:16',NULL,'Full',48.00,1,'2020-12-22 08:03:14','2020-12-22 15:03:14',1),(4,'2020-12-22','2020-12-21 22:27:47',NULL,'Full',36.00,1,'2020-12-22 08:05:14','2020-12-22 16:03:14',1),(5,'2020-12-22','2020-12-21 22:30:44',NULL,'Full',44.00,1,'2020-12-22 08:08:14','2020-12-22 15:33:14',1),(6,'2020-12-22','2020-12-21 22:32:41',NULL,'Full',42.00,0,'2020-12-22 08:13:14','2020-12-22 15:09:14',1),(7,'2021-01-01','2020-12-28 12:33:40',NULL,'Full',36.00,0,'2021-01-01 09:11:12','2021-01-01 16:32:42',1),(8,'2021-01-03','2020-12-28 15:55:46',NULL,'PM',56.00,0,'2021-01-03 15:11:12','2021-01-03 16:32:42',1),(9,'2021-01-29','2020-12-31 01:23:04',NULL,'AM',61.00,1,'2021-01-29 08:31:16',NULL,1),(10,'2021-01-29','2021-01-03 14:19:15',NULL,'Full',61.00,0,'2021-01-29 08:41:16',NULL,1),(11,'2021-01-22','2021-01-03 14:35:06',NULL,'AM',51.00,0,NULL,NULL,3),(12,'2021-01-28','2021-01-03 14:59:29',NULL,'Full',74.00,0,NULL,NULL,1),(13,'2021-01-29','2021-01-04 14:46:24',NULL,'PM',17.50,0,'2021-01-29 14:31:16',NULL,1),(14,'2021-01-14','2021-01-10 15:20:38',NULL,'Full',17.50,0,'2021-01-14 08:58:10','2021-01-14 16:32:42',1),(15,'2021-01-22','2021-01-11 10:27:01',NULL,'AM',7.50,0,NULL,NULL,1),(16,'2021-01-29','2021-01-13 11:53:57',NULL,'Full',27.00,0,'2021-01-29 08:12:10','2021-01-29 17:13:54',3),(17,'2021-01-17','2021-01-17 10:05:17','Roberto Manzo,\nDavide Iraci,\nGiorgia Russo','PM',33.00,0,'2021-01-17 15:05:44','2021-01-17 17:32:42',3),(18,'2021-01-22','2021-01-18 15:55:38',NULL,'AM',21.50,0,NULL,NULL,3),(19,'2021-01-23','2021-01-18 15:56:00',NULL,'AM',30.00,0,NULL,NULL,3),(20,'2021-01-23','2021-01-18 18:41:59',NULL,'Full',31.00,0,NULL,NULL,3),(21,'2021-01-20','2021-01-18 19:07:50',NULL,'Full',62.00,0,NULL,NULL,8),(22,'2021-01-21','2021-01-18 19:08:00',NULL,'Full',48.00,0,NULL,NULL,8),(23,'2021-01-22','2021-01-18 19:08:09',NULL,'Full',16.00,0,NULL,NULL,8),(24,'2021-01-23','2021-01-18 19:08:18',NULL,'Full',32.00,0,NULL,NULL,8),(25,'2021-01-24','2021-01-18 19:08:31',NULL,'Full',48.00,0,NULL,NULL,8),(26,'2021-01-20','2021-01-18 19:09:07',NULL,'Full',41.00,0,NULL,NULL,6),(27,'2021-01-22','2021-01-18 19:09:17',NULL,'Full',56.00,0,NULL,NULL,6),(28,'2021-01-23','2021-01-18 19:09:26',NULL,'Full',60.00,0,NULL,NULL,6),(29,'2021-01-20','2021-01-18 19:09:52',NULL,'Full',48.00,0,NULL,NULL,7),(30,'2021-01-22','2021-01-18 19:10:03',NULL,'Full',30.00,0,NULL,NULL,7),(31,'2021-01-28','2021-01-18 19:10:13',NULL,'Full',32.00,0,NULL,NULL,7),(32,'2021-01-21','2021-01-18 19:10:45',NULL,'Full',90.00,0,NULL,NULL,3),(33,'2021-01-23','2021-01-18 19:10:53',NULL,'Full',26.00,0,NULL,NULL,3);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_has_umbrellastation`
--

DROP TABLE IF EXISTS `book_has_umbrellastation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_has_umbrellastation` (
  `Book_id_Book` int NOT NULL,
  `UmbrellaStation_id_UmbrellaStation` int NOT NULL,
  `extraChair` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Book_id_Book`,`UmbrellaStation_id_UmbrellaStation`),
  KEY `fk_Book_has_UmbrellaStation_UmbrellaStation1_idx` (`UmbrellaStation_id_UmbrellaStation`),
  KEY `fk_Book_has_UmbrellaStation_Book1_idx` (`Book_id_Book`),
  CONSTRAINT `fk_Book_has_UmbrellaStation_Book1` FOREIGN KEY (`Book_id_Book`) REFERENCES `book` (`id_Book`),
  CONSTRAINT `fk_Book_has_UmbrellaStation_UmbrellaStation1` FOREIGN KEY (`UmbrellaStation_id_UmbrellaStation`) REFERENCES `umbrellastation` (`id_UmbrellaStation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_has_umbrellastation`
--

LOCK TABLES `book_has_umbrellastation` WRITE;
/*!40000 ALTER TABLE `book_has_umbrellastation` DISABLE KEYS */;
INSERT INTO `book_has_umbrellastation` VALUES (1,27,0),(2,12,1),(2,32,0),(2,45,2),(4,15,1),(4,16,0),(5,17,2),(5,18,1),(6,25,2),(6,26,1),(7,16,1),(7,17,0),(8,15,2),(8,16,0),(8,17,0),(9,15,2),(9,26,2),(9,35,0),(10,16,2),(10,25,2),(10,36,0),(11,13,1),(11,14,0),(11,23,0),(12,17,1),(12,27,0),(12,37,0),(12,46,0),(12,56,0),(13,33,1),(13,43,0),(14,35,2),(14,36,1),(15,24,0),(16,34,0),(16,44,0),(17,12,1),(17,24,0),(17,34,0),(17,44,0),(18,22,0),(18,32,0),(18,33,0),(19,13,0),(19,22,0),(19,23,0),(19,33,0),(20,16,0),(20,26,0),(21,13,0),(21,14,0),(21,23,0),(21,24,0),(22,15,0),(22,16,0),(22,17,0),(23,12,0),(24,14,0),(24,15,0),(25,12,0),(25,13,0),(25,14,0),(26,33,0),(26,34,0),(26,44,0),(27,10,0),(27,11,0),(27,50,0),(27,51,0),(28,55,0),(28,56,0),(28,57,0),(28,58,0),(28,59,0),(29,15,0),(29,16,0),(29,17,0),(30,26,0),(30,27,0),(31,13,0),(31,14,0),(32,12,0),(32,13,0),(32,21,0),(32,24,0),(32,32,0),(32,33,0),(33,45,0),(33,46,0);
/*!40000 ALTER TABLE `book_has_umbrellastation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `id_invoice` int NOT NULL AUTO_INCREMENT,
  `id_book` int DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `fiscalcode` varchar(16) NOT NULL,
  `address` varchar(60) NOT NULL,
  `region` varchar(45) NOT NULL,
  `province` varchar(4) NOT NULL,
  `city` varchar(45) NOT NULL,
  `CAP` varchar(5) NOT NULL,
  `method` tinytext NOT NULL,
  `cardno` mediumtext,
  `id_order` int DEFAULT NULL,
  PRIMARY KEY (`id_invoice`),
  KEY `id_book_idx` (`id_book`),
  CONSTRAINT `id_book` FOREIGN KEY (`id_book`) REFERENCES `book` (`id_Book`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,6,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani, 27','sicilia','pa','Palermo','90143','Paypal','',NULL),(2,7,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani, 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(3,8,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani27','sicilia','PA','Palermo','90143','Paypal','',NULL),(4,9,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani27','sicilia','pa','Palermo','90143','Paypal','',NULL),(5,10,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(6,11,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(7,12,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(8,13,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(9,NULL,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',2),(10,NULL,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','CreditCard','5228180097670546',3),(11,NULL,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','CreditCard','5228180097670546',1),(12,NULL,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','CreditCard','Sicilia',4),(13,15,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','CreditCard','Sicilia',NULL),(14,NULL,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',10),(15,16,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Siciali','PA','Palermo','90143','Paypal','',NULL),(16,17,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(17,NULL,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',11),(18,18,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(19,19,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(20,20,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','CreditCard','Sicilia',NULL),(21,21,'Federico','Guida','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(22,22,'Federico','Guida','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(23,23,'Federico','Guida','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(24,24,'Federico','Guida','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(25,25,'Federico','Guida','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(26,26,'Simon Pietro','Romeo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(27,27,'Simon Pietro','Romeo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(28,28,'Simon Pietro','Romeo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(29,29,'Francesco Paolo','Castiglione','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(30,30,'Francesco Paolo','Castiglione','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(31,31,'Francesco Paolo','Castiglione','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(32,32,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL),(33,33,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','',NULL);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id_Order` int NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` char(1) NOT NULL DEFAULT 'A' COMMENT 'A: Acquired\nW: Working\nR: Ready\nT: in Transit\nD: Delivered',
  `payed` tinyint(1) NOT NULL DEFAULT '0',
  `User_id_User` int NOT NULL,
  `delivery_method` varchar(45) NOT NULL,
  PRIMARY KEY (`id_Order`),
  KEY `fk_Order_User1_idx` (`User_id_User`),
  CONSTRAINT `fk_Order_User1` FOREIGN KEY (`User_id_User`) REFERENCES `user` (`id_User`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2021-01-09 23:00:00','D',1,1,'Umbrella'),(2,'2021-01-09 23:00:00','D',1,1,'Umbrella'),(3,'2021-01-11 09:02:08','D',1,1,'Umbrella'),(4,'2021-01-11 09:11:55','D',1,1,'Umbrella'),(5,'2021-01-11 09:15:28','D',1,1,'Bar'),(6,'2021-01-11 09:44:36','D',1,1,'Bar'),(7,'2021-01-11 09:48:38','D',1,1,'Umbrella'),(8,'2021-01-11 09:50:48','D',1,1,'Umbrella'),(9,'2021-01-12 10:34:40','D',1,1,'Umbrella'),(10,'2021-01-12 15:14:08','D',1,1,'Umbrella'),(11,'2021-01-17 10:07:27','D',1,3,'Umbrella'),(12,'2021-01-17 13:49:17','D',1,3,'Bar');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_has_product`
--

DROP TABLE IF EXISTS `order_has_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_has_product` (
  `Order_id_Order` int NOT NULL,
  `Product_barcode` varchar(12) NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `price` decimal(6,2) NOT NULL,
  `details` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Order_id_Order`,`Product_barcode`),
  KEY `fk_Order_has_Product_Product1_idx` (`Product_barcode`),
  KEY `fk_Order_has_Product_Order1_idx` (`Order_id_Order`),
  CONSTRAINT `fk_Order_has_Product_Order1` FOREIGN KEY (`Order_id_Order`) REFERENCES `order` (`id_Order`),
  CONSTRAINT `fk_Order_has_Product_Product1` FOREIGN KEY (`Product_barcode`) REFERENCES `product` (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_has_product`
--

LOCK TABLES `order_has_product` WRITE;
/*!40000 ALTER TABLE `order_has_product` DISABLE KEYS */;
INSERT INTO `order_has_product` VALUES (1,'79',2,5.00,NULL),(2,'81',2,5.00,NULL),(3,'124',1,2.50,'Bello Freddo!'),(3,'46',2,15.00,NULL),(3,'79',2,5.00,NULL),(4,'39',1,10.00,NULL),(4,'42',1,14.00,'Non bruciate!'),(4,'46',1,15.00,NULL),(4,'55',1,4.00,NULL),(5,'109',1,7.00,NULL),(5,'81',1,5.00,NULL),(6,'115',1,1.00,NULL),(6,'39',1,10.00,'Buonee'),(7,'109',1,7.00,'Per Giovanni'),(7,'79',2,5.00,NULL),(8,'79',1,5.00,NULL),(9,'79',1,5.00,NULL),(10,'79',1,5.00,'MMMM'),(11,'100',1,20.00,NULL),(11,'31',1,12.00,NULL),(11,'55',1,4.00,NULL),(11,'81',1,5.00,NULL),(12,'124',1,2.50,NULL),(12,'39',1,10.00,NULL);
/*!40000 ALTER TABLE `order_has_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price`
--

DROP TABLE IF EXISTS `price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price` (
  `row` int NOT NULL AUTO_INCREMENT COMMENT 'row 0: extra chair\nrow 1-5: price of postation',
  `lowSeason` double NOT NULL,
  `midSeason` double NOT NULL,
  `highSeason` double NOT NULL,
  PRIMARY KEY (`row`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price`
--

LOCK TABLES `price` WRITE;
/*!40000 ALTER TABLE `price` DISABLE KEYS */;
INSERT INTO `price` VALUES (0,4,5,6),(1,16,18,22),(2,15,17,21),(3,14,16,20),(4,13,15,19),(5,12,14,18);
/*!40000 ALTER TABLE `price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `name` varchar(120) NOT NULL,
  `description` varchar(300) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `barcode` varchar(12) NOT NULL,
  `category` varchar(45) NOT NULL,
  PRIMARY KEY (`barcode`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('Croissant vari gusti','pan brioche, confettura di albicocca o crema pasticciera o crema al pistacchio o crema alle nocciole.',1.20,'1','Colazione'),('Calzone al cotto','mozzarella, calzone, olio di semi di girasole, prosciutto cotto.',2.50,'10','Rustici'),('BST','cabernet merlot IGT folonari.',20.00,'100','Vini Rossi'),('Vodka Belvedere','vodka.',7.00,'101','Distillati'),('Vodka Beluga','vodka.',7.00,'102','Distillati'),('Gentleman Jack','whisky.',7.00,'103','Distillati'),('Woodford Reserve','whisky.',7.00,'104','Distillati'),('Jack Daniel\'s Barrel','whiskey.',7.00,'105','Distillati'),('Lagavulin 16','whisky.',7.00,'106','Distillati'),('Oban 14','whisky.',7.00,'107','Distillati'),('Talisker 14','whisky.',7.00,'108','Distillati'),('Appleton Vx','rum.',7.00,'109','Distillati'),('Focaccia vari gusti','focaccia, acciughe sott\'olio, indivia, melanzane, olio di semi di girasole, parmigiano reggiano DOP, provola, salsa di pomodoro, ricotta di pecora.',2.00,'11','Rustici'),('Don Papa Rum','rum.',7.00,'110','Distillati'),('Gin Malfy','gin.',7.00,'111','Distillati'),('Gin London','gin.',7.00,'112','Distillati'),('Gin Mare','gin.',7.00,'113','Distillati'),('Gin Hendrick\'s','gin.',7.00,'114','Distillati'),('Acqua 50cl','acqua.',1.00,'115','Analcolici'),('Lemon soda 33cl','soda al limone.',2.50,'116','Analcolici'),('Chinotto 33cl','chinotto.',2.50,'117','Analcolici'),('Fanta 33cl','aranciata.',2.50,'118','Analcolici'),('Sprite 33cl','soda.',2.50,'119','Analcolici'),('Spicchi di patate dorate','patate, olio di semi di girasole, sale.',3.00,'12','Rustici'),('Coca Cola 33cl','soda.',2.50,'120','Analcolici'),('Succhi di frutta 33cl','succo di frutta.',2.50,'121','Analcolici'),('Red Bull 33cl','energy drink.',3.50,'122','Analcolici'),('Crodino 33cl','crodino',2.50,'123','Analcolici'),('Bitter bianco/rosso 33cl','bitter.',2.50,'124','Analcolici'),('Calzone messinese','mozzarella, calzone, acciughe sott\'olio, indivia, pomodorini, olio di semi di girasole.',2.50,'13','Rustici'),('Mista','carote, lattuga, pomodoro cuore di bue, radicchio rosso.',4.00,'14','Insalatone'),('Estiva','lattuga, mozzarella, olio extra vergine di oliva, pomodoro cuore di bue, uova di gallina.',6.00,'15','Insalatone'),('Salina','lattuga, mais, olio extra vergine di oliva, olio di semi di girasole, pomodorini datterini, tonno in salamoia sgocciolato.',6.00,'16','Insalatone'),('Norvegese','lattuga, olio extra vergine di oliva, olive nere, radicchio rosso, salmone affumicato.',7.00,'17','Insalatone'),('Mediterranea','mozzarella, olio extra vergine di oliva, olive nere, pomodoro cuore di bue, radicchio rosso.',5.00,'18','Insalatone'),('I semifreddi','frutta a guscio (allergene), semifreddo, biscotto, fave di cacao, pan di spagna.',4.00,'19','Frutta e Dessert'),('Caprese','pomodoro, mozzarella, olio extra vergine di oliva, basilico, origano, pane a lievitazione naturale.',4.00,'2','Panini'),('Tartufo gelato','tartufo bianco, tartufo nero, gelato, caffé.',2.50,'20','Frutta e Dessert'),('Brioche siciliana','pan brioche.',0.80,'21','Frutta e Dessert'),('Granita vari gusti','ghiaccio, cacao, chicci di caffé, destrosio, fragole, frutta a guscio (allergene), frutti di bosco, limone, melone d\'estate, panna montata, pesca, zucchero.',1.80,'22','Frutta e Dessert'),('Frutta fresca di stagione','ananas, pere, melone, mela, uva, fragole, melone d\'estate, pesca.',5.00,'23','Frutta e Dessert'),('Gran coppa gelato belvedere','gelato, biscotto, cioccolato, frutta a guscio (allergene), panna montata.',6.00,'24','Frutta e Dessert'),('Sfizi fritti di mare el giorno','olio extra vergine di oliva, semola di grano duro, farina di grano tenero, sale, variabile, olio di arachidi.',10.00,'25','Antipasti Di Mare'),('Degustazione di antipasti belvedere','racchiude tutti glli antipasti sopra elencati più degli assaggini del giorno che possono essere proposti dal cameriere.',20.00,'26','Antipasti Di Mare'),('Insalata di mare al vapore ai profumi mediterranei','aglio, olio extra vergine di oliva, vongole, calamari, cozze, prezzemolo, gamberi, limone, polpo.',12.00,'27','Antipasti Di Mare'),('Crudo di gamberi di mazzara, salsa di soia e frutta fresca di stagione','olio extra vergine di oliva, soia, ananas, pere, melone, mela, uva, gamberi, sale, salsa di soia.',14.00,'28','Antipasti Di Mare'),('Crudo di parma e mozzarella di bufala campana','prosciutto crudo, mozzarella di bufala.',10.00,'29','Antipasti Di Terra'),('Toast','pancarré, prosciutto cotto, sottilette.',2.00,'3','Panini'),('Misto di salumi, formaggi, confetture e conserve del territorio','pomodoro, formaggio stagionato, carne di maiale, olive verdi, olive nere, salame di maiale, prosciutto crudo, ricotta, pancetta, provola, pomodori secchi.',14.00,'30','Antipasti Di Terra'),('Busiate alla belvedere','olio extra vergine di oliva, basilico, farina di grano tenero, sale, olio di semi di girasole, capperi, semi di girasole, melanzane, mentuccia, uva passa, pesce spada, pinoli, pomodorini, pasta fresca all\'uovo.',12.00,'31','Primi Di Mare'),('Scialatielli all\'astice','pomodoro, aglio, olio extra vergine di oliva, astice, prezzemolo, olio di oliva, pasta fresca all\'uovo.',18.00,'32','Primi Di Mare'),('Couscous di pesce, crostacei e verdure','pomodoro, aglio, olio extra vergine di oliva, vongole, basilico, semola di grano duro, calamari, cous cous, cozze, gamberi, carote, melanzane, peperoni, zucchine, pesce (allergene).',14.00,'33','Primi Di Mare'),('Risotto mantecato al modo del pescatore','pomodoro, aglio, olio extra vergine di oliva, riso bianco, vongole, calamari, cozze, prezzemolo, gamberi.',12.00,'34','Primi Di Mare'),('Linguine trafilate al bronzo allo scoglio','pomodoro, pasta, aglio, olio extra vergine di oliva, cannolicchio, vongole, semola di grano duro, calamari, totani, cozze, prezzemolo, fasolari, grano, gamberi, scampi.',16.00,'35','Primi Di Mare'),('Spaghettoni alla chitarra, vongole veraci e bottarga','pasta, aglio, olio extra vergine di oliva, vongole, semola di grano duro, prezzemolo, uova di pesce spada.',14.00,'36','Primi Di Mare'),('Gnocchi alla sorrentina','pomodoro, olio extra vergine di oliva, uova di gallina, basilico, mozzarella, gnocchi di patate.',10.00,'37','Primi Di Terra'),('Maccheroni tipici alla norma','pomodoro, olio extra vergine di oliva, basilico, sale, olio di semi di girasole, semi di girasole, ricotta, melanzane, pasta fresca all\'uovo.',10.00,'38','Primi Di Terra'),('Bavette integrali al pesto di pistacchi di bronte','aglio, olio extra vergine di oliva, basilico, parmigiano reggiano DOP, pistacchi, pasta integrale.',10.00,'39','Primi Di Terra'),('Hot dog','wurstel di maiale, pane al latte, ketchup, maionese, patate fritte.',4.00,'4','Panini'),('Filetto di pesce del giorno all\'eoliana','pomodoro, sedano, olio extra vergine di oliva, olive verdi, pane, basilico, capperi, uva passa, tonno, salmone, branzino, orata, pinoli, variabile.',16.00,'40','Secondi Di Mare'),('Il pesce fresco del giorno','alla griglia, al forno, gratinato alla palermitana o in zuppa.',10.00,'41','Secondi Di Mare'),('Braciolette di pesce spada gratinate al forno','olio extra vergine di oliva, pane, prezzemolo, origano, uva passa, pecorino, pinoli, provola, pesce spada.',14.00,'42','Secondi Di Mare'),('Fritto del golfo di tindari e crema di limoni','acciughe, latterino, triglia, semola di grano duro, calamari, farina di grano tenero, sale, gamberi, limone, variabile, maionese, olio di arachidi.',16.00,'43','Secondi Di Mare'),('Zuppa di cozze di ganzirri e crostini di pane','pomodoro, olio extra vergine di oliva, pane, basilico, cozze, origano.',10.00,'44','Secondi Di Mare'),('Grigliata mista di pesce al \"salmurigghiu\" siculo e misticanza fresca','aceto di vino, olio extra vergine di oliva, calamari, carote, cicoria, indivia, prezzemolo, gamberoni, limone, menta, origano, tonno, salmone, branzino, orata, pesce spada, radicchio, scampi, pepe nero, sale, lattuga, vino bianco, vino rosso, variabile.',20.00,'45','Secondi Di Mare'),('Astice, granchio o aragosta vivi','aragosta, astice, granciporro.',15.00,'46','Secondi Di Mare'),('Braciolette di vitello alla messinese','aglio, carne di vitello, olio extra vergine di oliva, pane, carne di manzo, prezzemolo, pecorino, provola.',10.00,'47','Secondi Di Terra'),('Cotoletta di manzo con patatine fritte','olio extra vergine di oliva, pane, uova di gallina, carne di manzo, noci, semi di girasole, olio di semi di girasole, parmigiano reggiano DOP.',10.00,'48','Secondi Di Terra'),('Cannolo alla ricotta','farina di grano tenero, scorza di arancia, cacao in polvere, sugna, olio di arachidi, pistacchi, zucchero, burro, brandy, cioccolato, albume d\'uovo di gallina, zucchero a velo, ricotta di pecora.',3.00,'49','Dessert'),('Delicato','lattuga, pane a lievitazione naturale, prosciutto cotto, provola.',4.00,'5','Panini'),('Coppa di gelato vari gusti','gelato, variabile.',3.00,'50','Dessert'),('Coppa tiramisù al marsala','liquore, uova di gallina, cacao in polvere, zucchero, marsala, mascarpone, savoiardi.',3.50,'51','Dessert'),('Tagliata di frutta fresca di stagione','ananas, pere, melone, mela, uva, cocomero, fragole, kiwi, pesca.',5.00,'52','Dessert'),('I semifreddi del maestro pasticciere','ananas, pere, melone, mela, uva, anacardi, mandorle, nocciole, noci, panna, semifreddo.',4.00,'53','Dessert'),('La tradizionale torta caprese con gelato alla vaniglia','uova di gallina, burro, cacao in polvere, cioccolato, cioccolato al latte, zucchero, mandorle, latte di vacca, gelato alla vaniglia.',4.00,'54','Dessert'),('Biscotti secchi tipici o piccola pasticceria con vino liquoroso','biscotto, vino liquoroso, burro, farina di grano tenero, frutta a guscio (allergene), latte di vacca.',4.00,'55','Dessert'),('Caffé caldo','caffé.',1.00,'56','Caffetteria'),('Caffé freddo','caffé.',1.50,'57','Caffetteria'),('Caffé corretto','caffé.',1.50,'58','Caffetteria'),('Cappuccino','latte e caffé.',2.00,'59','Caffetteria'),('Sandwich','pancarré, lattuga, maionese, prosciutto cotto, sottilette, tonno in salamoia sgocciolato.',3.00,'6','Panini'),('Sfogliatina','pasta sfoglia.',1.50,'60','Caffetteria'),('Ichnusa 33cl','Birra.',3.00,'61','Birre'),('Peroni 33cl','Birra.',2.00,'62','Birre'),('Moretti 33cl','Birra.',2.00,'63','Birre'),('Peroni Chill Lemon 33cl','Birra.',2.50,'64','Birre'),('Messina Cristalli di Sale 33cl','Birra.',3.00,'65','Birre'),('Ceres 33cl','Birra.',4.00,'66','Birre'),('Corona 33cl','Birra.',4.00,'67','Birre'),('Tennent\'s 33cl','Birra.',5.00,'68','Birre'),('Bud 33cl','Birra.',4.00,'69','Birre'),('Delizioso al tonno','mozzarella, pane a lievitazione naturale, pomodoro cuore di bue, tonno in salamoia sgocciolato, olio di semi di girasole.',4.00,'7','Panini'),('Pilsner Urquell 33cl','Birra.',3.00,'70','Birre'),('Forst Felsenkeller 33cl','Birra.',3.00,'71','Birre'),('Goose Island IPA 33cl','Birra.',5.00,'72','Birre'),('Peroni Forte 33cl','Birra.',3.50,'73','Birre'),('Gin Tonic','gin e acqua tonica.',5.00,'74','Cocktails'),('Campari Orange','campari.',5.00,'75','Cocktails'),('Rum e Cola','rum e coca cola.',5.00,'76','Cocktails'),('Jack Daniels e Coca','whiskey e coca cola.',5.00,'77','Cocktails'),('Negroni','campari, martini rosso, gin.',5.00,'78','Cocktails'),('Americano','campari, martini rosso, soda.',5.00,'79','Cocktails'),('Vegano alle verdure','melanzane, peperoni, olio extra vergine di oliva, olive nere, pane a lievitazione naturale, pomodoro cuore di bue, zucchine grigliate.',4.00,'8','Panini'),('Negroni sbagliato','ampari, artini rosso, prosecco.',5.00,'80','Cocktails'),('Aperol Spritz','aperol, prosecco, soda.',5.00,'81','Cocktails'),('Moscow Mule','vodka, succo di lime, ginger beer.',5.00,'82','Cocktails'),('Long Island','rum, vodka, triple sec, gin, sweet sour, coca cola.',5.00,'83','Cocktails'),('Cosmopolitan','vodka, succo di lime, triple sec, succo di mirtillo.',5.00,'84','Cocktails'),('Margarita','tequila, triple sec, succo di lime.',5.00,'85','Cocktails'),('Mojito','rum scuro, lime a pezzi, zucchero di canna.',5.00,'86','Cocktails'),('Caipirinha','cachaça, lime a pezzi, zucchero di canna.',5.00,'87','Cocktails'),('Caipiroska','vodka fragola, lime a pezzi, zucchero di canna.',5.00,'88','Cocktails'),('Pitti','vermentino IGP BIO torre a cenaia.',20.00,'89','Vini Bianchi'),('Goloso al prosciutto crudo','pane a lievitazione naturale, pomodoro cuore di bue, prosciutto crudo, provola.',4.00,'9','Panini'),('Traminer Aromatico','DOC ca\'tullio.',20.00,'90','Vini Bianchi'),('Sauvignon','DOC ca\'tullio.',20.00,'91','Vini Bianchi'),('Chardonnay','DOC ca\'tullio.',20.00,'92','Vini Bianchi'),('Pinot Grigio','DOC ca\'tullio.',20.00,'93','Vini Bianchi'),('Pomino Bianco','DOC marchesi de\'frescobaldi 2016.',20.00,'94','Vini Bianchi'),('Vernaccia di San Gimignano','DOCG sensi.',20.00,'95','Vini Bianchi'),('Le Coste','chianti DOCG giuliano grati.',20.00,'96','Vini Rossi'),('Granaio','chianti classico DOCG fattorie melini.',20.00,'97','Vini Rossi'),('Calappiano','sangiovese toscana IGT villa calappiano.',20.00,'98','Vini Rossi'),('La Pieve','morellino di scansano DOCG f.lli rossi.',20.00,'99','Vini Rossi');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `umbrellastation`
--

DROP TABLE IF EXISTS `umbrellastation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `umbrellastation` (
  `id_UmbrellaStation` int NOT NULL AUTO_INCREMENT,
  `row` int NOT NULL,
  `price` decimal(6,2) NOT NULL,
  PRIMARY KEY (`id_UmbrellaStation`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `umbrellastation`
--

LOCK TABLES `umbrellastation` WRITE;
/*!40000 ALTER TABLE `umbrellastation` DISABLE KEYS */;
INSERT INTO `umbrellastation` VALUES (10,1,8.00),(11,1,8.00),(12,1,8.00),(13,1,8.00),(14,1,8.00),(15,1,8.00),(16,1,8.00),(17,1,8.00),(18,1,8.00),(19,1,8.00),(20,2,6.00),(21,2,6.00),(22,2,6.00),(23,2,6.00),(24,2,6.00),(25,2,6.00),(26,2,6.00),(27,2,6.00),(28,2,6.00),(29,2,6.00),(30,3,4.00),(31,3,4.00),(32,3,4.00),(33,3,4.00),(34,3,4.00),(35,3,4.00),(36,3,4.00),(37,3,4.00),(38,3,4.00),(39,3,4.00),(40,4,8.00),(41,4,8.00),(42,4,8.00),(43,4,8.00),(44,4,8.00),(45,4,8.00),(46,4,8.00),(47,4,8.00),(48,4,8.00),(49,4,8.00),(50,5,8.00),(51,5,8.00),(52,5,8.00),(53,5,8.00),(54,5,8.00),(55,5,8.00),(56,5,8.00),(57,5,8.00),(58,5,8.00),(59,5,8.00);
/*!40000 ALTER TABLE `umbrellastation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_User` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `birthday` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(45) NOT NULL,
  `password` varchar(64) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  PRIMARY KEY (`id_User`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Davide','Iraci','1997-05-15','admin@gmail.com','Admin','554a8b9a80869d65d139436c1527058a066014367b638e35c98595d3f6ba016c','3333333333','091111111'),(2,'Marco','La Martina','1997-01-01','lifeguard@gmail.com','Lifeguard','58155115f04aed6b74032fe6aba066e255286de0e3ff343f04f1b685d4d60fe0','3333333333',''),(3,'Roberto','Manzo','1997-01-01','user@gmail.com','User','6d262a3747a2f9874c49708d35f84385d569b4eee54871924a873da2112e3e0d','3333333333',''),(4,'Andrea','Montemaggiore','1997-01-01','kitchen@gmail.com','Cook','7ee03d7da6e25ec6b24da85a3ca423813f61374c250dc4abf355d0100da4fdfd','3333333333',''),(5,'Giovanni','Raccuglia','1996-01-01','cashdesk@gmail.com','CashDesk','03c809b539aa81f1c45b4ce1ddd0c355cfdc60a9f6bfb6e1eef17c3cb1c06b47','3333333333',''),(6,'Simon Pietro','Romeo','1998-01-01','user4@gmail.com','User','6d262a3747a2f9874c49708d35f84385d569b4eee54871924a873da2112e3e0d','3333333333','091111111'),(7,'Francesco Paolo','Castiglione','1997-01-01','user2@gmail.com','User','6d262a3747a2f9874c49708d35f84385d569b4eee54871924a873da2112e3e0d','3333333333',''),(8,'Federico','Guida','1997-01-01','user3@gmail.com','User','6d262a3747a2f9874c49708d35f84385d569b4eee54871924a873da2112e3e0d','3333333333',''),(9,'Francesco','Bafumo','1998-01-01','user5@gmail.com','User','6d262a3747a2f9874c49708d35f84385d569b4eee54871924a873da2112e3e0d','3333333333','');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-18 21:08:45
