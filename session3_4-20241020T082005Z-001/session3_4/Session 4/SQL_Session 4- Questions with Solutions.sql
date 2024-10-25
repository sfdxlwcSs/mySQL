# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

CREATE SCHEMA IF NOT EXISTS Employee;
USE Employee;

# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;

#Q1. Retrive employee_id , first_name , last_name and salary details of those employees whose salary is greater than the average salary of all the employees.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM employee_details 
WHERE SALARY > (SELECT AVG(SALARY) FROM employee_details);

#Q2. Display first_name , last_name and department_id of those employee where the location_id of their department is 1700
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID 
FROM employee_details 
WHERE DEPARTMENT_ID= ANY(SELECT DEPARTMENT_ID FROM Department_Details WHERE LOCATION_ID = 1700); 

#Q3. From the table employees_details, extract the employee_id, first_name, last_name, job_id and department_id who work in  any of the departments of Shipping, Executive and Finance.
SELECT employee_id, FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID 
FROM employee_details E 
WHERE department_id = ANY (SELECT department_id  FROM department_details WHERE DEPARTMENT_NAME in ('Shipping','Executive','Finance'));


#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the CLERKS who earn more than the salary of any IT_PROGRAMMER.
SELECT employee_id, first_name, last_name,salary, phone_number, email
FROM employee_details 
WHERE JOB_ID LIKE '%CLERK%'
AND Salary > ANY  (SELECT Salary  FROM employee_details WHERE Job_id = 'IT_PROG'); 


#Q5. Extract employee_id, first_name, last_name,salary, phone_number, email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.
SELECT employee_id, first_name, last_name,salary, phone_number, email, job_id
FROM employee_details 
WHERE JOB_ID='AC_ACCOUNTANT'
AND salary >ALL (SELECT salary FROM employee_details WHERE Job_id = 'AD_VP');

#Q6. Write a Query to display the employee_id, first_name, last_name, department_id of the employees who have been recruited in the recent half timeline since the recruiting began. 

SELECT employee_id, first_name, last_name, phone_number, salary, job_id 
FROM employee_details 
WHERE hire_Date > (SELECT avg(hire_Date) FROM employee_details);

#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees belonging to the 'Contracting' department 
SELECT employee_id, first_name, last_name, phone_number, salary, job_id
FROM employee_details 
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID FROM Department_Details WHERE DEPARTMENT_NAME='Contracting');

#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees who does not belong to 'Contracting' department
SELECT employee_id , first_name,last_name,phone_number,salary, job_id, department_id
FROM employee_details
WHERE DEPARTMENT_ID NOT IN ( SELECT DEPARTMENT_ID FROM Department_Details WHERE DEPARTMENT_NAME='Contracting');


#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the employees who were recruited first in the department

SELECT employee_id, first_name, last_name, job_id, department_id
FROM employee_details o
WHERE hire_Date =(SELECT min(hire_Date) FROM EMPLOYEE_DETAILS i WHERE i.department_id=o.department_id);



#Q10. Display the employee_id, first_name, last_name, salary and job_id of the employees who earn maximum salary for every job.

SELECT  employee_id, first_name, last_name, salary, Job_id 
FROM employee_details o
WHERE salary = (SELECT max(salary) FROM employee_details i WHERE i.job_id=o.job_id);
