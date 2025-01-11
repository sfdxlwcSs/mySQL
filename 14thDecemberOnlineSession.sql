-- View Session 6
Use hr;
create  table emp_backup
as select * from employees

create  table emp_backup2
as select employee_id from employees;  # both have data 

create  table empnodata like employees;
# now u r trying to copydata here into blank table
insert into empnodata select * from employees ;

CREATE VIEW emp_demo_view
AS
SELECT e.employee_id,
	e.job_id,
	e.manager_id,
	e.department_id,
	d.location_id,
	l.country_id,
	e.first_name,
	e.last_name,
	e.salary,
	e.commission_pct,
	d.department_name,
	j.job_title,
	l.city,
	l.state_province,
	c.country_name,
	r.region_name
FROM emp_backup2 e,
	departments d,
	jobs j,
	locations l,
	countries c,
	regions r
WHERE e.department_id = d.department_id
	AND d.location_id = l.location_id
	AND l.country_id = c.country_id
	AND c.region_id = r.region_id
	AND j.job_id = e.job_id;
    
    describe  emp_demo_view;
    
    select * from information_schema.views where table_name='emp_demo_view';
    
select * from information_schema.views;


# simple assgnment
CREATE VIEW emp_view_complex_view
AS
SELECT e.employee_id,
	e.job_id,
	e.manager_id,
	e.department_id,
	d.location_id,
	l.country_id,
	e.first_name,
	e.last_name,
	e.salary,
	e.commission_pct,
	d.department_name,
	j.job_title,
	l.city,
	l.state_province,
	c.country_name,
	r.region_name
FROM emp_backup e,
	departments d,
	jobs j,
	locations l,
	countries c,
	regions r
WHERE e.department_id = d.department_id
	AND d.location_id = l.location_id
	AND l.country_id = c.country_id
	AND c.region_id = r.region_id
	AND j.job_id = e.job_id;
    
    UPDATE emp_view_complex_view
SET first_name = 'Ram'
WHERE department_id = 90; # does  update the source emp_backup

 UPDATE hr.emp_backup
SET first_name = 'Shyam'
WHERE department_id = 90; # view does  get updated

# A horizontal view refers to a view that filters rows based on specific conditions. 
# It is often used to restrict access to certain rows in a table while presenting the same column structure.
CREATE VIEW department_10_employees AS
SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE department_id = 10;
CREATE VIEW newview AS
SELECT employee_id, first_name, last_name, department_id
from emp_backup;
ALTER TABLE hr.emp_backup
DROP COLUMN first_name; 
#  after this if u do this u get error references invalid table
SELECT * FROM hr.newview;
# WITH CHECK OPTION
# WILL NOT ALLOW DATA INSERTED OR UPDATED FOR ANYTHING THAT DOES NOT FOLLOW FILTER C0NDITION



