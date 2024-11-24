# pivot table
# THEN 1 means 
SELECT Month(T.Tran_Date) as "Month",  
count(case when T.Channel= 'ATM withdrawal' THEN 1 END) ATM_transaction, 
count(case when T.Channel = 'Online transfer' THEN 1 END) Online_transfer,  
count(case when T.Channel = 'Branch deposit' THEN 1 END) Branch_deposit
 FROM Transaction T 
 GROUP BY month(T.Tran_Date);