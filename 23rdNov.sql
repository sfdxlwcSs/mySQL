use session5;
-- Subqueries with the ‘WITH’ Clause
# In SQL, the WITH clause (also known as Common Table Expressions (CTEs)) is used to define temporary result sets that can be referred to within a SELECT, INSERT, UPDATE, or DELETE statement. These temporary tables are only available for the duration of the query,
# and they help make complex queries more readable and manageable.
Select Acct_Num ,Acct_type from account;

select Acct_type,rate from interest;

select *
from account a inner join interest i
on a.Acct_type=i.Acct_type;

With temp as(
select distinct Acct_type,rate from interest
)


select *
from account a inner join temp i
on a.Acct_type=i.Acct_type;

select *
from account a inner join (select distinct Acct_type,rate from interest) i
on a.Acct_type=i.Acct_type;

use hr;

-- department_id having more than 2 employees
Select count(*) noofemployess,department_id
from employees e
group by department_id
having count(*)>2;

with temp as (Select count(*) noofemployess,department_id
from employees e
group by department_id
having count(*)>2)

-- get department information having more than 2 employees
select * from departments d
join temp e
on d.department_id=e.department_id;



-- get department and location information information having more than 2 employees
with dept_count as (
Select count(*) ,department_id
from employees
group by department_id
having count(*)>2)

Select d.* ,l.city locTableData,l.location_id from departments d
join dept_count empTable
on d.department_id =empTable.department_id
join locations l on d.location_id=l.location_id;


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
-- This SQL query retrieves all information about employees who have dependents.
select * from employees where employee_id in ( 
select  distinct employee_id from dependents );
# DISTINCT: This keyword ensures that only unique employee_id values are returned.
#  This is important because an employee might have multiple dependents, 
# and we only need their employee_id once to identify them in the outer query.
SELECT first_name, last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM dependents dep
    WHERE e.employee_id = dep.employee_id
);
# The SELECT 1 in the subquery inside the EXISTS clause is simply a convention used because the actual data retrieved is not important.
#  The subquery’s purpose is to check for the existence of matching rows, not to return any data. 
#  The value 1 is just a placeholder, and you could use any constant (like SELECT 'x') 
# without changing the behavior of the query.
-- Insert sample data into dependents table
INSERT INTO dependents (dependent_id, employee_id, first_name, last_name, relationship)
VALUES
    (1, 101, 'John', 'Doe', 'Child'),
    (2, 102, 'Jane', 'Smith', 'Spouse'),
    (3, 103, 'Bob', 'Johnson', 'Child')
    ;

-- Check the dependents table
SELECT * FROM dependents;

select * from employees where employee_id in ( 
select  distinct employee_id from dependents );

SELECT first_name, last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM dependents dep
    WHERE e.employee_id = dep.employee_id
); #check how many times this query will run

SELECT first_name, last_name
FROM employees e
WHERE not exists (
    SELECT 1
    FROM dependents dep
    WHERE e.employee_id = dep.employee_id
); 

# Session 6 Advanced Aggregate Functions and Data Integrity If you don't use a PARTITION BY clause, the entire result set is treated as a single partition. RANK() assigns ranks based on the ORDER BY clause across all rows.

Select employee_id,salary,rank() over ( order  by salary desc)
from employees; # if 2 people have same rank for ex 17000 2 have salary so both got 2 ,so next rank will be 4 no 3rd rank

Select employee_id,salary,dense_rank() over ( order  by salary desc)
from employees;# no rank skipping here

Select employee_id,salary,department_id,dense_rank() over ( order  by salary desc) as rankVal,
row_number() over ( order  by salary desc) as RowPos
from employees;

Select employee_id,salary,department_id,dense_rank() over (partition by department_id order  by salary desc) as rankVal,
row_number() over ( partition by department_id order  by salary desc) as RowPos
from employees
order by  department_id,salary desc;


# employess having max salary in each department
with temp_T as (
Select employee_id,salary,department_id,dense_rank() over (partition by department_id order  by salary desc) as rank_1,
row_number() over ( partition by department_id order  by salary desc) as RowPos
from employees
order by  department_id,salary desc)
select * from temp_T where rank_1=1;

Select employee_id,salary,department_id,sum(salary) over (partition by department_id order by salary desc) as sum_Sal
from employees
order by  department_id,salary desc; # it is adding to previous amount --cumilative sum

Select employee_id,salary,department_id,count(employee_id) over (partition by department_id order  by salary desc) as countOfEmpId
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,sum(salary) over ( order by salary desc) as sum_Sal
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,
lead(salary) 
over (partition by department_id order  by salary desc) as nextSal
from employees
order by  department_id,salary desc;


Select employee_id,salary,department_id,
lead(salary) 
over (partition by department_id order  by salary desc) as nextSal,
lead(salary,2) 
over (partition by department_id order  by salary desc) as nextSal_2,
lead(salary,3) 
over (partition by department_id order  by salary desc) as nextSal_3
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,
lag(salary) 
over (partition by department_id order  by salary desc) as nextSal
from employees
order by  department_id,salary desc;


Select employee_id,salary,department_id,
lag(salary) 
over (partition by department_id order  by salary desc) as nextSal,
lag(salary,2) 
over (partition by department_id order  by salary desc) as nextSal_2,
lag(salary,3) 
over (partition by department_id order  by salary desc) as nextSal_3
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,
first_value(salary) 
over (partition by department_id order  by salary desc) as first_sal
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,
first_value(employee_id) 
over (partition by department_id order  by salary desc) as first_sal
from employees
order by  department_id,salary desc; #employee id of a person having highest salary

# Key Concepts:
# UNBOUNDED PRECEDING: Refers to the first row in the partition, no matter where the current row is.
# UNBOUNDED FOLLOWING: Refers to the last row in the partition, no matter where the current row is.
# CURRENT ROW: Refers to the current row being processed.
# These keywords are often used with the ROWS or RANGE clauses to define the window (or frame) for calculations.

Select employee_id,salary,department_id,
last_value(salary) 
over (partition by department_id order  by salary desc
RANGE BETWEEN 
UNBOUNDED PRECEDING  AND
UNBOUNDED FOLLOWING
) as LAST_sal
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,
last_value(salary) 
over (partition by department_id order  by salary desc
RANGE BETWEEN 
UNBOUNDED PRECEDING AND
current row
) as LAST_sal
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,
last_value(salary) 
over (partition by department_id order  by salary desc
RANGE BETWEEN 
current row AND
UNBOUNDED FOLLOWING
) as LAST_sal
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,
last_value(salary) 
over (partition by department_id order  by salary desc
RANGE BETWEEN 
current row AND
current row
) as LAST_sal
from employees
order by  department_id,salary desc;

Select employee_id,salary,department_id,
ntile(3) 
over ( order  by salary asc) as n_bucket
from employees
where department_id=30;

Select employee_id,salary,department_id,
ntile(4) 
over ( order  by salary asc) as n_bucket
from employees
where department_id=30;

Select employee_id,salary,department_id,
ntile(4) 
over ( order  by salary desc) as n_bucket
from employees
where department_id=30;



























