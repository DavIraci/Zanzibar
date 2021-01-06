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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'2020-12-14','2020-12-14 10:14:38',NULL,'Full',15.00,1,'2020-12-22 16:08:12','2020-12-22 16:18:34',1),(2,'2020-12-18','2020-12-17 19:24:35',NULL,'Full',45.00,1,NULL,NULL,1),(3,'2020-12-22','2020-12-21 22:24:16',NULL,'Full',48.00,1,NULL,NULL,1),(4,'2020-12-22','2020-12-21 22:27:47',NULL,'Full',36.00,1,NULL,NULL,1),(5,'2020-12-22','2020-12-21 22:30:44',NULL,'Full',44.00,1,NULL,NULL,1),(6,'2020-12-22','2020-12-21 22:32:41',NULL,'Full',42.00,0,NULL,NULL,1),(7,'2021-01-01','2020-12-28 12:33:40',NULL,'Full',36.00,0,NULL,NULL,1),(8,'2021-01-03','2020-12-28 15:55:46',NULL,'PM',56.00,0,NULL,NULL,1),(9,'2021-01-29','2020-12-31 01:23:04',NULL,'AM',61.00,0,NULL,NULL,1),(10,'2021-01-29','2021-01-03 14:19:15',NULL,'Full',61.00,0,NULL,NULL,1),(11,'2021-01-22','2021-01-03 14:35:06',NULL,'AM',51.00,0,NULL,NULL,3),(12,'2021-01-28','2021-01-03 14:59:29',NULL,'Full',74.00,0,NULL,NULL,1),(13,'2021-01-29','2021-01-04 14:46:24',NULL,'PM',17.50,0,NULL,NULL,1);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-06 16:29:03
