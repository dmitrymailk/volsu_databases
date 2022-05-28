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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (6,10,53474),(7,3,230),(15,5,0),(20,5,1015),(21,5,45),(22,3,123),(23,4,432);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logger`
--

LOCK TABLES `logger` WRITE;
/*!40000 ALTER TABLE `logger` DISABLE KEYS */;
INSERT INTO `logger` VALUES (1,'user','insert','2022-04-23 20:30:16'),(2,'user','delete','2022-04-23 20:30:46'),(3,'user','insert','2022-04-26 07:39:25'),(4,'user','delete','2022-04-26 07:41:45'),(5,'user','insert','2022-05-23 19:31:41'),(6,'user','insert','2022-05-23 19:37:10'),(7,'user','insert','2022-05-23 19:38:22'),(8,'user','insert','2022-05-23 22:37:22'),(9,'user','insert','2022-05-23 22:39:43'),(10,'user','insert','2022-05-23 23:12:43'),(11,'user','insert','2022-05-23 23:13:48'),(12,'user','insert','2022-05-23 23:14:39'),(13,'user','insert','2022-05-23 23:15:05'),(14,'user','insert','2022-05-23 23:15:15'),(15,'user','insert','2022-05-23 23:16:24'),(16,'user','insert','2022-05-24 00:32:04'),(17,'user','insert','2022-05-24 00:38:34'),(18,'user','insert','2022-05-24 00:49:59'),(19,'user','insert','2022-05-24 07:53:43'),(20,'user','insert','2022-05-24 08:16:25'),(21,'user','insert','2022-05-24 08:25:46');
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
INSERT INTO `obligation` VALUES (6,6,0),(8,6,12),(9,6,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'product_name_11',12,'product_type_1','img_link_1'),(2,'product_name_2',123,'product_type_2','img_link_22'),(3,'product_name_32',12,'product_type_3','img_link_33'),(4,'product_name_4',1234,'product_type_4','img_link_4'),(5,'product_name_5',3123,'product_type_5','img_link_5'),(7,'name 7',32,'type 8','img 7'),(8,'name 8 ',33,'type 3','img 9'),(9,'qwer',232,'type6','img 11'),(10,'qweqwe',123,'qweqw','asdasd');
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'test3','dumb_hash',0,'8805553535','e4@mail.ru',0,1,0),(4,'test4','kjsdfh6s587sddghksd',0,'880555354335','e@maild.ru',0,1,0),(5,'test5','dumb_hash',10,'45553535','es@mail.ru',0,1,0),(6,'test6','dummy_hash',0,'889987789','test@mail.com',0,1,0),(8,'test9','dummy_hash',0,'123123','qweasdsdf',0,1,0),(10,'test11','dummy_hash',123123,'1231231','asdasd',0,1,0),(11,'test12','dummy_hash',123,'87865875','qweasd',0,1,0),(15,'test','$2a$10$eWhV1rfEm.AJZ3qRbIyM4.STthKnoz1CT1iUljyFlS.ZXVfnT3UuW',0,'123','test123@',1,1,0),(16,'test','$2a$10$ZyAx.XjpDYR8pEaJjYTYe.pnJM5kn8hlofTRu7.lmng3ggaCtpReK',0,'123','test124@',0,1,0),(17,'test','$2a$10$6h0m9ydmRI9.K8VSjhZDuecAohMw/Nar3tv0ECeH6nvaF12hRCk22',0,'123','test125@',0,1,0),(18,'test','$2a$10$dAu/ZdV.9an5AiatdxjIPenJAEeBHDL4OxakxO5uoJ4tnJbgFPluG',0,'123','qwe',0,1,0),(19,'test','$2a$10$kkuhfhFpbpa8AfSPa5EFo.4JOSQWgbVTq8iVauDbJ1VuqcDcsU/me',0,'123','',0,1,0),(20,'test','$2a$10$DzCHBkYo7VDBuC/51o871OfIE.b9ZyfUX2LUNpSNf9WVzVDfcxW9q',0,'123','qwe1',0,1,0),(21,'test','$2a$10$v9B9p7z8m4RK.DaW5d/AGuCcY8KALKmiD2dX7UvHH.6.O5jNTr6h6',0,'123','qwe2',0,1,0),(22,'test','$2a$10$5Q/v5M4zxfbr.TyFOvsiUOQhd9s27kmDU5iJvXaQZRQbL8Emnlf2G',0,'123','qwe3',0,1,0),(23,'test','$2a$10$fKHjqgiMDW4tAuH425/VA.vtqvPePfRuL.vq3Mw76fF5Z1ZS2.eQO',0,'123','qwe4',0,1,0),(24,'test','$2a$10$dn1oX3gSv6bPZy5PH0k.YuMZrwLrDcCuFgY..MfmSFhsE6kNKmZfi',0,'123','qwe5',0,1,0),(25,'test','$2a$10$fPwx766IdN81G2WVVpX3AOmYAC6zZUATTJjvw8qWLK9tgAerShmSq',0,'123','qwe6',0,1,0),(26,'test','$2a$10$aqByKJdRp0Q7SRLMRPMWR.yfhYDj1pl2FSDAZAkJe4Pmy7l8n/7w6',0,'123','qwe7',0,1,0),(27,'test','$2a$10$YyPqWcFztWw9U.bcJEzjne7Kd.qHcNKCUj5bGAHB6JHtaGQsfgS02',0,'123','qwe8',0,1,0),(28,'test','$2a$10$3zZ3NXgRSsM8SzJmpryJeePnUNt3bplr75A4cpFqXF6Q3eCh32jcO',0,'123','qwe9',0,1,0),(29,'test','$2a$10$.aWvM4ctptoNxcQgRxs5T.So8U/HEJBQuNdQjwYe1ic73Hv0dSM6S',0,'123','admin',1,1,0),(30,'test','$2a$10$oztyeA4IXaIi53y686ruIOi5/JZu/g9A4WcTr2.qDAgPNJqCUf5pq',0,'123','norm',0,1,0),(31,'test','$2a$10$EHMZ8/4Nya6Bzx7ZUJDciuUC2RLtfbA7qdyFMq33XviY3zUhYPlMK',0,'123','new_user1',0,1,0);
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

-- Dump completed on 2022-05-28 22:34:12
