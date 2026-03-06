CREATE DATABASE  IF NOT EXISTS `project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `project`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: project
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `PNRNo` varchar(20) NOT NULL,
  `serial_no` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `reservation_status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`PNRNo`,`serial_no`),
  CONSTRAINT `passenger_ibfk_1` FOREIGN KEY (`PNRNo`) REFERENCES `ticket` (`PNRNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES ('PNR001',1,'Ravi',65,'CONFIRM'),('PNR001',2,'Meena',58,'CONFIRM'),('PNR002',1,'Suresh',62,'RAC'),('PNR003',1,'Anita',45,'CONFIRM'),('PNR004',1,'Kamal',70,'WAITLIST'),('PNR005',1,'Geeta',60,'RAC'),('PNR005',2,'Balu',30,'RAC');
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `PNRNo` varchar(20) NOT NULL,
  `transactionid` varchar(50) DEFAULT NULL,
  `from_station` varchar(100) DEFAULT NULL,
  `to_station` varchar(100) DEFAULT NULL,
  `date_of_journey` date DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `date_of_booking` date DEFAULT NULL,
  `total_ticket_fare` decimal(10,2) DEFAULT NULL,
  `train_number` int DEFAULT NULL,
  PRIMARY KEY (`PNRNo`),
  KEY `train_number` (`train_number`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`train_number`) REFERENCES `train` (`train_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES ('PNR001','TX1001','Chennai','Mumbai','2019-10-01','3 TIER AC','2019-08-01',1800.00,12601),('PNR002',NULL,'Chennai','Mumbai','2019-09-15','2 TIER AC','2019-08-20',1500.00,12951),('PNR003','TX1003','Chennai','Mumbai','2019-10-01','AC CHAIR CAR','2019-08-15',820.00,12601),('PNR004','TX1004','Mumbai','Pune','2019-09-10','SLEEPER','2019-07-20',200.00,15023),('PNR005',NULL,'Chennai','Madurai','2019-10-01','3 TIER AC','2019-08-25',920.00,11011);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `train_number` int NOT NULL,
  `train_name` varchar(150) NOT NULL,
  `source` varchar(100) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `reach_time` time DEFAULT NULL,
  `traveltime` varchar(20) DEFAULT NULL,
  `distance` int DEFAULT NULL,
  `class` varchar(100) DEFAULT NULL,
  `days` varchar(100) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`train_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (11011,'Bay Area Link','Chennai','Madurai','10:00:00','18:00:00','08:00',500,'3 TIER AC, SLEEPER','Daily','Express'),(12601,'Chennai Express','Chennai','Mumbai','06:00:00','18:00:00','12:00',1210,'AC CHAIR CAR, 3 TIER AC, SLEEPER','Daily','Express'),(12951,'Coastal Mail','Chennai','Mumbai','08:00:00','22:00:00','14:00',1300,'2 TIER AC, 3 TIER AC, SLEEPER','Daily','Mail'),(13007,'Kaveri Superfast','Chennai','Mumbai','09:00:00','23:30:00','14:30',1250,'1 TIER AC, 3 TIER AC, SLEEPER','Daily','Superfast'),(15023,'Mumbai Local','Mumbai','Pune','05:30:00','07:30:00','02:00',125,'SLEEPER','Weekdays','Local');
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_route`
--

DROP TABLE IF EXISTS `train_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_route` (
  `train_number` int NOT NULL,
  `route_no` int NOT NULL,
  `station_code` varchar(10) NOT NULL,
  `name` varchar(150) DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `depart_time` time DEFAULT NULL,
  `distance` int DEFAULT NULL,
  `day` int DEFAULT NULL,
  PRIMARY KEY (`train_number`,`route_no`,`station_code`),
  CONSTRAINT `train_route_ibfk_1` FOREIGN KEY (`train_number`) REFERENCES `train` (`train_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_route`
--

LOCK TABLES `train_route` WRITE;
/*!40000 ALTER TABLE `train_route` DISABLE KEYS */;
INSERT INTO `train_route` VALUES (11011,1,'MAS','Chennai Central',NULL,'10:00:00',0,1),(12601,1,'MAS','Chennai Central',NULL,'06:00:00',0,1),(12601,2,'MBI','Madurai Junction','10:00:00','10:10:00',500,1),(12601,3,'MMT','Mumbai Central','18:00:00',NULL,1200,1),(12951,1,'MAS','Chennai Central',NULL,'08:00:00',0,1),(12951,2,'MDU','Madurai Junction','11:00:00','11:10:00',480,1),(12951,3,'MMR','Mumbai Road','22:00:00',NULL,1300,1),(13007,1,'MAS','Chennai Central',NULL,'09:00:00',0,1),(13007,2,'MNG','Mangalore Junction','15:00:00','15:15:00',700,1),(13007,3,'MMT','Mumbai Central','23:30:00',NULL,1250,1),(15023,1,'MMT','Mumbai Central',NULL,'05:30:00',0,1);
/*!40000 ALTER TABLE `train_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_ticket_fare`
--

DROP TABLE IF EXISTS `train_ticket_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_ticket_fare` (
  `train_number` int NOT NULL,
  `class` varchar(50) NOT NULL,
  `base_fare` decimal(10,2) DEFAULT NULL,
  `reservation_charge` decimal(8,2) DEFAULT NULL,
  `superfast_charge` decimal(8,2) DEFAULT NULL,
  `other_charge` decimal(8,2) DEFAULT NULL,
  `tatkal_charge` decimal(8,2) DEFAULT NULL,
  `service_tax` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`train_number`,`class`),
  CONSTRAINT `train_ticket_fare_ibfk_1` FOREIGN KEY (`train_number`) REFERENCES `train` (`train_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_ticket_fare`
--

LOCK TABLES `train_ticket_fare` WRITE;
/*!40000 ALTER TABLE `train_ticket_fare` DISABLE KEYS */;
INSERT INTO `train_ticket_fare` VALUES (11011,'3 TIER AC',900.00,25.00,55.00,10.00,0.00,18.00),(12601,'3 TIER AC',1200.00,30.00,60.00,10.00,0.00,18.00),(12601,'AC CHAIR CAR',800.00,20.00,50.00,10.00,0.00,18.00),(12951,'2 TIER AC',1500.00,35.00,70.00,12.00,0.00,18.00),(13007,'1 TIER AC',2000.00,40.00,80.00,12.00,0.00,18.00),(15023,'SLEEPER',200.00,10.00,0.00,5.00,0.00,5.00);
/*!40000 ALTER TABLE `train_ticket_fare` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-06 12:17:56
