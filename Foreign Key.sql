CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    dept_ref INT,
    FOREIGN KEY (dept_ref) REFERENCES departments(department_id)
);
INSERT INTO departments (department_id, department_name) VALUES (1, 'HR');
INSERT INTO employees (employee_id, employee_name, dept_ref) VALUES (1, 'John Doe', 1); 


