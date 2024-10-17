SELECT * from student where marks>70;
Select * from student where sid in(1,2);
Select * from student where sid not in(1,2);
Select * from student where marks>70 and sid in(4,5,6);
Select * from student where sid=4 
or sid=5;
Select * from student where marks>70 and marks<90; #it will not include 70 and 90
Select * from student where marks between 70 and 90; #it will include both 70 and 90
Select * from student where marks <> 65;
Select * from student where email like '%dfscorp.com';
Select * from student where sname like 'Somn%';
Select * from student where email like '%dover%';
Select * from student where sname like '%5';
select sname ,length(sname) as length_name from student;	
select sname ,length(sname) as length_name from student 
where length(sname)>5;	
delete  from student where sid=7; 
Select * from student where enrollmentdate is null;
SET SQL_SAFE_UPDATES = 0;
delete  from student where  enrollmentdate is null;
SET SQL_SAFE_UPDATES = 1;
update student set marks=62 where sid=2;
update student set marks=65 where contact_no=641186004;
ALTER TABLE student
CHANGE COLUMN sid student_id integer; #CHANGE
ALTER TABLE student
modify COLUMN  student_id integer AUTO_INCREMENT;
ALTER TABLE student
modify COLUMN  sname varchar(25) not null;# Modify
describe student;
ALTER TABLE student
ADD COLUMN enrollmentdatedummy datetime DEFAULT CURRENT_TIMESTAMP  ;
ALTER TABLE student
ADD COLUMN age int UNSIGNED NOT NULL   ;# the UNSIGNED attribute prevents negative values from being inserted into a column: 
ALTER TABLE student
drop column age ;
ALTER TABLE student
ADD COLUMN marks int UNSIGNED    ;

ALTER TABLE student
drop COLUMN enrollmentdatedummy   ;
ALTER TABLE student
ADD COLUMN enrollmentdatedummy datetime DEFAULT CURRENT_TIMESTAMP after marks ;
ALTER TABLE student
drop COLUMN enrollmentdatedummy   ;
rename table student to student_primary;
rename table student_primary to student;

create table customers (id int  AUTO_INCREMENT ,
first_name varchar(20) not null,
last_name varchar(20) not null,
country varchar(20) default 'India',
primary key(id) 
);

create table Orders ( OrderId int  AUTO_INCREMENT,
customerid int,
primary key(OrderId),
foreign key(customerid) references customers(id)

);

ALTER TABLE orders
ADD COLUMN OrderNumber int NOT NULL after OrderId ;
ALTER TABLE student
ADD COLUMN OrderNumber INT NOT NULL FIRST ;#The FIRST Keyword is used to add the column as the first column of the table
ALTER TABLE student
drop column OrderNumber;


INSERT INTO customers (first_name, last_name, country) 
VALUES ('Somnath', 'Sharma', 'USA');
INSERT INTO customers (first_name, last_name, country) 
VALUES ('Somnath1', 'Sharma1', null);
INSERT INTO customers (first_name, last_name, country) 
VALUES ('Somnath2', 'Sharma2', null);
INSERT INTO customers (first_name, last_name, country) 
VALUES ('Somnath3', 'Sharma3', 'USA');
INSERT INTO customers (first_name, last_name) 
VALUES ('Somnath3', 'Sharma3'); # to add default omit the column name

insert into orders (orderNumber,customerid) values(1234,1);
insert into orders (orderNumber,customerid) values(15234,2);
insert into orders (orderNumber,customerid) values(16234,3);
insert into orders (orderNumber,customerid) values(15734,4);
insert into orders (orderNumber,customerid) values(5677,5);

Select * from student;
ALTER TABLE student
modify COLUMN  email varchar(255) not null unique check (email like '%corp.com');
ALTER TABLE student
modify COLUMN  sex char(1) not null  check (sex ='M' Or sex='F');
describe student;
ALTER TABLE student DROP PRIMARY KEY;
#**********************
CREATE TABLE Employees (
    EmployeeID INT  PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    HireDate DATE NOT NULL
);

CREATE TABLE Departments (
    DepartmentID INT  PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Projects (
    ProjectID INT  PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Budget DECIMAL(15, 2) NOT NULL
);

SHOW TABLES;
SHOW DATABASES;
DESCRIBE Projects;
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'Ravi', 'Kumar', 'IT', 70000, '2021-01-15'),
(2, 'Sita', 'Verma', 'HR', 60000, '2020-03-12'),
(3, 'Anil', 'Reddy', 'Finance', 75000, '2019-07-19'),
(4, 'Ravi', 'Sharma', 'IT', 70000, '2022-11-05'),
(5, 'Sunita', 'Nair', 'Marketing', 68000, '2021-06-25');
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) 
VALUES (103, 'Ravi', NULL, 'IT', 70000.00, '2022-11-05');
INSERT INTO Employees 
VALUES (100, 'Ravi', NULL, 'IT', 70000.00, '2021-01-15');

INSERT INTO Employees 
VALUES (101, 'Sita', NULL, 'HR', 60000.00, '2020-03-12');



INSERT INTO Employees (EmployeeID, LastName,FirstName,Department, Salary, HireDate) 
VALUES (104, 'Sunita', 'Patil', 'Marketing', 68000.00, '2021-06-25');
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES
(1, 'IT', 1),
(2, 'HR', 2),
(3, 'Finance', 3),
(4, 'Marketing', 5);

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, Budget) VALUES
(1, 'Project Alpha', '2021-02-01', '2022-02-01', 1500000),
(2, 'Project Beta', '2020-05-15', '2021-05-15', 1200000),
(3, 'Project Gamma', '2019-08-20', '2020-08-20', 1300000),
(4, 'Project Delta', '2021-09-01', '2022-09-01', 1400000),
(5, 'Project Epsilon', '2022-01-10', '2023-01-10', 1600000);

SELECT e.EmployeeID, d.DepartmentName
FROM employees e
CROSS JOIN departments d;

# INNER JOIN (Intersection) This query retrieves only the employees who have a valid department.
SELECT e.EmployeeID,e.FirstName, d.DepartmentName,d.DepartmentID,d.ManagerID
FROM employees e
INNER JOIN departments d on e.EmployeeID=d.ManagerID;

# Select required columns:


SELECT FirstName, LastName FROM Employees;
# Limit rows:
SELECT * FROM Employees LIMIT 3;

# Offset rows:Give records after second record and only 2 records


SELECT * FROM Employees LIMIT 2 OFFSET 2;

# WHERE clause with IN:



# WHERE clause with =:


SELECT * FROM Employees WHERE FirstName = 'Ravi';
# WHERE clause with !=:


SELECT * FROM Employees WHERE Salary != 70000;
SELECT * FROM Employees WHERE Salary <> 70000;


SELECT * FROM Employees WHERE Department IN ('IT', 'HR');

# WHERE clause with NOT IN:


SELECT * FROM Employees WHERE Department NOT IN ('IT', 'HR');
-- Examples using AND, OR, IN, NOT IN

-- 1. Using AND to combine conditions
SELECT * FROM Employees WHERE Department = 'IT' AND Salary > 60000;

-- 2. Using OR to combine conditions
SELECT * FROM Employees WHERE Department = 'IT' OR Department = 'HR';

Select * from Employees Where Department="IT" and Salary=60000;
-- 3. Using AND and OR together
-- SELECT * FROM Employees WHERE (Department = 'IT' OR Department = 'HR') AND Salary > 60000;

-- 4. Using IN to specify multiple values in a condition
-- SELECT * FROM Employees WHERE Department IN ('IT', 'HR', 'Finance');

-- 5. Using NOT IN to exclude multiple values
-- SELECT * FROM Employees WHERE Department NOT IN ('IT', 'HR');

-- 6. Combining IN with another condition
-- SELECT * FROM Employees WHERE Department IN ('IT', 'HR') AND Salary > 60000;

-- 7. Using BETWEEN to specify a range
SELECT * FROM Employees WHERE Salary BETWEEN 60000 AND 75000;
-- 8. Using LIKE with wildcards for pattern matching
-- SELECT * FROM Employees WHERE FirstName LIKE 'R%';

-- 9. Using IS NULL to check for NULL values
-- SELECT * FROM Employees WHERE ManagerID IS NULL;

-- 10. Using IS NOT NULL to check for non-NULL values
-- SELECT * FROM Employees WHERE ManagerID IS NOT NULL;

# ORDER BY clause:

SELECT * FROM Employees ORDER BY Salary DESC;
# Using _ for character matching in WHERE clause:

SELECT * FROM Employees WHERE FirstName LIKE 'R_vi';
# Using % for wildcard matching in WHERE clause:

SELECT * FROM Employees WHERE FirstName LIKE '%avi%';
# Simple aggregation - SUM():

SELECT SUM(Salary) AS TotalSalary FROM Employees;
-- Simple aggregation - AVG():

SELECT AVG(Salary) AS AverageSalary FROM Employees;
SELECT MIN(Salary) AS MinimumSalary FROM Employees;
-- Simple aggregation - MAX():

SELECT MAX(Salary) AS MaximumSalary FROM Employees;
-- Date conversion function:


SELECT STR_TO_DATE('2021-01-15', '%Y-%m-%d') AS ConvertedDate;
SELECT CAST(Salary AS CHAR) AS SalaryString FROM Employees;
Describe employees;
-- String function - LOWER():

SELECT LOWER(FirstName) AS LowerFirstName FROM Employees;
-- String function - UPPER():

SELECT UPPER(FirstName) AS UpperFirstName FROM Employees;
-- String function - SUBSTRING():
SELECT SUBSTRING(FirstName, 1, 3) AS SubFirstName FROM Employees;
-- String function - REVERSE():

SELECT REVERSE(FirstName) AS ReversedFirstName FROM Employees;
SELECT LENGTH(FirstName) AS FirstNameLength FROM Employees;
-- Math function - ROUND():
SELECT ROUND(Salary, 1) AS RoundedSalary FROM Employees;
-- String function - CHAR_LENGTH():

SELECT CHAR_LENGTH(FirstName) AS FirstNameCharLength FROM Employees;













