--Basic table required to perform operations

-- Query:
CREATE TABLE students_grades (
    student_id VARCHAR PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    gender VARCHAR,
    age INTEGER,
    department VARCHAR,
    attendance_percent NUMERIC,
    midterm_score NUMERIC,
    final_score NUMERIC,
    assignments_avg NUMERIC,
    quizzes_avg NUMERIC,
    participation_score NUMERIC,
    projects_score NUMERIC,
    total_score NUMERIC,
    grade VARCHAR(2),
    study_hours_per_week NUMERIC,
    extracurricular_activities BOOLEAN,
    internet_access_at_home BOOLEAN,
    parent_education_level VARCHAR,
    family_income_level VARCHAR,
    stress_level INTEGER,
    sleep_hours_per_night NUMERIC
);
-- Output:
CREATE TABLE


-- populating the table with data 
-- Query:
\COPY students_grades FROM 'desktop/dataset/Students_Grading_Dataset_Biased.csv' DELIMITER ',' CSV HEADER;
-- output:
COPY 5000




Problem Statement 1: Reduce stress for students with poor sleep (<6 hours) by adding 1 hour
-- Query:
BEGIN;
UPDATE students_grades
SET sleep_hours_per_night = sleep_hours_per_night + 1
WHERE sleep_hours_per_night < 6;
COMMIT;
-- Output:
BEGIN
UPDATE 1954
COMMIT



Problem Statement 2 : Give scholarships (bonus points) to low-income students with good performance
-- Query:
BEGIN;
UPDATE students_grades
SET total_score = total_score + 5
WHERE family_income_level = 'Low' AND total_score >= 85;
COMMIT;
-- Output:
BEGIN
UPDATE 610
COMMIT



Problem Statement 3: Insert one valid and one faulty student, rollback only the second
-- Query:
BEGIN;

INSERT INTO students_grades (student_id, first_name)
VALUES ('S2003', 'Good');

SAVEPOINT after_valid;

-- Faulty insert (duplicate id)
INSERT INTO students_grades (student_id, first_name)
VALUES ('S2003', 'Duplicate');

ROLLBACK TO SAVEPOINT after_valid;
COMMIT;

-- Output:
BEGIN
INSERT 0 1
SAVEPOINT
ROLLBACK
COMMIT



Problem Statement 4: Reduce stress by 2 points for students in extracurriculars
-- Query:
BEGIN;
UPDATE students_grades
SET stress_level = GREATEST(stress_level - 2, 0)
WHERE extracurricular_activities = true;
COMMIT;
-- Output:
BEGIN
UPDATE 1507
COMMIT



Problem Statement 5: Reset all scores to 0 for students who have dropped out (attendance = 0)
-- Query:
BEGIN;
UPDATE students_grades
SET midterm_score = 0,
    final_score = 0,
    assignments_avg = 0,
    quizzes_avg = 0,
    participation_score = 0,
    projects_score = 0,
    total_score = 0,
    grade = 'F'
WHERE attendance_percent = 0;
COMMIT;
-- Output:
BEGIN
UPDATE 0
COMMIT



Problem Statement 6: Promote the top 5 students per department (by total_score) to grade A+.
-- Query:
BEGIN;

WITH ranked_students AS (
  SELECT student_id
  FROM (
    SELECT student_id, department, total_score,
           RANK() OVER (PARTITION BY department ORDER BY total_score DESC) AS rank
    FROM students_grades
  ) sub
  WHERE rank <= 5
)

UPDATE students_grades
SET grade = 'A+'
WHERE student_id IN (SELECT student_id FROM ranked_students);

COMMIT;
--Output:
BEGIN
UPDATE 20
COMMIT



Problem Statement 7: Archive students who have a failing grade (F) and <50% attendance (simulate soft delete).
-- Query:
BEGIN;

UPDATE students_grades
SET is_archived = true
WHERE grade = 'F' AND attendance_percent < 50;

SELECT COUNT(*) FROM students_grades WHERE is_archived = true;

COMMIT;
--Output:

BEGIN
ROLLBACK



Problem Statement 8: Create an alert list of students with high stress (>=8) and low sleep (<=5 hours) to notify the counselor.
-- Query:
BEGIN;

-- CREATE TEMP TABLE stress_alerts AS TABLE students_grades WITH NO DATA;

INSERT INTO stress_alerts
SELECT *
FROM students_grades
WHERE stress_level >= 8 AND sleep_hours_per_night <= 5;

SELECT COUNT(*) FROM stress_alerts;

ROLLBACK;

-- Output: 
BEGIN
INSERT 0 142
 count 
-------
   142
(1 row)
ROLLBACK

