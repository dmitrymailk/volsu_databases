CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (1,1,23),(2,2,34),(3,1,45),(4,2,10),(5,2,12),(6,3,534),(7,5,234),(8,3,4564),(9,1,789),(10,1,678),(11,1,6576),(12,1,78),(13,1,6788),(14,1,65276);
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
  `bought_product_price` decimal(10,0) NOT NULL,
  `bought_product_bill` int NOT NULL,
  PRIMARY KEY (`bought_product_id`,`bought_product_original`,`bought_product_bill`),
  UNIQUE KEY `bought_product_id_UNIQUE` (`bought_product_id`),
  KEY `fk_bought_product_1_idx` (`bought_product_original`),
  KEY `fk_bought_product_2_idx` (`bought_product_bill`),
  CONSTRAINT `fk_bought_product_1` FOREIGN KEY (`bought_product_original`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bought_product_2` FOREIGN KEY (`bought_product_bill`) REFERENCES `bill` (`bill_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bought_product`
--

LOCK TABLES `bought_product` WRITE;
/*!40000 ALTER TABLE `bought_product` DISABLE KEYS */;
INSERT INTO `bought_product` VALUES (1,3,45,4),(2,3,342,2),(3,4,234,3),(4,3,345,2),(5,3,867,5),(8,5,54,1),(9,5,65,3),(10,2,1321,4),(11,4,654,1),(12,3,76,5),(13,3,45,11),(14,2,45,13),(18,4,4545,3);
/*!40000 ALTER TABLE `bought_product` ENABLE KEYS */;
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
  CONSTRAINT `fk_obligation_1` FOREIGN KEY (`obligation_bill`) REFERENCES `bill` (`bill_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obligation`
--

LOCK TABLES `obligation` WRITE;
/*!40000 ALTER TABLE `obligation` DISABLE KEYS */;
INSERT INTO `obligation` VALUES (1,3,123),(2,2,544),(3,5,34),(4,4,4345),(5,1,456);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'product_name_1',12,'product_type_1','img_link_1'),(2,'product_name_2',123,'product_type_2','img_link_2'),(3,'product_name_3',12,'product_type_3','img_link_3'),(4,'product_name_4',1234,'product_type_4','img_link_4'),(5,'product_name_5',3123,'product_type_5','img_link_5');
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
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'test','kjsdfh6587sddghksd',0,'8805553535','e@mail.ru',0,1,0),(2,'test2','kjsdfh6587sdsddghksd',0,'8805553535','e2@mail.ru',0,1,0),(3,'test3','kjsdfh6587sddghksdsd',0,'8805553535','e3@mail.ru',0,1,0),(4,'test4','kjsdfh6s587sddghksd',0,'880555354335','e@maild.ru',0,1,0),(5,'test5','kjsdfewh6587sddghksd',0,'48805553535','es@mail.ru',0,1,0);
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

-- Dump completed on 2022-04-05  0:39:19
