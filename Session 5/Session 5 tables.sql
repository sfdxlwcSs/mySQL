create database session5;
use  session5;
drop table TRANSACTION;
drop table customer;
drop table account;
CREATE TABLE TRANSACTION (
    Trans_ID INT,
    Acct_Num INT,
    Tran_Amount DECIMAL(10, 2),
    Tran_Date DATE,
    Channel VARCHAR(50)
);
CREATE TABLE CUSTOMER (
    CustID INT,
    CustName VARCHAR(100),
    CustAddress VARCHAR(200)
);
CREATE TABLE ACCOUNT (
    Acct_Num INT,
    CustID INT,
    Balance DECIMAL(10, 2),
    Acct_type VARCHAR(50),
    Acct_status VARCHAR(50)
);

CREATE TABLE INTEREST (
    Acct_type VARCHAR(50),
    rate DECIMAL(5, 2)
);


CREATE TABLE MESSAGE (
    Msg_ID INT,
    Event VARCHAR(50),
    Event_Dt DATE
);
CREATE TABLE PROFIT_LOSS (
    Branch VARCHAR(50),
    Product VARCHAR(50),
    Estimated_profit DECIMAL(10, 2)
);



INSERT INTO ACCOUNT (Acct_Num, CustID, Balance, Acct_type, Acct_status) VALUES
(1001, 1, 1500.00, 'Savings', 'Active'),
(1002, 2, 3000.00, 'Checking', 'Active'),
(1003, 3, 2500.00, 'Savings', 'Inactive'),
(1004, 4, 4000.00, 'Checking', 'Active'),
(1005, 5, 1000.00, 'Savings', 'Active'),
(1006, 6, 2200.00, 'Checking', 'Inactive'),
(1007, 7, 3300.00, 'Savings', 'Active'),
(1008, 8, 1400.00, 'Checking', 'Active'),
(1009, 9, 1100.00, 'Savings', 'Inactive'),
(1010, 10, 1200.00, 'Checking', 'Active'),
(1011, 11, 2300.00, 'Savings', 'Inactive'),
(1012, 12, 3400.00, 'Checking', 'Active'),
(1013, 13, 4500.00, 'Savings', 'Active'),
(1014, 14, 5600.00, 'Checking', 'Inactive'),
(1015, 15, 6700.00, 'Savings', 'Active'),
(1016, 16, 7800.00, 'Checking', 'Inactive'),
(1017, 17, 8900.00, 'Savings', 'Active'),
(1018, 18, 9100.00, 'Checking', 'Active'),
(1019, 19, 10200.00, 'Savings', 'Inactive'),
(1020, 20, 11300.00, 'Checking', 'Active');

INSERT INTO TRANSACTION (Trans_ID, Acct_Num, Tran_Amount, Tran_Date, Channel) VALUES
(1, 1001, 200.00, '2020-04-24', 'ATM withdrawal'),
(2, 1002, 300.00, '2020-04-23', 'Online transfer'),
(3, 1003, 150.00, '2020-04-24', 'ATM withdrawal'),
(4, 1004, 400.00, '2020-04-22', 'Branch deposit'),
(5, 1001, 100.00, '2020-04-24', 'ATM withdrawal'),
(6, 1005, 50.00, '2020-04-21', 'ATM withdrawal'),
(7, 1006, 220.00, '2020-04-24', 'ATM withdrawal'),
(8, 1007, 330.00, '2020-04-20', 'Online transfer'),
(9, 1008, 140.00, '2020-04-19', 'Branch deposit'),
(10, 1009, 110.00, '2020-04-18', 'Online transfer'),
(11, 1010, 120.00, '2020-04-17', 'Branch deposit'),
(12, 1011, 230.00, '2020-04-16', 'ATM withdrawal'),
(13, 1012, 340.00, '2020-04-15', 'Online transfer'),
(14, 1013, 450.00, '2020-04-14', 'ATM withdrawal'),
(15, 1014, 560.00, '2020-04-24', 'ATM withdrawal'),
(16, 1015, 670.00, '2020-04-13', 'Branch deposit'),
(17, 1016, 780.00, '2020-04-12', 'ATM withdrawal'),
(18, 1017, 890.00, '2020-04-11', 'Online transfer'),
(19, 1018, 910.00, '2020-04-10', 'Branch deposit'),
(20, 1019, 1020.00, '2020-04-24', 'ATM withdrawal');


INSERT INTO MESSAGE (Msg_ID, Event, Event_Dt) VALUES
(1, 'Holiday', '2020-04-24'),
(2, 'Meeting', '2020-04-23'),
(3, 'Holiday', '2020-04-22'),
(4, 'Holiday', '2020-04-21'),
(5, 'Seminar', '2020-04-20'),
(6, 'Holiday', '2020-04-19'),
(7, 'Meeting', '2020-04-18'),
(8, 'Holiday', '2020-04-17'),
(9, 'Workshop', '2020-04-16'),
(10, 'Holiday', '2020-04-15'),
(11, 'Conference', '2020-04-14'),
(12, 'Holiday', '2020-04-13'),
(13, 'Holiday', '2020-04-12'),
(14, 'Meeting', '2020-04-11'),
(15, 'Holiday', '2020-04-10'),
(16, 'Seminar', '2020-04-09'),
(17, 'Holiday', '2020-04-08'),
(18, 'Holiday', '2020-04-07'),
(19, 'Conference', '2020-04-06'),
(20, 'Holiday', '2020-04-05');

INSERT INTO CUSTOMER (CustID, CustName, CustAddress) VALUES
(1, 'Arjun Sharma', 'Delhi'),
(2, 'Meera Kapoor', 'Mumbai'),
(3, 'Rahul Verma', 'Bangalore'),
(4, 'Sita Singh', 'Chennai'),
(5, 'Krishna Rao', 'Hyderabad'),
(6, 'Radha Gupta', 'Pune'),
(7, 'Lakshmi Menon', 'Kolkata'),
(8, 'Vijay Kumar', 'Jaipur'),
(9, 'Anita Das', 'Ahmedabad'),
(10, 'Rajesh Patil', 'Surat'),
(11, 'Neha Jain', 'Nagpur'),
(12, 'Karan Mehta', 'Indore'),
(13, 'Amit Desai', 'Thane'),
(14, 'Priya Reddy', 'Bhopal'),
(15, 'Rakesh Bhatt', 'Visakhapatnam'),
(16, 'Pooja Yadav', 'Pimpri-Chinchwad'),
(17, 'Suresh Nair', 'Patna'),
(18, 'Ritu Khanna', 'Vadodara'),
(19, 'Manish Joshi', 'Ghaziabad'),
(20, 'Alok Agrawal', 'Ludhiana');
INSERT INTO INTEREST (Acct_type, rate) VALUES
('Savings', 3.50),
('Checking', 1.00),
('Fixed Deposit', 5.00),
('Recurring Deposit', 4.00);

INSERT INTO PROFIT_LOSS (Branch, Product, Estimated_profit) VALUES
('Delhi', 'SuperSave', 10000.00),
('Delhi', 'SmartSave', 5000.00),
('Mumbai', 'SuperSave', 8000.00),
('Mumbai', 'BusinessCard', 3000.00),
('Bangalore', 'SmartSave', 7000.00),
('Bangalore', 'SuperSave', 4000.00),
('Chennai', 'SuperSave', 6000.00),
('Chennai', 'BusinessCard', 2000.00),
('Hyderabad', 'SmartSave', 9000.00),
('Hyderabad', 'BusinessCard', 1000.00),
('Pune', 'SuperSave', 11000.00),
('Pune', 'SmartSave', 6000.00),
('Kolkata', 'SuperSave', 12000.00),
('Kolkata', 'SmartSave', 7000.00),
('Jaipur', 'BusinessCard', 5000.00),
('Jaipur', 'SmartSave', 3000.00),
('Ahmedabad', 'SuperSave', 4000.00),
('Ahmedabad', 'BusinessCard', 2000.00),
('Surat', 'SmartSave', 3000.00),
('Surat', 'BusinessCard', 1000.00);
