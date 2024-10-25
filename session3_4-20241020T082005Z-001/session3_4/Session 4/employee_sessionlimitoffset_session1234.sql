-- Retrieve employees starting from the 6th row, skipping the first 5 rows.
use hr;
SELECT * FROM employees LIMIT 5 OFFSET 2;
select * from employees limit 2,5
-- Retrieve the top 5 jobs, excluding the first 2
SELECT * FROM jobs ORDER BY min_salary LIMIT 2, 5;
-- Skip the first 3 rows and fetch the next 5 rows in employees table
SELECT * FROM employees LIMIT 5 OFFSET 3;
SELECT * FROM jobs LIMIT 3 OFFSET 0;
-- is equivalent to
SELECT * FROM jobs LIMIT 3;

/*** few extra scenarios ******/
drop table new_employees;
CREATE TABLE new_employees AS
SELECT employee_id, first_name, last_name, hire_date,salary
FROM employees
WHERE department_id = 30;

CREATE TABLE new_employees (
    new_employee_id INT,
    new_first_name VARCHAR(50),
    new_last_name VARCHAR(50),
    new_hire_date DATE
) AS
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE department_id = 30;
/***

*/
UPDATE employees
SET salary = salary/1.1  -- Increase salaries by 10%
WHERE department_id = 50;
-- Delete Employees Based on Another Table
DELETE FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE manager_id IS NULL);


-- Create a sample table with student data and introduce duplicates
CREATE TABLE student_table (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    semester VARCHAR(10),
    section VARCHAR(2)
);

-- Insert some data with duplicates
INSERT INTO student_table (student_id, student_name, semester, section) VALUES
    (1, 'Aarav', 'Semester 1', 'A'),
    (2, 'Aanya', 'Semester 2', 'B'),
    (3, 'Advait', 'Semester 1', 'A'),
    (4, 'Aarav', 'Semester 1', 'A'),  -- Duplicate
    (5, 'Bhavya', 'Semester 2', 'B'),
    (6, 'Advait', 'Semester 1', 'A'),  -- Duplicate
    (7, 'Chhavi', 'Semester 1', 'A'),
    (8, 'Dhruv', 'Semester 2', 'B'),
    (9, 'Aarav', 'Semester 1', 'A');  -- Duplicate
    -- Find duplicates based on student_name, semester, and section columns
SELECT student_name, semester, section, COUNT(*) AS occurrence
FROM student_table
GROUP BY student_name, semester, section
HAVING COUNT(*) > 1;
-- Delete duplicates based on student_name, semester, and section columns, keeping the one with the lowest student_id
DELETE s1
FROM student_table s1
JOIN student_table s2 ON s1.student_name = s2.student_name AND s1.semester = s2.semester AND s1.section = s2.section AND s1.student_id > s2.student_id;

-- Select all rows from the table
SELECT * FROM student_table;

CREATE TABLE marks (
    student_id INT PRIMARY KEY,
    itp_marks INT,
    mf_marks INT,
    sql_marksINT
);

-- Insert some sample data
INSERT INTO marks (student_id, itp_marks, mf_marks, sql_marks) VALUES
    (1, 90, 75, 85),
    (2, 80, 92, 78),
    (3, 70, 85, 60),
    (4, 95, 88, 92),
    (5, 60, 70, 55);
-- Add a 'grade' column to the 'marks' table
ALTER TABLE marks
ADD COLUMN grade VARCHAR(1);
-- Update 'grade' based on the grading criteria
UPDATE marks
SET grade = CASE
    WHEN itp_marks >= 80 THEN 'A'
    WHEN itp_marks >= 60 THEN 'B'
    WHEN itp_marks >= 50 THEN 'C'
    ELSE 'F'
END;


