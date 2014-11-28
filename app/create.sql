-- MySQL Script generated by MySQL Workbench
-- 11/28/14 19:22:39
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pinchosdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pinchosdb` ;

-- -----------------------------------------------------
-- Schema pinchosdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pinchosdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `pinchosdb` ;

-- -----------------------------------------------------
-- Table `pinchosdb`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`usuario` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`usuario` (
  `id` INT NOT NULL,
  `email` VARCHAR(48) NOT NULL,
  `password` CHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`usuario_participante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`usuario_participante` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`usuario_participante` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(64) NOT NULL,
  `direccion` VARCHAR(512) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_up_id_usuario`
    FOREIGN KEY (`id`)
    REFERENCES `pinchosdb`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`usuario_jurado_popular`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`usuario_jurado_popular` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`usuario_jurado_popular` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_ujp_id_usuario`
    FOREIGN KEY (`id`)
    REFERENCES `pinchosdb`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`usuario_jurado_especialista`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`usuario_jurado_especialista` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`usuario_jurado_especialista` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(32) NULL,
  `apellidos` VARCHAR(64) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_uje_id_usuario`
    FOREIGN KEY (`id`)
    REFERENCES `pinchosdb`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`usuario_organizador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`usuario_organizador` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`usuario_organizador` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(32) NOT NULL,
  `apellidos` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_uo_id_usuario`
    FOREIGN KEY (`id`)
    REFERENCES `pinchosdb`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`concursos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`concursos` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`concursos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(64) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `descripcion` TEXT NOT NULL,
  `bases` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`agenda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`agenda` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`agenda` (
  `id` INT NOT NULL,
  `id_concurso` INT NOT NULL,
  `id_editor` INT NOT NULL,
  `nombre` VARCHAR(64) NOT NULL,
  `descripcion` VARCHAR(512) NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_fin` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ac_id_idx` (`id_concurso` ASC),
  INDEX `fk_auorganizador_id_idx` (`id_editor` ASC),
  CONSTRAINT `fk_aconcurso_id`
    FOREIGN KEY (`id_concurso`)
    REFERENCES `pinchosdb`.`concursos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_auorganizador_id`
    FOREIGN KEY (`id_editor`)
    REFERENCES `pinchosdb`.`usuario_organizador` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`premios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`premios` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`premios` (
  `id` INT NOT NULL,
  `id_concurso` INT NOT NULL,
  `id_editor` INT NOT NULL,
  `nombre` VARCHAR(64) NOT NULL,
  `descripcion` VARCHAR(512) NULL,
  `ganador` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pc_id_idx` (`id_concurso` ASC),
  INDEX `fk_uorganizador_id_idx` (`id_editor` ASC),
  INDEX `fk_gusuario_id_idx` (`ganador` ASC),
  CONSTRAINT `fk_pconcurso_id`
    FOREIGN KEY (`id_concurso`)
    REFERENCES `pinchosdb`.`concursos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_gusuario_id`
    FOREIGN KEY (`ganador`)
    REFERENCES `pinchosdb`.`usuario_participante` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_uorganizador_id`
    FOREIGN KEY (`id_editor`)
    REFERENCES `pinchosdb`.`usuario_organizador` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`pinchos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`pinchos` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`pinchos` (
  `id` INT NOT NULL,
  `id_participante` INT NOT NULL,
  `id_concurso` INT NOT NULL,
  `nombre` VARCHAR(32) NOT NULL,
  `descripcion` VARCHAR(512) NULL,
  `validado` BIT NOT NULL DEFAULT 0,
  `validado_id_organizador` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_uparticiante_idx` (`id_participante` ASC),
  INDEX `fk_pconcurso_id_idx` (`id_concurso` ASC),
  INDEX `fk_porganizador_id_idx` (`validado_id_organizador` ASC),
  CONSTRAINT `fk_pinparticiante`
    FOREIGN KEY (`id_participante`)
    REFERENCES `pinchosdb`.`usuario_participante` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pinconcurso_id`
    FOREIGN KEY (`id_concurso`)
    REFERENCES `pinchosdb`.`concursos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pinorganizador_id`
    FOREIGN KEY (`validado_id_organizador`)
    REFERENCES `pinchosdb`.`usuario_organizador` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`codigos_pincho`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`codigos_pincho` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`codigos_pincho` (
  `codigo` VARCHAR(12) NOT NULL,
  `id_pincho` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_cppincho_id_idx` (`id_pincho` ASC),
  CONSTRAINT `fk_cppincho_id`
    FOREIGN KEY (`id_pincho`)
    REFERENCES `pinchosdb`.`pinchos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`votos_populares`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`votos_populares` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`votos_populares` (
  `id` INT NOT NULL,
  `id_jurado` INT NOT NULL,
  `id_codigo_ganador` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vpusuario_id_idx` (`id_jurado` ASC),
  INDEX `fk_vppg_id_idx` (`id_codigo_ganador` ASC),
  CONSTRAINT `fk_vpusuario_id`
    FOREIGN KEY (`id_jurado`)
    REFERENCES `pinchosdb`.`usuario_jurado_popular` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vppg_id`
    FOREIGN KEY (`id_codigo_ganador`)
    REFERENCES `pinchosdb`.`codigos_pincho` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`votos_profesionales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`votos_profesionales` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`votos_profesionales` (
  `id_jurado` INT NOT NULL,
  `id_pincho` INT NOT NULL,
  `nota` FLOAT NOT NULL,
  PRIMARY KEY (`id_jurado`, `id_pincho`),
  INDEX `fp_vpjp_id_idx` (`id_pincho` ASC),
  CONSTRAINT `fk_vpjesp_id`
    FOREIGN KEY (`id_jurado`)
    REFERENCES `pinchosdb`.`usuario_jurado_especialista` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fp_vpjp_id`
    FOREIGN KEY (`id_pincho`)
    REFERENCES `pinchosdb`.`pinchos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pinchosdb`.`codigos_votados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pinchosdb`.`codigos_votados` ;

CREATE TABLE IF NOT EXISTS `pinchosdb`.`codigos_votados` (
  `id_voto` INT NOT NULL,
  `id_codigo` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_voto`, `id_codigo`),
  INDEX `fk_cvcodigo_id_idx` (`id_codigo` ASC),
  CONSTRAINT `fk_cvcodigo_id`
    FOREIGN KEY (`id_codigo`)
    REFERENCES `pinchosdb`.`codigos_pincho` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cvvoto_id`
    FOREIGN KEY (`id_voto`)
    REFERENCES `pinchosdb`.`votos_populares` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO testuser;
 DROP USER testuser;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'testuser' IDENTIFIED BY 'testpass';

GRANT ALL ON `pinchosdb`.* TO 'testuser';
GRANT SELECT ON TABLE `pinchosdb`.* TO 'testuser';
GRANT SELECT, INSERT, TRIGGER ON TABLE `pinchosdb`.* TO 'testuser';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `pinchosdb`.* TO 'testuser';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
