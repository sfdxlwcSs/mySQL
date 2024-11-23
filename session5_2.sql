use hr;
-- Find employees who earn a salary greater than all salaries in the IT department.
 
 -- Original Query with ALL
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 60);
 -- Find employees who earn a salary greater than any salary in the Sales department.
 -- Query with ANY
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 80);
SELECT first_name, last_name, salary
FROM employees
WHERE salary > SOME (SELECT salary FROM employees WHERE department_id = 20);

 -- Find employees in the HR department with a salary greater than the average salary of all employees.
 SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = 60);

use classicmodels;
 -- Find product lines that have products with a quantity in stock between   10 and 100 .
SELECT productLine
FROM productlines
WHERE productLine IN (
    SELECT productLine
    FROM products
    WHERE quantityInStock between 10 and 100 
);

use sakila;

use sakila;
-- Find films with a length greater than the average length of all films in the Action genre.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
               FROM film
               WHERE film_id IN (
                   SELECT film_id
                   FROM film_category
                   WHERE category_id = (SELECT category_id FROM category WHERE name = 'Action')
               )
);

select * from film;
select * from film_category;


 -- Find customers who have rented films in the Comedy genre.
 SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Comedy';

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
               FROM film
               WHERE film_id IN (
                   SELECT film_id
                   FROM film_category
                   WHERE category_id = (SELECT category_id FROM category WHERE name = 'Action')
               )
);
