-- Create `employees` table
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

-- Group By Single Column

-- 6. Count Employees per Department
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

-- 7. Total Salary per Department
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

-- 8. Average Salary per Department
SELECT department_id, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;

-- 9. Minimum Salary per Department
SELECT department_id, MIN(salary) AS min_salary
FROM employees
GROUP BY department_id;

-- 10. Maximum Salary per Department
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;

-- Group By Multiple Columns

-- 11. Count Employees per Department and Hire Date
SELECT department_id, hire_date, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id, hire_date;

-- 12. Total Salary per Department and Hire Year
SELECT department_id, YEAR(hire_date) AS hire_year, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id, YEAR(hire_date);

-- 13. Average Salary by Department and Job
SELECT department_id, job_title, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id, job_title;

-- 14. Minimum Salary by Department and Gender
SELECT department_id, gender, MIN(salary) AS min_salary
FROM employees
GROUP BY department_id, gender;

-- 15. Maximum Salary by Department and Manager
SELECT department_id, manager_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id, manager_id;

-- Using HAVING Clause

-- 16. Departments with More Than 5 Employees
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;

-- 17. Departments with Average Salary Greater Than $60,000
SELECT department_id, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 60000;

-- 18. Departments with Total Salary Less Than $200,000
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING SUM(salary) < 200000;

-- 19. Departments with Minimum Salary Greater Than $40,000
SELECT department_id, MIN(salary) AS min_salary
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 40000;

-- 20. Departments with Maximum Salary Less Than $120,000
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING MAX(salary) < 120000;

-- Handling NULL Values

-- 21. Count Employees with NULL Salaries
SELECT COUNT(*) AS null_salary_count
FROM employees
WHERE salary IS NULL;

-- 22. Total Salary per Department with NULL Handling
SELECT department_id, SUM(COALESCE(salary, 0)) AS total_salary
FROM employees
GROUP BY department_id;

-- 23. Average Salary per Department with NULL Handling
SELECT department_id, AVG(COALESCE(salary, 0)) AS average_salary
FROM employees
GROUP BY department_id;

-- 24. Minimum Salary per Department Considering NULLs
SELECT department_id, MIN(COALESCE(salary, 0)) AS min_salary
FROM employees
GROUP BY department_id;

-- 25. Maximum Salary per Department Considering NULLs
SELECT department_id, MAX(COALESCE(salary, 0)) AS max_salary
FROM employees
GROUP BY department_id;

-- More Complex Scenarios

-- 26. Top 3 Highest Paying Departments
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY total_salary DESC
LIMIT 3;

-- 27. Departments with More Than 1 Manager
SELECT department_id, COUNT(DISTINCT manager_id) AS manager_count
FROM employees
GROUP BY department_id
HAVING COUNT(DISTINCT manager_id) > 1;

-- 28. Average Salary by Hire Year for Each Department
SELECT department_id, YEAR(hire_date) AS hire_year, AVG(salary) AS average_salary
FROM employees
GROUP BY department_id, YEAR(hire_date);

-- 29. Departments with the Highest Minimum Salary
SELECT department_id, MIN(salary) AS min_salary
FROM employees
GROUP BY department_id
ORDER BY min_salary DESC
LIMIT 1;

-- 30. Employees with the Highest Salary in Each Department
SELECT department_id, employee_id, salary
FROM employees
WHERE (department_id, salary) IN (
    SELECT department_id, MAX(salary)
    FROM employees
    GROUP BY department_id
);

-- Analytical Functions

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

