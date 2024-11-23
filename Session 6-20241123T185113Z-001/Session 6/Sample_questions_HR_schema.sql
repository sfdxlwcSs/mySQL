use hr;
/*
 Use a natural join to fetch the first name, last name, 
 and department name of all employees from the "employees" and "departments" tables.
*/
SELECT first_name, last_name, department_name
FROM employees
NATURAL JOIN departments;
/*
 Find the first name, last name, and job title of employees who have a corresponding entry in the "jobs" table.
 Include all employees, even if they do not have a matching job.
*/
SELECT e.first_name, e.last_name, COALESCE(j.job_title, 'No Job') AS job_title
FROM employees e
LEFT JOIN jobs j ON e.job_id = j.job_id;



/*List the first name, last name, job title, and salary of employees
 who have held the title 'Sales Representative' and 'Sales Manager'
from the "employees," "jobs," and "job_history" tables. */

SELECT e.first_name, e.last_name, j.job_title, e.salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN job_history jh ON e.employee_id = jh.employee_id
WHERE j.job_title IN ('Sales Representative', 'Sales Manager');
/*
Retrieve the first name, last name, and department name of employees
 along with their corresponding department information 
and location from the "employees," "departments," and "locations" tables.
*/
SELECT e.first_name, e.last_name, d.department_name, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;
/*
Find the first name, last name, and hire date of employees
 along with their corresponding manager's first and last name from the "employees" table 
 */
 SELECT e.first_name, e.last_name, e.hire_date, m.first_name AS manager_first, m.last_name AS manager_last
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

--  Calculate the average salary for each job title from the "employees" and "jobs" tables
--  and display the job title along with the average salary.
SELECT j.job_title, AVG(e.salary) AS avg_salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title;

-- Find employees who earn a salary greater than all salaries in the IT department.
 
 -- Original Query with ALL
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 60);
 -- Find employees who earn a salary greater than any salary in the Sales department.
 -- Query with ANY
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 80);
SELECT first_name, last_name, salary
FROM employees
WHERE salary > SOME (SELECT salary FROM employees WHERE department_id = 20);

 -- Find employees in the HR department with a salary greater than the average salary of all employees.
 SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = 60);

use hr;
-- Create dependents table
CREATE TABLE dependents (
    dependent_id INT PRIMARY KEY,
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    relationship VARCHAR(50)
);
use hr;
select * from dependents;
select * from employees where employee_id in ( 
select  distinct employee_id from dependents );
SELECT first_name, last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM dependents dep
    WHERE e.employee_id = dep.employee_id
);

-- Insert sample data into dependents table
INSERT INTO dependents (dependent_id, employee_id, first_name, last_name, relationship)
VALUES
    (1, 101, 'John', 'Doe', 'Child'),
    (2, 102, 'Jane', 'Smith', 'Spouse'),
    (3, 103, 'Bob', 'Johnson', 'Child')
    ;

-- Check the dependents table
SELECT * FROM dependents;


-- Scenario: Find employees who have at least one dependent.
use hr;
-- Query with EXISTS

SELECT first_name, last_name, department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE EXISTS (
    SELECT 1
    FROM dependents dep
    WHERE e.employee_id = dep.employee_id
);

-- Alternate Implementation without EXISTS
explain
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN dependents dep ON e.employee_id = dep.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name;

 -- Find departments with no employees
 -- Query with NOT EXISTS
 explain
SELECT department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);
-- Alternate Implementation without NOT EXISTS
SELECT department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- Create training_history table
CREATE TABLE training_history (
    training_id INT PRIMARY KEY,
    employee_id INT,
    training_date DATE,
    training_title VARCHAR(100),
    trainer_name VARCHAR(100)
    -- CONSTRAINT fk_training_history_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

desc employees;
-- Insert sample data into training_history table
INSERT INTO training_history (training_id, employee_id, training_date, training_title, trainer_name)
VALUES
    (1, 101, '2023-01-15', 'SQL Basics', 'John Trainer'),
    (2, 102, '2023-02-20', 'Advanced Excel', 'Jane Trainer'),
    (3, 103, '2023-03-10', 'Presentation Skills', 'Bob Trainer')
    ;

-- Check the training_history table
SELECT * FROM training_history;

 -- Find employees who have attended any training sessions.
 -- Query with EXISTS
SELECT first_name, last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM training_history th
    WHERE e.employee_id = th.employee_id
);
-- Alternate Implementation without EXISTS
SELECT DISTINCT e.first_name, e.last_name
FROM employees e
JOIN training_history th ON e.employee_id = th.employee_id;

-- correlated subquries ----------------------
 -- Find employees whose salary is above the average salary in their department.
 SELECT first_name, last_name, salary, department_id
FROM employees e_outer
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e_inner
    WHERE e_outer.department_id = e_inner.department_id
);
-- Find employees whose job title matches that of their manager.
SELECT first_name, last_name, job_id, manager_id
FROM employees e_outer
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE employee_id = e_outer.manager_id
);
-- Find employees who have a higher commission percentage than the average commission percentage in their department.
SELECT first_name, last_name, department_id, commission_pct
FROM employees e_outer
WHERE commission_pct > (
    SELECT AVG(commission_pct)
    FROM employees e_inner
    WHERE e_outer.department_id = e_inner.department_id
);
select * from employees;
-- Add the vacation_days_taken column
ALTER TABLE employees
ADD COLUMN vacation_days_taken INT;

-- Update employees with random vacation days taken (values between 0 and 15)
SET SQL_SAFE_UPDATES = 0;
-- Update employees with random vacation days taken (values between 0 and 15)
UPDATE employees
SET vacation_days_taken = FLOOR(RAND() * 16) 
WHERE vacation_days_taken IS NULL OR vacation_days_taken = 0;

-- Find employees with more vacation days than the average in their department
SELECT first_name, last_name, department_id, vacation_days_taken
FROM employees e_outer
WHERE vacation_days_taken > (
    SELECT AVG(vacation_days_taken)
    FROM employees e_inner
    WHERE e_outer.department_id = e_inner.department_id
);
use hr;
-- Find employees whose salary is above the average salary in their department:
SELECT e1.first_name, e1.last_name, e1.salary, e1.department_id
FROM employees e1
JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) e2 ON e1.department_id = e2.department_id
WHERE e1.salary > e2.avg_salary;
-- Find employees whose job title matches that of their manager:
SELECT first_name, last_name, job_id, manager_id
FROM employees e_outer
WHERE EXISTS (
    SELECT 1
    FROM employees e_inner
    WHERE e_outer.manager_id = e_inner.employee_id AND e_outer.job_id = e_inner.job_id
);

-- Find employees who have a higher commission percentage than the average commission percentage in their department:
SELECT e1.first_name, e1.last_name, e1.commission_pct, e1.department_id
FROM employees e1
JOIN (
    SELECT department_id, AVG(commission_pct) AS avg_commission_pct
    FROM employees
    GROUP BY department_id
) e2 ON e1.department_id = e2.department_id
WHERE e1.commission_pct > e2.avg_commission_pct;

-- Find employees with more vacation days than the average in their department:
SELECT e1.first_name, e1.last_name, e1.vacation_days_taken, e1.department_id
FROM employees e1
JOIN (
    SELECT department_id, AVG(vacation_days_taken) AS avg_vacation_days
    FROM employees
    GROUP BY department_id
) e2 ON e1.department_id = e2.department_id
WHERE e1.vacation_days_taken > e2.avg_vacation_days;



create database students_data_1717;
use students_data_1717;


-- Create Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255),
    gpa DECIMAL(3, 2)
);

-- Create Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(255)
);

-- Create Enrollments Table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    score INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (student_id, student_name, gpa) VALUES
(1, 'John Doe', 3.8),
(2, 'Jane Smith', 3.5),
(3, 'Bob Johnson', 3.9),
(4, 'Alice Brown', 3.7),
(5, 'Charlie Davis', 3.6),
(6, 'Eva Martinez', 4.0),
(7, 'Frank Wilson', 3.9),
(8, 'Grace Taylor', 3.8),
(9, 'Henry Lee', 3.7),
(10, 'Ivy White', 3.6);

INSERT INTO courses (course_id, course_name) VALUES
(1, 'Mathematics'),
(2, 'English'),
(3, 'Physics'),
(4, 'History'),
(5, 'Chemistry'),
(6, 'Computer Science'),
(7, 'Biology'),
(8, 'Literature'),
(9, 'Geography'),
(10, 'Art');
INSERT INTO enrollments (enrollment_id, student_id, course_id, score) VALUES
(1, 1, 1, 92),
(2, 2, 1, 88),
(3, 3, 1, 95),
(4, 4, 1, 90),
(5, 5, 1, 87),
(6, 6, 1, 98),
(7, 7, 1, 94),
(8, 8, 1, 91),
(9, 9, 1, 89),
(10, 10, 1, 86),
-- Additional records with different courses
(11, 1, 2, 85),
(12, 2, 2, 89),
(13, 3, 2, 92),
(14, 4, 2, 87),
(15, 5, 2, 91),
(16, 6, 2, 95),
(17, 7, 2, 93),
(18, 8, 2, 88),
(19, 9, 2, 90),
(20, 10, 2, 86);
select * from students;
select * from enrollments;
select * from courses;

-- Query to find students with a GPA above the overall average GPA.
SELECT student_id, student_name, gpa
FROM students
WHERE gpa > (
    SELECT AVG(gpa)
    FROM students
);

-- Query to find students who are enrolled in more than one course.
SELECT student_id, student_name, gpa
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(course_id) > 1
);
-- Find Students with the Highest GPA
SELECT student_id, student_name, age, gpa
FROM students
WHERE gpa = (
    SELECT MAX(gpa)
    FROM students
);
-- Query to count the number of enrollments for each course.
SELECT course_name, (
    SELECT COUNT(*)
    FROM enrollments
    WHERE enrollments.course_id = courses.course_id
) AS enrollment_count
FROM courses;

-- Query to find students with the same GPA as student 'John Doe'.
SELECT student_id, student_name, gpa
FROM students
WHERE gpa = (
    SELECT gpa
    FROM students
    WHERE student_name = 'John Doe'
);

-- Example: Retrieve student names, individual GPA, and average GPA for all students
SELECT student_name, gpa, (SELECT AVG(gpa) FROM students) AS average_gpa
FROM students;

-- Example: Create a new column 'grade_category' based on the average GPA
create view temp_demo as (
SELECT student_name, gpa,
  CASE
    WHEN gpa >= (SELECT AVG(gpa) FROM students) THEN 'High Achiever'
    WHEN gpa >= 3.0 AND gpa < (SELECT AVG(gpa) FROM students) THEN 'Average'
    ELSE 'Below Average'
  END AS grade_category
FROM students);
select * from temp_demo;
--- where 

 use students_data_1717;

SELECT *
FROM ACCOUNT
WHERE (ACCT_NUM, BALANCE ) IN (SELECT ACCT_NUM,
TRAN_AMOUNT
FROM TRANSACTION )



