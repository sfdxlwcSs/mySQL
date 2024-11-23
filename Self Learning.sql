# In SQL, the WITH clause (also known as Common Table Expressions (CTEs)) is used to define temporary 
# result sets that can be referred to within a SELECT, INSERT, UPDATE, or DELETE statement. These temporary tables are only available for the duration of the query,
#  and they help make complex queries more readable and manageable.

create database SelfLearning;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

ALTER TABLE employees
ADD salary DECIMAL(10, 2);


CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    product_id INT,
    sales_amount DECIMAL(10, 2),
    sale_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE transaction (
    transaction_id INT PRIMARY KEY,
    acct_num INT,
    transaction_date DATE,
    channel VARCHAR(50),
    amount DECIMAL(10, 2),
    FOREIGN KEY (acct_num) REFERENCES account(acct_num)
);


CREATE TABLE account (
    acct_num INT PRIMARY KEY,
    acct_holder_name VARCHAR(100),
    balance DECIMAL(15, 2)
);

INSERT INTO employees (employee_id, first_name, last_name, department, manager_id)
VALUES
(1, 'John', 'Doe', 'Sales', NULL),        -- John is the manager
(2, 'Jane', 'Smith', 'Sales', 1),          -- Jane reports to John
(3, 'Sam', 'Brown', 'HR', NULL),           -- Sam is an HR manager
(4, 'Emily', 'Davis', 'Sales', 1),         -- Emily reports to John
(5, 'Michael', 'Johnson', 'HR', 3);        -- Michael reports to Sam

UPDATE employees
SET salary = CASE employee_id
    WHEN 1 THEN 5000.00 -- John
    WHEN 2 THEN 3000.00 -- Jane
    WHEN 3 THEN 4000.00 -- Emily
    WHEN 4 THEN 6000.00 -- Sam
    WHEN 5 THEN 3500.00 -- Michael
END;


INSERT INTO sales (sale_id, employee_id, product_id, sales_amount, sale_date)
VALUES
(1, 2, 101, 200.50, '2024-10-15'),    -- Jane sold product 101
(2, 2, 102, 150.00, '2024-10-16'),    -- Jane sold product 102
(3, 4, 101, 300.75, '2024-10-17'),    -- Emily sold product 101
(4, 4, 103, 100.00, '2024-10-18'),    -- Emily sold product 103
(5, 2, 103, 450.20, '2024-10-20');    -- Jane sold product 103

INSERT INTO products (product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 1000.00),
(102, 'Smartphone', 'Electronics', 500.00),
(103, 'Headphones', 'Electronics', 150.00);

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
(1, 1, '2024-10-01', 1500.00),  -- Customer 1 placed an order
(2, 2, '2024-10-03', 650.00),   -- Customer 2 placed an order
(3, 3, '2024-10-05', 200.00);   -- Customer 3 placed an order

INSERT INTO transaction (transaction_id, acct_num, transaction_date, channel, amount)
VALUES
(1, 101, '2024-10-01', 'ATM Withdrawal', 500.00),  -- Account 101 made an ATM withdrawal
(2, 102, '2024-10-02', 'ATM Withdrawal', 200.00),  -- Account 102 made an ATM withdrawal
(3, 101, '2024-10-03', 'ATM Withdrawal', 150.00),  -- Account 101 made another ATM withdrawal
(4, 103, '2024-10-04', 'ATM Withdrawal', 400.00);  -- Account 103 made an ATM withdrawal

INSERT INTO account (acct_num, acct_holder_name, balance)
VALUES
(101, 'John Doe', 1500.00),
(102, 'Jane Smith', 1200.00),
(103, 'Emily Davis', 500.00),
(104, 'Michael Johnson', 800.00);

# *********************************


Use SelfLearning;
WITH Temp AS (
    SELECT employee_id, first_name, last_name
    FROM employees
    WHERE department = 'Sales'
)
SELECT * FROM Temp; #note this query runs  with Select * from Temp

 SELECT employee_id, first_name, last_name
    FROM employees
    WHERE department = 'Sales';

SELECT employee_id, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY employee_id;
   #  
#     Explanation:
# The WITH clause creates a CTE TotalSales that calculates the total sales for each employee.
# The main query then joins the employees table with the TotalSales CTE to return employees with sales greater than 500.
    WITH TotalSales AS (
    SELECT employee_id, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY employee_id
)
SELECT e.first_name, e.last_name, ts.total_sales
FROM employees e
JOIN TotalSales ts ON e.employee_id = ts.employee_id
WHERE ts.total_sales > 500;

SELECT employee_id, salary,
       SUM(salary) OVER (PARTITION BY department ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_salary
FROM employees;





