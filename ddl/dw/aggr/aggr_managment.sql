/*
SQLyog Community v8.3 
MySQL - 5.1.41-3ubuntu12.3 : Database - kalturadw
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `kalturadw`;

/*Table structure for table `aggr_managment` */

DROP TABLE IF EXISTS `aggr_managment`;

CREATE TABLE `aggr_managment` (
  `aggr_name` varchar(100) NOT NULL DEFAULT '',
  `aggr_day_int` int(11) unsigned NOT NULL DEFAULT '0',
  `aggr_day` date NOT NULL DEFAULT '0000-00-00',
  `hour_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `is_calculated` tinyint(4) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`aggr_name`,`aggr_day_int`,`hour_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;