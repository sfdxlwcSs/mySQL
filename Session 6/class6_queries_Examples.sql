use hr;
select * from employees;
SELECT employee_id, last_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
SELECT employee_id, last_name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
SELECT employee_id, last_name, salary,
       percent_rank() OVER (ORDER BY salary ) AS salary_rank
FROM employees;

SELECT
  employee_id,
  salary,
  RANK() OVER (ORDER BY salary) AS ranks,
  COUNT(*) OVER () AS total_rows,
  (RANK() OVER (ORDER BY salary)) / (COUNT(*) OVER ()) AS percent_ranks
FROM
  employees;
SELECT department_id, job_id, salary,
       PERCENT_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS percent_rank_salary
FROM employees;

with emp as (SELECT employee_id, last_name, salary,department_id,
       rank() OVER (partition by department_id ORDER BY salary DESC) AS salary_rank
FROM employees) 
select emp.*  ,d.department_name 
from emp , departments d
where emp.department_id = d.department_id
and  salary_rank =2 ;
SELECT department_id, job_id, salary,
       LEAD(salary) OVER ( ORDER BY salary DESC) AS next_salary,
       LAG(Salary) over ( ORDER BY salary DESC) AS prev_Salary
FROM employees;
SELECT department_id, job_id, salary,
       LEAD(salary) OVER (PARTITION BY department_id ORDER BY salary) AS next_salary
FROM employees;


with emp as (SELECT employee_id, last_name, salary,department_id,
       rank() OVER (partition by department_id ORDER BY salary DESC) AS salary_rank
FROM employees) 
select emp.*  ,d.department_name 
from emp , department d
where emp.department_id = d.department_id
and  salary_rank =2 ;
SELECT department_id, job_id, salary,
       FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY salary) AS first_salary
FROM employees;

SELECT
  employee_id,
  salary,
  SUM(salary) OVER (ORDER BY salary ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS cumulative_salary
FROM
  employees;
  
  SELECT
  employee_id,
  salary,
  SUM(salary) OVER (ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cumulative_salary
FROM
  employees;
  
  use hr;
  
  
  SELECT
  employee_id,
  salary,
  SUM(salary) OVER (ORDER BY salary RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS cumulative_salary
FROM
  employees;
  SELECT
  employee_id,
  salary,
  SUM(salary) OVER (ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_salary
FROM
  employees;

SELECT department_id, job_id, salary,
       LAST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY salary 
                               ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_salary
FROM employees;
SELECT
  department_id,employee_id,salary,
  SUM(salary) OVER (PARTITION BY department_id ORDER BY employee_id) AS cumulative_salary
FROM
  employees;


SELECT employee_id, last_name, salary,
       NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile
FROM employees;

SELECT department_id, job_id, salary,
       NTILE(3) OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_tercile
FROM employees;

SELECT department_id, job_id, salary,
       CUME_DIST() OVER (ORDER BY salary DESC) AS cumulative_distribution
FROM employees;
/*
Here's how CUME_DIST() works:

Ordering the Data:

Before applying CUME_DIST(), the data is first ordered based on the specified column or
 columns within the window frame.
Calculation of Cumulative Distribution:

For each row in the result set, CUME_DIST() calculates
 the cumulative distribution by counting the number of rows 
 with values less than or equal to the current row's value 
 and dividing it by the total number of rows in the partition.

Result:

The result is a value between 0 and 1 (inclusive), where 0 represents the beginning of the ordered set,
 and 1 represents the end.
 The higher the CUME_DIST value, the later the row appears in the ordered set.
 */
SELECT department_id, job_id, salary,
       CUME_DIST() OVER (PARTITION BY department_id ORDER BY salary DESC) AS department_cumulative_dist
FROM employees;



SELECT employee_id, last_name, salary,
       LAG(salary) OVER (ORDER BY salary) AS previous_salary
FROM employees;



SELECT department_id, job_id, salary,
       DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dense_salary_rank
FROM employees;