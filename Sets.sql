SELECT student_id,sname,marks FROM student where sex='M';
SELECT student_id,sname,marks FROM student where marks=94;

# The issue with your query is that the two SELECT statements in the UNION operation are selecting different 
# columns in different orders, which can cause confusion and unintended duplicates.
SELECT student_id,sname,marks FROM student where sex='M' UNION
SELECT student_id,marks,sex FROM student where marks=94;

# correct query
SELECT student_id,sname,marks FROM student where sex='M' UNION
SELECT student_id,sname,marks FROM student where marks=94;

# To return duplicate results also
SELECT student_id,sname,marks FROM student where sex='M' UNION ALL
SELECT student_id,sname,marks FROM student where marks=94;

# Example Queries
# Using UNION:

# This query combines the FirstName, LastName, and Department columns from both tables and removes duplicates.


SELECT FirstName, LastName, Department
FROM Employees
UNION
SELECT FirstName, LastName, Department
FROM Contractors;


# This query combines the FirstName, LastName, and Department columns from both tables and includes all rows, including duplicates.


SELECT FirstName, LastName, Department
FROM Employees
UNION ALL
SELECT FirstName, LastName, Department
FROM Contractors;

SELECT account_number
FROM deposits
UNION
SELECT account_number
FROM withdrawals;

# SELECT account_number
# FROM deposits
# EXCEPT
# SELECT account_number
# FROM withdrawals;

