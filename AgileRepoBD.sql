-- MySQL Script generated by MySQL Workbench
-- Tue Apr  7 01:27:28 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema agilerepo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema agilerepo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `agilerepo` DEFAULT CHARACTER SET utf8 ;
USE `agilerepo` ;

-- -----------------------------------------------------
-- Table `agilerepo`.`asistenteseventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`asistenteseventos` (
  `idasistentesEventos` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `apellidos` VARCHAR(150) NULL DEFAULT NULL,
  `cedula` INT(20) NULL DEFAULT NULL,
  `telefono` INT(20) NULL DEFAULT NULL,
  `correo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idasistentesEventos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`usuarios` (
  `uid` VARCHAR(500) CHARACTER SET 'utf8' NOT NULL,
  `rol` BIT(1) NULL DEFAULT NULL,
  `displayName` VARCHAR(200) NULL DEFAULT NULL,
  `descripcion` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`eventos` (
  `idEvento` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(150) NULL DEFAULT NULL,
  `horas` INT(11) NULL DEFAULT NULL,
  `dias` INT(11) NULL DEFAULT NULL,
  `propietario` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idEvento`),
  INDEX `eventos_ibfk_1` (`propietario` ASC) VISIBLE,
  CONSTRAINT `eventos_ibfk_1`
    FOREIGN KEY (`propietario`)
    REFERENCES `agilerepo`.`usuarios` (`uid`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`comentarios` (
  `idComentario` INT(11) NOT NULL AUTO_INCREMENT,
  `uId` VARCHAR(500) NULL DEFAULT NULL,
  `evento` INT(11) NULL DEFAULT NULL,
  `displayName` VARCHAR(500) NULL DEFAULT NULL,
  `comentario` VARCHAR(500) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idComentario`),
  INDEX `uId` (`uId` ASC) VISIBLE,
  INDEX `evento` (`evento` ASC) VISIBLE,
  CONSTRAINT `comentarios_ibfk_1`
    FOREIGN KEY (`uId`)
    REFERENCES `agilerepo`.`usuarios` (`uid`),
  CONSTRAINT `comentarios_ibfk_2`
    FOREIGN KEY (`evento`)
    REFERENCES `agilerepo`.`eventos` (`idEvento`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`confighoraubi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`confighoraubi` (
  `idEvento` INT(11) NOT NULL,
  `ubiFisica` VARCHAR(500) NULL DEFAULT NULL,
  `link` VARCHAR(500) NULL DEFAULT NULL,
  `zonaHoraria` VARCHAR(70) NULL DEFAULT NULL,
  `hIni` TIME NULL DEFAULT NULL,
  `hFin` TIME NULL DEFAULT NULL,
  `presencial` BIT(1) NULL DEFAULT NULL,
  `FIni` DATE NULL DEFAULT NULL,
  `FFin` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idEvento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `agilerepo`.`detalleevento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`detalleevento` (
  `idDetalleEvento` INT(11) NOT NULL AUTO_INCREMENT,
  `indiceEvento` INT(11) NOT NULL,
  `evento` INT(11) NULL DEFAULT NULL,
  `duracion` INT(11) NULL DEFAULT '1',
  `titulo` VARCHAR(100) NULL DEFAULT 'Slot',
  `descripcion` VARCHAR(300) NULL DEFAULT 'Descripcion...',
  `borrado` BIT(1) NULL DEFAULT b'0',
  `Objetivo` VARCHAR(3000) NULL DEFAULT 'Objetivo...',
  `Categoria` VARCHAR(50) NULL DEFAULT 'Categoria...',
  `ColorCategoria` VARCHAR(45) NULL DEFAULT '00ff00',
  `Pasos` VARCHAR(3000) NULL DEFAULT 'Pasos...',
  `Materiales` VARCHAR(3000) NULL DEFAULT 'Materiales...',
  `bloqueo` INT(11) NULL DEFAULT '0',
  `horaInicio` TIME NULL DEFAULT '08:30:00',
  `primeroDeDia` BIT(1) NULL DEFAULT b'0',
  PRIMARY KEY (`idDetalleEvento`),
  INDEX `FK_evento_idx` (`evento` ASC) VISIBLE,
  CONSTRAINT `FK_detalle`
    FOREIGN KEY (`evento`)
    REFERENCES `agilerepo`.`eventos` (`idEvento`))
ENGINE = InnoDB
AUTO_INCREMENT = 123
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`entrada` (
  `idEntrada` INT(11) NOT NULL AUTO_INCREMENT,
  `EventoId` INT(11) NOT NULL,
  `cantidad` INT(11) NULL DEFAULT NULL,
  `nombreEntrada` VARCHAR(100) NULL DEFAULT NULL,
  `precio` DOUBLE NULL DEFAULT NULL,
  `fechaInicio` DATE NULL DEFAULT NULL,
  `horaInicio` TIME NULL DEFAULT NULL,
  `fechaFin` DATE NULL DEFAULT NULL,
  `horaFin` TIME NULL DEFAULT NULL,
  `Tipo` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`idEntrada`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`tiposeventop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`tiposeventop` (
  `idTipo` INT(11) NOT NULL AUTO_INCREMENT,
  `tipoEvento` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipo`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`eventopublic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`eventopublic` (
  `idEventoPublic` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NULL DEFAULT NULL,
  `Descripcion` TEXT NULL DEFAULT NULL,
  `finalizado` BIT(1) NULL DEFAULT NULL,
  `tipo` INT(11) NULL DEFAULT NULL,
  `portada` VARCHAR(1000) NULL DEFAULT NULL,
  `video` VARCHAR(1000) NULL DEFAULT NULL,
  `cancelado` INT(11) NULL DEFAULT NULL,
  `resumen` VARCHAR(150) NULL DEFAULT NULL,
  `imgSecundaria` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`idEventoPublic`),
  INDEX `tipoEvtP_fk_idx` (`tipo` ASC) VISIBLE,
  CONSTRAINT `tipoEvtP_fk`
    FOREIGN KEY (`tipo`)
    REFERENCES `agilerepo`.`tiposeventop` (`idTipo`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`zonashorarias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`zonashorarias` (
  `idZona` INT(11) NOT NULL AUTO_INCREMENT,
  `zonaHoraria` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idZona`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`fechaseventop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`fechaseventop` (
  `idFecha` INT(11) NOT NULL AUTO_INCREMENT,
  `evento` INT(11) NULL DEFAULT NULL,
  `fechaEvento` DATE NULL DEFAULT NULL,
  `zonaHoraria` INT(11) NULL DEFAULT NULL,
  `cancelado` BIT(1) NULL DEFAULT NULL,
  `presencial` BIT(1) NULL DEFAULT NULL,
  `lugar` VARCHAR(300) NULL DEFAULT NULL,
  `link` VARCHAR(300) NULL DEFAULT NULL,
  `horaInicio` TIME NULL DEFAULT NULL,
  `requerido` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idFecha`),
  INDEX `eventoFechaP_fk_idx` (`evento` ASC) VISIBLE,
  INDEX `zonaH_fk_idx` (`zonaHoraria` ASC) VISIBLE,
  CONSTRAINT `eventoFechaP_fk`
    FOREIGN KEY (`evento`)
    REFERENCES `agilerepo`.`eventopublic` (`idEventoPublic`),
  CONSTRAINT `zonaH_fk`
    FOREIGN KEY (`zonaHoraria`)
    REFERENCES `agilerepo`.`zonashorarias` (`idZona`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`organizadoreseventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`organizadoreseventos` (
  `organizador` VARCHAR(500) NOT NULL,
  `evento` INT(11) NULL DEFAULT NULL,
  `idOrganiza` INT(11) NOT NULL AUTO_INCREMENT,
  `descri` VARCHAR(200) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `profileImage` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idOrganiza`),
  INDEX `evtPOrg_fk_idx` (`evento` ASC) VISIBLE,
  INDEX `organizador_fk` (`organizador` ASC) VISIBLE,
  CONSTRAINT `evtPOrg_fk`
    FOREIGN KEY (`evento`)
    REFERENCES `agilerepo`.`eventopublic` (`idEventoPublic`),
  CONSTRAINT `organizador_fk`
    FOREIGN KEY (`organizador`)
    REFERENCES `agilerepo`.`usuarios` (`uid`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`paiszona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`paiszona` (
  `fkZona` INT(11) NOT NULL,
  `paisZona` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `fk_idx` (`fkZona` ASC) VISIBLE,
  CONSTRAINT `fk`
    FOREIGN KEY (`fkZona`)
    REFERENCES `agilerepo`.`zonashorarias` (`idZona`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `agilerepo`.`tagseventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`tagseventos` (
  `idTag` INT(11) NOT NULL AUTO_INCREMENT,
  `tag` VARCHAR(45) NULL DEFAULT NULL,
  `evento` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idTag`),
  INDEX `FK_evento_idx` (`evento` ASC) VISIBLE,
  CONSTRAINT `FK_evento`
    FOREIGN KEY (`evento`)
    REFERENCES `agilerepo`.`eventos` (`idEvento`))
ENGINE = InnoDB
AUTO_INCREMENT = 112
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `agilerepo`.`tagsevtpublico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agilerepo`.`tagsevtpublico` (
  `idTag` INT(11) NOT NULL AUTO_INCREMENT,
  `tag` VARCHAR(25) NULL DEFAULT NULL,
  `evento` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idTag`),
  INDEX `evtPubtag_fk_idx` (`evento` ASC) VISIBLE,
  CONSTRAINT `evtPubtag_fk`
    FOREIGN KEY (`evento`)
    REFERENCES `agilerepo`.`eventopublic` (`idEventoPublic`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8;

USE `agilerepo` ;

-- -----------------------------------------------------
-- procedure insert_infoBasica
-- -----------------------------------------------------

DELIMITER $$
USE `agilerepo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_infoBasica`(IN nombre VARCHAR(25),IN tipo VARCHAR(50),OUT idEvtO int)
BEGIN
  Declare idEvt int;
  set idEvt = null;
  set idEvt = (select max(idEventoPublic) from eventopublic) +1;
  
  if(idEvt is null) then
   set idEvt = 1;
  end if;
  
  insert into eventopublic (Nombre,finalizado,tipo)  values(nombre,b'0',(select idTipo from  tiposeventop where tipoEvento = tipo ));
  set idEvtO = idEvt;
  
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
