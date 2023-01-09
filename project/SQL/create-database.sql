DROP DATABASE IF EXISTS sound_good_music_school;
CREATE DATABASE sound_good_music_school;
USE sound_good_music_school;
CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    city VARCHAR(50) NOT NULL
);
CREATE TABLE persons (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    person_number CHAR(12) UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    mobile_phone VARCHAR(20) UNIQUE,
    home_phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address_id INT
);
CREATE TABLE sound_good_music_school (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    available_spots INT NOT NULL,
    address_id INT
);
ALTER TABLE
  sound_good_music_school
ADD
  CONSTRAINT available_spots_positive CHECK (available_spots >= 0);
CREATE TABLE application_forms (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
    desired_instrument VARCHAR(100) NOT NULL,
    person_id INT NOT NULL,
    sgms_id INT NOT NULL
);
CREATE TABLE instructors (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    teaches_ensambles BIT(1) NOT NULL,
    employment_id INT NOT NULL UNIQUE,
    person_id INT NOT NULL
);
CREATE TABLE instrument_types (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100) NOT NULL UNIQUE,
    instructor_id INT
);
CREATE TABLE music_lessons (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    instructor_id INT NOT NULL,
    time_start TIMESTAMP NOT NULL,
    time_end TIMESTAMP NOT NULL,
    numb_of_participants INT,
    lesson_type ENUM('individual', 'group', 'ensemble') NOT NULL
);
ALTER TABLE
  music_lessons
ADD
  CONSTRAINT participants_not_negative CHECK (numb_of_participants >= 0);
CREATE TABLE parents (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL
);
CREATE TABLE pricing_scheme (
    sgms_id INT NOT NULL,
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
  CONSTRAINT PK_pricing_scheme PRIMARY KEY (sgms_id),
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
CREATE TABLE students (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    parent_id INT NOT NULL,
    instrument_quota INT NOT NULL,
    person_id INT NOT NULL,
    skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL
);
ALTER TABLE
  students
ADD
  CONSTRAINT quota_not_negative CHECK (instrument_quota >= 0);
CREATE TABLE bookings (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    instructor_id INT NOT NULL,
    student_id INT NOT NULL,
    lesson_type ENUM('individual', 'group', 'ensemble') NOT NULL,
    time_start TIMESTAMP NOT NULL,
    time_end TIMESTAMP NOT NULL
);
CREATE TABLE ensemble (
    lesson_id INT NOT NULL,
    minimum_number_of_students INT NOT NULL,
    maximum_number_of_students INT NOT NULL,
    skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
    genre VARCHAR(50) NOT NULL
);
ALTER TABLE
  ensemble
ADD
  CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id),
ADD
  CONSTRAINT ensemble_min_students_positive CHECK (minimum_number_of_students >= 0),
ADD
  CONSTRAINT ensemble_max_students_positive CHECK (maximum_number_of_students >= 0);
CREATE TABLE genres (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genre VARCHAR(100) NOT NULL UNIQUE,
    instructor_id INT
);
CREATE TABLE group_lessons (
    lesson_id INT NOT NULL,
    minimum_number_of_students INT NOT NULL,
    maximum_number_of_students INT NOT NULL,
    skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
    instrument_type VARCHAR(50) NOT NULL
);
ALTER TABLE
  group_lessons
ADD
  CONSTRAINT PK_group_lessons PRIMARY KEY (lesson_id),
ADD
  CONSTRAINT group_min_students_positive CHECK (minimum_number_of_students >= 0),
ADD
  CONSTRAINT group_max_students_positive CHECK (maximum_number_of_students >= 0);
CREATE TABLE individual_lesson (
    lesson_id INT NOT NULL,
    student_id INT NOT NULL,
    skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
    instrument_type VARCHAR(50)
);
ALTER TABLE
  individual_lesson
ADD
  CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);
CREATE TABLE instrument_inventory (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    total_quantity INT NOT NULL,
    in_stock INT NOT NULL,
    brand VARCHAR(50),
    instrument_type_id INT NOT NULL,
    renting_fee DECIMAL(7 , 2 ) NOT NULL
);
ALTER TABLE
  instrument_inventory
ADD
  CONSTRAINT total_quantity_positive CHECK (total_quantity >= 0),
ADD
  CONSTRAINT stock_positive CHECK (in_stock >= 0),
ADD
  CONSTRAINT renting_fee_positive CHECK (renting_fee >= 0);
CREATE TABLE lease_contracts (
    student_id INT NOT NULL,
    id INT NOT NULL AUTO_INCREMENT,
    start_rent_period TIMESTAMP NOT NULL,
    end_rent_period TIMESTAMP NOT NULL,
    inventory_id INT NOT NULL,
    PRIMARY KEY (student_id , id)
)  ENGINE=MYISAM;
CREATE TABLE monthly_lessons (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    group_lessons INT,
    ensemble_lessons INT,
    individual_lessons INT,
    student_id INT,
    month DATE NOT NULL,
    instructor_id INT
);
ALTER TABLE
  monthly_lessons
ADD
  CONSTRAINT gl_positive CHECK (group_lessons >= 0),
ADD
  CONSTRAINT el_positive CHECK (ensemble_lessons >= 0),
ADD
  CONSTRAINT il_positive CHECK (individual_lessons >= 0);
ALTER TABLE
  persons
ADD
  CONSTRAINT FK_persons_0 FOREIGN KEY (address_id) REFERENCES addresses (id);
ALTER TABLE
  sound_good_music_school
ADD
  CONSTRAINT FK_sound_good_music_school_0 FOREIGN KEY (address_id) REFERENCES addresses (id);
ALTER TABLE
  application_forms
ADD
  CONSTRAINT FK_application_forms_0 FOREIGN KEY (person_id) REFERENCES persons (id);
ALTER TABLE
  application_forms
ADD
  CONSTRAINT FK_application_forms_1 FOREIGN KEY (sgms_id) REFERENCES sound_good_music_school (id);
ALTER TABLE
  instructors
ADD
  CONSTRAINT FK_instructors_0 FOREIGN KEY (person_id) REFERENCES persons (id);
ALTER TABLE
  instrument_types
ADD
  CONSTRAINT FK_instrument_types_0 FOREIGN KEY (instructor_id) REFERENCES instructors (id);
ALTER TABLE
  music_lessons
ADD
  CONSTRAINT FK_music_lessons_0 FOREIGN KEY (instructor_id) REFERENCES instructors (id);
ALTER TABLE
  parents
ADD
  CONSTRAINT FK_parents_0 FOREIGN KEY (person_id) REFERENCES persons (id);
ALTER TABLE
  pricing_scheme
ADD
  CONSTRAINT FK_pricing_scheme_0 FOREIGN KEY (sgms_id) REFERENCES sound_good_music_school (id);
ALTER TABLE
  students
ADD
  CONSTRAINT FK_students_0 FOREIGN KEY (parent_id) REFERENCES parents (id);
ALTER TABLE
  students
ADD
  CONSTRAINT FK_students_1 FOREIGN KEY (person_id) REFERENCES persons (id);
ALTER TABLE
  bookings
ADD
  CONSTRAINT FK_bookings_0 FOREIGN KEY (instructor_id) REFERENCES instructors (id);
ALTER TABLE
  bookings
ADD
  CONSTRAINT FK_bookings_1 FOREIGN KEY (student_id) REFERENCES students (id);
ALTER TABLE
  ensemble
ADD
  CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES music_lessons (id);
ALTER TABLE
  genres
ADD
  CONSTRAINT FK_genres_0 FOREIGN KEY (instructor_id) REFERENCES instructors (id);
ALTER TABLE
  group_lessons
ADD
  CONSTRAINT FK_group_lessons_0 FOREIGN KEY (lesson_id) REFERENCES music_lessons (id);
ALTER TABLE
  individual_lesson
ADD
  CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES music_lessons (id);
ALTER TABLE
  individual_lesson
ADD
  CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (student_id) REFERENCES students (id);
ALTER TABLE
  instrument_inventory
ADD
  CONSTRAINT FK_instrument_inventory_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_types (id);
ALTER TABLE
  lease_contracts
ADD
  CONSTRAINT FK_lease_contracts_0 FOREIGN KEY (student_id) REFERENCES students (id);
ALTER TABLE
  lease_contracts
ADD
  CONSTRAINT FK_lease_contracts_1 FOREIGN KEY (inventory_id) REFERENCES instrument_inventory (id);
ALTER TABLE
  monthly_lessons
ADD
  CONSTRAINT FK_monthly_lessons_0 FOREIGN KEY (student_id) REFERENCES students (id);
ALTER TABLE
  monthly_lessons
ADD
  CONSTRAINT FK_monthly_lessons_1 FOREIGN KEY (instructor_id) REFERENCES instructors (id);