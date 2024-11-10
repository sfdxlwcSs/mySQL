create database mtech2107;
use mtech2107;
CREATE TABLE demo (
    email_id VARCHAR(255) NOT NULL,
    email_with_com VARCHAR(255) GENERATED ALWAYS AS (
        CASE
            WHEN RIGHT(email_id, 4) = '.com' THEN email_id
            ELSE CONCAT(email_id, '.com')
        END
    ) STORED
);

DELIMITER //
CREATE TRIGGER append_com
BEFORE INSERT ON demo
FOR EACH ROW
BEGIN
    IF RIGHT(NEW.email_id, 4) != '.com' THEN
        SET NEW.email_id = CONCAT(NEW.email_id, '.com');
    END IF;
END//
DELIMITER ;
select * from locations ;
select first_name, last_name, department_name
from employees as emp , departments  as dept
where emp.department_id=dept.department_id;


select 
department_name,
concat(first_name,' ',last_name),manager_name 
from  departments  dept
inner join employees e
on dept.manager_id=e.employee_id

CREATE TABLE students (
    student_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    date_of_birth DATE
);



INSERT INTO students (student_id, name, email, phone_number, date_of_birth) VALUES
('S001', 'John Doe', 'john.doe@example.com', '+1-555-1234', '2000-05-15'),
('S002', 'Jane Smith', 'jane.smith@domain.com', '+44-20-7946-095', '1999-12-01'),
('S003', 'Alice Johnson', 'alice.johnson@company.co.uk', '+91-98201-23456', '2001-07-22'),
('S004', 'Bob Brown', 'bob.brown@website.org', '+33-100-675-6', '2002-03-30'),
('S005', 'Charlie Davis', 'charlie.davis@domain.com', '555-9876', '2000-11-05');
--  Find Emails Ending with .com
select * FROM STUDENTS WHERE EMAIL LIKE '%.com';
SELECT student_id, name, email
FROM students
WHERE email REGEXP '\\.com$';
 -- Find Phone Numbers Starting with a Country Code
 SELECT student_id, name, phone_number
FROM students
WHERE phone_number REGEXP '^\\+1';
-- Find Names Containing Only Letters and Spaces
SELECT student_id, name
FROM students
WHERE name REGEXP '^[a-zA-Z ]+$';
-- Extract Domain from Email Addresses
SELECT email,
       INSTR(email, '@')  AS domain
FROM students;
-- Mask Phone Numbers (Show Only Last 4 Digits)
SELECT phone_number,
       CONCAT('*****', RIGHT(phone_number, 4)) AS masked_phone
FROM students;
-- Validate Email Format and Extract Local Part
SELECT email,
       CASE 
           WHEN email REGEXP '^[^@]+@[^@]+\\.com$' THEN 
               SUBSTRING(email, 1, INSTR(email, '@') - 1)
           ELSE 
               'Invalid Email'
       END AS local_part
       
       
       
FROM students;
-- Extract First and Last Names from Full Name
SELECT name,
       SUBSTRING_INDEX(name, ' ', 1) AS first_name,
       SUBSTRING_INDEX(name, ' ', -1) AS last_name
FROM students;
--  Check if Email Contains Digits
SELECT email,
       CASE 
           WHEN email REGEXP '[0-9]' THEN 'Contains Digits'
           ELSE 'No Digits'
       END AS email_digit_check
FROM students;
-- Extract Numeric Part from Phone Number
SELECT phone_number,
       REGEXP_REPLACE(phone_number, '[^0-9]', '') AS numeric_phone
FROM students;




