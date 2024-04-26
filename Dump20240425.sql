-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: database-sia.cn6ciymc8chd.us-east-2.rds.amazonaws.com    Database: db_sia
-- ------------------------------------------------------
-- Server version	8.0.35

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `Alimento`
--

CREATE DATABASE IF NOT EXISTS db_sia;

USE db_sia;

DROP TABLE IF EXISTS `Alimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Alimento` (
  `a_id` int NOT NULL AUTO_INCREMENT,
  `a_nombre` varchar(30) DEFAULT NULL,
  `a_cantidad` decimal(10,0) DEFAULT NULL,
  `a_stock` int DEFAULT NULL,
  `a_fechaSalida` date DEFAULT NULL,
  `a_fechaEntrada` date DEFAULT NULL,
  `a_fechaCaducidad` date DEFAULT NULL,
  `um_id` varchar(4) DEFAULT NULL,
  `m_id` int DEFAULT NULL,
  PRIMARY KEY (`a_id`),
  KEY `um_id` (`um_id`),
  KEY `m_id` (`m_id`),
  CONSTRAINT `Alimento_ibfk_1` FOREIGN KEY (`um_id`) REFERENCES `UnidadMedida` (`um_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Alimento_ibfk_2` FOREIGN KEY (`m_id`) REFERENCES `Marca` (`m_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alimento`
--

LOCK TABLES `Alimento` WRITE;
/*!40000 ALTER TABLE `Alimento` DISABLE KEYS */;
INSERT INTO `Alimento` VALUES (1,'Frijol Lata',260,10,'2024-04-19','2024-04-19','2025-04-01','g',1),(2,'Leche',2,35,'2024-04-19','2024-04-19','2024-05-01','L',2),(3,'Manzana',20,20,'2024-04-13','2024-04-19','2024-04-20','U',NULL),(4,'Nombre del alimento',100,1,'2023-04-19','2022-01-01','2025-01-01','g',1),(8,'Nombre del alimento 1',100,1,'2023-04-19','2022-01-01','2025-01-01','g',1),(10,'Nombre del alimento 3',200,1,'2023-04-19','2022-01-01','2025-01-01','kg',1),(16,'Alimento 3',200,0,'2024-04-19','2024-04-19','2023-04-19','g',1),(17,'Alimento 4',250,0,'2024-04-19','2024-04-19','2023-04-19','g',1),(18,'Arroz',10,10,'2024-04-20','2024-04-20','2025-04-20','Kg',NULL),(41,'Test Alimento1',200,10,'0000-00-00','0000-00-00','0000-00-00','g',1),(42,'Test Alimento2',200,10,'0000-00-00','0000-00-00','2024-04-13','g',1),(43,'Test Alimento3',10,10,'0000-00-00','2024-04-25','2024-04-12','g',1),(44,'Lata de atún',200,10,'0000-00-00','2024-04-24','2024-04-30','g',1),(45,'a',10,10,'0000-00-00','2024-04-24','2024-04-01','g',2),(46,'a',10,10,'0000-00-00','2024-04-24','2024-04-01','g',3),(50,'Lata de atún',200,10,'0000-00-00','2024-04-24','2024-04-13','g',NULL),(54,'Lata de atún',200,10,'0000-00-00','2024-04-24','2024-04-13','g',NULL),(55,'Lata de atún',200,10,'0000-00-00','2024-04-24','2024-04-13','g',NULL),(56,'Lata de atún',200,10,'0000-00-00','2024-04-24','2024-04-17','g',NULL);
/*!40000 ALTER TABLE `Alimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Marca`
--

DROP TABLE IF EXISTS `Marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Marca` (
  `m_id` int NOT NULL AUTO_INCREMENT,
  `m_nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`m_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Marca`
--

LOCK TABLES `Marca` WRITE;
/*!40000 ALTER TABLE `Marca` DISABLE KEYS */;
INSERT INTO `Marca` VALUES (1,'Tunny'),(2,'Del Valle'),(3,'La Costeña');
/*!40000 ALTER TABLE `Marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UnidadMedida`
--

DROP TABLE IF EXISTS `UnidadMedida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UnidadMedida` (
  `um_id` varchar(4) NOT NULL,
  `um_nombre` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`um_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UnidadMedida`
--

LOCK TABLES `UnidadMedida` WRITE;
/*!40000 ALTER TABLE `UnidadMedida` DISABLE KEYS */;
INSERT INTO `UnidadMedida` VALUES ('g','Gramos'),('Kg','Kilogramos'),('L','Litros'),('U','Unidad');
/*!40000 ALTER TABLE `UnidadMedida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `u_id` varchar(20) NOT NULL,
  `u_nombre` varchar(40) DEFAULT NULL,
  `u_apellidos` varchar(40) DEFAULT NULL,
  `u_email` varchar(50) DEFAULT NULL,
  `u_contraseña` varchar(64) DEFAULT NULL,
  `u_rol` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES ('GiselleMaster','Giselle','Ortiz','giselle@example.com','8abfe9252eb4cdcddfcc0a80203ee26142b598e75d0a50b51e8c4ad8749083ed',1),('ManejadorEventos','Event','Handler','','',1),('PatyUser1','Doña','Paty','paty@example.com','62aa1db94898939dd6b5f20182c65edb2879e1f7c844a3fa9ec486c5cf001d51',0),('user003','Alice','Johnson','alice.johnson@example.com','a0ed2f4c9219282530289ebd45de3cc919b3ba5636eae799c4bdfee418caf24b',0);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UsuarioAlimento`
--

DROP TABLE IF EXISTS `UsuarioAlimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UsuarioAlimento` (
  `ua_id` int NOT NULL AUTO_INCREMENT,
  `u_id` varchar(20) DEFAULT NULL,
  `a_id` int DEFAULT NULL,
  `ua_cantidad` int DEFAULT NULL,
  `ua_accion` varchar(10) DEFAULT NULL,
  `ua_fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`ua_id`),
  KEY `u_id` (`u_id`),
  KEY `a_id` (`a_id`),
  CONSTRAINT `UsuarioAlimento_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `Usuario` (`u_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `UsuarioAlimento_ibfk_2` FOREIGN KEY (`a_id`) REFERENCES `Alimento` (`a_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UsuarioAlimento`
--

LOCK TABLES `UsuarioAlimento` WRITE;
/*!40000 ALTER TABLE `UsuarioAlimento` DISABLE KEYS */;
INSERT INTO `UsuarioAlimento` VALUES (9,'GiselleMaster',1,20,'Add','2024-04-19 20:53:31'),(10,'PatyUser1',2,50,'Add','2024-04-19 20:53:31'),(11,'user003',3,20,'Add','2024-04-19 20:53:31'),(12,'PatyUser1',2,10,'Reduce','2024-04-19 20:53:31'),(13,'user003',1,20,'Update','2024-04-19 20:53:31'),(16,'ManejadorEventos',NULL,2,'Delete','2024-04-19 23:05:20'),(17,'PatyUser1',1,20,'Add',NULL),(22,'user003',18,10,'Add',NULL);
/*!40000 ALTER TABLE `UsuarioAlimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db_sia'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `eliminarAlimentosAntiguos` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone = '-06:00' */;
/*!50106 CREATE*/ /*!50117 DEFINER=`admin`@`%`*/ /*!50106 EVENT `eliminarAlimentosAntiguos` ON SCHEDULE EVERY 10 SECOND STARTS '2024-04-19 23:05:20' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DECLARE num_alimentos_eliminados INT;
    
    -- Contar el número de alimentos que cumplen las condiciones
    SELECT COUNT(*) INTO num_alimentos_eliminados
    FROM Alimento
    WHERE a_stock = 0 AND a_fechaSalida <= DATE_SUB(NOW(), INTERVAL 1 YEAR);
    
    -- Eliminar todas las entradas de la tabla Alimento que cumplen las condiciones
    DELETE FROM Alimento
    WHERE a_stock = 0 AND a_fechaSalida <= DATE_SUB(NOW(), INTERVAL 1 YEAR);
    
    -- Guardar el número de alimentos eliminados en la tabla UsuarioAlimento
    IF num_alimentos_eliminados > 0 THEN
        INSERT INTO UsuarioAlimento (u_id, a_id, ua_cantidad, ua_accion, ua_fecha)
        VALUES ('ManejadorEventos', NULL, num_alimentos_eliminados, 'Delete', NOW());
    END IF;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'db_sia'
--
/*!50003 DROP FUNCTION IF EXISTS `contarRegistrosUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `contarRegistrosUsuario`(usuario_id VARCHAR(20)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE total_registros INT;
    
    SELECT COUNT(*) INTO total_registros
    FROM UsuarioAlimento
    WHERE u_id = usuario_id AND ua_accion = 'Add';
    
    RETURN total_registros;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stockAlimentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `stockAlimentos`(IN alimento_id INT, IN usuario_id VARCHAR(20), IN actionType INT, IN quantity INT)
BEGIN
    -- Add Reduce Update = 0 1 2 
    CASE actionType
        WHEN 0 THEN
            -- Código para manejar el tipo de acción add
            UPDATE Alimento
            SET a_stock = a_stock + quantity, a_fechaEntrada = NOW()
            WHERE a_id = alimento_id;
            
            INSERT INTO UsuarioAlimento (u_id, a_id, ua_cantidad, ua_accion, ua_fecha) VALUES (usuario_id, alimento_id, quantity, "Add", NOW());
        WHEN 1 THEN
            -- Código para manejar el tipo de acción reduce
            UPDATE Alimento
            SET a_stock = a_stock - quantity, a_fechaSalida = NOW()
            WHERE a_id = alimento_id;
            
            INSERT INTO UsuarioAlimento (u_id, a_id, ua_cantidad, ua_accion, ua_fecha) VALUES (usuario_id, alimento_id, quantity, "Reduce",NOW());
            
        WHEN 2 THEN
            -- Código para manejar el tipo de acción 2
            INSERT INTO UsuarioAlimento (u_id, a_id, ua_cantidad, ua_accion, ua_fecha) 
            VALUES (usuario_id, alimento_id, quantity, "Update", NOW());

    END CASE;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-25 20:02:53
