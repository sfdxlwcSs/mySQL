# pivot table
# THEN 1 means 

INSERT INTO session5.transaction (Trans_ID, Acct_Num, Tran_Amount, Tran_Date,Channel)
VALUES 
(21,1001, 200, '2020-04-24', 'UPI transfer'),
(22,1002, 200, '2020-05-24', 'UPI transfer'),
(23,1001, 200, '2020-05-24', 'Bankers cheque');

SELECT Month(T.Tran_Date) as "Month",  
count(case when T.Channel= 'ATM withdrawal' THEN 1 END) ATM_transaction, 
count(case when T.Channel = 'Online transfer' THEN 1 END) Online_transfer,  
count(case when T.Channel = 'Branch deposit' THEN 1 END) Branch_deposit,
count(case when T.Channel = 'UPI transfer' THEN 1 END) UPI_transfer,
count(case when T.Channel = 'Bankers cheque' THEN 1 END) Bankers_cheque
 FROM Transaction T 
 GROUP BY month(T.Tran_Date);