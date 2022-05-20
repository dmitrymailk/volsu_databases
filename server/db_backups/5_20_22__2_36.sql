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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (6,3,534),(7,5,23),(15,8,299),(18,3,344),(19,5,123);
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
  CONSTRAINT `fk_bought_product_1` FOREIGN KEY (`bought_product_original`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_bought_product_2` FOREIGN KEY (`bought_product_bill`) REFERENCES `bill` (`bill_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bought_product`
--

LOCK TABLES `bought_product` WRITE;
/*!40000 ALTER TABLE `bought_product` DISABLE KEYS */;
INSERT INTO `bought_product` VALUES (19,1,10,7);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logger`
--

LOCK TABLES `logger` WRITE;
/*!40000 ALTER TABLE `logger` DISABLE KEYS */;
INSERT INTO `logger` VALUES (1,'user','insert','2022-04-23 20:30:16'),(2,'user','delete','2022-04-23 20:30:46'),(3,'user','insert','2022-04-26 07:39:25'),(4,'user','delete','2022-04-26 07:41:45');
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
INSERT INTO `obligation` VALUES (6,6,0),(8,6,12),(9,6,-1);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'product_name_11',12,'product_type_1','img_link_1'),(2,'product_name_2',123,'product_type_2','img_link_22'),(3,'product_name_32',12,'product_type_3','img_link_33'),(4,'product_name_4',1234,'product_type_4','img_link_4'),(5,'product_name_5',3123,'product_type_5','img_link_5'),(7,'name 7',32,'type 8','img 7'),(8,'name 8 ',33,'type 3','img 9'),(9,'qwer',232,'type6','img 11');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'test3','dumb_hash',0,'8805553535','e4@mail.ru',0,1,0),(4,'test4','kjsdfh6s587sddghksd',0,'880555354335','e@maild.ru',0,1,0),(5,'test5','dumb_hash',10,'45553535','es@mail.ru',0,1,0),(6,'test6','dummy_hash',0,'889987789','test@mail.com',0,1,0),(8,'test9','dummy_hash',0,'123123','qweasdsdf',0,1,0),(10,'test11','dummy_hash',123123,'1231231','asdasd',0,1,0),(11,'test12','dummy_hash',123,'87865875','qweasd',0,1,0);
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

-- Dump completed on 2022-05-20  2:36:35
