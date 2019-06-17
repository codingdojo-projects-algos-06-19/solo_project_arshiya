-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: solo_project
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `likes_info`
--

DROP TABLE IF EXISTS `likes_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `likes_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `posts_id` int(11) DEFAULT NULL,
  `users_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_pid_idx` (`posts_id`),
  KEY `fk_ud_idx` (`users_id`),
  CONSTRAINT `fk_pid` FOREIGN KEY (`posts_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `fk_ud` FOREIGN KEY (`users_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_info`
--

LOCK TABLES `likes_info` WRITE;
/*!40000 ALTER TABLE `likes_info` DISABLE KEYS */;
INSERT INTO `likes_info` VALUES (5,6,1,'2019-06-16 20:42:28','2019-06-16 20:42:28'),(6,1,1,'2019-06-16 20:42:51','2019-06-16 20:42:51'),(7,6,1,'2019-06-16 20:59:42','2019-06-16 20:59:42'),(8,2,1,'2019-06-16 21:00:40','2019-06-16 21:00:40'),(9,6,1,'2019-06-16 22:29:43','2019-06-16 22:29:43'),(10,8,1,'2019-06-16 22:29:51','2019-06-16 22:29:51'),(11,1,2,'2019-06-16 23:41:26','2019-06-16 23:41:26'),(12,3,2,'2019-06-16 23:41:57','2019-06-16 23:41:57'),(13,1,2,'2019-06-16 23:42:53','2019-06-16 23:42:53'),(14,2,2,'2019-06-16 23:43:46','2019-06-16 23:43:46'),(15,3,2,'2019-06-16 23:45:31','2019-06-16 23:45:31'),(16,2,2,'2019-06-17 00:36:22','2019-06-17 00:36:22'),(17,8,2,'2019-06-17 01:18:11','2019-06-17 01:18:11'),(18,1,4,'2019-06-17 01:21:14','2019-06-17 01:21:14'),(19,9,1,'2019-06-17 01:27:43','2019-06-17 01:27:43'),(20,9,1,'2019-06-17 01:27:50','2019-06-17 01:27:50'),(21,2,3,'2019-06-17 01:30:30','2019-06-17 01:30:30'),(22,10,3,'2019-06-17 01:38:41','2019-06-17 01:38:41'),(23,1,2,'2019-06-17 01:43:55','2019-06-17 01:43:55'),(24,1,2,'2019-06-17 01:44:01','2019-06-17 01:44:01');
/*!40000 ALTER TABLE `likes_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `post` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_uid_idx` (`user_id`),
  CONSTRAINT `fk_uid` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'hello world!','2019-06-16 18:31:49','2019-06-16 18:31:49'),(2,1,'efhwwjkfhwej','2019-06-16 18:32:02','2019-06-16 18:32:02'),(3,2,'i like arshiya','2019-06-16 18:38:54','2019-06-16 18:38:54'),(6,2,'dfsf dfdkhjfs jdfhsdjkhfsdj djfhsdjkfh fd fdfd dsdjkhsj fsdfsf fs fs fss fsfsf fs fsf dfsfs ff dd ff ee sf fdsf faf fas f asf asf fas ge sas fdaf asfa sas f sfs gf hd ee gfgddfd sfs gdh  fsgsg sfggsg sfgsdsklg djgd sdnjsd sdfn dsdfnsdk dfsj sdgnsd jsdhdjs jdfjsf fdsjfsdj jdfbjsd jdfjsdbsdjfhdjsb jdfjsd','2019-06-16 19:36:59','2019-06-16 19:36:59'),(7,2,'i hate snabd','2019-06-16 19:41:27','2019-06-16 19:41:27'),(8,2,'hello world!','2019-06-16 19:42:01','2019-06-16 19:42:01'),(9,4,'good morning!!','2019-06-17 01:25:02','2019-06-17 01:25:02'),(10,3,'lets create a new app','2019-06-17 01:38:25','2019-06-17 01:38:25'),(11,2,'whre is arfa','2019-06-17 01:42:31','2019-06-17 01:42:31');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `alias` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1,'arshiya','arsh','arshiyajamali16@gmail.com','$2b$12$tLri0FTYw.lejn/1C/YQYODZU88dEleodWUWeyzVto3S0EvRKksl2','2019-06-16 01:31:41','2019-06-16 01:31:41'),(2,'shafeeq','arif','shafeeq_rahmans@yahoo.com','$2b$12$lJfnjUplRAK4C4dbIxzxL.6RE43Am.2BBaP8otC0nIa.xcdAMGj9y','2019-06-16 01:40:02','2019-06-16 01:40:02'),(3,'khadija','khattu','khadija@gmail.com','$2b$12$r9Kh2j4y2A5zuF7TURXCEOYB9nMxUkcfK1Paz7pxEQG08QnAtqaGW','2019-06-16 14:34:37','2019-06-16 14:34:37'),(4,'aaira','aaira','aaira12@gmail.com','$2b$12$y9vz6ce.0X8yv6jYdYMAOuq7gDI4CA0i9T9ftHFD3zGEJBETle3MS','2019-06-16 14:46:08','2019-06-16 14:46:08'),(5,'tara','tara','tara@gmail.com','$2b$12$yA6OxWI.1XBR2nrLptkymudSYaWgCBzMLBlEA4XTnVI6ZOASyLq7.','2019-06-16 17:13:00','2019-06-16 17:13:00');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'solo_project'
--

--
-- Dumping routines for database 'solo_project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-17  1:47:57
