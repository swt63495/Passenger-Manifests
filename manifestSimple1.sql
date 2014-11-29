
-- -----------------------------------------------------
-- Schema gene25: No Canonical Persons table
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gene25` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `gene25` ;

-- -----------------------------------------------------
-- Table `place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `place` (
  `id_place` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(25) NULL DEFAULT NULL,
  `state` VARCHAR(25) NULL DEFAULT NULL,
  `country` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`id_place`))
ENGINE = InnoDB;

INSERT INTO `place` (`id_place`, `address`, `city`, `state`, `country`) VALUES
(1, NULL, 'Bridgetown', '', 'Barbados'),
(2, NULL, NULL, NULL, 'Barbados'),
(3, NULL, 'Colon, C.Z.','', 'Panama'),
(4, NULL, 'Cristobal, C.Z.', '', 'Panama'),
(5, NULL, 'Panama City', '', 'Panama'),
(6, NULL, 'New York City', 'NY', 'USA'),
(7, NULL, 'Boston', 'MA', 'USA');


-- -----------------------------------------------------
-- Table `canon_person`
-- -----------------------------------------------------
/*CREATE TABLE IF NOT EXISTS `canon_person` (
  `id_canon_person` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(20) NULL DEFAULT NULL,
  `lname` VARCHAR(20) NULL DEFAULT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `race` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id_canon_person`))
ENGINE = InnoDB;

INSERT INTO `canon_person` (`id_canon_person`, `fname`, `lname`, `gender`, `dob`, `race`) VALUES
(1, 'UNKNOWN', 'UNKNOWN', 'u', NULL, 'UNKNOWN'),
(2, 'Marcus', 'Edwards', 'm', NULL, 'black'),
(3, 'Dudley', 'Browne', 'm', NULL, 'black'),
(4, 'Ashton', 'Codrington', 'm', NULL, 'black'),
(5, 'Earle', 'Browne', 'm', NULL, 'Black'),
(6, 'Rosalie', 'Beckles', 'f', NULL, 'black'),
(7, 'Joseph', 'Beckles', 'm', NULL, 'black'),
(8, 'Mariam', 'Browne', 'f', NULL, 'black'),
(9, 'Edwards', 'Vashti', 'f', NULL, 'black'),
(10,'Ada Kathleen', 'Burke', 'f', NULL, 'black'),
(11, 'Conrad Sarsfield', 'Burke', 'm', NULL, 'black'),
(12, 'Nathaniel', 'Burke', 'm', NULL, 'black'),
(13, 'Cleveland', 'Burke', 'm', NULL, 'black');*/


-- Table `document_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `document_type` (
-- -----------------------------------------------------
  `id_document_type` INT NOT NULL,
  `document_type` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `document_type_UNIQUE` (`document_type` ASC),
  PRIMARY KEY (`id_document_type`))
ENGINE = InnoDB;

INSERT INTO `document_type` (`id_document_type`,`document_type`) VALUES
(1, 'UNKNOWN'),
(2, 'Passenger Manifest (Alien), NYC'),
(3, 'Passenger Manifest (Citizen), NYC'),
(4, 'Birth Certificate'),
(5, 'City Directory'),
(6, '1940 Census'),
(7, '1930 Census'),
(8, '1920 Census'),
(9, '1910 Census'),
(10, '1900 Census'),
(11, 'MA State Death Index'),
(12, 'Social Security Death Index');


-- -----------------------------------------------------
-- Table `record_of_person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `record_of_person` (
  `id_person` INT NOT NULL AUTO_INCREMENT,
  `id_canon_person` INT NOT NULL,
  `id_document_type` INT NULL DEFAULT NULL,
  `fname` VARCHAR(20) NULL DEFAULT NULL,
  `lname` VARCHAR(20) NULL DEFAULT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `race` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id_person`),
  -- INDEX `fk_person_canon_person_idx` (`id_canon_person` ASC),
  INDEX `fk_record_of_person_document_type1_idx` (`id_document_type` ASC),
  -- CONSTRAINT `fk_person_canon_person`
	 -- FOREIGN KEY (`id_canon_person`)
	 -- REFERENCES `canon_person` (`id_canon_person`)
	 -- ON DELETE CASCADE
	 -- ON UPDATE CASCADE,
  CONSTRAINT `fk_record_of_person_document_type1`
	 FOREIGN KEY (`id_document_type`)
	 REFERENCES `document_type` (`id_document_type`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO `record_of_person` (`id_person`, `id_document_type`, `fname`, `lname`, `gender`, `dob`, `race`) VALUES
(1, 2, 'UNKNOWN', 'UNKNOWN', 'u', NULL, 'UNKNOWN'),
(2, 2, 'Marcus', 'Edwards', 'm', NULL, 'black'),
(3, 2, 'Dudley', 'Brown', 'm', NULL, 'black'),
(4, 2, 'Ashton', 'Codrington', 'm', NULL, 'black'),
(5, 2, 'Earl', 'Browne', 'm', NULL, 'Black'),
(6, 2, 'Rosalie', 'Beckles', 'f', NULL, 'black'),
(7, 2, 'Joseph', 'Beckles', 'm', NULL, 'black'),
(8, 2, 'Mariam L.', 'Browne', 'f', NULL, 'black'),
(9, 2, 'Edwards', 'Vashti', 'f', NULL, 'black'),
(10, 2, 'Ada Kathleen', 'Burke', 'f', NULL, 'black'),
(11, 2, 'Conrad Sarsfield', 'Burke', 'm', NULL, 'black'),
(12, 2, 'Nathaniel', 'Burke', 'm', NULL, 'black'),
(13, 2, 'Cleveland', 'Burk', 'm', NULL, 'black');


-- -----------------------------------------------------
-- Table `vessel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vessel` (
  `id_vessel` INT NOT NULL AUTO_INCREMENT,
  `vessel_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_vessel`))
ENGINE = InnoDB;

INSERT INTO `vessel` (`id_vessel`,`vessel_name`) VALUES
(1, 'UNKNOWN'),
(2, 'Advance'),
(3, 'Colon'),
(4, 'General G. W. Goethals'),
(5, 'Lennnjan?'),
(6, 'Pancras'),
(7, 'Thespis'),
(8, 'Vandyck'),
(9, 'Vauban');



-- -----------------------------------------------------
-- Table `manifest`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `manifest` (
  `m_id` INT NOT NULL AUTO_INCREMENT,
  `doctype` INT,
  `id_vessel` INT DEFAULT NULL,
  `id_place_sailed_from` INT DEFAULT NULL,
  `date_departed` date DEFAULT NULL,
  `id_place_sailed_to` INT DEFAULT NULL,
  `date_arrived` date DEFAULT NULL,
  `list` varchar(3) DEFAULT NULL,
  `line` INT DEFAULT NULL,
  `id_passenger` INT DEFAULT NULL COMMENT 'passenger is unique to each voyage.',
  `pass_age_years` INT DEFAULT NULL,
  `pass_age_mos` INT DEFAULT NULL,
  `pass_sex` char(1) DEFAULT NULL,
  `pass_marrital_status` char(1) DEFAULT NULL,
  `pass_occupation` varchar(25) DEFAULT NULL,
  `pass_can_read` char(1) DEFAULT NULL,
  `pass_can_write` char(1) DEFAULT NULL,
  `pass_nationality` varchar(25) DEFAULT NULL,
  `pass_race` varchar(15) DEFAULT NULL,
  `id_pass_prev_place` INT DEFAULT NULL,
  `pass_prev_place_num_years` varchar(25) DEFAULT NULL COMMENT 'Number of years at last permanent address',
  `id_relative_back_home` int DEFAULT NULL,
  `relative_back_home_relationship` varchar(25) DEFAULT NULL COMMENT 'how psgr is related to person at last permanent address (e.g., sister, father, etc.)',
  `id_relative_back_home_place` INT DEFAULT NULL,
  `id_pass_dest_place` INT DEFAULT NULL,
  `pass_prev_visit` char(1) DEFAULT NULL,
  `pass_prev_visit_date` date DEFAULT NULL,
  `pass_prev_visit_length` INT DEFAULT NULL,
  `id_pass_prev_visit_place` INT DEFAULT NULL,
  `pass_join_someone` CHAR(1) DEFAULT NULL,
  `id_dest_person` INT DEFAULT NULL,
  `id_dest_person_place` INT DEFAULT NULL,
  `dest_person_relationship` varchar(25) DEFAULT NULL COMMENT 'how related to person at final destination (e.g., friend, father, etc.)',
  `pass_height` decimal(2,1) DEFAULT NULL,
  `pass_complexion` varchar(10) DEFAULT NULL,
  `pass_hair` varchar(5) DEFAULT NULL,
  `pass_eye` varchar(5) DEFAULT NULL,
  `pass_identifying_marks` varchar(25) DEFAULT NULL,
  `id_pass_bth_place` INT DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
PRIMARY KEY (`m_id`),
  INDEX `fk_manifest_info_person1_idx` (`id_passenger`),
  INDEX `fk_manifest_info_person2_idx` (`id_relative_back_home`),
  INDEX `fk_manifest_info_person3_idx` (`id_dest_person`),
  INDEX `fk_manifest_info_place1_idx` (`id_pass_prev_place`),
  INDEX `fk_manifest_info_place2_idx` (`id_pass_dest_place`),
  INDEX `fk_manifest_info_place3_idx` (`id_place_sailed_from`),
  INDEX `fk_manifest_info_place4_idx` (`id_place_sailed_to`),
  INDEX `fk_manifest_info_vessel1_idx` (`id_vessel`),
  INDEX `final_destination_place2` (`id_dest_person_place`),
  INDEX `pass_birth_place` (`id_pass_bth_place`),
  INDEX `pass_prev_visit_locale` (`id_pass_prev_visit_place`),
  INDEX `relative_back_home_lives` (`id_relative_back_home_place`),
  CONSTRAINT `birth_place`
	 FOREIGN KEY (`id_pass_bth_place`)
	 REFERENCES `place` (`id_place`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `final_destination_person`
	 FOREIGN KEY (`id_dest_person`)
	 REFERENCES `record_of_person` (`id_person`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `final_destination_place`
	 FOREIGN KEY (`id_pass_dest_place`)
	 REFERENCES `place` (`id_place`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `passenger_person`
	 FOREIGN KEY (`id_passenger`)
	 REFERENCES `record_of_person` (`id_person`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `person_at_fin_destination`
	 FOREIGN KEY (`id_dest_person_place`)
	 REFERENCES `place` (`id_place`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `prev_visit_place`
	 FOREIGN KEY (`id_pass_prev_visit_place`)
	 REFERENCES `place` (`id_place`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `previous_place`
	 FOREIGN KEY (`id_pass_prev_place`)
	 REFERENCES `place` (`id_place`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `relative_person`
	 FOREIGN KEY (`id_relative_back_home`)
	 REFERENCES `record_of_person` (`id_person`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `relative_place`
	 FOREIGN KEY (`id_relative_back_home_place`)
	 REFERENCES `place` (`id_place`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `vessel`
	 FOREIGN KEY (`id_vessel`)
	 REFERENCES `vessel` (`id_vessel`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `voyage_placce1`
	 FOREIGN KEY (`id_place_sailed_from`)
	 REFERENCES `place` (`id_place`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE,
  CONSTRAINT `voyage_place2`
	 FOREIGN KEY (`id_place_sailed_to`)
	 REFERENCES `place` (`id_place`)
	 ON DELETE SET NULL
	 ON UPDATE CASCADE)
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS`manifest_excel_data` (
  `m_id` INT NOT NULL AUTO_INCREMENT,
  `doctype` INT,
  `vessel_name` VARCHAR(25) NULL,
  `id_vessel` INT NULL,
  `sailed_from` VARCHAR(25) NULL,
  `id_place_sailed_from` INT NULL,
  `date_departed` DATE NULL,
  `date_arrived` DATE NULL,
  `list` VARCHAR(3) NULL,
  `line` INT NULL,
  `pass_lname` VARCHAR(25) NULL,
  `pass_fname` VARCHAR(25) NULL,
  `id_passenger` INT NULL,
  `pass_age` INT NULL,
/*`pass_age_years` INT NULL,
  `pass_age_mos` INT NULL, */
  `pass_sex` CHAR(1) NULL,
  `pass_marrital_status` CHAR(1) NULL,
  `pass_occupation` VARCHAR(25) NULL,
  `pass_can_read` CHAR(1) NULL,
  `pass_can_write` CHAR(1) NULL,
  `pass_nationality` VARCHAR(25) NULL,
  `pass_race` VARCHAR(15) NULL,
  `pass_prev_place_country` VARCHAR(25) NULL,
/*`pass_prev_place_state` VARCHAR(25) NULL,*/
  `pass_prev_place_city` VARCHAR(25) NULL,
  `id_pass_prev_place` INT NULL,
  `pass_prev_place_num_years` VARCHAR(25) NULL,
  `relative_back_home_lname` VARCHAR(25) NULL,
  `relative_back_home_fname` VARCHAR(25) NULL,
  `id_relative_back_home` INT NULL,
  `relative_back_home_relationship` VARCHAR(25) NULL,
  `relative_back_home_country` VARCHAR(25) NULL,
/*`relative_back_home_state` VARCHAR(25) NULL,*/
  `relative_back_home_city` VARCHAR(25) NULL,
  `id_relative_back_home_place` INT NULL,
  `pass_dest_state` VARCHAR(25) NULL,
  `pass_dest_city` VARCHAR(25) NULL,
  `id_pass_dest_place` INT NULL,
  `pass_prev_visit` CHAR(1) NULL,
  `pass_prev_visit_date` DATE NULL,
  `pass_prev_visit_length` INT NULL,
  `pass_prev_visit_state` VARCHAR(25) NULL,
  `pass_prev_visit_city` VARCHAR(25) NULL,
  `id_pass_prev_visit_place` INT NULL,
  `pass_join_someone` CHAR(1) NULL,
  `dest_person_lname` VARCHAR(25) NULL,
  `dest_person_fname` VARCHAR(25) NULL,
  `id_dest_person` INT NULL,
  `dest_person_state` VARCHAR(25) NULL,
  `dest_person_city` VARCHAR(25) NULL,
  `dest_person_address` VARCHAR(30) NULL,
  `id_dest_person_place` INT NULL,
  `dest_person_relationship` VARCHAR(25) NULL,
  `pass_height` DECIMAL(2,1) NULL,
  `pass_complexion` VARCHAR(10) NULL,
  `pass_hair` VARCHAR(5) NULL,
  `pass_eye` VARCHAR(5) NULL,
  `pass_identifying_marks` VARCHAR(25) NULL,
  `pass_bth_country` VARCHAR(25) NULL,
/*`pass_bth_state` VARCHAR(25) NULL,*/
  `pass_bth_city` VARCHAR(25) NULL,
  `id_pass_bth_place` INT NULL,
  `notes` VARCHAR(50) NULL,
PRIMARY KEY (`m_id`))
ENGINE = InnoDB;


INSERT INTO `manifest_excel_data` 
(`m_id`,  `vessel_name`,  `id_vessel`,  `sailed_from`,  `id_place_sailed_from`, `date_departed`,  `date_arrived`, `list`, `line`, `pass_lname`, `pass_fname`, `id_passenger`, `pass_age`, `pass_sex`, `pass_marrital_status`, `pass_occupation`,  `pass_can_read`,  `pass_can_write`, `pass_nationality`, `pass_race`,  `pass_prev_place_country`, `pass_prev_place_city`, `id_pass_prev_place`, `pass_prev_place_num_years`,  `relative_back_home_lname`, `relative_back_home_fname`, `id_relative_back_home`, `relative_back_home_relationship`,  `relative_back_home_country`, `relative_back_home_city`,  `id_relative_back_home_place`,  `pass_dest_state`,  `pass_dest_city`, `id_pass_dest_place`, `pass_prev_visit`,  `pass_prev_visit_date`, `pass_prev_visit_length`, `pass_prev_visit_state`,  `pass_prev_visit_city`, `id_pass_prev_visit_place`, `dest_person_lname`,  `dest_person_fname`,  `id_dest_person`, `dest_person_state`,  `dest_person_city`, `dest_person_address`,  `id_dest_person_place`, `dest_person_relationship`, `pass_height`,  `pass_complexion`,  `pass_hair`,  `pass_eye`, `pass_identifying_marks`, `pass_bth_country`, `pass_bth_city`,  `id_pass_bth_place`,  `notes`) VALUES
(1, 'Advance',  NULL, 'Cristobal [Panama]', NULL, '1913-10-16', '1913-10-23', '2',  2,  'Burk', 'Cleveland',  23, NULL, 'm',  'm',  'carpenter',  'y',  'y',  'B.W.I.', 'African',  'Panama', 'Panama', NULL, NULL, 'Burk', 'Nathaniel',  NULL, 'brother',  'Panama', 'Panama City',  NULL, 'MA', 'Boston', NULL, 'y',  '1909', 4,  'MA', 'Boston', NULL, 'Camms?', 'A. J.',  NULL, 'MA', 'Boston', '112 Canal St.',  NULL, 'friend', 5.7,  'colored',  NULL, NULL, NULL, 'Barbados', 'Bridgetown', NULL, 'colored written as one word across 3 columns: complexion,  hair, eyes'),
(2, 'General G. W. Goethals', NULL, 'Cristoabl, C. Z.', NULL, '1918-08-13', '0000-00-00', '6',  4,  'Brown',  'Dudley', 26, NULL, 'm',  'm',  'clerk',  'y',  'y',  'Gt. Britain',  'African',  'Panama', 'Panama & Colon', NULL, 12, 'Brown',  'James',  NULL, 'father', 'Barbados', NULL, NULL, 'NY', 'New York', NULL, 'n',  '0000', NULL, NULL, NULL, NULL, 'Heubeck?', 'Joesph', NULL, 'NY', 'New York', '227 W. 63rd St.',  NULL, 'friend', 5.7,  'dk', 'dk', 'dk', NULL, 'Barbados', NULL, NULL, 'St. James typed: St. George '),
(3, 'Lennnjan?',  NULL, 'Barbados', NULL, '1905-05-14', '1905-05-20', '2',  7,  'Burke',  'Conrad Sarsfield', 20, 11, 'm',  's',  '[illegible]',  'y',  'y',  'British',  'West Indian',  'Barbados', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NY', 'Brooklyn', NULL, 'n',  '0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NY', 'Brooklyn', '944 Mary Ave', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'going home'),
(4, 'Pancras',  NULL, 'Barbados', NULL, '1914-05-22', '1914-05-29', '2',  29, 'Burke',  'Nathaniel',  30, NULL, 'm',  's',  'fireman',  'y',  'y',  'British',  'African',  NULL, NULL, NULL, NULL, 'Burke',  'Cecilia',  NULL, 'mother', 'Barbados', 'St. Helens', NULL, 'MA', 'Boston', NULL, 'n',  '0000', NULL, NULL, NULL, NULL, 'Burke',  'Cleveland',  NULL, 'MA', 'Boston', '142?A Harvard St.',  NULL, 'brother',  5.1,  'blk',  'blk',  'blk',  NULL, 'Barbados', NULL, NULL, ''),
(5, 'Thespis',  NULL, 'Barbados', NULL, '1913-04-16', '1913-04-23', '5',  22, 'Burke',  'Ada Kathleen', 12, NULL, 'f',  's',  'seamstress', 'y',  'y',  'Barbados', 'African',  'Barbados', NULL, NULL, NULL, 'Burke',  'James',  NULL, 'father', 'Barbados', NULL, NULL, 'NY', 'New York', NULL, 'n',  '0000', NULL, NULL, NULL, NULL, 'Burke',  'Matilda',  NULL, 'NY', 'New York', '300 W. 109th St.', NULL, 'sister', 5.6,  'colored',  'black',  'black',  NULL, 'Barbados', NULL, NULL, 'Adas age unclear on form'),
(7, 'Vandyck',  NULL, 'Barbados', NULL, '1924-12-09', '1924-12-15', '16', 2,  'Browne', 'Earl', 3,  NULL, 'm',  's',  'none', 'n',  'n',  'USA',  'West Indian',  'USA', NULL, NULL, NULL, 'Prince', 'Angeline', NULL, 'grandmother',  'Barbados', 'Good Intent',  NULL, 'NY', 'New York', NULL, 'y',  '1924', NULL, 'NY', 'New York', NULL, 'Browne', 'Dudley W.',  NULL, 'NY', 'New York', '114 W. 37th St.',  NULL, 'father', NULL, 'blk',  'blk',  'blk',  NULL, 'U.S.', 'New York', NULL, 'birth for previous years visit'),
(8, 'Vandyck',  NULL, 'Barbados', NULL, '1924-12-09', '1924-12-15', '16', 1,  'Browne', 'Mariam L.',  27, NULL, 'f',  'm',  'housewife',  'y',  'y',  'Gt. Britain',  'African',  'USA', NULL, NULL, NULL, 'Prince', 'Angeline', NULL, 'mother', 'Barbados', 'Good Intent',  NULL, 'NY', 'New York', NULL, 'y',  '1919', NULL, 'NY', 'New York', NULL, 'Browne', 'Dudley W.',  NULL, 'NY', 'New York', '114 W. 37th St.',  NULL, 'husband',  5.5,  'blk',  'blk',  'blk',  NULL, 'Barbados', NULL, NULL, 'intends permanent residence; prev visit 1919-1924'),
(6, 'unknown',  NULL, 'unknown',  NULL, '0000-00-00', '1918-11-09', '4',  25, 'Browne', 'Mariam L.',  21, NULL, 'f',  'm',  'seams',  'y',  'y',  'B.W.I.', 'African',  'Panama', 'C. Z.',  NULL, 4,  'Edwards',  'Marcus', NULL, 'father', 'Barbados', NULL, NULL, 'NY', 'New York', NULL, 'n',  '0000', NULL, NULL, NULL, NULL, 'Browne', 'Dudley W.',  NULL, 'NY', 'New York', '227 W. 63rd St.',  NULL, 'husband',  5.6,  'dk', 'dk', 'dk', NULL, 'Barbados', NULL, NULL, 'vessel,  origin, date of departure all unknown'),
(9, 'Vauban', NULL, 'Barbados', NULL, '1921-04-18', '1921-04-24', '7',  4,  'Browne', 'Dudley', 27, NULL, 'm',  'm',  'clerk',  'y',  'y',  'British',  'African',  'Barbados', NULL, NULL, NULL, 'Brown',  'James',  NULL, 'father', 'Barbados', NULL, NULL, 'NY', 'New York', NULL, 'y',  '1921-03-01', 3,  'NY', 'New York', NULL, 'Brown',  'Miriam', NULL, 'NY', 'New York', '114 W. 37th St.',  NULL, 'wife', 5.9,  'dk', 'bl', 'bl', 'Scar on left eye', 'Barbados', NULL, NULL, 'intends permanent residence; prev visit left Mar. 1921'),
(10,  'Vauban', NULL, 'Barbados', NULL, '1922-04-28', '1922-05-01', '7',  4,  'Browne', 'Earl', NULL, 8,  'm',  's',  'none', 'n',  'n',  'USA',  'African',  'Barbados', 'Bridgetown', NULL, NULL, 'Prince', 'Angeline', NULL, 'grandmother',  'Barbados', NULL, NULL, 'NY', 'New York', NULL, 'n',  '1922-03-04', NULL, NULL, NULL, NULL, 'Browne', 'Dudley W.',  NULL, 'NY', 'New York', '114 W. 37th St.',  NULL, 'father', NULL, 'dk', 'blk',  'brn',  NULL, 'U.S.', 'New York', NULL, 'U.S. born, son of Mariam & Dudley; prev visit 3-4-1922'),
(11,  'Vauban', NULL, 'Barbados', NULL, '1922-04-28', '1922-05-01', '7',  3,  'Browne', 'Mariam L.',  24, NULL, 'f',  'm',  'wife', 'y',  'y',  'Gt. Britain',  'African',  'Barbados', 'Bridgetown', NULL, NULL, 'Prince', 'Angeline', NULL, 'mother', 'Barbados', NULL, NULL, 'NY', 'New York', NULL, 'y',  '1918', 3,  'NY', 'New York', NULL, 'Browne', 'Dudley W.',  NULL, 'NY', 'New York', '114 W. 37th St.',  NULL, 'husband',  5.5,  'dk', 'blk',  'brn',  NULL, 'Barbados', NULL, NULL, 'previous visit 3 or 4 years (1918-1922)'),
(12,  'Vauban', NULL, 'Barbados', NULL, '1922-07-08', '1922-07-12', '6',  5,  'Codrington', 'Ashton', 19, NULL, 'm',  's',  'porter', 'y',  'y',  'Gt. Britain',  'African',  'Barbados', 'Bridgetown', NULL, NULL, 'Codrington', 'Ernest', NULL, 'father', 'Barbados', NULL, NULL, 'NY', 'New York', NULL, 'n',  '0000', NULL, NULL, NULL, NULL, 'Graham', 'Clarence', NULL, 'NY', 'New York', '114 W. 37th St.',  NULL, 'brother',  5.8,  'blk',  'blk',  'blk',  NULL, 'Barbados', NULL, NULL, ''),
(13,  'Colon',  NULL, 'Cristoabl, C. Z.', NULL, '1917-07-08', '1917-07-14', '1',  24, 'Beckles',  'Rosalie',  33, NULL, 'f',  'm',  'housewife',  'y',  'y',  'Barbados', 'African',  'Panama', 'Colon',  NULL, NULL, 'Brown',  'Joseph', NULL, 'father', 'Barbados', NULL, NULL, 'NY', 'New York', NULL, 'n',  '0000', NULL, 'NY', 'New York', NULL, 'Beckles',  'Joesph', NULL, 'NY', 'New York', '7 W. 137th St.', NULL, 'husband',  5.6,  'dk', 'br', 'br', NULL, 'Barbados', NULL, NULL, 'I believe St. Miguels should be St. Michael in Barbados'),
(14,  'Colon',  NULL, 'Cristoabl, C. Z.', NULL, '1916-11-08', '1916-11-14', '2',  12, 'Beckles',  'Joseph', 28, NULL, 'm',  'm',  'iron worker',  'y',  'y',  'Barbados', 'Negro',  'Panama', 'Colon',  NULL, NULL, 'Beckles',  NULL, NULL, 'wife', 'Panama', 'Colon',  NULL, 'NY', 'NYC',  NULL, 'n',  '0000', NULL, NULL, NULL, NULL, 'Beckles',  '?',  NULL, 'NY', 'NYC',  '27 or 37 W. 137th St.',  NULL, 'brother',  5.1,  'blk',  'blk',  'br', NULL, 'Barbados', NULL, NULL, ''),
(15,  'General G. W. Goethals', NULL, 'Cristoabl, C. Z.', NULL, '1918-10-30', '1918-11-04', '5',  7,  'Edwards',  'Vashti', 20, NULL, 'f',  's',  'teacher',  'y',  'y',  'B.W.I.', 'African',  'Barbados', NULL, NULL, 20, 'Edwards',  'Marcus', NULL, 'father', 'Barbados', NULL, NULL, 'NY', 'NYC',  NULL, 'n',  '0000', NULL, NULL, NULL, NULL, 'Beckles',  'Rosalie',  NULL, 'NY', 'NYC',  '227 W. 63rd St.',  NULL, 'sister', 5.25, 'dk', 'dk', 'dk', NULL, 'Barbados', NULL, NULL, '');


