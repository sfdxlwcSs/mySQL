CREATE DATABASE	 CLASS17121;
USE CLASS17121;
SET sql_safe_updates=0;
SET GLOBAL sql_safe_updates=0;
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(255) 
);
INSERT INTO Authors (AuthorID, AuthorName) VALUES
    (1, 'John Smith'),
    (2, 'Alice Brown'),
    (3, 'Bob Johnson'),
    (4, 'Emily White'),
    (5, 'Charlie Davis'),
    (6, NULL);
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Books (BookID, Title, AuthorID) VALUES
    (101, 'Introduction to SQL', 1),
    (102, 'Python Basics', 2),
    (103, 'Data Science Fundamentals', 1),
    (104, 'Java Programming', 3),
    (105, 'Web Development', 4);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL
);
INSERT INTO Customers (CustomerID, CustomerName) VALUES
    (201, 'John Doe'),
    (202, 'Alice Smith'),
    (203, 'Bob Johnson'),
    (204, 'Emily White'),
    (205, 'Charlie Davis');
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
    (301, 201, '2023-01-01'),
    (302, 202, '2023-01-02'),
    (303, 203, '2023-01-03'),
    (304, 204, '2023-01-04'),
    (305, 205, '2023-01-05');
    CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT ,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO OrderDetails (OrderDetailID, OrderID, BookID, Quantity, Price) VALUES
    (401, 301, 101, 2, 30.00),
    (402, 302, 103, 1, 45.00),
    (403, 303, 104, 3, 20.00),
    (404, 304, 102, 1, 15.00),
    (405, 305, 105, 2, 40.00);
-- Delete Orders for a Specific Customer:
DELETE FROM Orders WHERE CustomerID = 202;
SELECT * FROM ORDERS;
-- Update  0  Prices in OrderDetails with Average Price:
INSERT INTO OrderDetails (OrderDetailID, OrderID, BookID, Quantity, Price) VALUES
    (501, 305, 101, 2, 0);
    INSERT INTO OrderDetails (OrderDetailID, OrderID, BookID, Quantity, Price) VALUES
    (801, 301, 101, null, 0);
    select * from orderdetails;
WITH aVGPR AS (
SELECT AVG(Price) AS AVGP FROM OrderDetails WHERE Price IS NOT NULL) 
UPDATE OrderDetails
SET Price = ( SELECT AVGP FROM aVGPR)
WHERE Price=  0;
SELECT * FROM OrderDetails;
update OrderDetails set price = 0 where orderdetailid= 405;
create database temp;
use temp;
-- on delete cascde
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(255) NOT NULL
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE ON UPDATE CASCADE
);
/* In this example, we have two tables, Authors and Books, with a foreign key relationship between them. 
The AuthorID in the Books table references the AuthorID in the Authors table.
*/
INSERT INTO Authors (AuthorID, AuthorName) VALUES (1, 'John Smith');
INSERT INTO Books (BookID, Title, AuthorID) VALUES (101, 'Introduction to SQL', 1);
-- If we delete the author "John Smith" from the Authors table:
DELETE FROM Authors WHERE AuthorID = 1;
SELECT * FROM Authors;
SELECT * FROM BOOKS;
/*
The ON DELETE CASCADE action will automatically delete all books authored by "John Smith"
 from the Books table. 
In this case, the record with BookID = 101 will be deleted.
*/

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
);
/*
In this example, we have two tables, Customers and Orders, with a foreign key relationship between them. 
The CustomerID in the Orders table references the CustomerID in the Customers table.
*/
INSERT INTO Customers (CustomerID, CustomerName) VALUES (201, 'John Doe');
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES (301, 201, '2023-01-01');
UPDATE Customers SET CustomerName = 'John Smith' WHERE CustomerID = 201;



-- Create the Employee table with duplicates
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(255) NOT NULL
);

-- Insert data with duplicates
INSERT INTO Employee (EmployeeID, EmployeeName) VALUES
(101, 'John Doe'),
(102, 'Jane Doe'),
(103, 'John Doe'),  -- Duplicate
(104, 'Alice Smith'),
(105, 'Bob Johnson'),
(106, 'Jane Doe');  -- Duplicate

-- Delete duplicates from the Employee table using ROW_NUMBER()
DELETE e1
FROM Employee e1
JOIN (
    SELECT EmployeeID, EmployeeName,
           ROW_NUMBER() OVER (PARTITION BY EmployeeName ORDER BY EmployeeID) AS rn
    FROM Employee
) e2 ON e1.EmployeeID = e2.EmployeeID
WHERE e2.rn > 1;

create database nj;
use  nj;
-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    DepartmentID INT,
    Location VARCHAR(255), -- Second common column
    Salary DECIMAL(10, 2),
    CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) -- Second common column
);

-- Insert data into Employees and Departments tables
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Location, Salary) VALUES
(1, 'John', 'Doe', 101, 'Building A', 50000.00),
(2, 'Jane', 'Smith', 102, 'Building B', 60000.00),
(3, 'Bob', 'Johnson', 101, 'Building A', 55000.00);

INSERT INTO Departments (DepartmentID, DepartmentName, Location) VALUES
(101, 'Engineering', 'Building A'),
(102, 'Marketing', 'Building B');

SELECT *
FROM Employees
NATURAL JOIN Departments;
 
 ----
 -- Create Jobs table
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    SalaryBase DECIMAL(10, 2) NOT NULL
);

-- Insert data into Jobs table
INSERT INTO Jobs (JobID, SalaryBase) VALUES
(1, 50000.00),
(2, 60000.00),
(3, 70000.00);

-- Create SalaryDetails table
CREATE TABLE SalaryDetails (
    EmployeeID INT PRIMARY KEY,
    Salary DECIMAL(10, 2),
    JobID INT,
    Experience INT,
    CONSTRAINT FK_SalaryDetails_Jobs FOREIGN KEY (JobID) REFERENCES Jobs(JobID)
);

-- Insert data into SalaryDetails table
INSERT INTO SalaryDetails (EmployeeID, Salary, JobID, Experience) VALUES
(101, NULL, 1, 2),
(102, NULL, 2, 3),
(103, NULL, 3, 5);

-- Update SalaryDetails with values from SalaryBase in Jobs multiplied by Experience

UPDATE SalaryDetails
JOIN Jobs ON SalaryDetails.JobID = Jobs.JobID
SET SalaryDetails.Salary = Jobs.SalaryBase * SalaryDetails.Experience;



CREATE TABLE your_table (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

INSERT INTO your_table (id, name, age, city) VALUES
(1, 'Alice', 25, 'New York'),
(2, 'Bob', 30, 'Los Angeles'),
(3, 'Alice', 25, 'New York'),
(4, 'Charlie', 22, 'Chicago'),
(5, 'Bob', 30, 'Los Angeles');

SELECT *
FROM (
    SELECT
        your_table.*,
        ROW_NUMBER() OVER (PARTITION BY name, age, city ORDER BY id) AS row_num
    FROM your_table
) AS numbered_rows
WHERE row_num > 1;

