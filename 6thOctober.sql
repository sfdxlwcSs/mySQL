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

SELECT firstname,POSITION('a' IN FirstName) AS PositionA FROM Employees;
-- return the first non null values from left to right
SELECT employeeId,FirstName,LastName, COALESCE( LastName,employeeId) AS NonNullFirstName FROM Employees;
--  if you wish row number then the below syntax is applicable 
SELECT 
    ROW_NUMBER() OVER() AS RowNumber, 
    EmployeeID, 
    FirstName, 
    LastName, 
    Department, 
    Salary, 
    HireDate
FROM employees;
-- CONCAT_WS(separator, expression1, expression2, expression3,...)
SELECT CONCAT_WS('-', FirstName, LastName,Salary) AS FullName FROM Employees;
SELECT CURDATE() AS CurrentDate;
SELECT DATE_ADD(HireDate, INTERVAL 1 YEAR) AS NextYear FROM Employees;
SELECT DATE_SUB(HireDate, INTERVAL 1 MONTH) AS PreviousMonth FROM Employees;

SELECT LEFT(FirstName, 2) AS FirstTwoChars FROM Employees;
-- String function - RIGHT():

SELECT RIGHT(FirstName, 2) AS LastTwoChars FROM Employees;
-- Math function - ABS(): The ABS() function returns the absolute (positive) value of a number.
SELECT ABS(-Salary) AS AbsoluteSalary FROM Employees;
SELECT MOD(Salary, 10000) AS SalaryMod FROM Employees;
SELECT REPEAT(FirstName, 2) AS RepeatedName FROM Employees;
SELECT REPLACE(FirstName, 'a', 'A') AS ReplacedName FROM Employees;
SELECT FirstName FROM Employees;
SELECT DepartmentName FROM Departments;

SELECT FirstName FROM Employees
UNION
SELECT DepartmentName FROM Departments;
-- Union All:
SELECT FirstName FROM Employees
UNION ALL
SELECT DepartmentName FROM Departments;
-- The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL:
-- The UNION operator is used to combine the result-set of two or more SELECT statements.

-- Every SELECT statement within UNION must have the same number of columns
-- The columns must also have similar data types
-- The columns in every SELECT statement must also be in the same order

SELECT FIELD(Department, 'HR', 'IT', 'Finance') AS DepartmentOrder FROM Employees;
SELECT DATEDIFF(CURDATE(), HireDate) AS DaysSinceHire FROM Employees;
-- String function - FIELD():
-- SELECT CEIL(Salary / 1000) * 1000 AS CeilSalary FROM Employees;
-- Math function - FLOOR():
-- 62. String function - ASCII()
-- SELECT ASCII(FirstName) AS AsciiValue FROM Employees;

-- 63. String function - HEX()
-- SELECT HEX(FirstName) AS HexValue FROM Employees;

-- 64. String function - UNHEX()
-- SELECT UNHEX('52617669') AS UnhexValue;

-- 65. String function - SPACE()
SELECT CONCAT(FirstName, SPACE(5), LastName) AS FullNameWithSpace FROM Employees;




-- SELECT FLOOR(Salary / 1000) * 1000 AS FloorSalary FROM Employees;
-- String function - REPEAT():
-- =

-- SELECT REPEAT(FirstName, 2) AS RepeatedName FROM Employees;
-- String function - REPLACE():

-- SELECT REPLACE(FirstName, 'a', 'A') AS ReplacedName FROM Employees;
-- CASE statements:


SELECT FirstName,
       Salary,
       CASE
           WHEN Salary > 70000 THEN 'High'
           ELSE 'Low'
       END AS SalaryRange
FROM Employees;

-- 61. String function - FIND_IN_SET()
SELECT FIND_IN_SET('IT', 'HR,IT,Finance') AS PositionInSet;

-- 66. String function - ELT()
SELECT ELT(1, 'HR', 'IT', 'Finance') AS SecondElement;

-- 67. Math function - PI()
SELECT PI() AS PiValue;

-- 68. Math function - COS()
SELECT COS(0) AS CosValue;

-- 69. Math function - SIN()
SELECT SIN(PI() / 2) AS SinValue;

-- 70. Math function - TAN()
-- SELECT TAN(PI() / 4) AS TanValue;
-- 71. Math function - EXP()
-- SELECT EXP(1) AS ExpValue;

-- 72. Math function - LOG()
-- SELECT LOG(10) AS LogValue;

-- 73. Math function - LOG10()
-- SELECT LOG10(100) AS Log10Value;

-- 74. Math function - DEGREES()
-- SELECT DEGREES(PI()) AS DegreesValue;

-- 75. Math function - RADIANS()
-- SELECT RADIANS(180) AS RadiansValue;

-- 76. String function - QUOTE()
SELECT QUOTE(FirstName) AS QuotedName FROM Employees;

-- 77. String function - BIN()
-- SELECT BIN(EmployeeID) AS BinaryID FROM Employees;

-- 78. String function - OCT()
SELECT EmployeeID,OCT(EmployeeID) AS OctalID FROM Employees;

-- 79. String function - LPAD() with spaces
SELECT LPAD(FirstName, 10, ' ') AS PaddedNameWithSpaces FROM Employees;

-- 80. String function - RPAD() with spaces
SELECT RPAD(FirstName, 10, ' ') AS PaddedNameWithSpaces FROM Employees;
-- 1. Replace all occurrences of 'a' with 'A' in the FirstName column of the Employees table.
SELECT REPLACE(FirstName, 'a', 'A') AS ReplacedFirstName FROM Employees;

-- 2. Replace all occurrences of ' ' (space) with '-' in the LastName column of the Employees table.
SELECT REPLACE(LastName, ' ', '-') AS ReplacedLastName FROM Employees;

-- 3. Replace all occurrences of 'Ravi' with 'Raj' in the FirstName column of the Employees table.
SELECT REPLACE(FirstName, 'Ravi', 'Raj') AS ReplacedFirstName FROM Employees;

-- 4. Replace all occurrences of 'IT' with 'Information Technology' in the Department column of the Employees table.
SELECT REPLACE(Department, 'IT', 'Information Technology') AS ReplacedDepartment FROM Employees;
-- 5. Replace all occurrences of 'Project' with 'Initiative' in the ProjectName column of the Projects table.
SELECT REPLACE(ProjectName, 'Project', 'Initiative') AS ReplacedProjectName FROM Projects;
-- Student Table

CREATE TABLE Student (
    StudentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE
);

-- Courses Table

CREATE TABLE Courses (
    CourseID INT,
    CourseName VARCHAR(100),
    Credits INT
);




-- Inserting Data into Student Table

INSERT INTO Student (StudentID, FirstName, LastName, DateOfBirth) VALUES
(1, 'John', 'Doe', '2001-05-15'),
(2, 'Jane', 'Smith', '2000-10-22'),
(3, 'Emily', 'Jones', '2002-03-30'),
(4, 'Michael', 'Brown', '2001-07-19');

INSERT INTO Student (StudentID, FirstName, LastName, DateOfBirth) VALUES
(5, 'Alice', 'Williams', '2003-02-14'),
(6, 'Bob', 'Taylor', '2000-12-05'),
(7, 'Charlie', 'Harris', '2001-09-27'),
(8, 'Diana', 'Clark', '2002-04-12'),
(9, 'Eve', 'Martin', '2003-06-20');

-- Inserting Data into Courses Table

INSERT INTO Courses (CourseID, CourseName, Credits) VALUES
(101, 'Introduction to Programming', 4),
(102, 'Database Systems', 3),
(103, 'Web Development', 4),
(104, 'Data Structures', 3);

INSERT INTO Courses (CourseID, CourseName, Credits) VALUES
(105, 'Machine Learning', 4),
(106, 'Artificial Intelligence', 4),
(107, 'Computer Networks', 3),
(108, 'Operating Systems', 3),
(109, 'Cybersecurity', 3);

-- Scenarios for ALTER TABLE Commands
-- 1. Adding a Column
-- Scenario: Add a Email column to the Student table.

ALTER TABLE Student
ADD Email VARCHAR(100);

-- 2. Renaming a Column
-- Scenario: Rename CourseName to Title in the Courses table.

ALTER TABLE Courses
RENAME COLUMN CourseName TO Title;

-- 3. Changing Data Type of a Column
-- Scenario: Change the data type of the Credits column in the Courses table from INT to DECIMAL(5, 2).

ALTER TABLE Courses
MODIFY Credits DECIMAL(5, 2);
-- 4. Adding a Primary Key
-- Scenario: Add a primary key to the StudentID column in the Student table.


ALTER TABLE Student
ADD PRIMARY KEY (StudentID);
-- 5. Removing a Primary Key
-- Scenario: Remove the primary key from the StudentID column in the Student table.


ALTER TABLE Student
DROP PRIMARY KEY;

-- 6. Adding a Foreign Key

-- Scenario: Add a CourseID column to the Student table and create a foreign key constraint that references the CourseID in the Courses table.

-- Step 1: Add the CourseID column to the Student table.


ALTER TABLE Student
ADD CourseID INT;

alter TABLE courses
add unique(CourseID);
describe courses;

--  To make below statement work Courses(CourseID) should be either unique or primary or both
ALTER TABLE Student
ADD FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);-- //FK contraints will be automatically named by mySQL
ALTER TABLE student DROP FOREIGN KEY student_ibfk_1;



-- Step 2: Add the foreign key constraint. name  explicitly by us "FK_Course"


ALTER TABLE Student
ADD CONSTRAINT FK_Course
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);



















