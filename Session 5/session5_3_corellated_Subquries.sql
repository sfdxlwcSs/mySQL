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







