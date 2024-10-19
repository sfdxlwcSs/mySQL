select departmentname from departments; 
select FirstName from employees group by Department; -- this will give error
-- Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'mtechlearning.employees.FirstName' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
# You are selecting FirstName, but it is not part of an aggregate function (e.g., COUNT, MAX, MIN, etc.) 
# and is not included in the GROUP BY clause. MySQL doesn't know which FirstName to return for each
#  Department since there could be multiple FirstNames for each Department.
select Department from employees group by Department; 
select Department,count(*) from employees group by Department; 
select Department,count(EmployeeID) from employees group by Department; 

SELECT FirstName, Department ,count(*)
FROM employees 
GROUP BY FirstName, Department;

select Department,avg(Salary)
FROM employees 
GROUP BY Department;

select count(*),year(hiredate)
FROM employees 
GROUP BY year(hiredate); -- year wise employee data hired

select count(*),year(hiredate)
FROM employees 
where Department='IT'
GROUP BY year(hiredate); -- first filter by data then apply aggregation

-- how many people have same last name

select count(*) ,lastname
from employees
group by lastname;

-- total salary department wise count(1)
select count(1) ,sum(salary),Department
from employees
group by Department;
select count(3) ,sum(salary),Department
from employees
group by Department; -- same result as above

select count(1) ,count(lastname)
from employees; -- count does not work on null values observe no grp by

select firstname,lastname,count(*)
from employees
group by firstname,lastname; -- 2 Ravi which are duplicate Ravi null firstname and last name combo not unique

select firstname,lastname,count(*)
from employees
group by firstname,lastname
having count(*)>1;  -- duplicate records identify on the basis of first name and lastname

--  find sum of salary for department where Sum of salary is > 210000

Select Department,sum(salary) as TotalSalary from employees
 group by Department
 having sum(Salary)>210000;
 
 Select Department,sum(salary) as TotalSalary from employees
 group by Department
 having TotalSalary>210000; -- observe the use of aliasing 
 
 -- check if total salary is exceeding a certain no
 Select sum(salary) as SumSal  from employees;
 Select sum(salary) as SumSal
 from employees
 having SumSal>650000; -- observe the use of aliasing 
 














Select * from employees order by 5 desc; -- here 5 refers to Index of Salary column
Select * from employees 
order by 5 desc ,FirstName; 
Select * from employees 
order by 5 desc ,FirstName,lastname; -- null is given priority as its ascii value is 0

select 10 div 2;
-- just a view for all rows
select *,'Somnath' as owner from employees;
SELECT * from(
       Select *,
       CASE
           WHEN Salary > 70000 THEN 'High'
           WHEN Salary =68000 then  'Equal'
           ELSE 'Low' 
       END AS bucket
FROM Employees ) e
order by bucket ;

CREATE TABLE Contractors (
    ContractorID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HourlyRate DECIMAL(10, 2),
    ContractStartDate DATE
);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(106, 'Alice', 'Smith', 'Engineering', 70000.00, '2020-01-15'),
(107, 'Bob', 'Johnson', 'Marketing', 80000.00, '2019-11-22'),
(108, 'Charlie', 'Brown', 'Engineering', 75000.00, '2021-06-10');

# Insert Data into Contractors Table

INSERT INTO Contractors (ContractorID, FirstName, LastName, Department, HourlyRate, ContractStartDate) VALUES
(1, 'Dave', 'Williams', 'Engineering', 65.00, '2023-01-01'),
(2, 'Alice', 'Smith', 'Engineering', 70.00, '2024-01-01'),
(3, 'Eve', 'Davis', 'Marketing', 60.00, '2024-07-01');

Select cast(employeeid as char) from employees e;
Select distinct firstname from employees;
Select distinct * from employees; # if table has primarykey this stateemnt does not make any difference





