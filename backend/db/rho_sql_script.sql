SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `private_slack` ;
CREATE SCHEMA IF NOT EXISTS `private_slack` DEFAULT CHARACTER SET latin1 ;
USE `private_slack` ;

-- -----------------------------------------------------
-- Table `private_slack`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `private_slack`.`user` ;

CREATE TABLE IF NOT EXISTS `private_slack`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `nick` VARCHAR(45) NOT NULL,
  `registered` DATETIME NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `iduser_UNIQUE` (`iduser` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `private_slack`.`team_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `private_slack`.`team_info` ;

CREATE TABLE IF NOT EXISTS `private_slack`.`team_info` (
  `idteam_info` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idteam_info`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `private_slack`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `private_slack`.`team` ;

CREATE TABLE IF NOT EXISTS `private_slack`.`team` (
  `idteam` INT NOT NULL AUTO_INCREMENT,
  `iduser` INT NOT NULL,
  `idteam_info` INT NOT NULL,
  PRIMARY KEY (`idteam`),
  INDEX `fk_team_info_idx` (`idteam_info` ASC),
  INDEX `fk_user_idx` (`iduser` ASC),
  CONSTRAINT `fk_team_info`
    FOREIGN KEY (`idteam_info`)
    REFERENCES `private_slack`.`team_info` (`idteam_info`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`iduser`)
    REFERENCES `private_slack`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `private_slack`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `private_slack`.`message` ;

CREATE TABLE IF NOT EXISTS `private_slack`.`message` (
  `idmessage` INT NOT NULL AUTO_INCREMENT,
  `idchannel` INT NOT NULL,
  `iduser_from` INT NOT NULL,
  `time` DATETIME NOT NULL,
  `body` TEXT NOT NULL,
  PRIMARY KEY (`idmessage`),
  INDEX `fk_message_id_idx` (`iduser_from` ASC),
  CONSTRAINT `fk_message_id`
    FOREIGN KEY (`iduser_from`)
    REFERENCES `private_slack`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `private_slack`.`channel_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `private_slack`.`channel_info` ;

CREATE TABLE IF NOT EXISTS `private_slack`.`channel_info` (
  `idchannel_info` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idchannel_info`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `private_slack`.`channel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `private_slack`.`channel` ;

CREATE TABLE IF NOT EXISTS `private_slack`.`channel` (
  `idchannel` INT NOT NULL AUTO_INCREMENT,
  `idchannel_info` INT NOT NULL,
  `iduser` INT NOT NULL,
  PRIMARY KEY (`idchannel`),
  INDEX `fk_channel_info_idx` (`idchannel_info` ASC),
  INDEX `fk_channel_user_idx` (`iduser` ASC),
  CONSTRAINT `fk_channel_info`
    FOREIGN KEY (`idchannel_info`)
    REFERENCES `private_slack`.`channel_info` (`idchannel_info`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_channel_user`
    FOREIGN KEY (`iduser`)
    REFERENCES `private_slack`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `private_slack`.`direct_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `private_slack`.`direct_message` ;

CREATE TABLE IF NOT EXISTS `private_slack`.`direct_message` (
  `iddirect_message` INT NOT NULL AUTO_INCREMENT,
  `iduser_from` INT NOT NULL,
  `iduser_to` INT NOT NULL,
  `time` DATETIME NOT NULL,
  `body` TEXT NOT NULL,
  PRIMARY KEY (`iddirect_message`),
  INDEX `fk_direct_from_idx` (`iduser_from` ASC),
  INDEX `fk_direct_to_idx` (`iduser_to` ASC),
  CONSTRAINT `fk_direct_from`
    FOREIGN KEY (`iduser_from`)
    REFERENCES `private_slack`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direct_to`
    FOREIGN KEY (`iduser_to`)
    REFERENCES `private_slack`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
