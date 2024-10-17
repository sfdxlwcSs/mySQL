#inner join -- This will succeed

SELECT e.employee_name, d.department_name
FROM employees e
JOIN departments d ON e.dept_ref = d.department_id;