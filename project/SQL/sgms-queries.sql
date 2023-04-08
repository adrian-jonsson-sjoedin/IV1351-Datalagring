-- total number of leasson each month per year
-- SELECT YEAR(time_start) AS year, DATE_FORMAT(time_start, '%M') AS month, COUNT(*) AS 'total_nr_of_lesson' FROM music_lesson WHERE YEAR(time_start) = '2023'
-- GROUP BY YEAR(time_start), DATE_FORMAT(time_start, '%M');

-- total number of lessons per year and month for each lesson type
-- This query is expected to be performed a few times per week.
-- Run with: SELECT * FROM lessons_per_month_year WHERE year = 2023;
DROP VIEW IF EXISTS  lessons_per_month_year;
CREATE VIEW lessons_per_month_year AS 
SELECT 
    MONTH(ml.time_start) AS month, 
    YEAR(ml.time_start) AS year,
    COUNT(il.music_lesson_id) AS individual_lessons,
    COUNT(gl.music_lesson_id) AS group_lessons,
    COUNT(e.music_lesson_id) AS ensembles,
    COUNT(*) AS total_available_lessons
FROM 
    music_lesson ml
LEFT JOIN 
    ensemble e ON ml.id = e.music_lesson_id
LEFT JOIN 
    group_lesson gl ON ml.id = gl.music_lesson_id
LEFT JOIN 
    individual_lesson il ON ml.id = il.music_lesson_id
    GROUP BY 
    MONTH(ml.time_start), 
    YEAR(ml.time_start);
    
  
-- Show how many students there are with no siblings, 1 sibling, 2 siblings etc.
-- This query is expected to be performed a few times per week
  -- i need to check how many students with different id have a parent_id that is the same
DROP VIEW IF EXISTS  siblings;
CREATE VIEW siblings AS 
SELECT
  id AS 'student_id',
  --   parent_id,
  (
    SELECT
      COUNT(*) -1
    FROM
      student b
    WHERE
      b.parent_id = a.parent_id
  ) AS 'has_x_sibling(s)'
FROM
  student a
ORDER BY
  id;
  
-- list of all instructors and how many lessons they had in the current month.
-- This gives me the booked lessons
SELECT music_lesson_id FROM group_lesson
UNION
SELECT music_lesson_id FROM individual_lesson
UNION
SELECT music_lesson_id FROM ensemble;

-- This gives me the booked lessons and the instructor id for the instructor holding it
SELECT m.id, m.instructor_id
FROM music_lesson m
JOIN (
  SELECT music_lesson_id FROM group_lesson
  UNION
  SELECT music_lesson_id FROM individual_lesson
  UNION
  SELECT music_lesson_id FROM ensemble
) t ON m.id = t.music_lesson_id;

-- List of all instructors who have given more than a specific nr of lessons during the current month. Sum all lessons and sort the reuslt by number of given lesson
-- This query will be executed daily
DROP VIEW IF EXISTS  workload;
CREATE VIEW workload AS 
SELECT *
FROM (
  SELECT
    DATE_FORMAT(music_lesson.time_start, '%M') AS month,
    instructor.employment_id,
    person.first_name,
    person.last_name,
    COUNT(*) AS total_number_of_lessons
  FROM
    music_lesson
    INNER JOIN instructor ON instructor.id = music_lesson.instructor_id
    INNER JOIN person ON instructor.person_id = person.id
  WHERE
    (music_lesson.id IN (SELECT music_lesson_id FROM group_lesson) OR
    music_lesson.id IN (SELECT music_lesson_id FROM individual_lesson) OR
    music_lesson.id IN (SELECT music_lesson_id FROM ensemble)) AND
    -- Replace 1 with MONTH(NOW()) if you want to see lessons for the current month. However the database only contains data for January
    MONTH(music_lesson.time_start) = 1 AND 
    YEAR(music_lesson.time_start) = YEAR(NOW())
  GROUP BY
    month,
    instructor.employment_id,
    person.first_name,
    person.last_name
) AS instructors
WHERE total_number_of_lessons > 1 -- CHANGE THIS TO CHANGE WHERE THE CUT OFF NUMBER IS
ORDER BY total_number_of_lessons DESC;
    
  -- List all ensembles held during the next week, sorted by music genre and weekday. 
  -- For each list if it's fully booked, has 1-2 spots left, or has more spots left
  -- No information of how often this query will be executed
DROP VIEW IF EXISTS  ensemble_spots;
CREATE VIEW ensemble_spots AS 
SELECT 
    WEEK(ml.time_start, 1) AS week_number,
    ml.time_start,
    g.genre,
    DATE_FORMAT(ml.time_start, '%a') AS weekday,
    e.maximum_number_of_students - COUNT(b.id) AS spots_left,
    CASE
        WHEN e.maximum_number_of_students - COUNT(b.id) = 0 THEN 'Fully booked'
        WHEN e.maximum_number_of_students - COUNT(b.id) <= 2 THEN '1-2 spots left'
        ELSE 'More spots left'
    END AS booking_status
FROM
    music_lesson ml
JOIN
    ensemble e ON ml.id = e.music_lesson_id
JOIN
    genre g ON e.genre_id = g.id
LEFT JOIN
    booking b ON ml.id = b.music_lesson_id
WHERE -- CHANGE LINE BELOWW FOR IT TO ALWAYS CHECK THE NEXT WEEK BASED ON THE CURRENT WEEK. HARDCODED DATE SINCE I DON'T HAVE DATA EXCEPT FOR WEEK 3
WEEK(ml.time_start) = 2 + 1 -- CHANGE 2 TO WEEK(NOW()). Only have data for week 3
GROUP BY
    ml.id
ORDER BY
    g.genre ASC, weekday DESC;