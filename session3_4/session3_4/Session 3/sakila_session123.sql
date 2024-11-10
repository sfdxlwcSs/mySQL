use sakila;
/* note - if u dont have the database, please use the zip file shared to you by Ullas 
which has the commands to execute to create tables and insert data into the tables */
-- Display the first and last names of all actors from the table actor.
SELECT first_name, last_name
FROM actor;
-- Display the first and last name of each actor
 -- in a single column in upper case letters. Name the column "Actor Name."
 SELECT CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS "Actor Name"
FROM actor;
 -- Find the ID number, first name, and last name of an actor whose first name is "Joe."
 SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';
-- Find all actors whose last name contains the letters GEN:
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';
 -- Find all actors whose last names contain the letters LI.
 -- This time, order the rows by last name and first name, in that order.
 SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY 2, 1;

-- Using IN, display the country_id and country columns of the following countries: 
-- Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
-- What are the names of all the languages in the database (sorted alphabetically)?
SELECT name
FROM language
ORDER BY name;
-- Return the full names (first and last) of actors with “SON” in their last name
-- , ordered by their first name.
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%SON%'
ORDER BY first_name;
-- Find all the addresses where the postal code is blank (i.e., does not contain some text/numbers).
SELECT address
FROM address
WHERE postal_code IS NULL OR postal_code = '';
-- Find all the film categories along with names of the categories in which film ids are between 55 and 65.
SELECT category.category_id, category.name
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
WHERE film.film_id BETWEEN 55 AND 65;
-- Return the first and last names of actors who played in a film involving a “Angels”alter
--  along with the release year of the movie, sorted by the actors’ last names.
SELECT distinct actor.first_name, actor.last_name, film.release_year,film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title LIKE '%Angels%'
ORDER BY actor.last_name;


-- Display the films and their rental rates
-- where the rental rate of one film is greater than the rental rate of another film.
SELECT f1.title AS film1, f1.rental_rate AS rate1, f2.title AS film2, f2.rental_rate AS rate2
FROM film f1
JOIN film f2 ON f1.rental_rate > f2.rental_rate;

-- List all combinations of customers and films, showing the customer name and film title.
SELECT customer_id, first_name, last_name, title
FROM customer
CROSS JOIN film;

-- Find the total number of rentals for each customer, along with their names.
SELECT customer.customer_id, first_name, last_name, COUNT(rental_id) AS total_rentals
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, first_name, last_name;
-- Display the actors along with the films they have acted in. Include actors who have not acted in any films
SELECT actor.actor_id, first_name, last_name, film.title
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id;
-- Retrieve all payments where the payment amount is greater than the average payment amount.
-- Non-equi join between 'payment' and a subquery for average payment amount
SELECT payment_id, customer_id, amount, payment_date
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment);
-- List the top 5 customers along with their total payments.
-- Inner join between 'customer' and 'payment', aggregated by customer
SELECT customer.customer_id, first_name, last_name, SUM(amount) AS total_payments
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, first_name, last_name
ORDER BY total_payments DESC
LIMIT 5;
-- Find the film categories along with the total number of films in each category,
--  only including categories with at least 10 films.
-- Inner join between 'category' and 'film_category', aggregated and filtered
SELECT category.category_id, category.name, COUNT(film_category.film_id) AS total_films
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.category_id, category.name
HAVING total_films >= 10;









