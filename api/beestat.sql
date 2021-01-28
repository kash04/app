-- mysqldump -u root -p --opt beestat -d --single-transaction | sed 's/ AUTO_INCREMENT=[0-9]*//g' > beestat.sql







-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: beestat
-- ------------------------------------------------------
-- Server version 8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `normalized` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `user_id_guid` (`user_id`,`key`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement` (
  `announcement_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `important` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_cache`
--

DROP TABLE IF EXISTS `api_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_cache` (
  `api_cache_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `response_data` json DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`api_cache_id`),
  KEY `user_id_key` (`user_id`,`key`),
  CONSTRAINT `api_cache_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_log`
--

DROP TABLE IF EXISTS `api_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_log` (
  `api_log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `api_user_id` int unsigned DEFAULT NULL,
  `ip_address` int unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `request` json DEFAULT NULL,
  `response` json DEFAULT NULL,
  `error_code` int unsigned DEFAULT NULL,
  `error_detail` json DEFAULT NULL,
  `total_time` decimal(10,4) unsigned DEFAULT NULL,
  `query_count` int unsigned DEFAULT NULL,
  `query_time` decimal(10,4) unsigned DEFAULT NULL,
  PRIMARY KEY (`api_log_id`,`timestamp`),
  KEY `user_id` (`user_id`),
  KEY `request_ip_request_timestamp` (`ip_address`,`timestamp`),
  KEY `request_timestamp` (`timestamp`),
  KEY `request_api_user_id_request_timestamp` (`api_user_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPRESSED
/*!50100 PARTITION BY RANGE (unix_timestamp(`timestamp`))
(PARTITION 2020_10 VALUES LESS THAN (1604188800) ENGINE = InnoDB,
 PARTITION 2020_11 VALUES LESS THAN (1606780800) ENGINE = InnoDB,
 PARTITION 2020_12 VALUES LESS THAN (1609459200) ENGINE = InnoDB,
 PARTITION 2021_01 VALUES LESS THAN (1612137600) ENGINE = InnoDB,
 PARTITION 2021_02 VALUES LESS THAN (1614556800) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_user`
--

DROP TABLE IF EXISTS `api_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_user` (
  `api_user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `api_key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `session_key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`api_user_id`),
  UNIQUE KEY `api_key` (`api_key`),
  UNIQUE KEY `username` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecobee_api_cache`
--

DROP TABLE IF EXISTS `ecobee_api_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecobee_api_cache` (
  `ecobee_api_cache_id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `response` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ecobee_api_cache_id`),
  KEY `user_id_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecobee_api_log`
--

DROP TABLE IF EXISTS `ecobee_api_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecobee_api_log` (
  `ecobee_api_log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `api_user_id` int unsigned DEFAULT NULL,
  `request_timestamp` timestamp NULL DEFAULT NULL,
  `request` json DEFAULT NULL,
  `response` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ecobee_api_log_id`),
  KEY `user_id` (`user_id`),
  KEY `api_user_id` (`api_user_id`),
  KEY `request_timestamp` (`request_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecobee_sensor`
--

DROP TABLE IF EXISTS `ecobee_sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecobee_sensor` (
  `ecobee_sensor_id` int unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `ecobee_thermostat_id` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `in_use` tinyint(1) DEFAULT NULL,
  `capability` json DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ecobee_sensor_id`),
  UNIQUE KEY `thermostat_id_identifier` (`ecobee_thermostat_id`,`identifier`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ecobee_sensor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `ecobee_sensor_ibfk_4` FOREIGN KEY (`ecobee_thermostat_id`) REFERENCES `ecobee_thermostat` (`ecobee_thermostat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecobee_thermostat`
--

DROP TABLE IF EXISTS `ecobee_thermostat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecobee_thermostat` (
  `ecobee_thermostat_id` int unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `guid` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `connected` tinyint(1) DEFAULT NULL,
  `thermostat_revision` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `alert_revision` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `runtime_revision` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `interval_revision` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `utc_time` timestamp NULL DEFAULT NULL,
  `model_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `runtime` json DEFAULT NULL,
  `extended_runtime` json DEFAULT NULL,
  `electricity` json DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `location` json DEFAULT NULL,
  `program` json DEFAULT NULL,
  `events` json DEFAULT NULL,
  `device` json DEFAULT NULL,
  `technician` json DEFAULT NULL,
  `utility` json DEFAULT NULL,
  `management` json DEFAULT NULL,
  `alerts` json DEFAULT NULL,
  `weather` json DEFAULT NULL,
  `house_details` json DEFAULT NULL,
  `oem_cfg` json DEFAULT NULL,
  `equipment_status` json DEFAULT NULL,
  `notification_settings` json DEFAULT NULL,
  `privacy` json DEFAULT NULL,
  `version` json DEFAULT NULL,
  `remote_sensors` json DEFAULT NULL,
  `audio` json DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ecobee_thermostat_id`),
  UNIQUE KEY `guid` (`guid`),
  KEY `user_id_guid` (`user_id`,`guid`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `ecobee_thermostat_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecobee_token`
--

DROP TABLE IF EXISTS `ecobee_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecobee_token` (
  `ecobee_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `access_token` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `refresh_token` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ecobee_token_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `ecobee_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailgun_api_cache`
--

DROP TABLE IF EXISTS `mailgun_api_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mailgun_api_cache` (
  `mailgun_api_cache_id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `response` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mailgun_api_cache_id`),
  KEY `user_id_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailgun_api_log`
--

DROP TABLE IF EXISTS `mailgun_api_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mailgun_api_log` (
  `mailgun_api_log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `api_user_id` int unsigned DEFAULT NULL,
  `request_timestamp` timestamp NULL DEFAULT NULL,
  `request` json DEFAULT NULL,
  `response` text COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mailgun_api_log_id`),
  KEY `user_id` (`user_id`),
  KEY `api_user_id` (`api_user_id`),
  KEY `request_timestamp` (`request_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patreon_api_cache`
--

DROP TABLE IF EXISTS `patreon_api_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patreon_api_cache` (
  `patreon_api_cache_id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `response` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`patreon_api_cache_id`),
  KEY `user_id_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patreon_api_log`
--

DROP TABLE IF EXISTS `patreon_api_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patreon_api_log` (
  `patreon_api_log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `api_user_id` int unsigned DEFAULT NULL,
  `request_timestamp` timestamp NULL DEFAULT NULL,
  `request` json DEFAULT NULL,
  `response` text COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`patreon_api_log_id`),
  KEY `user_id` (`user_id`),
  KEY `api_user_id` (`api_user_id`),
  KEY `request_timestamp` (`request_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patreon_token`
--

DROP TABLE IF EXISTS `patreon_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patreon_token` (
  `patreon_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `access_token` char(43) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `refresh_token` char(43) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`patreon_token_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `patreon_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runtime_sensor`
--

DROP TABLE IF EXISTS `runtime_sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `runtime_sensor` (
  `runtime_sensor_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sensor_id` int unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` smallint DEFAULT NULL,
  `occupancy` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`runtime_sensor_id`,`timestamp`),
  UNIQUE KEY `thermostat_id_timestamp` (`sensor_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPRESSED
/*!50100 PARTITION BY RANGE (unix_timestamp(`timestamp`))
(PARTITION 2020_10 VALUES LESS THAN (1604188800) ENGINE = InnoDB,
 PARTITION 2020_11 VALUES LESS THAN (1606780800) ENGINE = InnoDB,
 PARTITION 2020_12 VALUES LESS THAN (1609459200) ENGINE = InnoDB,
 PARTITION 2021_01 VALUES LESS THAN (1612137600) ENGINE = InnoDB,
 PARTITION 2021_02 VALUES LESS THAN (1614556800) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runtime_thermostat`
--

DROP TABLE IF EXISTS `runtime_thermostat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `runtime_thermostat` (
  `runtime_thermostat_id` int unsigned NOT NULL AUTO_INCREMENT,
  `thermostat_id` int unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `compressor_1` smallint unsigned DEFAULT NULL,
  `compressor_2` smallint unsigned DEFAULT NULL,
  `compressor_mode` enum('heat','cool','off') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `auxiliary_heat_1` smallint unsigned DEFAULT NULL,
  `auxiliary_heat_2` smallint unsigned DEFAULT NULL,
  `fan` smallint unsigned DEFAULT NULL,
  `accessory` smallint unsigned DEFAULT NULL,
  `accessory_type` enum('humidifier','dehumidifier','ventilator','economizer','off') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `system_mode` enum('auto','auxiliary_heat','cool','heat','off') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `indoor_temperature` smallint DEFAULT NULL,
  `indoor_humidity` tinyint unsigned DEFAULT NULL,
  `outdoor_temperature` smallint DEFAULT NULL,
  `outdoor_humidity` tinyint unsigned DEFAULT NULL,
  `event_runtime_thermostat_text_id` smallint unsigned DEFAULT NULL,
  `climate_runtime_thermostat_text_id` smallint unsigned DEFAULT NULL,
  `setpoint_cool` smallint unsigned DEFAULT NULL,
  `setpoint_heat` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`runtime_thermostat_id`,`timestamp`),
  UNIQUE KEY `thermostat_id_timestamp` (`thermostat_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPRESSED
/*!50100 PARTITION BY RANGE (unix_timestamp(`timestamp`))
(PARTITION 2020_01 VALUES LESS THAN (1580515200) ENGINE = InnoDB,
 PARTITION 2020_02 VALUES LESS THAN (1583020800) ENGINE = InnoDB,
 PARTITION 2020_03 VALUES LESS THAN (1585699200) ENGINE = InnoDB,
 PARTITION 2020_04 VALUES LESS THAN (1588291200) ENGINE = InnoDB,
 PARTITION 2020_05 VALUES LESS THAN (1590969600) ENGINE = InnoDB,
 PARTITION 2020_06 VALUES LESS THAN (1593561600) ENGINE = InnoDB,
 PARTITION 2020_07 VALUES LESS THAN (1596240000) ENGINE = InnoDB,
 PARTITION 2020_08 VALUES LESS THAN (1598918400) ENGINE = InnoDB,
 PARTITION 2020_09 VALUES LESS THAN (1601510400) ENGINE = InnoDB,
 PARTITION 2020_10 VALUES LESS THAN (1604188800) ENGINE = InnoDB,
 PARTITION 2020_11 VALUES LESS THAN (1606780800) ENGINE = InnoDB,
 PARTITION 2020_12 VALUES LESS THAN (1609459200) ENGINE = InnoDB,
 PARTITION 2021_01 VALUES LESS THAN (1612137600) ENGINE = InnoDB,
 PARTITION 2021_02 VALUES LESS THAN (1614556800) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runtime_thermostat_summary`
--

DROP TABLE IF EXISTS `runtime_thermostat_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `runtime_thermostat_summary` (
  `runtime_thermostat_summary_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `thermostat_id` int unsigned NOT NULL,
  `date` date NOT NULL,
  `count` smallint unsigned NOT NULL,
  `sum_compressor_cool_1` mediumint unsigned NOT NULL,
  `sum_compressor_cool_2` mediumint unsigned NOT NULL,
  `sum_compressor_heat_1` mediumint unsigned NOT NULL,
  `sum_compressor_heat_2` mediumint unsigned NOT NULL,
  `sum_auxiliary_heat_1` mediumint unsigned NOT NULL,
  `sum_auxiliary_heat_2` mediumint unsigned NOT NULL,
  `sum_fan` mediumint unsigned NOT NULL,
  `sum_humidifier` mediumint unsigned NOT NULL,
  `sum_dehumidifier` mediumint unsigned NOT NULL,
  `sum_ventilator` mediumint unsigned NOT NULL,
  `sum_economizer` mediumint unsigned NOT NULL,
  `avg_outdoor_temperature` smallint NOT NULL,
  `avg_outdoor_humidity` tinyint unsigned NOT NULL,
  `min_outdoor_temperature` smallint NOT NULL,
  `max_outdoor_temperature` smallint NOT NULL,
  `avg_indoor_temperature` smallint NOT NULL,
  `avg_indoor_humidity` tinyint unsigned NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`runtime_thermostat_summary_id`),
  UNIQUE KEY `thermostat_id_date` (`thermostat_id`,`date`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `runtime_thermostat_summary_ibfk_1` FOREIGN KEY (`thermostat_id`) REFERENCES `thermostat` (`thermostat_id`),
  CONSTRAINT `runtime_thermostat_summary_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `runtime_thermostat_text`
--

DROP TABLE IF EXISTS `runtime_thermostat_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `runtime_thermostat_text` (
  `runtime_thermostat_text_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`runtime_thermostat_text_id`),
  UNIQUE KEY `user_id_guid` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensor` (
  `sensor_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `thermostat_id` int unsigned NOT NULL,
  `ecobee_sensor_id` int unsigned DEFAULT NULL,
  `identifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `in_use` tinyint(1) DEFAULT NULL,
  `temperature` decimal(4,1) DEFAULT NULL,
  `humidity` int unsigned DEFAULT NULL,
  `occupancy` tinyint(1) DEFAULT NULL,
  `capability` json DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sensor_id`),
  KEY `user_id` (`user_id`),
  KEY `thermostat_id` (`thermostat_id`),
  KEY `ecobee_sensor_id` (`ecobee_sensor_id`),
  CONSTRAINT `sensor_ibfk_1` FOREIGN KEY (`thermostat_id`) REFERENCES `thermostat` (`thermostat_id`),
  CONSTRAINT `sensor_ibfk_2` FOREIGN KEY (`ecobee_sensor_id`) REFERENCES `ecobee_sensor` (`ecobee_sensor_id`),
  CONSTRAINT `sensor_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `session_id` int unsigned NOT NULL AUTO_INCREMENT,
  `session_key` char(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `api_user_id` int unsigned DEFAULT NULL,
  `timeout` int unsigned DEFAULT NULL,
  `life` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int unsigned NOT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `last_used_by` int unsigned NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `key` (`session_key`),
  KEY `user_id_2` (`user_id`),
  KEY `api_user_id` (`api_user_id`),
  CONSTRAINT `session_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `session_ibfk_2` FOREIGN KEY (`api_user_id`) REFERENCES `api_user` (`api_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smarty_streets_api_cache`
--

DROP TABLE IF EXISTS `smarty_streets_api_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `smarty_streets_api_cache` (
  `smarty_streets_api_cache_id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `response` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`smarty_streets_api_cache_id`),
  KEY `user_id_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smarty_streets_api_log`
--

DROP TABLE IF EXISTS `smarty_streets_api_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `smarty_streets_api_log` (
  `smarty_streets_api_log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `api_user_id` int unsigned DEFAULT NULL,
  `request_timestamp` timestamp NULL DEFAULT NULL,
  `request` json DEFAULT NULL,
  `response` text COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`smarty_streets_api_log_id`),
  KEY `user_id` (`user_id`),
  KEY `api_user_id` (`api_user_id`),
  KEY `request_timestamp` (`request_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `thermostat`
--

DROP TABLE IF EXISTS `thermostat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thermostat` (
  `thermostat_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `ecobee_thermostat_id` int unsigned DEFAULT NULL,
  `thermostat_group_id` int unsigned DEFAULT NULL,
  `address_id` int unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `temperature` decimal(4,1) DEFAULT NULL,
  `temperature_unit` enum('°F','°C') DEFAULT NULL,
  `humidity` int unsigned DEFAULT NULL,
  `alerts` json DEFAULT NULL,
  `first_connected` timestamp NULL DEFAULT NULL,
  `sync_begin` timestamp NULL DEFAULT NULL,
  `sync_end` timestamp NULL DEFAULT NULL,
  `data_begin` timestamp NULL DEFAULT NULL,
  `data_end` timestamp NULL DEFAULT NULL,
  `time_zone` varchar(255) DEFAULT NULL,
  `filters` json DEFAULT NULL,
  `temperature_profile` json DEFAULT NULL,
  `profile` json DEFAULT NULL,
  `property` json DEFAULT NULL,
  `system_type` json DEFAULT NULL,
  `system_type2` json DEFAULT NULL,
  `weather` json DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `program` json DEFAULT NULL,
  `system_type_heat` enum('geothermal','compressor','boiler','gas','oil','electric','none') DEFAULT NULL,
  `system_type_heat_stages` int unsigned DEFAULT NULL,
  `system_type_heat_auxiliary` enum('electric','gas','oil','none') DEFAULT NULL,
  `system_type_heat_auxiliary_stages` int unsigned DEFAULT NULL,
  `system_type_cool` enum('geothermal','compressor','none') DEFAULT NULL,
  `system_type_cool_stages` int unsigned DEFAULT NULL,
  `property_age` int unsigned DEFAULT NULL,
  `property_square_feet` int unsigned DEFAULT NULL,
  `property_stories` int unsigned DEFAULT NULL,
  `property_structure_type` enum('detached','apartment','condominium','loft','multiplex','townhouse','semi-detached') DEFAULT NULL,
  `address_latitude` decimal(8,6) DEFAULT NULL,
  `address_longitude` decimal(9,6) DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`thermostat_id`),
  KEY `ecobee_thermostat_id` (`ecobee_thermostat_id`),
  KEY `user_id` (`user_id`),
  KEY `thermostat_group_id` (`thermostat_group_id`),
  KEY `address_id` (`address_id`),
  KEY `comparison` (`system_type_heat`,`system_type_cool`,`system_type_heat_stages`,`system_type_cool_stages`,`property_structure_type`,`address_latitude`,`address_longitude`),
  CONSTRAINT `thermostat_ibfk_1` FOREIGN KEY (`ecobee_thermostat_id`) REFERENCES `ecobee_thermostat` (`ecobee_thermostat_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `thermostat_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `thermostat_ibfk_3` FOREIGN KEY (`thermostat_group_id`) REFERENCES `thermostat_group` (`thermostat_group_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `thermostat_ibfk_4` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `thermostat_group`
--

DROP TABLE IF EXISTS `thermostat_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thermostat_group` (
  `thermostat_group_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `address_id` int unsigned NOT NULL,
  `system_type_heat` enum('geothermal','compressor','boiler','gas','oil','electric','none') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `system_type_heat_auxiliary` enum('electric','gas','oil','none') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `system_type_cool` enum('geothermal','compressor','none') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `property_age` int unsigned DEFAULT NULL,
  `property_square_feet` int unsigned DEFAULT NULL,
  `property_stories` int unsigned DEFAULT NULL,
  `property_structure_type` enum('detached','apartment','condominium','loft','multiplex','townhouse','semi-detached') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_latitude` decimal(10,8) DEFAULT NULL,
  `address_longitude` decimal(11,8) DEFAULT NULL,
  `temperature_profile` json DEFAULT NULL,
  `profile` json DEFAULT NULL,
  `weather` json DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`thermostat_group_id`),
  UNIQUE KEY `user_id_address_id` (`user_id`,`address_id`),
  KEY `address_id` (`address_id`),
  KEY `system_type_heat` (`system_type_heat`,`property_structure_type`,`property_stories`,`property_square_feet`,`property_age`,`address_latitude`,`address_longitude`),
  KEY `system_type_cool` (`system_type_cool`,`property_structure_type`,`property_stories`,`property_square_feet`,`property_age`,`address_latitude`,`address_longitude`),
  CONSTRAINT `thermostat_group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `thermostat_group_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` char(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `anonymous` tinyint(1) NOT NULL,
  `email_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `patreon_status` json DEFAULT NULL,
  `sync_status` json DEFAULT NULL,
  `debug` tinyint(1) DEFAULT '0',
  `comment` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-23 19:10:19
