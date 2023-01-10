-- total number of leasson each month per year
-- SELECT YEAR(time_start) AS year, DATE_FORMAT(time_start, '%M') AS month, COUNT(*) AS 'total_nr_of_lesson' FROM music_lessons WHERE YEAR(time_start) = '2023'
-- GROUP BY YEAR(time_start), DATE_FORMAT(time_start, '%M');

-- total number of lessons per year and month for each lesson type
-- This query is expected to be performed a few times per week.
DROP VIEW IF EXISTS  lessons_per_month_year;
CREATE VIEW lessons_per_month_year AS 
SELECT
  YEAR(time_start) AS year,
  DATE_FORMAT(time_start, '%M') AS month,
  COUNT(*) AS 'total_nr_of_lessons',
  SUM(
    CASE
      WHEN lesson_type = 'individual' THEN 1
      ELSE 0
    END
  ) AS individual,
  SUM(
    CASE
      WHEN lesson_type = 'group' THEN 1
      ELSE 0
    END
  ) AS 'group',
  SUM(
    CASE
      WHEN lesson_type = 'ensemble' THEN 1
      ELSE 0
    END
  ) AS ensemble
FROM
  music_lessons
GROUP BY
  YEAR(time_start),
  DATE_FORMAT(time_start, '%M');
  
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
      students b
    WHERE
      b.parent_id = a.parent_id
  ) AS 'has_x_sibling(s)'
FROM
  students a
ORDER BY
  id;
  
-- list of all instructors and how many lessons they had in the current month.
SELECT
  instructor_id,
  DATE_FORMAT(time_start, '%M') AS month,
  COUNT(*) AS 'total_number_of_lessons'
FROM
  music_lessons
WHERE
  month(time_start) = month(now())
GROUP BY
  instructor_id,
  month
ORDER BY
  'total_number_of_lessons';
  
-- list of all instructors who have given more than a specific nr of lessons during the current month. Sum all lessons and sort the reuslt by number of given lesson
-- This query will be executed daily
DROP VIEW IF EXISTS  workload;
CREATE VIEW workload AS 
SELECT 
    *
FROM(
    SELECT
      DATE_FORMAT(music_lessons.time_start, '%M') AS month,
      instructors.employment_id,
      persons.first_name,
      persons.last_name,
      Count(*) as total_number_of_lessons
    FROM
      music_lessons
      INNER JOIN instructors ON instructors.id = music_lessons.instructor_id
      INNER JOIN persons ON instructors.person_id = persons.id
    WHERE
      MONTH(music_lessons.time_start) = MONTH(NOW())
    GROUP BY
      month,
      employment_id,
      persons.first_name,
      persons.last_name
    ORDER BY
      Count(*) DESC
  ) AS instructors;
    
-- SELECT * FROM workload   
-- WHERE
--   total_number_of_lessons > 6;
  
  
  -- List all ensembles held during the next week, sorted by music genre and weekday. 
  -- For each list if it's fully booked, has 1-2 spots left, or has more spots left
  -- No information of how often this query will be executed
DROP VIEW IF EXISTS  ensemble_spots;
CREATE VIEW ensemble_spots AS 
SELECT 
    ensemble.genre AS genre, 
    WEEK(music_lessons.time_start) AS week, 
    DATE_FORMAT(music_lessons.time_start, '%a') AS weekday, 
    CASE 
        WHEN music_lessons.numb_of_participants = ensemble.maximum_number_of_students THEN 'Full'
        WHEN (ensemble.maximum_number_of_students - music_lessons.numb_of_participants) = 1 THEN '1 spot left'
        WHEN (ensemble.maximum_number_of_students - music_lessons.numb_of_participants) = 2 THEN '2 spots left'
        ELSE '3 or more spots left'
    END AS spots_left
FROM ensemble
    INNER JOIN music_lessons ON music_lessons.id = ensemble.lesson_id 
WHERE WEEK(music_lessons.time_start) = WEEK(NOW())+1 -- Ensembles are scheduled in week 4 so set = 4 for testing
GROUP BY ensemble.genre, music_lessons.numb_of_participants, music_lessons.time_start, ensemble.maximum_number_of_students
ORDER BY weekday DESC;