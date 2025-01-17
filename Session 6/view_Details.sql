-- Employees table
create database Mtech07012024;
use Mtech07012024;
CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  department_id INT
);

INSERT INTO employees VALUES
(1, 'John', 'Doe', 1),
(2, 'Jane', 'Smith', 2),
(3, 'Bob', 'Johnson', 1),
(4, 'Alice', 'Williams', 3),
(5, 'Charlie', 'Brown', 2);

-- Departments table
CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');


-- View joining employees and departments
CREATE VIEW employee_department_view_updatable AS
SELECT employees.employee_id, employees.first_name, employees.last_name, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id
;
select * from employee_department_view_updatable;

INSERT INTO employee_department_view_updatable (employee_id, first_name, last_name, department_name)
VALUES (6, 'Eva', 'Miller', 'IT');

-- Valid update in the view
UPDATE employee_department_view_updatable
SET department_name = 'Finance'
WHERE employee_id = 4;
select * from departments;
select * from employees;
select * from employee_department_view_updatable where employee_id = 4;
-- Valid delete from the view
DELETE FROM employee_department_view_updatable
WHERE employee_id = 5;



INSERT INTO employees VALUES
(6, 'Ullas', 'Rao', 1);
create view  horizontal_View  as(
select * from employees);
INSERT INTO horizontal_View VALUES
(7, 'ABC', 'Rao', 3);
select * from horizontal_View;
select * from employees;
delete from  horizontal_View where employee_id =7;
select * from employees;
create view horizontal_view_filter as
( select * from employees where department_id <3);
INSERT INTO horizontal_view_filter VALUES
(8, 'ABC', 'VCD', 4);
select * from horizontal_view_filter;
select * from employees;
create view horizontal_view_filter_wc as
 select * from employees where department_id <3 WITH CHECK OPTION;

INSERT INTO horizontal_view_filter_wc VALUES
(8, 'ABC', 'VCD', 3);

create view vertical_view as ( 
select first_name,last_name from employees);

create view  sample as(
select first_name,last_name from employees where department_id<3)
