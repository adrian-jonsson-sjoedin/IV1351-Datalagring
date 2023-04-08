-- Delete all rows in all tables when importing file for easier development
-- DELETE FROM
--   sound_good_music_school;
-- DELETE FROM
--   address;
-- DELETE FROM
--   application_form;
-- DELETE FROM
--   booking;
-- DELETE FROM
--   ensemble;
-- DELETE FROM
--   genre;
-- DELETE FROM
--   group_lesson;
-- DELETE FROM
--   individual_lesson;
-- DELETE FROM
--   instructor;
-- DELETE FROM
--   instrument_inventory;
-- DELETE FROM
--   instrument_type;
-- DELETE FROM
--   lease_contract;
-- DELETE FROM
--   music_lesson;
-- DELETE FROM
--   parent;
-- DELETE FROM
--   person;
-- DELETE FROM
--   pricing_scheme;
-- DELETE FROM
--   student;
-- ------------------------------------------------------------------------------
  -- ----------- Tables involving the human actors in the model -------------------
  -- ------------------------------------------------------------------------------

INSERT INTO
  `address` (`street`, `zip`, `city`)
VALUES
  ("Ap #865-9831 Lacus. Avenue", "10692","Linköping"),
  ("9680 Elit, Road", "61562", "Mjölby"),
  ("784-6255 Tincidunt St.", "63876", "Avesta"),
  ("3418 Nulla Avenue", "42334", "Hudiksvall"),
  ("Ap #941-9878 Aenean Rd.", "10398", "Söderhamn"),
  ("Ap #452-4803 Mus. St.", "11776", "Trollhättan"),
  ("215-3895 Ridiculus Rd.", "47855", "Vänersborg"),
  ("393 Ligula. Street", "28114", "Vetlanda"),
  ("5113 Id Road", "90065", "Värnamo"),
  ("201-7469 Amet, Av.", "05812", "Söderhamn"),
  ("Ap #920-9559 Eleifend Avenue", "52034", "Hofors"),
  ("297-9511 Mi Rd.", "97774", "Tranås"),
  ("Ap #946-8820 Morbi St.", "67167", "Vetlanda"),
  ("466-7312 Quis St.", "67058", "Falun"),
  ("992-887 Felis, St.", "47654", "Motala"),
  ("2833 Rutrum, St.", "53189", "Värnamo");
  -- Soundgood music school
INSERT INTO
  sound_good_music_school (available_spots, address_id)
VALUES
  (
    25,
    (
      SELECT
        id
      FROM
        address
      where
        street = 'Ap #865-9831 Lacus. Avenue'
        AND zip = '10692'
    )
  );
-- Personal data
INSERT INTO
  person (
    person_number,
    first_name,
    last_name,
    mobile_phone,
    home_phone,
    email,
    address_id
  ) -- Parrent
VALUES
  (
    197349179540,
    "Leandra",
    "Mercado",
    "+32 77  641 62 92",
    "+99 27 060 19 94",
    "id@protonmail.org",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '9680 Elit, Road'
    )
  ),
  -- Parent
  (
    196164739316,
    "Genevieve",
    "Roach",
    "+72 15  827 38 87",
    "+99 47 050 16 47",
    "euismod.et@icloud.se",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '3418 Nulla Avenue'
    )
  ),
  -- Parent
  (
    201243299178,
    "Keiko",
    "Berg",
    "+09 25  747 70 32",
    "+54 10 585 14 80",
    "morbi.neque@icloud.org",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '784-6255 Tincidunt St.'
    )
  ),
  -- Parent
  (
    198582732654,
    "Mechelle",
    "Lee",
    "+57 46  571 78 32",
    "+83 85 263 22 28",
    "pellentesque.massa@aol.net",(
      SELECT
        id
      FROM
        address
      WHERE
        street = 'Ap #941-9878 Aenean Rd.'
    )
  ),
  -- Parent
  (
    199117329906,
    "Isabelle",
    "Campos",
    "+79 38  856 75 70",
    "(12) 086 50",
    "arcu.morbi@google.ca",(
      SELECT
        id
      FROM
        address
      WHERE
        street = 'Ap #452-4803 Mus. St.'
    )
  ),
  -- Parent
  (
    201423094880,
    "Whoopi",
    "Mathis",
    "+42 87  052 52 12",
    "(67) 165 58",
    "ullamcorper.duis@yahoo.ca",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '393 Ligula. Street'
    )
  ),
  -- Child
  (
    195819737313,
    "Zelenia",
    "Wynn",
    "+27 89  465 62 15",
    "+43 57 545 57 82",
    "nulla.cras@icloud.se",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '9680 Elit, Road'
    )
  ),
  -- Child
  (
    195367418395,
    "Vanna",
    "Roberson",
    "+23 88  476 06 83",
    "+72 74 937 68 07",
    "tellus.imperdiet@aol.net",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '9680 Elit, Road'
    )
  ),
  -- Child
  (
    196163772791,
    "Indira",
    "Benjamin",
    "+65 79  876 78 88",
    "+26 78 215 22 62",
    "nonummy.fusce.fermentum@protonmail.com",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '784-6255 Tincidunt St.'
    )
  ),
  -- Child
  (
    199839379376,
    "Thor",
    "Baxter",
    "+56 66  137 69 53",
    "(45) 769 13",
    "nisl.sem@yahoo.org",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '9680 Elit, Road'
    )
  ),
  -- Child
  (
    199266807638,
    "Fulton",
    "Walter",
    "+78 12  294 76 14",
    "+82 11 453 88 81",
    "nibh.dolor@aol.couk",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '3418 Nulla Avenue'
    )
  ),
  -- Child
  (
    199938380350,
    "Riley",
    "Barrera",
    "+31 62  414 45 39",
    "(33) 856 31",
    "eros@hotmail.se",(
      SELECT
        id
      FROM
        address
      WHERE
        street = 'Ap #941-9878 Aenean Rd.'
    )
  ),
  -- Child
  (
    198617719937,
    "Courtney",
    "Mercer",
    "+83 85  503 27 33",
    "(22) 413 02",
    "interdum.curabitur@protonmail.couk",(
      SELECT
        id
      FROM
        address
      WHERE
        street = 'Ap #452-4803 Mus. St.'
    )
  ),
  -- Child
  (
    197275573864,
    "Nadine",
    "Griffin",
    "+60 55  528 46 28",
    "+34 36 296 52 13",
    "eu.tellus@outlook.net",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '393 Ligula. Street'
    )
  ),
  -- Instructor
  (
    198922168269,
    "Angelica",
    "Aguirre",
    "+62 83  580 37 77",
    "(28) 753 76",
    "aenean.sed@google.net",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '5113 Id Road'
    )
  ),
  -- Instructor
  (
    196912026969,
    "Angelica",
    "Smith",
    "+62 87  581 37 77",
    "(28) 753 76",
    "aenean69@google.net",(
      SELECT
        id
      FROM
        address
      WHERE
        street = '201-7469 Amet, Av.'
    )
  );
-- Instructors
INSERT INTO
  instructor (
    teaches_ensambles,
    employment_id,
    person_id
  )
VALUES
  (
    FALSE,
    1,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 198922168269
    )
  ),
  (
    TRUE,
    2,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 196912026969
    )
  );
-- Parents
INSERT INTO
  parent (person_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 197349179540
    )
  ),
  (
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 196164739316
    )
  ),
  (
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 201243299178
    )
  ),
  (
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 198582732654
    )
  ),
  (
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 199117329906
    )
  ),
  (
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 201423094880
    )
  );
-- Students
INSERT INTO
  student (
    instrument_quota,
    person_id,
    parent_id,
    skill_level
  )
VALUES
  (
    2,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 197275573864
    ),
    (
      SELECT
        id
      FROM
        parent
      WHERE
        person_id = (
          SELECT
            id
          FROM
            person
          WHERE
            person_number = 201423094880
        )
    ),
    'beginner'
  ),
  (
    1,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 195819737313
    ),
    (
      SELECT
        id
      FROM
        parent
      WHERE
        person_id = (
          SELECT
            id
          FROM
            person
          WHERE
            person_number = 197349179540
        )
    ),
    'beginner'
  ),
  (
    0,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 195367418395
    ),
    (
      SELECT
        id
      FROM
        parent
      WHERE
        person_id = (
          SELECT
            id
          FROM
            person
          WHERE
            person_number = 197349179540
        )
    ),
    'intermediate'
  ),
  (
    0,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 196163772791
    ),
    (
      SELECT
        id
      FROM
        parent
      WHERE
        person_id = (
          SELECT
            id
          FROM
            person
          WHERE
            person_number = 201243299178
        )
    ),
    'advanced'
  ),
  (
    1,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 199839379376
    ),
    (
      SELECT
        id
      FROM
        parent
      WHERE
        person_id = (
          SELECT
            id
          FROM
            person
          WHERE
            person_number = 197349179540
        )
    ),
    'intermediate'
  ),
  (
    1,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 199266807638
    ),
    (
      SELECT
        id
      FROM
        parent
      WHERE
        person_id = (
          SELECT
            id
          FROM
            person
          WHERE
            person_number = 196164739316
        )
    ),
    'beginner'
  ),
  (
    2,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 199938380350
    ),
    (
      SELECT
        id
      FROM
        parent
      WHERE
        person_id = (
          SELECT
            id
          FROM
            person
          WHERE
            person_number = 198582732654
        )
    ),
    'advanced'
  ),
  (
    1,
    (
      SELECT
        id
      FROM
        person
      WHERE
        person_number = 198617719937
    ),
    (
      SELECT
        id
      FROM
        parent
      WHERE
        person_id = (
          SELECT
            id
          FROM
            person
          WHERE
            person_number = 199117329906
        )
    ),
    'intermediate'
  );
-- -----------------------------------------------------------------------------
  -- ---------------- Tables for the objects in the model -------------------------
  -- ------------------------------------------------------------------------------
  -- Instrument Types
INSERT INTO
  instrument_type (type, instructor_id)
VALUES
  (
    'piano',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 1
    )
  ),
  (
    'bass',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 1
    )
  ),
  (
    'guitar',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 1
    )
  ),
  (
    'cello',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 1
    )
  ),
  (
    'drums',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 2
    )
  ),
  (
    'violin',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 2
    )
  ),
  (
    'saxophone',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 2
    )
  );
INSERT INTO
  instrument_type (type)
VALUES
  ('bagpipe'),
  ('trumpet');
-- Genres
INSERT INTO
  genre (genre, instructor_id)
VALUES
  (
    'rock',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 1
    )
  ),
  (
    'punk',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 1
    )
  ),
  (
    'classical',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 2
    )
  ),
  (
    'jazz',
    (
      SELECT
        id
      FROM
        instructor
      WHERE
        employment_id = 2
    )
  );
-- Instrument Inventory
INSERT INTO
  instrument_inventory (
    total_quantity,
    in_stock,
    brand,
    instrument_type_id,
    renting_fee
  )
VALUES
  (
    2,
    2,
    'Yamaha',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'piano'
    ),
    349.95
  ),
  (
    5,
    4,
    'Fender',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'bass'
    ),
    199.95
  ),
  (
    5,
    3,
    'Les Paul',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'guitar'
    ),
    149.95
  ),
  (
    2,
    1,
    'Eastman Strings',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'cello'
    ),
    245.45
  ),
  (
    1,
    0,
    'Tama',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'drums'
    ),
    349.95
  ),
  (
    2,
    1,
    'Eastman Strings',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'violin'
    ),
    245.45
  ),
  (
    2,
    1,
    'Yamaha',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'saxophone'
    ),
    199.95
  ),
  (
    1,
    1,
    'McCallum',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'bagpipe'
    ),
    149.95
  ),
  (
    2,
    1,
    'Yamaha',
    (
      SELECT
        id
      FROM
        instrument_type
      WHERE
        type = 'trumpet'
    ),
    199.95
  );
-- Pricing scheme
INSERT INTO
  pricing_scheme (
    group_lesson_price,
    ensemble_lesson_price,
    individual_lesson_price,
    beginner_level_surcharge,
    intermediate_level_surcharge,
    advanced_level_surcharge,
    discount_rate
  )
VALUES
  (
    110.00,
    150.00,
    220.00,
    0.00,
    25.00,
    50.00,
    0.75
  );
-- Music lesson
INSERT INTO 
music_lesson(
time_start,
time_end,
skill_level,
instructor_id,
lesson_type
)
VALUES
('2023-01-17 14:00', '2023-01-17 15:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-17 15:00', '2023-01-17 16:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-17 16:00', '2023-01-17 17:00', 'intermediate', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-17 17:00', '2023-01-17 18:00', 'advanced', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-17 14:00', '2023-01-17 15:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 2), 'group'),
('2023-01-17 15:00', '2023-01-17 16:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 2), 'group'),
('2023-01-17 16:00', '2023-01-17 17:00', 'intermediate', (SELECT id FROM instructor WHERE employment_id = 2), 'ensemble'),
('2023-01-17 17:00', '2023-01-17 18:00', 'advanced', (SELECT id FROM instructor WHERE employment_id = 2), 'ensemble'),

('2023-01-18 14:00', '2023-01-18 15:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-18 15:00', '2023-01-18 16:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-18 16:00', '2023-01-18 17:00', 'intermediate', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-18 17:00', '2023-01-18 18:00', 'advanced', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-18 14:00', '2023-01-18 15:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 2), 'group'),
('2023-01-18 15:00', '2023-01-18 16:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 2), 'group'),
('2023-01-18 16:00', '2023-01-18 17:00', 'intermediate', (SELECT id FROM instructor WHERE employment_id = 2), 'ensemble'),
('2023-01-18 17:00', '2023-01-18 18:00', 'advanced', (SELECT id FROM instructor WHERE employment_id = 2), 'ensemble'),

('2023-01-19 14:00', '2023-01-19 15:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-19 15:00', '2023-01-19 16:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-19 16:00', '2023-01-19 17:00', 'intermediate', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-19 17:00', '2023-01-19 18:00', 'advanced', (SELECT id FROM instructor WHERE employment_id = 1), 'individual'),
('2023-01-19 14:00', '2023-01-19 15:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 2), 'group'),
('2023-01-19 15:00', '2023-01-19 16:00', 'beginner', (SELECT id FROM instructor WHERE employment_id = 2), 'group'),
('2023-01-19 16:00', '2023-01-19 17:00', 'intermediate', (SELECT id FROM instructor WHERE employment_id = 2), 'ensemble'),
('2023-01-19 17:00', '2023-01-19 18:00', 'advanced', (SELECT id FROM instructor WHERE employment_id = 2), 'ensemble');

-- Bookings
INSERT INTO
  booking (
    time_start,
    time_end,
    music_lesson_id,
    student_id
  )
VALUES
('2023-01-17 14:00', 
'2023-01-17 15:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-17 14:00' AND skill_level = 'beginner' AND instructor_id = (SELECT id FROM instructor where employment_id = 1)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 197275573864))), -- individual

('2023-01-17 15:00', 
'2023-01-17 16:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-17 15:00' AND skill_level = 'beginner' AND instructor_id = (SELECT id FROM instructor where employment_id = 1)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 195819737313))), -- individual

('2023-01-17 15:00', 
'2023-01-17 16:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-17 15:00' AND skill_level = 'beginner' AND instructor_id = (SELECT id FROM instructor where employment_id = 2)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 199266807638))), -- group

('2023-01-18 16:00', 
'2023-01-18 17:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-18 16:00' AND skill_level = 'intermediate' AND instructor_id = (SELECT id FROM instructor where employment_id = 2)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 195367418395))), -- ensemble

('2023-01-18 16:00', 
'2023-01-18 17:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-18 16:00' AND skill_level = 'intermediate' AND instructor_id = (SELECT id FROM instructor where employment_id = 2)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 199839379376))), -- ensemble

('2023-01-17 17:00', 
'2023-01-17 18:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-17 17:00' AND skill_level = 'advanced' AND instructor_id = (SELECT id FROM instructor where employment_id = 1)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 196163772791))), -- individual

('2023-01-18 17:00', 
'2023-01-18 18:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-18 17:00' AND skill_level = 'advanced' AND instructor_id = (SELECT id FROM instructor where employment_id = 1)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 199938380350))), -- individual

('2023-01-18 16:00', 
'2023-01-18 17:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-18 16:00' AND skill_level = 'intermediate' AND instructor_id = (SELECT id FROM instructor where employment_id = 2)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 198617719937))), -- ensemble

('2023-01-17 15:00', 
'2023-01-17 16:00', 
(SELECT id FROM music_lesson WHERE time_start = '2023-01-17 15:00' AND skill_level = 'beginner' AND instructor_id = (SELECT id FROM instructor where employment_id = 2)),
(SELECT id FROM student WHERE person_id = (SELECT id FROM person WHERE person_number = 197275573864))); -- group

-- Individual Lessons 
INSERT INTO 
    individual_lesson(
    music_lesson_id,
    instrument_type_id
    )
VALUES
((SELECT id FROM music_lesson WHERE time_start = '2023-01-17 14:00' AND instructor_id = 1),(SELECT id FROM instrument_type WHERE type = 'piano')),

((SELECT id FROM music_lesson WHERE time_start = '2023-01-17 15:00:00' AND instructor_id = 1),(SELECT id FROM instrument_type WHERE type = 'piano')),

((SELECT id FROM music_lesson WHERE time_start = '2023-01-17 17:00' AND instructor_id = 1),(SELECT id FROM instrument_type WHERE type = 'piano')),

((SELECT id FROM music_lesson WHERE time_start = '2023-01-18 17:00' AND instructor_id = 1),(SELECT id FROM instrument_type WHERE type = 'piano'));

-- Group Lessons 
INSERT INTO
  group_lesson (
    music_lesson_id,
    minimum_number_of_students,
    maximum_number_of_students,
    instrument_type_id
  )
VALUES
    ((SELECT id FROM music_lesson WHERE time_start = '2023-01-17 15:00' AND instructor_id = 2), 2, 4, (SELECT id FROM instrument_type WHERE type = 'violin')); -- 2 students

-- ensemble
INSERT INTO
  ensemble (
    music_lesson_id,
    genre_id
  )
VALUES
    ((SELECT id FROM music_lesson WHERE time_start = '2023-01-17 16:00' AND instructor_id = 2), (SELECT id FROM genre WHERE genre = 'jazz')),
    ((SELECT id FROM music_lesson WHERE time_start = '2023-01-17 17:00' AND instructor_id = 2), (SELECT id FROM genre WHERE genre = 'jazz')),
    ((SELECT id FROM music_lesson WHERE time_start = '2023-01-18 16:00' AND instructor_id = 2), (SELECT id FROM genre WHERE genre = 'classical')), -- 3 students
    ((SELECT id FROM music_lesson WHERE time_start = '2023-01-18 17:00' AND instructor_id = 2), (SELECT id FROM genre WHERE genre = 'classical')),
    ((SELECT id FROM music_lesson WHERE time_start = '2023-01-19 16:00' AND instructor_id = 2), (SELECT id FROM genre WHERE genre = 'jazz')),
    ((SELECT id FROM music_lesson WHERE time_start = '2023-01-19 17:00' AND instructor_id = 2), (SELECT id FROM genre WHERE genre = 'jazz')); 
    