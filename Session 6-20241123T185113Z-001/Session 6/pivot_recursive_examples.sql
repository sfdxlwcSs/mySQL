-- Sample data
create database 06012024u;
CREATE TABLE sales (
    product VARCHAR(50),
    region VARCHAR(50),
    amount_sold INT
);

INSERT INTO sales VALUES ('ProductA', 'North', 100);
INSERT INTO sales VALUES ('ProductB', 'North', 150);
INSERT INTO sales VALUES ('ProductA', 'South', 200);
INSERT INTO sales VALUES ('ProductB', 'South', 120);
INSERT INTO sales VALUES ('ProductA', 'East', 180);
INSERT INTO sales VALUES ('ProductB', 'East', 90);
INSERT INTO sales VALUES ('ProductA', 'West', 130);
INSERT INTO sales VALUES ('ProductB', 'West', 110);
select * from sales;

# you are not creating a column call amount_sold where result in store and displayed as North or soth as the case may be
SELECT
    product,
    SUM(CASE WHEN region = 'North' THEN amount_sold END) AS North,
    SUM(CASE WHEN region = 'South' THEN amount_sold END) AS South,
    SUM(CASE WHEN region = 'East' THEN amount_sold END) AS East,
    SUM(CASE WHEN region = 'West' THEN amount_sold END) AS West
FROM
    sales
GROUP BY
    product;







create database RTE;
use RTE;
CREATE TABLE CUSTOMER_HOUSEHOLD
( Cust_Id INT, NAME VARCHAR(20), PARENT_NAME
VARCHAR(20));
INSERT INTO CUSTOMER_HOUSEHOLD VALUES
(123000, 'GEFF', NULL ),
(123001, 'MARK', 'GEFF' ),
(123002, 'CHARLIE' , 'MARK' ) ,
(123003, 'CRISTY' , 'MARK' ) ,
(123004, 'SARAH', 'GEFF' ),
(123005, 'ROBERT' , 'SARAH') ,
(123006, 'ANDY' , 'SARAH') ;
select * from CUSTOMER_HOUSEHOLD;

# The CTE consists of two parts:
# Anchor Query (Base Case):
SELECT Name, Parent_Name, CAST(Name AS CHAR(200))
FROM CUSTOMER_HOUSEHOLD
WHERE Parent_Name IS NULL;

# Recursive Query:

WITH RECURSIVE Family ( NAME, PARENT_NAME, Hierarchy) AS
(SELECT Name, Parent_name, CAST(Name AS CHAR(200))
FROM CUSTOMER_HOUSEHOLD
WHERE Parent_Name IS NULL
UNION ALL
SELECT ch.Name, ch.Parent_Name, CONCAT(cf.Hierarchy, ",", ch.name)
FROM Family cf
JOIN CUSTOMER_HOUSEHOLD ch
ON cf.name = ch.parent_name )
SELECT * FROM Family ORDER BY Hierarchy;



WITH RECURSIVE countup AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM countup WHERE n < 3
)
SELECT * FROM countup;

WITH RECURSIVE countup AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM countup WHERE n < 5
)
SELECT * FROM countup;
# even number
WITH RECURSIVE countup AS (
  SELECT 2 AS n
  UNION ALL
  SELECT n + 2 FROM countup WHERE n < 20
)
SELECT * FROM countup;
# odd number
WITH RECURSIVE countup AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 2 FROM countup WHERE n < 20
)
SELECT * FROM countup;

-- Recursive CTE for powers of 2
WITH RECURSIVE powers_of_2 AS (
  SELECT 1 AS power
  UNION ALL
  SELECT power * 2 FROM powers_of_2 WHERE power < 256
)
SELECT power FROM powers_of_2;


WITH RECURSIVE fibonacci AS (
  SELECT 0 AS n, 1 AS next
  UNION ALL
  SELECT next, n + next FROM fibonacci WHERE n < 14
)
SELECT n FROM fibonacci;

Use hr;
select * from employees;
select * from departments;
select * from jobs;
create view emp_dep_job as (
select employee_id, concat_ws(first_name,'',last_name ) as employee_name, department_name,job_title
from departments d, jobs j,employees e 
where e.job_id = j.job_id 
and e.department_id = d.department_id
order by employee_id);

insert  into emp_dep_job ( employee_id,employee_name,department_name,job_title)
values (4000,'Ullas Rao','Education','Professor');
select * from emp_dep_job;