-- Create `transaction` table
CREATE TABLE transaction (
    transaction_id VARCHAR(15) PRIMARY KEY,
    account_number CHAR(10),
    transaction_type ENUM('DEPOSIT', 'WITHDRAWAL', 'TRANSFER') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL CHECK (amount > 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO transaction (transaction_id, account_number, transaction_type, amount, transaction_date)
VALUES
('T0000000001', 'ACC0000001', 'DEPOSIT', 100.00, '2024-07-20 10:00:00'),
('T0000000002', 'ACC0000001', 'WITHDRAWAL', 50.00, '2024-07-20 11:00:00'),
('T0000000003', 'ACC0000002', 'DEPOSIT', 200.00, '2024-07-20 12:00:00'),
('T0000000004', 'ACC0000002', 'WITHDRAWAL', 150.00, '2024-07-20 13:00:00'),
('T0000000005', 'ACC0000003', 'TRANSFER', 300.00, '2024-07-20 14:00:00'),
('T0000000006', 'ACC0000003', 'DEPOSIT', 400.00, '2024-07-20 15:00:00'),
('T0000000007', 'ACC0000004', 'WITHDRAWAL', 500.00, NULL),  -- NULL date
('T0000000008', NULL, 'TRANSFER', 600.00, '2024-07-20 16:00:00');  -- NULL account_number

-- Simple Examples

-- 1. Count Transactions per Account
SELECT account_number, COUNT(*) AS transaction_count
FROM transaction
GROUP BY account_number;

-- 2. Total Amount per Transaction Type
SELECT transaction_type, SUM(amount) AS total_amount
FROM transaction
GROUP BY transaction_type;

-- 3. Average Amount per Account
SELECT account_number, AVG(amount) AS average_amount
FROM transaction
GROUP BY account_number;

-- 4. Minimum and Maximum Amount per Transaction Type
SELECT transaction_type, MIN(amount) AS min_amount, MAX(amount) AS max_amount
FROM transaction
GROUP BY transaction_type;

-- 5. Total Deposits and Withdrawals per Account
SELECT 
    account_number,
    SUM(CASE WHEN transaction_type = 'DEPOSIT' THEN amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN transaction_type = 'WITHDRAWAL' THEN amount ELSE 0 END) AS total_withdrawals
FROM transaction
GROUP BY account_number;

-- Examples with Handling `NULL` Values

-- 6. Count Transactions with NULL Account Numbers
SELECT COUNT(*) AS null_account_transactions
FROM transaction
WHERE account_number IS NULL;

-- 7. Total Amount for Transactions with NULL Dates
SELECT SUM(amount) AS total_amount
FROM transaction
WHERE transaction_date IS NULL;

-- 8. Group by Account Number Handling NULL
SELECT IFNULL(account_number, 'Unknown') AS account_number, COUNT(*) AS transaction_count
FROM transaction
GROUP BY account_number;

-- 9. Average Amount with NULL Handling
SELECT 
    IFNULL(DATE(transaction_date), 'No Date Provided') AS transaction_date_label,
    AVG(amount) AS average_amount
FROM transaction
GROUP BY transaction_date;

-- 10. Minimum and Maximum Amount Per Transaction Type with NULL
SELECT transaction_type, 
       MIN(amount) AS min_amount, 
       MAX(amount) AS max_amount
FROM transaction
GROUP BY transaction_type;

-- Examples Using Aggregates and HAVING

-- 11. Accounts with More Than 1 Transaction
SELECT account_number, COUNT(*) AS transaction_count
FROM transaction
GROUP BY account_number
HAVING COUNT(*) > 1;

-- 12. Total Amount for Each Transaction Type with Minimum Total
SELECT transaction_type, SUM(amount) AS total_amount
FROM transaction
GROUP BY transaction_type
HAVING SUM(amount) > 500;

-- 13. Accounts with Average Amount Greater Than $200
SELECT account_number, AVG(amount) AS average_amount
FROM transaction
GROUP BY account_number
HAVING AVG(amount) > 200;

-- 14. Transaction Types with Minimum Amount Greater Than $50
SELECT transaction_type, MIN(amount) AS min_amount
FROM transaction
GROUP BY transaction_type
HAVING MIN(amount) > 50;

-- 15. Accounts with Total Withdrawals Less Than $100
SELECT account_number, SUM(CASE WHEN transaction_type = 'WITHDRAWAL' THEN amount ELSE 0 END) AS total_withdrawals
FROM transaction
GROUP BY account_number
HAVING SUM(CASE WHEN transaction_type = 'WITHDRAWAL' THEN amount ELSE 0 END) < 100;

-- More Complex Examples

-- 16. Top 3 Accounts by Total Amount
SELECT account_number, SUM(amount) AS total_amount
FROM transaction
GROUP BY account_number
ORDER BY total_amount DESC
LIMIT 3;

-- 17. Transaction Types with No Deposits
SELECT transaction_type
FROM transaction
GROUP BY transaction_type
HAVING SUM(CASE WHEN transaction_type = 'DEPOSIT' THEN 1 ELSE 0 END) = 0;

-- 18. Total Transactions per Date with More Than 3 Transactions
SELECT DATE(transaction_date) AS transaction_date, COUNT(*) AS transaction_count
FROM transaction
GROUP BY DATE(transaction_date)
HAVING COUNT(*) > 3;

-- 19. Accounts with Highest Average Transaction Amount
SELECT account_number, AVG(amount) AS average_amount
FROM transaction
GROUP BY account_number
ORDER BY average_amount DESC
LIMIT 1;

-- 20. Accounts with Transactions Missing Dates
SELECT account_number
FROM transaction
WHERE transaction_date IS NULL
GROUP BY account_number;
