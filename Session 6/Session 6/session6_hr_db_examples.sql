-- Display the employee_id, salary, and the rank of each employee based on their salary, ordered by salary within each department.
use hr;
SELECT employee_id, salary,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;
-- Calculate the running total of salaries for each department, ordering by hire date, and partitioning by department.
SELECT employee_id, department_id, salary, hire_date,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS running_total_salary
FROM employees;
/*
Find the percentage change in salary for each employee within their job title, 
ordering by hire date and partitioning by job title.
*/
SELECT employee_id, job_id, salary, hire_date,
       (salary - LAG(salary) OVER (PARTITION BY job_id ORDER BY hire_date)) / LAG(salary) OVER (PARTITION BY job_id ORDER BY hire_date) * 100 AS salary_change_percentage
FROM employees;
-- Retrieve the top 3 employees with the highest average salary in each department.
SELECT department_id, employee_id, salary,
       RANK() OVER (PARTITION BY department_id ORDER BY AVG(salary) DESC) AS avg_salary_rank
FROM employees
GROUP BY department_id, employee_id, salary;
-- Calculate the cumulative distribution of salaries for each employee over time, ordering by hire date.
SELECT employee_id, hire_date, salary,
       CUME_DIST() OVER (ORDER BY salary) AS cumulative_distribution
FROM employees;
-- Identify employees whose salary changes deviate significantly from the average salary change within their department.
SELECT employee_id, department_id, salary, hire_date,
       salary - AVG(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS salary_deviation
FROM employees;

-- Classify employees into quartiles based on their salary within each department.
SELECT department_id, employee_id, salary,
       NTILE(4) OVER (PARTITION BY department_id ORDER BY salary) AS salary_quartile
FROM employees;
-- Show the first salary of each employee within their department, ordering by hire date.
SELECT employee_id, hire_date, salary,
       FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS first_salary
FROM employees;

-- Identify employees who have left the company by showing the last hire date of each employee.
SELECT employee_id, MAX(hire_date) OVER (PARTITION BY employee_id) AS last_hire_date
FROM employees;
-- Calculate the cumulative salary for each employee over the entire department,
--  without any restriction on the order.
SELECT employee_id, department_id, salary,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cumulative_salary
FROM employees;

-- Calculate the running total salary for each employee from the beginning of their department.
SELECT employee_id, department_id, salary,
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_salary
FROM employees;



