-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `epl_db` DEFAULT CHARACTER SET utf8 ;
USE `epl_db` ;

-- -----------------------------------------------------
-- Table `epl_db`.`Managers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `epl_db`.`Managers` (
  `Manager` VARCHAR(255) NOT NULL,
  `Nationality` VARCHAR(255) NOT NULL,
  `Status` VARCHAR(255) NOT NULL,
  `Team` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`Manager`));


-- -----------------------------------------------------
-- Table `epl_db`.`Stadiums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `epl_db`.`Stadiums` (
  `Team` VARCHAR(255) NOT NULL,
  `Venue` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Team`));


-- -----------------------------------------------------
-- Table `epl_db`.`Matches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `epl_db`.`Matches` (
  `Match_Num` INT NOT NULL,
  `Match_Day` INT NULL,
  `Date` DATE NOT NULL,
  `Half time score Team_1` INT NULL,
  `Half time score Team_2` INT NULL,
  `Full time score Team_1` INT NOT NULL,
  `Full time score Team_2` INT NOT NULL,
  `Team_1` VARCHAR(225) NOT NULL,
  `Team_2` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`Match_Num`));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
