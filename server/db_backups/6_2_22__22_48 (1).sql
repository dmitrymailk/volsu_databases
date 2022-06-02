CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `bill_user` int NOT NULL,
  `bill_sum` decimal(10,0) NOT NULL,
  PRIMARY KEY (`bill_id`,`bill_user`),
  UNIQUE KEY `bill_id_UNIQUE` (`bill_id`),
  KEY `fk_bill_1_idx` (`bill_user`),
  CONSTRAINT `fk_bill_1` FOREIGN KEY (`bill_user`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (29,38,5),(30,38,80),(31,40,30),(32,41,35),(33,41,35),(34,42,15),(35,42,60),(36,42,90),(37,43,20),(38,43,40);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bought_product`
--

DROP TABLE IF EXISTS `bought_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bought_product` (
  `bought_product_id` int NOT NULL AUTO_INCREMENT,
  `bought_product_original` int NOT NULL,
  `bought_product_price` int NOT NULL,
  `bought_product_bill` int NOT NULL,
  `bought_product_time` date DEFAULT NULL,
  PRIMARY KEY (`bought_product_id`,`bought_product_original`,`bought_product_bill`),
  UNIQUE KEY `bought_product_id_UNIQUE` (`bought_product_id`),
  KEY `fk_bought_product_1_idx` (`bought_product_original`),
  KEY `fk_bought_product_2_idx` (`bought_product_bill`),
  CONSTRAINT `fk_bought_product_1` FOREIGN KEY (`bought_product_original`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_bought_product_2` FOREIGN KEY (`bought_product_bill`) REFERENCES `bill` (`bill_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bought_product`
--

LOCK TABLES `bought_product` WRITE;
/*!40000 ALTER TABLE `bought_product` DISABLE KEYS */;
INSERT INTO `bought_product` VALUES (20,14,5,29,'2022-01-01'),(21,15,10,30,'2022-01-01'),(22,15,10,30,'2022-01-01'),(23,15,10,30,'2022-01-01'),(24,15,10,30,'2022-01-01'),(25,19,40,30,'2022-01-01'),(26,18,30,31,'2022-02-01'),(27,14,5,32,'2022-02-02'),(28,14,5,32,'2022-02-02'),(29,14,5,32,'2022-02-02'),(30,17,20,32,'2022-02-02'),(31,16,15,33,'2022-02-03'),(32,17,20,33,'2022-02-03'),(33,16,15,34,'2022-02-03'),(34,18,30,35,'2022-03-01'),(35,18,30,35,'2022-03-01'),(36,19,40,36,'2022-04-01'),(37,15,10,36,'2022-04-01'),(38,14,5,36,'2022-04-01'),(39,14,5,36,'2022-04-01'),(40,18,30,36,'2022-04-01'),(41,16,15,37,'2022-04-01'),(42,14,5,37,'2022-04-01'),(43,19,40,38,'2022-04-01');
/*!40000 ALTER TABLE `bought_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logger`
--

DROP TABLE IF EXISTS `logger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logger` (
  `logger_id` bigint NOT NULL AUTO_INCREMENT,
  `logger_table_name` varchar(100) DEFAULT NULL,
  `logger_action` varchar(100) DEFAULT NULL,
  `logger_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`logger_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logger`
--

LOCK TABLES `logger` WRITE;
/*!40000 ALTER TABLE `logger` DISABLE KEYS */;
INSERT INTO `logger` VALUES (1,'user','insert','2022-04-23 20:30:16'),(2,'user','delete','2022-04-23 20:30:46'),(3,'user','insert','2022-04-26 07:39:25'),(4,'user','delete','2022-04-26 07:41:45'),(5,'user','insert','2022-05-23 19:31:41'),(6,'user','insert','2022-05-23 19:37:10'),(7,'user','insert','2022-05-23 19:38:22'),(8,'user','insert','2022-05-23 22:37:22'),(9,'user','insert','2022-05-23 22:39:43'),(10,'user','insert','2022-05-23 23:12:43'),(11,'user','insert','2022-05-23 23:13:48'),(12,'user','insert','2022-05-23 23:14:39'),(13,'user','insert','2022-05-23 23:15:05'),(14,'user','insert','2022-05-23 23:15:15'),(15,'user','insert','2022-05-23 23:16:24'),(16,'user','insert','2022-05-24 00:32:04'),(17,'user','insert','2022-05-24 00:38:34'),(18,'user','insert','2022-05-24 00:49:59'),(19,'user','insert','2022-05-24 07:53:43'),(20,'user','insert','2022-05-24 08:16:25'),(21,'user','insert','2022-05-24 08:25:46'),(22,'user','insert','2022-05-31 08:37:39'),(23,'user','delete','2022-05-31 08:41:10'),(24,'user','delete','2022-05-31 09:52:27'),(25,'user','delete','2022-05-31 09:52:30'),(26,'user','delete','2022-05-31 09:52:32'),(27,'user','delete','2022-05-31 09:52:33'),(28,'user','delete','2022-05-31 09:52:35'),(29,'user','delete','2022-05-31 09:52:37'),(30,'user','insert','2022-05-31 09:53:24'),(31,'user','delete','2022-05-31 09:55:46'),(32,'user','insert','2022-05-31 09:59:37'),(33,'user','insert','2022-05-31 10:06:27'),(34,'user','insert','2022-05-31 10:13:46'),(35,'user','insert','2022-05-31 10:37:33'),(36,'user','delete','2022-06-02 19:52:15'),(37,'user','delete','2022-06-02 19:52:15'),(38,'user','delete','2022-06-02 19:52:16'),(39,'user','delete','2022-06-02 19:52:18'),(40,'user','delete','2022-06-02 19:52:19'),(41,'user','delete','2022-06-02 19:52:19'),(42,'user','delete','2022-06-02 19:52:20'),(43,'user','delete','2022-06-02 19:52:20'),(44,'user','delete','2022-06-02 19:52:21'),(45,'user','delete','2022-06-02 19:52:22'),(46,'user','delete','2022-06-02 19:52:22'),(47,'user','delete','2022-06-02 19:52:23'),(48,'user','delete','2022-06-02 19:52:23'),(49,'user','delete','2022-06-02 19:52:23'),(50,'user','delete','2022-06-02 19:52:24'),(51,'user','delete','2022-06-02 19:52:25'),(52,'user','delete','2022-06-02 19:52:26'),(53,'user','delete','2022-06-02 19:52:29'),(54,'user','delete','2022-06-02 19:52:30'),(55,'user','delete','2022-06-02 19:52:30'),(56,'user','delete','2022-06-02 19:52:31'),(57,'user','insert','2022-06-02 20:11:48'),(58,'user','insert','2022-06-02 20:11:48'),(59,'user','insert','2022-06-02 20:11:48'),(60,'user','insert','2022-06-02 20:11:48'),(61,'user','insert','2022-06-02 20:11:48'),(62,'user','insert','2022-06-02 20:11:48'),(63,'user','insert','2022-06-02 20:11:48');
/*!40000 ALTER TABLE `logger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obligation`
--

DROP TABLE IF EXISTS `obligation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obligation` (
  `obligation_id` int NOT NULL AUTO_INCREMENT,
  `obligation_bill` int NOT NULL,
  `obligation_sum` decimal(10,0) NOT NULL,
  PRIMARY KEY (`obligation_id`,`obligation_bill`),
  UNIQUE KEY `obligation_id_UNIQUE` (`obligation_id`),
  KEY `fk_obligation_1_idx` (`obligation_bill`),
  CONSTRAINT `fk_obligation_1` FOREIGN KEY (`obligation_bill`) REFERENCES `bill` (`bill_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obligation`
--

LOCK TABLES `obligation` WRITE;
/*!40000 ALTER TABLE `obligation` DISABLE KEYS */;
/*!40000 ALTER TABLE `obligation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) NOT NULL,
  `product_price` decimal(10,0) NOT NULL,
  `product_type` varchar(45) NOT NULL,
  `product_img` mediumtext NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_id_UNIQUE` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (14,'product_name_1',5,'type_1','img'),(15,'product_name_2',10,'type_1','img'),(16,'product_name_3',15,'type_2','img'),(17,'product_name_4',20,'type_2','img'),(18,'product_name_5',30,'type_2','img'),(19,'product_name_6',40,'type_3','img');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `user_hash` varchar(100) NOT NULL,
  `user_credit` decimal(10,0) NOT NULL,
  `user_phone` varchar(45) NOT NULL,
  `user_email` varchar(45) NOT NULL,
  `user_admin` tinyint NOT NULL DEFAULT '0',
  `user_read` tinyint NOT NULL DEFAULT '1',
  `user_write` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  UNIQUE KEY `user_UN` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (33,'test','$2a$10$YF4DtYGLDiL4VtzkLKa92O.qxGBzbIO.sXuiO.hf1QJx74qBlRxRm',0,'123','admin',1,1,0),(38,'user_name_1','user_hash',0,'1','email_1@mail.ru',0,1,0),(39,'user_name_2','user_hash',0,'2','email_2@mail.ru',0,1,0),(40,'user_name_3','user_hash',0,'3','email_3@mail.ru',0,1,0),(41,'user_name_4','user_hash',0,'4','email_4@mail.ru',0,1,0),(42,'user_name_5','user_hash',0,'5','email_5@mail.ru',0,1,0),(43,'user_name_6','user_hash',0,'6','email_6@mail.ru',0,1,0),(44,'user_name_7','user_hash',0,'7','email_7@mail.ru',0,1,0);
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

-- Dump completed on 2022-06-03  0:11:48
