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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-15 10:08:37
