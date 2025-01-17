use sakila;
-- Display the film_id, title, 
-- and the rank of each film based on their rental duration, ordered by rental duration.
SELECT film_id, title, rental_duration,
       RANK() OVER (ORDER BY rental_duration) AS rental_duration_rank
FROM film;
-- Calculate the running total of payments for each customer, ordering by payment date.
SELECT customer_id, payment_id, amount, payment_date,
       SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total_payment
FROM payment;
-- Find the percentage change in the rental rate for each film within its category, 
-- ordering by film_id and partitioning by category_id.

SELECT film_id, category_id, title, rental_rate,
       (rental_rate - LAG(rental_rate) OVER (PARTITION BY category_id ORDER BY film_id)) / LAG(rental_rate) OVER (PARTITION BY category_id ORDER BY film_id) * 100 AS rental_rate_change_percentage
FROM film_category
JOIN film USING (film_id);
-- Retrieve the top 3 films with the highest grossing revenue in each genre.
SELECT category_id, film_id, title, rental_rate,
       RANK() OVER (PARTITION BY category_id ORDER BY SUM(rental_rate) DESC) AS grossing_rank
FROM film_category
JOIN film USING (film_id)
GROUP BY category_id, film_id, title, rental_rate;
-- Calculate the cumulative distribution of rental durations for each film, ordering by rental duration.
SELECT film_id, title, rental_duration,
       CUME_DIST() OVER (ORDER BY rental_duration) AS cumulative_distribution
FROM film;

-- dentify films whose ratings deviate significantly from the average rating within their category.
SELECT film_id, category_id, title, rating,
       rating - AVG(rating) OVER (PARTITION BY category_id) AS rating_deviation
FROM film_category
JOIN film USING (film_id);
-- Classify films into quartiles based on their rental rates within each category.
SELECT category_id, film_id, title, rental_rate,
       NTILE(4) OVER (PARTITION BY category_id ORDER BY rental_rate) AS rental_rate_quartile
FROM film_category
JOIN film USING (film_id);

-- Monthly First_Value() of Rental Durations
-- Show the first rental duration of each film within its category, ordering by film_id
SELECT film_id, category_id, title, rental_duration,
       FIRST_VALUE(rental_duration) OVER (PARTITION BY category_id ORDER BY film_id) AS first_rental_duration
FROM film_category
JOIN film USING (film_id);




