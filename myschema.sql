-- MySQL dump 10.13  Distrib 8.0.34, for Linux (x86_64)
--
-- Host: localhost    Database: PFMonsters
-- ------------------------------------------------------
-- Server version	8.0.34-0ubuntu0.22.04.1

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
-- Table structure for table `Ability`
--

DROP TABLE IF EXISTS `Ability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ability` (
  `AbilityName` varchar(30) NOT NULL,
  `AbilityType` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`AbilityName`),
  CONSTRAINT `Ability_chk_1` CHECK ((`AbilityType` in (_utf8mb4'Ex',_utf8mb4'Sp',_utf8mb4'Su')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ability`
--

LOCK TABLES `Ability` WRITE;
/*!40000 ALTER TABLE `Ability` DISABLE KEYS */;
INSERT INTO `Ability` VALUES ('Cold','Ex'),('Icy Destruction','Ex'),('Immunity to Magic','Ex'),('Undersized Weapons','Ex');
/*!40000 ALTER TABLE `Ability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AbilityEffect`
--

DROP TABLE IF EXISTS `AbilityEffect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AbilityEffect` (
  `EffectID` smallint unsigned NOT NULL AUTO_INCREMENT,
  `AbilityName` varchar(30) NOT NULL,
  `Effect` text NOT NULL,
  PRIMARY KEY (`EffectID`),
  KEY `fk_abilityname` (`AbilityName`),
  CONSTRAINT `fk_abilityname` FOREIGN KEY (`AbilityName`) REFERENCES `Ability` (`AbilityName`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AbilityEffect`
--

LOCK TABLES `AbilityEffect` WRITE;
/*!40000 ALTER TABLE `AbilityEffect` DISABLE KEYS */;
INSERT INTO `AbilityEffect` VALUES (1,'Cold','1d6 cold damage on touch, incl. unarmed or natural attacks'),(2,'Icy Destruction','3d6 slashing damage in 10 foot burst'),(3,'Icy Destruction','2d6 cold damage in 10 foot burst'),(4,'Immunity to Magic','Immune to any spell or spell-like ability excluding those that the fire descriptor'),(5,'Immunity to Magic','Magical attack that does electricity damage slows for 2d6 rounds'),(6,'Immunity to Magic','A magical attack that deals cold damage breaks any slow effect and heals 1 point for every 3 points of damage the attack would deal.'),(7,'Undersized Weapons','Wields weapons as if they were one size category smaller');
/*!40000 ALTER TABLE `AbilityEffect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Creature`
--

DROP TABLE IF EXISTS `Creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Creature` (
  `CreatureName` varchar(30) NOT NULL,
  `HP` varchar(10) NOT NULL,
  `MeleeDmg` varchar(25) DEFAULT NULL,
  `RangeDmg` varchar(25) DEFAULT NULL,
  `AC` smallint unsigned DEFAULT NULL,
  `SizeType` varchar(20) NOT NULL,
  `PrimaryType` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`CreatureName`),
  CONSTRAINT `Creature_chk_1` CHECK ((`SizeType` in (_utf8mb4'Fine',_utf8mb4'Diminutive',_utf8mb4'Tiny',_utf8mb4'Small',_utf8mb4'Medium',_utf8mb4'Large',_utf8mb4'Huge',_utf8mb4'Gargantuan',_utf8mb4'Colossal')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Creature`
--

LOCK TABLES `Creature` WRITE;
/*!40000 ALTER TABLE `Creature` DISABLE KEYS */;
INSERT INTO `Creature` VALUES ('Centaur','4d10+8','1d8+2','1d8+2',20,'Large','Monstrous Humanoid'),('Goblin','1d10+1','1d4','1d4',16,'Small','Goblinoid'),('Golem, Ice','6d10+20','1d6+3 plus 1d6 cold',NULL,17,'Medium','Construct'),('Hell Hound','4d10+8','1d8+1 plus 1d6 fire',NULL,16,'Medium','Outsider'),('Nymph','8d6+32','1d4',NULL,23,'Medium','Fey'),('Violet Fungus','4d8+12','1d4+1 plus rot',NULL,15,'Medium','Plant');
/*!40000 ALTER TABLE `Creature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CreatureAbility`
--

DROP TABLE IF EXISTS `CreatureAbility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CreatureAbility` (
  `CreatureName` varchar(30) NOT NULL,
  `AbilityName` varchar(30) NOT NULL,
  PRIMARY KEY (`CreatureName`,`AbilityName`),
  KEY `fk_creatureability` (`AbilityName`),
  CONSTRAINT `fk_creatureability` FOREIGN KEY (`AbilityName`) REFERENCES `Ability` (`AbilityName`),
  CONSTRAINT `fk_creaturename` FOREIGN KEY (`CreatureName`) REFERENCES `Creature` (`CreatureName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CreatureAbility`
--

LOCK TABLES `CreatureAbility` WRITE;
/*!40000 ALTER TABLE `CreatureAbility` DISABLE KEYS */;
INSERT INTO `CreatureAbility` VALUES ('Golem, Ice','Cold'),('Golem, Ice','Icy Destruction'),('Golem, Ice','Immunity to Magic'),('Centaur','Undersized Weapons');
/*!40000 ALTER TABLE `CreatureAbility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CreatureInstance`
--

DROP TABLE IF EXISTS `CreatureInstance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CreatureInstance` (
  `InstanceID` smallint unsigned NOT NULL AUTO_INCREMENT,
  `CurrentHP` smallint NOT NULL,
  `MaxHP` smallint unsigned NOT NULL,
  `Alignment` varchar(2) DEFAULT NULL,
  `CreatureID` varchar(30) NOT NULL,
  PRIMARY KEY (`InstanceID`),
  KEY `fk_creatureid` (`CreatureID`),
  CONSTRAINT `fk_creatureid` FOREIGN KEY (`CreatureID`) REFERENCES `Creature` (`CreatureName`),
  CONSTRAINT `CreatureInstance_chk_1` CHECK ((`Alignment` in (_utf8mb4'LG',_utf8mb4'LN',_utf8mb4'LE',_utf8mb4'NG',_utf8mb4'N',_utf8mb4'NE',_utf8mb4'CG',_utf8mb4'CN',_utf8mb4'CE')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CreatureInstance`
--

LOCK TABLES `CreatureInstance` WRITE;
/*!40000 ALTER TABLE `CreatureInstance` DISABLE KEYS */;
INSERT INTO `CreatureInstance` VALUES (1,6,6,'NE','Goblin'),(2,10,10,'NE','Goblin'),(3,0,5,'NE','Goblin'),(4,38,49,'N','Golem, Ice'),(5,22,22,'LE','Centaur'),(6,15,26,'N','Centaur');
/*!40000 ALTER TABLE `CreatureInstance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CreatureType`
--

DROP TABLE IF EXISTS `CreatureType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CreatureType` (
  `TypeName` varchar(25) NOT NULL,
  PRIMARY KEY (`TypeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CreatureType`
--

LOCK TABLES `CreatureType` WRITE;
/*!40000 ALTER TABLE `CreatureType` DISABLE KEYS */;
INSERT INTO `CreatureType` VALUES ('Animal'),('Construct'),('Fey'),('Goblinoid'),('Monstrous Humanoid'),('Outsider');
/*!40000 ALTER TABLE `CreatureType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TypeImmunity`
--

DROP TABLE IF EXISTS `TypeImmunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TypeImmunity` (
  `ImmunityID` smallint unsigned NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(25) NOT NULL,
  `Immunity` text NOT NULL,
  PRIMARY KEY (`ImmunityID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TypeImmunity`
--

LOCK TABLES `TypeImmunity` WRITE;
/*!40000 ALTER TABLE `TypeImmunity` DISABLE KEYS */;
INSERT INTO `TypeImmunity` VALUES (1,'Construct','Mind-Affecting'),(2,'Construct','Abilities requiring fort save'),(3,'Construct','Bleed'),(4,'Construct','Death effect'),(5,'Construct','Paralysis'),(6,'Construct','Poison'),(7,'Construct','Sleep'),(8,'Construct','Stun'),(9,'Plant','Paralysis'),(10,'Plant','Poison'),(11,'Plant','Polymorph'),(12,'Plant','Sleep'),(13,'Plant','Stun');
/*!40000 ALTER TABLE `TypeImmunity` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-21  2:07:29
