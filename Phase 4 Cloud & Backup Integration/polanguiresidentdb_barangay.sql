CREATE DATABASE  IF NOT EXISTS `polanguiresidentdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `polanguiresidentdb`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: polanguiresidentdb
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `barangay`
--

DROP TABLE IF EXISTS `barangay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barangay` (
  `barangay_id` int NOT NULL AUTO_INCREMENT,
  `barangay_name` varchar(100) NOT NULL,
  `barangay_classification` enum('Poblacion','Rinconada','Upland','Railroad') NOT NULL,
  PRIMARY KEY (`barangay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barangay`
--

LOCK TABLES `barangay` WRITE;
/*!40000 ALTER TABLE `barangay` DISABLE KEYS */;
INSERT INTO `barangay` VALUES (1,'Agos','Rinconada'),(2,'Alnay','Poblacion'),(3,'Alomon','Poblacion'),(4,'Amoguis','Upland'),(5,'Anopol','Upland'),(6,'Apad','Rinconada'),(7,'Balaba','Upland'),(8,'Balangibang','Poblacion'),(9,'Balinad','Upland'),(10,'Basud','Poblacion'),(11,'Binagbangan (Pintor)','Rinconada'),(12,'Buyo','Upland'),(13,'Centro Occidental','Poblacion'),(14,'Centro Oriental','Poblacion'),(15,'Cepres','Upland'),(16,'Cotmon','Upland'),(17,'Cotnogan','Upland'),(18,'Danao','Upland'),(19,'Gabon','Upland'),(20,'Gamot','Upland'),(21,'Itaran','Upland'),(22,'Kinale','Upland'),(23,'Kinuartilan','Upland'),(24,'La Medalla','Rinconada'),(25,'La Purisima','Rinconada'),(26,'Lanigay','Rinconada'),(27,'Lidong','Upland'),(28,'Lourdes','Upland'),(29,'Magpanambo','Upland'),(30,'Magurang','Upland'),(31,'Matacon','Rinconada'),(32,'Maynaga','Upland'),(33,'Maysua','Rinconada'),(34,'Mendez','Upland'),(35,'Napo','Upland'),(36,'Pinagdapugan','Upland'),(37,'Ponso','Rinconada'),(38,'Salvacion','Upland'),(39,'San Roque','Rinconada'),(40,'Santicon','Rinconada'),(41,'Santa Cruz','Upland'),(42,'Santa Teresita','Rinconada'),(43,'Sugcad','Poblacion'),(44,'Ubaliw','Poblacion');
/*!40000 ALTER TABLE `barangay` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-07 17:25:42
