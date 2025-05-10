-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: swiggy
-- ------------------------------------------------------
-- Server version	8.0.27
create database swiggy;
use swiggy;

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
-- Table structure for table `delivery_partner`
--

DROP TABLE IF EXISTS `delivery_partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_partner` (
  `partner_id` int DEFAULT NULL,
  `partner_name` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_partner`
--

LOCK TABLES `delivery_partner` WRITE;
/*!40000 ALTER TABLE `delivery_partner` DISABLE KEYS */;
INSERT INTO `delivery_partner` VALUES (1,'Suresh'),(2,'Amit'),(3,'Lokesh'),(4,'Kartik'),(5,'Gyandeep');
/*!40000 ALTER TABLE `delivery_partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `f_id` int DEFAULT NULL,
  `f_name` text,
  `type` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Non-veg Pizza','Non-veg'),(2,'Veg Pizza','Veg'),(3,'Choco Lava cake','Veg'),(4,'Chicken Wings','Non-veg'),(5,'Chicken Popcorn','Non-veg'),(6,'Rice Meal','Veg'),(7,'Roti meal','Veg'),(8,'Masala Dosa','Veg'),(9,'Rava Idli','Veg'),(10,'Schezwan Noodles','Veg'),(11,'Veg Manchurian','Veg');
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menu_id` int DEFAULT NULL,
  `r_id` int DEFAULT NULL,
  `f_id` int DEFAULT NULL,
  `price` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,1,450),(2,1,2,400),(3,1,3,100),(4,2,3,115),(5,2,4,230),(6,2,5,300),(7,3,3,80),(8,3,6,160),(9,3,7,140),(10,4,6,230),(11,4,8,180),(12,4,9,120),(13,5,6,250),(14,5,10,220),(15,5,11,180);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `f_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (1,1001,1),(2,1001,3),(3,1002,4),(4,1002,3),(5,1003,6),(6,1003,3),(7,1004,6),(8,1004,3),(9,1005,7),(10,1005,3),(11,1006,1),(12,1006,2),(13,1006,3),(14,1007,4),(15,1007,3),(16,1008,6),(17,1008,3),(18,1009,8),(19,1009,9),(20,1010,10),(21,1010,11),(22,1010,6),(23,1011,1),(24,1012,8),(25,1013,4),(26,1014,4),(27,1015,4),(28,1016,8),(29,1016,9),(30,1017,8),(31,1017,9),(32,1018,10),(33,1018,11),(34,1019,10),(35,1019,11),(36,1020,10),(37,1020,11),(38,1021,1),(39,1021,3),(40,1022,1),(41,1022,3),(42,1023,3),(43,1023,4),(44,1023,5),(45,1024,3),(46,1024,4),(47,1024,5),(48,1025,3),(49,1025,4),(50,1025,5);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `r_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `date` text,
  `partner_id` int DEFAULT NULL,
  `delivery_time` int DEFAULT NULL,
  `delivery_rating` int DEFAULT NULL,
  `restaurant_rating` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1001,1,1,550,'10-05-2022',1,25,5,'3'),(1002,1,2,415,'26-05-2022',1,19,5,'2'),(1003,1,3,240,'15-06-2022',5,29,4,''),(1004,1,3,240,'29-06-2022',4,42,3,'5'),(1005,1,3,220,'10-07-2022',1,58,1,'4'),(1006,2,1,950,'10-06-2022',2,16,5,''),(1007,2,2,530,'23-06-2022',3,60,1,'5'),(1008,2,3,240,'07-07-2022',5,33,4,'5'),(1009,2,4,300,'17-07-2022',4,41,1,''),(1010,2,5,650,'31-07-2022',1,67,1,'4'),(1011,3,1,450,'10-05-2022',2,25,3,'1'),(1012,3,4,180,'20-05-2022',5,33,4,'1'),(1013,3,2,230,'30-05-2022',4,45,3,''),(1014,3,2,230,'11-06-2022',2,55,1,'2'),(1015,3,2,230,'22-06-2022',3,21,5,''),(1016,4,4,300,'15-05-2022',3,31,5,'5'),(1017,4,4,300,'30-05-2022',1,50,1,''),(1018,4,4,400,'15-06-2022',2,40,3,'5'),(1019,4,5,400,'30-06-2022',1,70,2,'4'),(1020,4,5,400,'15-07-2022',3,26,5,'3'),(1021,5,1,550,'01-07-2022',5,22,2,''),(1022,5,1,550,'08-07-2022',1,34,5,'1'),(1023,5,2,645,'15-07-2022',4,38,5,'1'),(1024,5,2,645,'21-07-2022',2,58,2,'1'),(1025,5,2,645,'28-07-2022',2,44,4,'');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `r_id` int DEFAULT NULL,
  `r_name` text,
  `cuisine` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'dominos','Italian'),(2,'kfc','American'),(3,'box8','North Indian'),(4,'Dosa Plaza','South Indian'),(5,'China Town','Chinese');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int DEFAULT NULL,
  `name` text,
  `email` text,
  `password` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Nitish','nitish@gmail.com','p252h'),(2,'Khushboo','khushboo@gmail.com','hxn9b'),(3,'Vartika','vartika@gmail.com','9hu7j'),(4,'Ankit','ankit@gmail.com','lkko3'),(5,'Neha','neha@gmail.com','3i7qm'),(6,'Anupama','anupama@gmail.com','46rdw2'),(7,'Rishabh','rishabh@gmail.com','4sw123');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 17:29:16
