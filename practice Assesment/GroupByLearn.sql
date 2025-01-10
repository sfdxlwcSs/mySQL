Create database GroupByLearn;
Use GroupByLearn;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(15, 2),
    hire_date DATE
);

-- Create `departments` table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
-- Insert departments
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Software Development'),
(2, 'Quality Assurance'),
(3, 'Data Science'),
(4, 'Network Engineering'),
(5, 'Product Management'),
(6, 'Technical Support'),
(7, 'HR & Administration'),
(8, 'Sales & Marketing');

-- Insert employees
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date) VALUES
(1, 'Aarav', 'Sharma', 1, 75000.00, '2022-01-15'),
(2, 'Vivaan', 'Patel', 2, 60000.00, '2022-02-20'),
(3, 'Aditya', 'Reddy', 3, 90000.00, '2022-03-25'),
(4, 'Vihaan', 'Kumar', 4, 65000.00, '2022-04-10'),
(5, 'Reyaan', 'Singh', 5, 85000.00, '2022-05-05'),
(6, 'Arjun', 'Gupta', 6, 70000.00, '2022-06-18'),
(7, 'Sai', 'Iyer', 7, 72000.00, '2022-07-22'),
(8, 'Kabir', 'Joshi', 8, 68000.00, '2022-08-15'),
(9, 'Raj', 'Bhatia', 1, 77000.00, '2022-09-10'),
(10, 'Reema', 'Sinha', 2, 62000.00, '2022-10-05'),
(11, 'Ananya', 'Mehta', 3, 93000.00, '2022-11-20'),
(12, 'Kiran', 'Nair', 4, 67000.00, '2022-12-15'),
(13, 'Maya', 'Patil', 5, 86000.00, '2023-01-10'),
(14, 'Saanvi', 'Verma', 6, 71000.00, '2023-02-05'),
(15, 'Rohan', 'Sharma', 7, 73000.00, '2023-03-15'),
(16, 'Ishaan', 'Rao', 8, 69000.00, '2023-04-20'),
(17, 'Nisha', 'Khan', 1, 78000.00, '2023-05-25'),
(18, 'Aanya', 'Dubey', 2, 63000.00, '2023-06-15'),
(19, 'Arnav', 'Agarwal', 3, 94000.00, '2023-07-10'),
(20, 'Tanya', 'Mishra', 4, 68000.00, '2023-08-05'),
(21, 'Siddharth', 'Kumar', 5, 87000.00, '2023-09-10'),
(22, 'Shreya', 'Chopra', 6, 72000.00, '2023-10-05'),
(23, 'Vikram', 'Singh', 7, 74000.00, '2023-11-15'),
(24, 'Kavya', 'Ahuja', 8, 70000.00, '2023-12-20');

SELECT * FROM groupbylearn.employees;
select month(hire_date) from employees;
Select count(*),sum(salary),year(hire_date),department_id from employees 
group by department_id,year(hire_date) 
having sum(salary)>152000;
SELECT department_id, 
       CASE WHEN salary > 60000 THEN 'HighSalary' ELSE 'LowSalary' END AS salary_category, 
       AVG(salary) AS average_salary 
FROM employees
GROUP BY department_id, salary_category;
-- The AVG(salary) function calculates the average salary within each department_id and salary_category group.
-- Basic Aggregates

-- 1. Count of Employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 2. Total Salary Paid
SELECT SUM(salary) AS total_salary
FROM employees;

-- 3. Average Salary
SELECT AVG(salary) AS average_salary
FROM employees;

-- 4. Minimum Salary
SELECT MIN(salary) AS min_salary
FROM employees;

-- 5. Maximum Salary
SELECT MAX(salary) AS max_salary
FROM employees;
SELECT department_id, COUNT(*) AS employee_count -- no of employees for a department
FROM employees
GROUP BY department_id;

-- Employees with the Highest Salary in Each Department
SELECT department_id, employee_id, salary
FROM employees
WHERE (department_id, salary) IN (
    SELECT department_id, MAX(salary)
    FROM employees
    GROUP BY department_id
);
-- 1. Find the Maximum Salary in Each Department

-- Subquery:
-- SELECT department_id, MAX(salary) FROM employees GROUP BY department_id
-- This part of the query focuses on finding the maximum salary within each department.
-- GROUP BY department_id divides the employees into groups based on their department.
-- MAX(salary) calculates the highest salary within each of these department groups.
-- This subquery effectively creates a temporary result set containing the department ID and the corresponding maximum salary for each department.
-- 2. Identify Employees with the Maximum Salary

-- Outer Query:

-- SELECT department_id, employee_id, salary FROM employees
-- This part selects the department_id, employee_id, and salary of all employees from the employees table.
-- WHERE (department_id, salary) IN (...)

-- This clause filters the employees. It checks if the combination of department_id and salary for each employee matches any of the combinations found in the subquery (i.e., department ID and maximum salary for that department).
-- In simpler terms:

-- The subquery finds the highest salary for each department.
-- The outer query then selects only those employees who belong to a department and have the maximum salary for that specific department.
-- This approach effectively identifies the top-earning employee in each department within the company.

SELECT department_id, sum(salary) totalSalary
    FROM employees
    GROUP BY department_id;
    
-- 31. Running Total of Salaries within Each Department
SELECT 
    employee_id,
    department_id,
    salary,
    hire_date,
    SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS running_total_salary
FROM employees;

-- 32. Rank Employees by Salary within Each Department
SELECT 
    employee_id,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;