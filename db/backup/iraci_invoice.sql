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
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `id_invoice` int NOT NULL AUTO_INCREMENT,
  `id_book` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `fiscalcode` varchar(16) NOT NULL,
  `address` varchar(60) NOT NULL,
  `region` varchar(45) NOT NULL,
  `province` varchar(4) NOT NULL,
  `city` varchar(45) NOT NULL,
  `CAP` varchar(5) NOT NULL,
  `method` varchar(10) NOT NULL,
  `cardno` varchar(4) NOT NULL,
  PRIMARY KEY (`id_invoice`),
  KEY `id_book_idx` (`id_book`),
  CONSTRAINT `id_book` FOREIGN KEY (`id_book`) REFERENCES `book` (`id_Book`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,6,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani, 27','sicilia','pa','Palermo','90143','Paypal',''),(2,7,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani, 27','Sicilia','PA','Palermo','90143','Paypal',''),(3,8,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani27','sicilia','PA','Palermo','90143','Paypal',''),(4,9,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani27','sicilia','pa','Palermo','90143','Paypal',''),(5,10,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal',''),(6,11,'Roberto','Manzo','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal',''),(7,12,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal',''),(8,13,'Davide','Iraci','iraci.davide@gmail.com','RCIDVD97E15G273R','Via Saverio Scrofani 27','Sicilia','PA','Palermo','90143','Paypal','');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
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
