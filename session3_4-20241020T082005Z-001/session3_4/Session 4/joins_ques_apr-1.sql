use hr;
#Q1. WAQ to display the details of employees like id, names , salary ,
# and the names of the departments they work in.  
select e.employee_id,e.first_name,e.salary,d.department_name 
  from employees e   join departments d  
  on e.department_id=d.department_id;


#Q2. WAQ to display the details of employees like id, names , salary ,
# and the names of the departments they work in. Also include such
#employees who are not assigned to any departments yet.  

select e.employee_id,e.first_name,e.salary,d.department_name 
  from employees e  left join departments d  
  on e.department_id=d.department_id;



# Q3. WAQ to display the details of employees like id, names , salary ,
# and the names of the departments they work in. Include the list of departments
#where no employees are working. 

select e.employee_id,e.first_name,e.salary,d.department_name 
  from employees e  right join departments d  
  on e.department_id=d.department_id;

#Q4. WAQ to display the details of employees like id, names , salary ,
# and the names of the departments they work in. Also include such
#employees who are not assigned to any departments yet and the list of 
#departments where no employees are working.
 
 select e.employee_id,e.first_name,e.salary,d.department_name 
  from employees e  left join departments d  
  on e.department_id=d.department_id
  union all
  select e.employee_id,e.first_name,e.salary,d.department_name 
  from employees e  right join departments d  
  on e.department_id=d.department_id;
 
 






#Q5. WAQ to display the details of employees along with the departments, cities and the country
#they work in.


select e.first_name,d.department_name,l.city,c.country_name 
 from employees e join departments d 
     on e.department_id=d.department_id
         join locations l   
             on l.location_id=d.location_id
                join countries c
                   on c.country_id=l.country_id;



#Q6. WAQ to get the count of employees working in different cities.
#display such cities which has more than 20 employees working in them.

select city,count(*) from employees e 
join departments d on e.department_id=d.department_id 
 join locations l on l.location_id=d.location_id 
   group by city 
      having count(*)>20;

#Q7. Display the list of employees who are based out of 
-- America Region.

select first_name ,region_name from employees e 
join departments d on e.department_id=d.department_id 
  join locations l on l.location_id=d.location_id 
    join countries c on c.country_id=l.country_id
       join regions r on c.region_id=r.region_id
          where region_name like '%america%';



#Q8. WAQ to list the employees working in 'Seattle'.
select first_name ,city from employees e 
join departments d on e.department_id=d.department_id 
  join locations l on l.location_id=d.location_id 
     where city='Seattle';



#Q9. WAQ to list the details of employees, their department names and the job titles.
select first_name ,department_name,job_title from employees e 
join departments d on e.department_id=d.department_id 
  join jobs j  on e.job_id=j.job_id;

 -----------------------------------------------------------------------------------------

#Natural join - primitive join - uses any columns with same name and datatype to perform the join.

#10.Write a query to find the addresses 
-- (location_id, street_address, city, state_province, country_name) of 
--   all the departments.
select department_id, location_id,street_address ,city,state_province,country_name 
   from locations natural join countries natural join departments;

#11.write a query to display job title, firstname , 
-- difference between max salary and salary of all employees using natural join
select job_title,first_name ,max_salary-salary as difference from employees natural join jobs ;
--------------------------------------------
/*
#Cross Join - cartersian product between tables
			- every row of 1 table mapped to every row of other table.
            - m*n rows
            - cross join   ,   join 

*/
select  * from employees,departments;
select * from employees cross join departments;

---------------------------------------------------------------------------

 #Self join 
-- 12.Write a query to find the name (first_name, last_name) and hire date of 
-- the employees who was hired after 'Jones'.
 select e1.first_name,e1.last_name,e1.hire_date from employees e1 join employees e2
    on e2.last_name='Jones' and e1.hire_date>e2.hire_date;
 
# 13.Write a query to display first and last name ,salary of employees
 -- who earn less than the employee whose number is 182 using self join  

 select e1.first_name,e1.last_name ,e1.salary from employees e1 inner join employees e2 on e1.salary <e2.salary and e2.employee_id=182;
-------------------------------------------------------------------

/*
CASE <input>
    WHEN <eval_expression_1> THEN <expression if true>
    WHEN <eval_expression_2> THEN <expression if true>
    …
    WHEN <eval_expression_N> THEN <expression if true>
    ELSE <default expression> END 
*/
select salary , 
case 
when salary>20000 then 'heavily paid'
when salary between 10000 and 20000  then ' good pay'
when salary >5000 and salary<10000 then 'moderatly paid'
else 'less paid'
end as salarydetails
from employees;






-- categorize employees based on their year of service <365 as less than 1 yr, <730 as 1-2 yrs <1095 as 2-3 yrs else more than 3 yrs 
-- consider todays date as 2000-12-31.
select hire_date ,
case 
when datediff('2000-12-31',hire_date) <365 then 'less than 1 year'
when datediff('2000-12-31',hire_date) <730 then '1 -2 year'
when datediff('2000-12-31',hire_date) <1095 then '2-3 year'
else 'more than 3 yrs '
end as experience
from employees;


-- extra practices 
 
 
 
 -- 1.Display the first name, last name, department id and department name, for all employees for departments 80 or 40.
Select e.first_name, e.last_name, e.department_id, d.department_name from employees e Join departments d on e.department_id = d.department_id 
where d.department_id in(80,90);
 
 
-- 2. Write a query in SQL to display the full name (first and last name), and salary of those employees who working in
--  any department located in London. */

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,        e.salary   FROM employees e   INNER JOIN departments d     ON e.department_id = d.department_id   INNER JOIN locations l
    ON d.location_id = l.location_id       WHERE l.city = 'London';
 
 
 
 -- 3.	Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name,
 -- department, city, and state province. (3 rows)

select e.first_name, e.last_name, e.department_id, d.department_name, l.city,l.state_province 
from employees e inner join departments d
on e.department_id=d.department_id
inner join locations l
on d.location_id=l.location_id where e.first_name like "%z%";    

-- 4.	Write a query in SQL to display the job title, department id, full name (first and last name) of employee, starting date 
-- and end date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 2000. (8 rows)

select j.job_id,e.department_id,concat(e.first_name,' ',
e.last_name) full_name, j.start_date , j.end_date from
employees e join job_history j
on e.employee_id = j.employee_id
where j.start_date >='1993-01-01' and end_date<= '2000-08-31';		

-- 5.	.Display employee name if the employee joined before his manager.

Select e1.first_name from  employees e1 join employees e2 on (e1.manager_id=e2.employee_id) where e1.hire_date < e2.hire_date;



-- 6 •Write a query in SQL to display the name of the department, average salary and number of employees working in that department who 
-- got commission. */

SELECT d.department_name,        AVG(e.salary),        COUNT(commission_pct)
  FROM employees e   JOIN departments d     ON e.department_id = d.department_id
  GROUP BY d.department_name;


-- 7. Write a query in SQL to display the details of jobs which was done by any of the employees who is  earning a salary on and above 12000( use job_history) */


SELECT jh.*
  FROM employees e
  INNER JOIN job_history jh
    ON e.employee_id = jh.employee_id
      WHERE salary >= 12000.00;
-- 8. Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80.(use job, job_history)

SELECT jh.employee_id,
       j.job_title,
       datediff(jh.end_date,jh.start_date) AS num_days
  FROM jobs j
  INNER JOIN job_history jh
    ON j.job_id = jh.job_id
      WHERE jh.department_id = 80;
