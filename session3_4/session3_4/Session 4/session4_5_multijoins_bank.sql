-- Creating the Learning Bank Database
CREATE DATABASE IF NOT EXISTS learning_bank;

-- Switch to the Learning Bank Database
USE learning_bank;
select  * from customers where first_name like 'Arjun%';
select * from accounts where customer_id in(4,19);
select customers.customer_id,customers.first_name,customers.last_name,
accounts.account_number,accounts.balance
from customers 
inner join accounts
on customers.customer_id = accounts.customer_id





-- Create Customers Table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(255),
    phone VARCHAR(15)
);

-- Insert Sample Customer Data
INSERT INTO customers (first_name, last_name, address, phone)
VALUES
    ('Aarav', 'Patel', '123 Main Street, City', '9876543210'),
    ('Isha', 'Sharma', '456 Park Avenue, Town', '8765432109'),
    ('Rahul', 'Singh', '789 Oak Lane, Village', '7654321098');

-- Create Accounts Table
CREATE TABLE IF NOT EXISTS accounts (
    account_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert Sample Account Data
INSERT INTO accounts (customer_id, account_type, balance)
VALUES
    (1, 'Loan', 50000.00),
    (2, 'SB', 1000.00),
    (3, 'Current', 5000.00);

-- Create Transactions Table
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(10, 2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_number) REFERENCES accounts(account_number)
);

-- Insert Sample Transaction Data
INSERT INTO transactions (account_number, transaction_type, amount)
VALUES
    (1, 'Deposit', 10000.00),
    (2, 'Withdrawal', 500.00),
    (3, 'Deposit', 2000.00);
    
    -- Insert More Sample Customer Data
INSERT INTO customers (first_name, last_name, address, phone)
VALUES
    ('Arjun', 'Gupta', '111 River Road, City', '9876543211'),
    ('Neha', 'Verma', '222 Hillside Avenue, Town', '8765432108'),
    ('Priya', 'Rajput', '333 Valley Lane, Village', '7654321097'),
    ('Raj', 'Malhotra', '444 Mountain Street, Town', '6543210987'),
    ('Shreya', 'Singh', '555 Grove Avenue, City', '5432109876'),
    ('Vikram', 'Shah', '666 Meadow Lane, Village', '4321098765'),
    ('Kavita', 'Kumar', '777 Ocean Road, City', '3210987654'),
    ('Rohan', 'Nair', '888 Skyline Avenue, Town', '2109876543'),
    ('Anika', 'Pandey', '999 Sunset Lane, Village', '1098765432'),
    ('Aryan', 'Mehta', '123 Star Street, City', '9876543212');

-- Insert More Sample Account Data
INSERT INTO accounts (customer_id, account_type, balance)
VALUES
    (1, 'Loan', 75000.00),
    (1, 'SB', 2500.00),
    (2, 'Loan', 50000.00),
    (2, 'Current', 10000.00),
    (3, 'SB', 3000.00),
    (4, 'Current', 15000.00),
    (5, 'Loan', 60000.00),
    (5, 'SB', 5000.00),
    (6, 'Current', 20000.00),
    (7, 'Loan', 70000.00);

-- Insert More Sample Transaction Data
INSERT INTO transactions (account_number, transaction_type, amount)
VALUES
    (1, 'Deposit', 15000.00),
    (1, 'Withdrawal', 10000.00),
    (1, 'Deposit', 5000.00),
    (1, 'Withdrawal', 2000.00),
    (1, 'Deposit', 1000.00),
    (2, 'Deposit', 20000.00),
    (2, 'Withdrawal', 5000.00),
    (2, 'Deposit', 3000.00),
    (2, 'Withdrawal', 1500.00),
    (2, 'Deposit', 1000.00),
    
    (3, 'Deposit', 8000.00),
    (3, 'Withdrawal', 2000.00),
    (3, 'Deposit', 3000.00),
    (3, 'Withdrawal', 1000.00),
    (3, 'Deposit', 2000.00),
    
    (4, 'Deposit', 10000.00),
    (4, 'Withdrawal', 5000.00),
    (4, 'Deposit', 2000.00),
    (4, 'Withdrawal', 1000.00),
    (4, 'Deposit', 500.00),
    
    (5, 'Deposit', 12000.00),
    (5, 'Withdrawal', 3000.00),
    (5, 'Deposit', 4000.00),
    (5, 'Withdrawal', 2000.00),
    (5, 'Deposit', 1000.00);
    
    -- Insert More Sample Data for Analysis
INSERT INTO customers (first_name, last_name, address, phone)
VALUES
    ('Sunil', 'Mittal', '101 Sunrise Street, City', '9876543200'),
    ('Jaya', 'Shah', '202 Sunset Avenue, Town', '8765432100');

-- Insert More Sample Account Data for Analysis
INSERT INTO accounts (customer_id, account_type, balance)
VALUES
    (11, 'Loan', 80000.00),
    (11, 'SB', 5000.00),
    (12, 'Current', 15000.00);

-- Insert More Sample Transaction Data for Analysis
INSERT INTO transactions (account_number, transaction_type, amount)
VALUES
    (11, 'Deposit', 20000.00),
    (11, 'Withdrawal', 5000.00),
    (11, 'Deposit', 3000.00),
    (11, 'Withdrawal', 2000.00),
    (11, 'Deposit', 1000.00),
    
    (12, 'Deposit', 25000.00),
    (12, 'Withdrawal', 10000.00),
    (12, 'Deposit', 3000.00),
    (12, 'Withdrawal', 1500.00),
    (12, 'Deposit', 1000.00),
    -- Adding potential fraudulent transactions
    (12, 'Withdrawal', 2000000.00), -- Unusual large withdrawal
    (12, 'Deposit', 500000.00);      -- Unusual large deposit



-- Identify Customers with High Account Balances
SELECT c.first_name, c.last_name, MAX(a.balance) AS max_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
HAVING max_balance > 50000.00;


-- Find Customers with Multiple Accounts
SELECT c.first_name, c.last_name, COUNT(DISTINCT a.account_number) AS num_accounts
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id
HAVING num_accounts > 1;

-- Identify Potential Fraudulent Transactions (Large Withdrawals)
SELECT c.first_name, c.last_name, t.transaction_id, t.transaction_type, t.amount
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_number = t.account_number
WHERE t.transaction_type = 'Withdrawal' AND t.amount > 100000.00;

-- Identify Potential Fraudulent Transactions (Large Deposits)
SELECT c.first_name, c.last_name, t.transaction_id, t.transaction_type, t.amount
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_number = t.account_number
WHERE t.transaction_type = 'Deposit' AND t.amount > 5000.00;

-- Identify Customers with Unusual Transaction Patterns
SELECT c.first_name, c.last_name, COUNT(t.transaction_id) AS num_transactions
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_number = t.account_number
GROUP BY c.customer_id
HAVING num_transactions > 10; 

-- Add More Sample Transaction Data for a Customer with Over 10 Transactions per Day
INSERT INTO transactions (account_number, transaction_type, amount, transaction_date)
VALUES
    (5, 'Deposit', 2000.00, '2023-01-10 12:30:00'),
    (5, 'Withdrawal', 500.00, '2023-01-10 14:45:00'),
    (5, 'Deposit', 1000.00, '2023-01-10 15:30:00'),
    (5, 'Withdrawal', 200.00, '2023-01-10 17:15:00'),
    (5, 'Deposit', 1500.00, '2023-01-10 18:45:00'),
    (5, 'Withdrawal', 1000.00, '2023-01-10 19:30:00'),
    (5, 'Deposit', 2000.00, '2023-01-10 21:00:00'),
    (5, 'Withdrawal', 500.00, '2023-01-10 22:30:00'),
    (5, 'Deposit', 1000.00, '2023-01-10 23:15:00'),
    (5, 'Withdrawal', 200.00, '2023-01-10 23:45:00'),
    
    (5, 'Deposit', 1500.00, '2023-01-11 10:30:00'),
    (5, 'Withdrawal', 1000.00, '2023-01-11 12:15:00'),
    (5, 'Deposit', 2000.00, '2023-01-11 14:00:00'),
    (5, 'Withdrawal', 500.00, '2023-01-11 16:45:00'),
    (5, 'Deposit', 1000.00, '2023-01-11 18:30:00'),
    (5, 'Withdrawal', 200.00, '2023-01-11 20:00:00'),
    (5, 'Deposit', 1500.00, '2023-01-11 21:30:00'),
    (5, 'Withdrawal', 1000.00, '2023-01-11 22:15:00'),
    (5, 'Deposit', 2000.00, '2023-01-11 23:45:00'),
    (5, 'Withdrawal', 500.00, '2023-01-11 23:59:59');
    -- Find Customers with More Than 10 Transactions in a Day
SELECT c.customer_id, c.first_name, c.last_name, COUNT(t.transaction_id) AS num_transactions
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_number = t.account_number
GROUP BY c.customer_id, DATE(t.transaction_date)
HAVING num_transactions > 10;



