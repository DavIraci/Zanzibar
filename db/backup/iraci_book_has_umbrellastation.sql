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
INSERT INTO `book_has_umbrellastation` VALUES (1,27,0),(2,12,1),(2,32,0),(2,45,2),(4,15,1),(4,16,0),(5,17,2),(5,18,1),(6,25,2),(6,26,1),(7,16,1),(7,17,0),(8,15,2),(8,16,0),(8,17,0),(9,15,2),(9,26,2),(9,35,0),(10,16,2),(10,25,2),(10,36,0),(11,13,1),(11,14,0),(11,23,0),(12,17,1),(12,27,0),(12,37,0),(12,46,0),(12,56,0),(13,33,1),(13,43,0),(14,35,2),(14,36,1),(15,24,0),(16,34,0),(16,44,0);
/*!40000 ALTER TABLE `book_has_umbrellastation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-15 10:08:37
