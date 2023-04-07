DROP DATABASE IF EXISTS sound_good_music_school;
CREATE DATABASE sound_good_music_school;
USE sound_good_music_school;
CREATE TABLE address (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL
);
CREATE TABLE person (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    person_number CHAR(12) UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    mobile_phone VARCHAR(20) UNIQUE,
    home_phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(id)
);
CREATE TABLE sound_good_music_school (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    available_spots INT NOT NULL,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(id)
);
ALTER TABLE
  sound_good_music_school
ADD
  CONSTRAINT available_spots_positive CHECK (available_spots >= 0);
CREATE TABLE application_form (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
    desired_instrument VARCHAR(100) NOT NULL,
    person_id INT NOT NULL,
    sgms_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (sgms_id) REFERENCES sound_good_music_school(id)
);
CREATE TABLE instructor (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    teaches_ensambles BIT(1) NOT NULL,
    employment_id INT NOT NULL UNIQUE,
    person_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id)
);
CREATE TABLE instrument_type (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100) NOT NULL UNIQUE,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructor(id)
);
CREATE TABLE music_lesson (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    time_start TIMESTAMP NOT NULL,
    time_end TIMESTAMP NOT NULL,
    skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
    instructor_id INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES instructor(id)
);
CREATE TABLE parent (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id)
);
CREATE TABLE pricing_scheme (
    group_lesson_price DECIMAL(7 , 2 ) NOT NULL,
    ensemble_lesson_price DECIMAL(7 , 2 ) NOT NULL,
    individual_lesson_price DECIMAL(7 , 2 ) NOT NULL,
    beginner_level_surcharge DECIMAL(7 , 2 ) NOT NULL,
    intermediate_level_surcharge DECIMAL(7 , 2 ) NOT NULL,
    advanced_level_surcharge DECIMAL(7 , 2 ) NOT NULL,
    discount_rate DECIMAL(3 , 2 ) NOT NULL
);
ALTER TABLE
  pricing_scheme
ADD
  CONSTRAINT gl_price_positive CHECK (group_lesson_price >= 0),
ADD
  CONSTRAINT el_price_positive CHECK (ensemble_lesson_price >= 0),
ADD
  CONSTRAINT il_price_positive CHECK (individual_lesson_price >= 0),
ADD
  CONSTRAINT bl_surcharge_positive CHECK (beginner_level_surcharge >= 0),
ADD
  CONSTRAINT il_surcharge_positive CHECK (intermediate_level_surcharge >= 0),
ADD
  CONSTRAINT al_surcharge_positive CHECK (advanced_level_surcharge >= 0);
CREATE TABLE student (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    parent_id INT NOT NULL,
    instrument_quota INT NOT NULL,
    person_id INT NOT NULL,
    skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES parent(id),
    FOREIGN KEY (person_id) REFERENCES person(id)
);
ALTER TABLE
  student
ADD
  CONSTRAINT quota_not_negative CHECK (instrument_quota >= 0);
CREATE TABLE booking (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    time_start TIMESTAMP NOT NULL,
    time_end TIMESTAMP NOT NULL,
    music_lesson_id INT NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (music_lesson_id) REFERENCES music_lesson(id),
    FOREIGN KEY (student_id) REFERENCES student(id)
);
CREATE TABLE genre (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genre VARCHAR(100) NOT NULL UNIQUE,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructor(id)
);
CREATE TABLE ensemble (
    music_lesson_id INT NOT NULL,
    minimum_number_of_students INT NOT NULL,
    maximum_number_of_students INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (genre_id) REFERENCES genre(id)
);
ALTER TABLE
  ensemble
ADD
  CONSTRAINT PK_ensemble PRIMARY KEY (music_lesson_id),
ADD
  CONSTRAINT ensemble_min_students_positive CHECK (minimum_number_of_students >= 0),
ADD
  CONSTRAINT ensemble_max_students_positive CHECK (maximum_number_of_students >= 0);

CREATE TABLE group_lesson (
    music_lesson_id INT NOT NULL,
    minimum_number_of_students INT NOT NULL,
    maximum_number_of_students INT NOT NULL,
    instrument_type_id INT NOT NULL,
    FOREIGN KEY (instrument_type_id) REFERENCES instrument_type(id)
);
ALTER TABLE
  group_lesson
ADD
  CONSTRAINT PK_group_lessons PRIMARY KEY (music_lesson_id),
ADD
  CONSTRAINT group_min_students_positive CHECK (minimum_number_of_students >= 0),
ADD
  CONSTRAINT group_max_students_positive CHECK (maximum_number_of_students >= 0);
CREATE TABLE individual_lesson (
    music_lesson_id INT NOT NULL,
    instrument_type_id INT NOT NULL,
    FOREIGN KEY (instrument_type_id) REFERENCES instrument_type(id)
);
ALTER TABLE
  individual_lesson
ADD
  CONSTRAINT PK_individual_lesson PRIMARY KEY (music_lesson_id);
CREATE TABLE instrument_inventory (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    total_quantity INT NOT NULL,
    in_stock INT NOT NULL,
    brand VARCHAR(50),
    instrument_type_id INT NOT NULL,
    renting_fee DECIMAL(7 , 2 ) NOT NULL,
    FOREIGN KEY (instrument_type_id) REFERENCES instrument_type(id)
);
ALTER TABLE
  instrument_inventory
ADD
  CONSTRAINT total_quantity_positive CHECK (total_quantity >= 0),
ADD
  CONSTRAINT stock_positive CHECK (in_stock >= 0),
ADD
  CONSTRAINT renting_fee_positive CHECK (renting_fee >= 0);
CREATE TABLE lease_contract (
    student_id INT NOT NULL,
    id INT NOT NULL AUTO_INCREMENT,
    start_rent_period TIMESTAMP NOT NULL,
    end_rent_period TIMESTAMP NOT NULL,
    inventory_id INT NOT NULL,
    PRIMARY KEY (student_id , id),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (inventory_id) REFERENCES instrument_inventory(id)
)  ENGINE=MYISAM;
-- This table is not needed since it is derived data 
-- CREATE TABLE monthly_lessons (
--     id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     group_lessons INT,
--     ensemble_lessons INT,
--     individual_lessons INT,
--     student_id INT,
--     month DATE NOT NULL,
--     instructor_id INT
-- );
-- ALTER TABLE
--   monthly_lessons
-- ADD
--   CONSTRAINT gl_positive CHECK (group_lessons >= 0),
-- ADD
--   CONSTRAINT el_positive CHECK (ensemble_lessons >= 0),
-- ADD
 --  CONSTRAINT il_positive CHECK (individual_lessons >= 0);

-- ALTER TABLE
--   monthly_lessons
-- ADD
--   CONSTRAINT FK_monthly_lessons_0 FOREIGN KEY (student_id) REFERENCES students (id);
-- ALTER TABLE
--   monthly_lessons
-- ADD
--   CONSTRAINT FK_monthly_lessons_1 FOREIGN KEY (instructor_id) REFERENCES instructors (id);