-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: gamecase
-- ------------------------------------------------------
-- Server version	5.5.47-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gifts`
--

DROP TABLE IF EXISTS `gifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gifts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `status` enum('active','passive') NOT NULL DEFAULT 'active',
  `send_daily_max` smallint(5) unsigned DEFAULT NULL,
  `claim_daily_max` smallint(5) unsigned DEFAULT NULL,
  `expire_day` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gifts`
--

LOCK TABLES `gifts` WRITE;
/*!40000 ALTER TABLE `gifts` DISABLE KEYS */;
INSERT INTO `gifts` VALUES (1,'Coin','active',1,NULL,7),(2,'Food','active',NULL,1,1);
/*!40000 ALTER TABLE `gifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gifts_claimed`
--

DROP TABLE IF EXISTS `gifts_claimed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gifts_claimed` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `claimer_id` int(10) unsigned NOT NULL,
  `from_id` int(10) unsigned NOT NULL,
  `gift_id` int(10) unsigned NOT NULL,
  `date` datetime DEFAULT NULL,
  `status` enum('sent','seen','accepted','rejected') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gifts_claimed_users_FK` (`claimer_id`),
  KEY `gifts_claimed_users2_FK` (`from_id`),
  KEY `gifts_claimed_gifts_FK` (`gift_id`),
  KEY `gifts_claimed_status_IDX` (`status`),
  CONSTRAINT `gifts_claimed_gifts_FK` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`),
  CONSTRAINT `gifts_claimed_users2_FK` FOREIGN KEY (`from_id`) REFERENCES `users` (`id`),
  CONSTRAINT `gifts_claimed_users_FK` FOREIGN KEY (`claimer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gifts_claimed`
--

LOCK TABLES `gifts_claimed` WRITE;
/*!40000 ALTER TABLE `gifts_claimed` DISABLE KEYS */;
INSERT INTO `gifts_claimed` VALUES (1,1,2,1,'2016-04-17 11:48:16','accepted');
/*!40000 ALTER TABLE `gifts_claimed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gifts_sent`
--

DROP TABLE IF EXISTS `gifts_sent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gifts_sent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) unsigned NOT NULL,
  `to_id` int(10) unsigned NOT NULL,
  `gift_id` int(10) unsigned NOT NULL,
  `date` datetime DEFAULT NULL,
  `status` enum('active','expired') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gifts_sent_gifts_FK` (`gift_id`),
  KEY `gifts_sent_users_FK` (`sender_id`),
  KEY `gifts_sent_users2_FK` (`to_id`),
  KEY `gifts_sent_status_IDX` (`status`),
  CONSTRAINT `gifts_sent_users2_FK` FOREIGN KEY (`to_id`) REFERENCES `users` (`id`),
  CONSTRAINT `gifts_sent_gifts_FK` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`),
  CONSTRAINT `gifts_sent_users_FK` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gifts_sent`
--

LOCK TABLES `gifts_sent` WRITE;
/*!40000 ALTER TABLE `gifts_sent` DISABLE KEYS */;
INSERT INTO `gifts_sent` VALUES (1,1,2,1,'2016-04-17 11:31:16',NULL),(2,1,3,1,'2016-04-17 11:31:16','active');
/*!40000 ALTER TABLE `gifts_sent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_gifts`
--

DROP TABLE IF EXISTS `user_gifts`;
/*!50001 DROP VIEW IF EXISTS `user_gifts`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user_gifts` (
  `user_id` tinyint NOT NULL,
  `nickname` tinyint NOT NULL,
  `sender_id` tinyint NOT NULL,
  `gift_id` tinyint NOT NULL,
  `date` tinyint NOT NULL,
  `status` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(64) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'isteyen','test','202cb962ac59075b964b07152d234b70'),(2,'istenen','İstenen User','202cb962ac59075b964b07152d234b70'),(3,'tarafsiz','Tarafsız User','202cb962ac59075b964b07152d234b70');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `user_gifts`
--

/*!50001 DROP TABLE IF EXISTS `user_gifts`*/;
/*!50001 DROP VIEW IF EXISTS `user_gifts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_gifts` AS select `u`.`id` AS `user_id`,`u`.`nickname` AS `nickname`,`gs`.`sender_id` AS `sender_id`,`gs`.`gift_id` AS `gift_id`,`gs`.`date` AS `date`,`gs`.`status` AS `status` from (`users` `u` join `gifts_sent` `gs` on((`gs`.`to_id` = `u`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-17 14:01:17
