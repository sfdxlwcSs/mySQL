#inner join -- This will succeed

SELECT e.employee_name, d.department_name
FROM employees e
JOIN departments d ON e.dept_ref = d.department_id;

# **********************Class Joins20th Oct-HR DB****************
select *
from employees
JOIN departments 
on employees.department_id=departments.department_id;

select *
from employees as e
JOIN departments  as d
on e.department_id=d.department_id;

select e.first_name,e.last_name,d.department_name,e.department_id
from employees as e
JOIN departments  as d
on e.department_id=d.department_id;

select d.department_name, l.city
from departments d
JOIN locations  as l
on d.location_id=l.location_id;
-- INNER JOIN
select l.*,d.department_name
from locations  as l
JOIN departments as d
on l.location_id=d.location_id;

--  less efficient as differenciated by way it functions Equi join
select l.*,d.department_name
from locations  as l,departments d
where l.location_id=d.location_id;
-- cross join
Select * from departments,locations;

select * from locations
natural join departments ;-- note this works when column name ,in such case we dont have to explicith explain the common column ,is same basically an inner join

select * from locations
cross join departments ;





select l.*,d.department_name
from locations  as l
LEFT JOIN departments as d
on l.location_id=d.location_id;

select l.*,d.department_name
from locations  as l
right JOIN departments as d
on l.location_id=d.location_id; -- try making a department without location

select d.*,l.city
from departments  as d
RIGHT JOIN locations as l
on d.location_id=l.location_id;

select concat_ws(' ',e.first_name,e.last_name) as emp_name,d.department_name, l.city
from employees as e
JOIN departments  as d
on e.department_id=d.department_id
JOIN locations  as l
on d.location_id=l.location_id;

-- Self Join
Select e1.employee_id,e1.first_name,e1.last_name,
manager.first_name as managerFN ,manager.last_name as managerLN
from employees e1 join employees manager
on e1.manager_id =manager.employee_id;

Select e1.employee_id,e1.first_name,e1.last_name,
manager.first_name as managerFN ,manager.last_name as managerLN
from employees e1 left join employees manager
on e1.manager_id =manager.employee_id; -- since i wanted to see steven who has no manager id

Select e1.employee_id,e1.first_name,e1.last_name,
manager.first_name as managerFN ,manager.last_name as managerLN
from employees e1 right join employees manager
on e1.manager_id =manager.employee_id; -- since i wanted to see steven who has no manager id

-- full outer join combination of left and right join
-- do union of both joins  as u dont want duplicates

