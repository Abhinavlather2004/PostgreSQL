
Problem Statement:
You are tasked with designing a database system for a university to manage student records, course enrollments, and grading. Your implementation should optimize performance, ensure data integrity, and automate certain operations using stored procedures and triggers.
Schema:
1. Students:
    * StudentID (Primary Key, INT)
    * FirstName (VARCHAR(50))
    * LastName (VARCHAR(50))
    * EnrollmentDate (DATE)
    * Email (VARCHAR(100), UNIQUE)
2. Courses:
    * CourseID (Primary Key, INT)
    * CourseName (VARCHAR(100))
    * Credits (INT)
3. Enrollments:
    * EnrollmentID (Primary Key, INT)
    * StudentID (Foreign Key, INT)
    * CourseID (Foreign Key, INT)
    * Grade (DECIMAL(3, 2))



Requirements:
1. Stored Procedure:
Create a stored procedure named EnrollStudent that:
* Takes inputs: StudentID, CourseID, and an optional Grade.
* Checks if the student is already enrolled in the course using a subquery.
* If not enrolled, inserts a new record into the Enrollments table.
* If enrolled, updates the Grade if a new value is provided.
2. Trigger:
Create a trigger named UpdateStudentCount that:
* Automatically updates a table CourseStatistics whenever a new student is enrolled or removed from a course.
* CourseStatistics table schema:
    * CourseID (Primary Key, INT)
    * StudentCount (INT, default 0)
3. Subquery:
Write a query to fetch students who:
* Have enrolled in more than 3 courses.
* Have an average grade of 8.0 or higher across all their courses.
4. Indexing:
Optimize the performance of the database by:
* Adding an index to improve the performance of queries on Enrollments that filter by StudentID and CourseID.
* Justify why indexing is necessary for these columns.



Deliverables:
1. Schema Creation Queries for the tables.
2. Stored Procedure definition for EnrollStudent.
3. Trigger definition for UpdateStudentCount.
4. SQL query for fetching students based on the criteria mentioned in requirement 3.
5. Indexing strategy with justification.

Query: 
CREATE TABLE Students (
     StudentID INT PRIMARY KEY,
     FirstName VARCHAR(50),
     LastName VARCHAR(50),
     EnrollmentDate DATE,
     Email VARCHAR(100) UNIQUE
 );
 
Query:
CREATE TABLE Courses (
  CourseID INT PRIMARY KEY,
  CourseName VARCHAR(100),
  Credits INT NOT NULL
);
 
Query: 
CREATE TABLE Enrollments (
  EnrollmentID SERIAL PRIMARY KEY,
  StudentID INT NOT NULL,
  CourseID INT NOT NULL,
  Grade DECIMAL(3, 2),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
 
Query: 
CREATE TABLE CourseStatistics (
  CourseID INT PRIMARY KEY,
  StudentCount INT DEFAULT 0,
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
 
Query: 
INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate, Email) 
VALUES 
  (1, 'Abhinav', 'Lather', '2025-01-01', 'abhinav55@gmail.com'),
  (2, 'Varun', 'Thakur', '2025-01-02', 'varun10@gmail.com'),
  (3, 'Ayush', 'Nagar', '2025-01-03', 'ayush20@gmail.com');
 
Query: 
INSERT INTO Courses (CourseID, CourseName, Credits) 
VALUES 
  (1, 'English', 3),
  (2, 'Math', 4),
  (3, 'Physics', 3),
  (4, 'Chemistry', 4);
 
Query: 
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) 
VALUES 
  (1, 1, 9.0), 
  (1, 2, 8.5),  
  (1, 3, 7.8),  
  (2, 2, 9.0), 
  (2, 3, 8.0), 
  (3, 4, 9.5);
 
 
Query: 
CREATE OR REPLACE PROCEDURE EnrollStudent (
  IN procedure_StudentID INT,
  IN procedure_CourseID INT,
  IN procedure_Grade DECIMAL(3, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN
     
  IF EXISTS (
      SELECT 1 
      FROM Enrollments 
      WHERE StudentID = procedure_StudentID AND CourseID = procedure_CourseID
  ) THEN
         
    IF procedure_Grade IS NOT NULL THEN
          UPDATE Enrollments 
          SET Grade = procedure_Grade 
          WHERE StudentID = procedure_StudentID AND CourseID = procedure_CourseID;
      END IF;
    ELSE
         
      INSERT INTO Enrollments (StudentID, CourseID, Grade) 
        VALUES (procedure_StudentID, procedure_CourseID, procedure_Grade);
     END IF;
END;
$$;
 
 
Query: 
CREATE OR REPLACE FUNCTION updateStudentCount() 
RETURNS TRIGGER 
LANGUAGE plpgsql 
AS $$
BEGIN
    
  INSERT INTO CourseStatistics (CourseID, StudentCount) 
  VALUES (NEW.CourseID, 1)
  ON CONFLICT (CourseID) 
  DO UPDATE SET StudentCount = CourseStatistics.StudentCount + 1;
  RETURN NEW;
END;
$$;
 
Query: 
CREATE TRIGGER UpdateStudentCount 
AFTER INSERT ON Enrollments 
FOR EACH ROW 
EXECUTE FUNCTION updateStudentCount();
 
 
 
Query: 
SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
WHERE s.StudentID IN (
  SELECT e.StudentID
  FROM Enrollments e
  GROUP BY e.StudentID
  HAVING COUNT(e.CourseID) > 3 AND AVG(e.Grade) >= 8.0
);
 
Query: 
SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
WHERE s.StudentID IN (
  SELECT e.StudentID
  FROM Enrollments e
  GROUP BY e.StudentID
  HAVING COUNT(e.CourseID) > 2 AND AVG(e.Grade) >= 8.0
);
 
 
Query: 
CREATE INDEX idx_enrollments_student_course 
ON Enrollments (StudentID, CourseID);

Query: 
call enrollstudent (1,1,9.5);
 
Query:
SELECT * FROM Enrollments;

Query:
call enrollstudent (1,4,9.0);