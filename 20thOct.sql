create database MtechJuly2024_banking_Class;
CREATE TABLE customer_details (
    customer_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('M', 'F', 'O') NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL UNIQUE, 
    address VARCHAR(255),
    postal_code VARCHAR(10),
    country VARCHAR(50) DEFAULT 'India',
    CONSTRAINT chk_email CHECK (email REGEXP '^[^@]+@[^@]+\.com$'),
    CONSTRAINT chk_postal_code CHECK (postal_code REGEXP '^[0-9]{6}$')
);
CREATE TABLE account (
    account_number CHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    account_type ENUM('SAVINGS', 'CHECKING', 'CREDIT') NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer_details(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE transaction (
    transaction_id VARCHAR(15) PRIMARY KEY,
    account_number CHAR(10),
    transaction_type ENUM('DEPOSIT', 'WITHDRAWAL', 'TRANSFER') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL CHECK (amount > 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_account_number FOREIGN KEY (account_number) REFERENCES account(account_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
INSERT INTO customer_details (customer_id, first_name, last_name, gender, email, phone_number, address, postal_code)
VALUES
('CUST001', 'Arjun', 'Reddy', 'M', 'arjun.reddy@example.com', '9876543210', '123 MG Road', '560001'),
('CUST002', 'Bhavna', 'Sharma', 'F', 'bhavna.sharma@example.com', '8765432109', '456 Brigade Road', '560002'),
('CUST003', 'Chirag', 'Patel', 'M', 'chirag.patel@example.com', '7654321098', '789 Residency Road', '560003'),
('CUST004', 'Divya', 'Singh', 'F', 'divya.singh@example.com', '6543210987', '101 Lavelle Road', '560004'),
('CUST005', 'Esha', 'Jain', 'F', 'esha.jain@example.com', '5432109876', '202 Commercial Street', '560005'),
('CUST006', 'Farhan', 'Khan', 'M', 'farhan.khan@example.com', '4321098765', '303 MG Road', '560006'),
('CUST007', 'Gauri', 'Mehta', 'F', 'gauri.mehta@example.com', '3210987654', '404 Brigade Road', '560007'),
('CUST008', 'Harish', 'Gupta', 'M', 'harish.gupta@example.com', '2109876543', '505 Residency Road', '560008'),
('CUST009', 'Isha', 'Kapoor', 'F', 'isha.kapoor@example.com', '1098765432', '606 Lavelle Road', '560009'),
('CUST010', 'Jatin', 'Verma', 'M', 'jatin.verma@example.com', '0987654321', '707 Commercial Street', '560010');

INSERT INTO account (account_number, customer_id, account_type, balance)
VALUES
('ACC0000001', 'CUST001', 'SAVINGS', 1000.00),
('ACC0000002', 'CUST002', 'CHECKING', 500.00),
('ACC0000003', 'CUST003', 'CREDIT', 200.00),
('ACC0000004', 'CUST004', 'SAVINGS', 1500.00),
('ACC0000005', 'CUST005', 'CHECKING', 750.00),
('ACC0000006', 'CUST006', 'CREDIT', 300.00),
('ACC0000007', 'CUST007', 'SAVINGS', 2000.00),
('ACC0000008', 'CUST008', 'CHECKING', 1000.00),
('ACC0000009', 'CUST009', 'CREDIT', 400.00),
('ACC0000010', 'CUST010', 'SAVINGS', 2500.00);


INSERT INTO transaction (transaction_id, account_number, transaction_type, amount)
VALUES
('T0000000001', 'ACC0000001', 'DEPOSIT', 100.00),
('T0000000002', 'ACC0000001', 'WITHDRAWAL', 50.00),
('T0000000003', 'ACC0000002', 'DEPOSIT', 200.00),
('T0000000004', 'ACC0000002', 'WITHDRAWAL', 100.00),
('T0000000005', 'ACC0000003', 'DEPOSIT', 150.00),
('T0000000006', 'ACC0000003', 'WITHDRAWAL', 75.00),
('T0000000007', 'ACC0000004', 'DEPOSIT', 300.00),
('T0000000008', 'ACC0000004', 'WITHDRAWAL', 150.00),
('T0000000009', 'ACC0000005', 'DEPOSIT', 400.00),
('T0000000010', 'ACC0000005', 'WITHDRAWAL', 200.00),
('T0000000011', 'ACC0000006', 'DEPOSIT', 250.00),
('T0000000012', 'ACC0000006', 'WITHDRAWAL', 125.00),
('T0000000013', 'ACC0000007', 'DEPOSIT', 500.00),
('T0000000014', 'ACC0000007', 'WITHDRAWAL', 250.00),
('T0000000015', 'ACC0000008', 'DEPOSIT', 600.00),
('T0000000016', 'ACC0000008', 'WITHDRAWAL', 300.00),
('T0000000017', 'ACC0000009', 'DEPOSIT', 700.00),
('T0000000018', 'ACC0000009', 'WITHDRAWAL', 350.00),
('T0000000019', 'ACC0000010', 'DEPOSIT', 800.00),
('T0000000020', 'ACC0000010', 'WITHDRAWAL', 400.00);

----------------------------
--  constraint voliation 

-- Account table is child table  and customer is parent
INSERT INTO account (account_number, customer_id, account_type, balance)
VALUES ('ACC0000011', 'CUST999', 'SAVINGS', 1200.00);
-- to fix
INSERT INTO customer_details (customer_id, first_name, last_name, gender, email, phone_number, address, postal_code)
VALUES
('CUST999', 'Somnath', 'Reddy', 'M', 'Somnath.reddy@example.com', '7876543210', '1233 MEG Road', '560100');
delete from customer_details where customer_id='CUST999';
INSERT INTO customer_details (customer_id, first_name, last_name, gender, email, phone_number, address, postal_code)
VALUES ('CUST011', 'Karan', 'Singh', 'M', 'karan.singhexample.com', '9876543211', '808 Koramangala', '560011');
-- fix 
INSERT INTO customer_details (customer_id, first_name, last_name, gender, email, phone_number, address, postal_code)
VALUES ('CUST011', 'Karan', 'Singh', 'M', 'karan@singhexample.com', '9876543211', '808 Koramangala', '560011');
INSERT INTO customer_details (customer_id, first_name, last_name, gender, email, phone_number, address, postal_code)
VALUES ('CUST012', 'Lata', 'Kumar', 'F', 'lata.kumar@example.com', '8765432110', '909 Indiranagar', '5601A');
-- fix only numeric
INSERT INTO customer_details (customer_id, first_name, last_name, gender, email, phone_number, address, postal_code)
VALUES ('CUST012', 'Lata', 'Kumar', 'F', 'lata.kumar@example.com', '8765432110', '909 Indiranagar', '560101');

describe account;
CREATE TABLE deposits (
    account_number CHAR(10),
    amount DECIMAL(15, 2),
    deposit_date DATE
);

CREATE TABLE withdrawals (
    account_number CHAR(10),
    amount DECIMAL(15, 2),
    withdrawal_date DATE
);
-- Insert sample data
INSERT INTO deposits (account_number, amount, deposit_date)
VALUES
('ACC0000001', 100.00, '2024-07-20'),
('ACC0000002', 200.00, '2024-07-21');

INSERT INTO withdrawals (account_number, amount, withdrawal_date)
VALUES
('ACC0000001', 50.00, '2024-07-22'),
('ACC0000003', 75.00, '2024-07-23');
select * from withdrawals;
select * from deposits;

SELECT transaction_id, transaction_date, 
       CONVERT_TZ(transaction_date, '+00:00', '+05:30') AS transaction_date_IST
FROM transaction;

SELECT 
    transaction_id,
    account_number,
    transaction_type,
    amount,
    transaction_date,
    CASE
        WHEN amount < 100 THEN 'Low'
        WHEN amount BETWEEN 100 AND 500 THEN 'Medium'
        WHEN amount > 500 THEN 'High'
        ELSE 'Unknown'
           END AS amount_category
FROM transaction;
-- even inside aggregate queries we can write case statement -PIVOT COLUMN
SELECT
    transaction_type,
    SUM(CASE WHEN amount < 100 THEN amount ELSE 0 END) AS total_low,
    SUM(CASE WHEN amount BETWEEN 100 AND 500 THEN amount ELSE 0 END) AS total_medium,
    SUM(CASE WHEN amount > 500 THEN amount ELSE 0 END) AS total_high
FROM transaction
GROUP BY transaction_type;

CREATE DATABASE HR;
-- refer joins file


