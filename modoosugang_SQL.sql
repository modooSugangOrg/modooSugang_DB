-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema modoosugang
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema modoosugang
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `modoosugang` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `modoosugang` ;

-- -----------------------------------------------------
-- Table `modoosugang`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`professor` (
  `professor_id` VARCHAR(14) NOT NULL,
  `professor_name` VARCHAR(30) NOT NULL,
  `professor_major` VARCHAR(50) NULL DEFAULT NULL,
  `professor_email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`professor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`lecture` (
  `lecture_index` INT(11) NOT NULL AUTO_INCREMENT,
  `professor_id` VARCHAR(14) NOT NULL,
  `lecture_id` VARCHAR(10) NOT NULL,
  `lecture_name` VARCHAR(50) NOT NULL,
  `lecture_limit` INT(11) NOT NULL,
  `lecture_credit` INT(11) NOT NULL,
  `lecture_major` VARCHAR(20) NOT NULL,
  `lecture_class` VARCHAR(2) NOT NULL,
  `lecture_room` VARCHAR(10) NOT NULL,
  `lecture_semester` CHAR(6) NOT NULL,
  `lecture_professor` VARCHAR(30) NOT NULL,
  `lecture_start_time` TIME NOT NULL,
  `lecture_end_time` TIME NOT NULL,
  `lecture_classify` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`lecture_index`),
  INDEX `fk_lecture_professor1_idx` (`professor_id` ASC) VISIBLE,
  CONSTRAINT `fk_lecture_professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `modoosugang`.`professor` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`university`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`university` (
  `univ_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`univ_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`manager` (
  `manager_id` VARCHAR(14) NOT NULL,
  `univ_name` VARCHAR(50) NOT NULL,
  `manager_email` VARCHAR(50) NOT NULL,
  `manager_pw` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`manager_id`),
  INDEX `fk_manager_university1_idx` (`univ_name` ASC) VISIBLE,
  CONSTRAINT `fk_manager_university1`
    FOREIGN KEY (`univ_name`)
    REFERENCES `modoosugang`.`university` (`univ_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`schedule` (
  `schedule_index` INT(11) NOT NULL AUTO_INCREMENT,
  `univ_name` VARCHAR(50) NOT NULL,
  `manager_id` VARCHAR(14) NOT NULL,
  `semester` CHAR(6) NOT NULL,
  `basket_start` DATETIME NOT NULL,
  `basket_end` DATETIME NOT NULL,
  `register_start` DATETIME NOT NULL,
  `register_end` DATETIME NOT NULL,
  `modify_start` DATETIME NOT NULL,
  `modify_end` DATETIME NOT NULL,
  `cancel_start` DATETIME NOT NULL,
  `cancel_end` DATETIME NOT NULL,
  PRIMARY KEY (`schedule_index`, `univ_name`, `manager_id`),
  INDEX `fk_schedule_university1_idx` (`univ_name` ASC) VISIBLE,
  INDEX `fk_schedule_manager1_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_schedule_university1`
    FOREIGN KEY (`univ_name`)
    REFERENCES `modoosugang`.`university` (`univ_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_manager1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `modoosugang`.`manager` (`manager_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`student` (
  `student_id` VARCHAR(14) NOT NULL,
  `schedule_index` INT(11) NOT NULL,
  `univ_name` VARCHAR(50) NOT NULL,
  `student_name` VARCHAR(30) NOT NULL,
  `student_year` VARCHAR(2) NOT NULL,
  `student_birth` DATE NOT NULL,
  `student_phone` VARCHAR(15) NOT NULL,
  `student_major` VARCHAR(50) NOT NULL,
  `student_second_major` VARCHAR(50) NULL DEFAULT NULL,
  `student_grade` DECIMAL(3,2) NOT NULL,
  `student_enroll` CHAR(4) NOT NULL,
  `student_credit` INT(11) NOT NULL,
  `student_pw` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`student_id`, `schedule_index`, `univ_name`),
  INDEX `fk_student_schedule1_idx` (`schedule_index` ASC, `univ_name` ASC) VISIBLE,
  CONSTRAINT `fk_student_schedule1`
    FOREIGN KEY (`schedule_index` , `univ_name`)
    REFERENCES `modoosugang`.`schedule` (`schedule_index` , `univ_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`prefer_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`prefer_info` (
  `prefer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `student_id` VARCHAR(14) NOT NULL,
  `schedule_index` INT(11) NOT NULL,
  `univ_name` VARCHAR(50) NOT NULL,
  `major_credit` INT(11) NULL DEFAULT 0,
  `etc_credit` INT(11) NULL DEFAULT 0,
  `experiment_credit` INT(11) NULL DEFAULT 0,
  PRIMARY KEY (`prefer_id`, `student_id`, `schedule_index`, `univ_name`),
  INDEX `fk_prefer_info_student1_idx` (`student_id` ASC, `schedule_index` ASC, `univ_name` ASC) VISIBLE,
  CONSTRAINT `fk_prefer_info_student1`
    FOREIGN KEY (`student_id` , `schedule_index` , `univ_name`)
    REFERENCES `modoosugang`.`student` (`student_id` , `schedule_index` , `univ_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`requesting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`requesting` (
  `requesting_id` INT(11) NOT NULL,
  `professor_id` VARCHAR(14) NOT NULL,
  `lecture_index` INT(11) NOT NULL,
  PRIMARY KEY (`requesting_id`),
  INDEX `fk_requesting_professor1_idx` (`professor_id` ASC) VISIBLE,
  INDEX `fk_requesting_lecture1_idx` (`lecture_index` ASC) VISIBLE,
  CONSTRAINT `fk_requesting_professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `modoosugang`.`professor` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_requesting_lecture1`
    FOREIGN KEY (`lecture_index`)
    REFERENCES `modoosugang`.`lecture` (`lecture_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`student_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`student_log` (
  `log_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lecture_index` INT(11) NOT NULL,
  `student_id` VARCHAR(14) NOT NULL,
  `schedule_index` INT(11) NOT NULL,
  `univ_name` VARCHAR(50) NOT NULL,
  `register_log` DATE NOT NULL,
  `modify_log` DATE NULL DEFAULT NULL,
  `cancel_log` DATE NULL DEFAULT NULL,
  `retake_log` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`log_id`, `lecture_index`, `student_id`, `schedule_index`, `univ_name`),
  INDEX `fk_student_log_lecture1_idx` (`lecture_index` ASC) VISIBLE,
  INDEX `fk_student_log_student1_idx` (`student_id` ASC, `schedule_index` ASC, `univ_name` ASC) VISIBLE,
  CONSTRAINT `fk_student_log_lecture1`
    FOREIGN KEY (`lecture_index`)
    REFERENCES `modoosugang`.`lecture` (`lecture_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_log_student1`
    FOREIGN KEY (`student_id` , `schedule_index` , `univ_name`)
    REFERENCES `modoosugang`.`student` (`student_id` , `schedule_index` , `univ_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `modoosugang`.`register_basket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`register_basket` (
  `register_basket_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lecture_index` INT(11) NOT NULL,
  `student_id` VARCHAR(14) NOT NULL,
  `schedule_index` INT(11) NOT NULL,
  `univ_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`register_basket_id`, `lecture_index`, `student_id`, `schedule_index`, `univ_name`),
  INDEX `fk_register_basket_lecture1_idx` (`lecture_index` ASC) VISIBLE,
  INDEX `fk_register_basket_student1_idx` (`student_id` ASC, `schedule_index` ASC, `univ_name` ASC) VISIBLE,
  CONSTRAINT `fk_register_basket_lecture1`
    FOREIGN KEY (`lecture_index`)
    REFERENCES `modoosugang`.`lecture` (`lecture_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_register_basket_student1`
    FOREIGN KEY (`student_id` , `schedule_index` , `univ_name`)
    REFERENCES `modoosugang`.`student` (`student_id` , `schedule_index` , `univ_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modoosugang`.`register_lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`register_lecture` (
  `register_lecture_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lecture_index` INT(11) NOT NULL,
  `student_id` VARCHAR(14) NOT NULL,
  `schedule_index` INT(11) NOT NULL,
  `univ_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`register_lecture_id`, `lecture_index`, `student_id`, `schedule_index`, `univ_name`),
  INDEX `fk_register_lecture_lecture1_idx` (`lecture_index` ASC) VISIBLE,
  INDEX `fk_register_lecture_student1_idx` (`student_id` ASC, `schedule_index` ASC, `univ_name` ASC) VISIBLE,
  CONSTRAINT `fk_register_lecture_lecture1`
    FOREIGN KEY (`lecture_index`)
    REFERENCES `modoosugang`.`lecture` (`lecture_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_register_lecture_student1`
    FOREIGN KEY (`student_id` , `schedule_index` , `univ_name`)
    REFERENCES `modoosugang`.`student` (`student_id` , `schedule_index` , `univ_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modoosugang`.`schedule_professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modoosugang`.`schedule_professor` (
  `schedule_index` INT(11) NOT NULL,
  `univ_name` VARCHAR(50) NOT NULL,
  `manager_id` VARCHAR(14) NOT NULL,
  `professor_id` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`schedule_index`, `univ_name`, `manager_id`, `professor_id`),
  INDEX `fk_schedule_has_professor_professor1_idx` (`professor_id` ASC) VISIBLE,
  INDEX `fk_schedule_has_professor_schedule1_idx` (`schedule_index` ASC, `univ_name` ASC, `manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_schedule_has_professor_schedule1`
    FOREIGN KEY (`schedule_index` , `univ_name` , `manager_id`)
    REFERENCES `modoosugang`.`schedule` (`schedule_index` , `univ_name` , `manager_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schedule_has_professor_professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `modoosugang`.`professor` (`professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
