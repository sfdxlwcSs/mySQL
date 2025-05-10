-- SECTION B – 40 MARKS
use swiggy;
 #3a. List all restaurants that have received at least one order(2 marks)
SELECT *
FROM restaurants
WHERE r_id IN (
    SELECT DISTINCT r_id 
    FROM `orders`
);

-- 3b. How many customers have not placed any orders? (3 marks)
select user_id from users
where user_id not in (
    select distinct user_id from orders
    where user_id is not null
);

-- 3c. Identify the top 3 most expensive food items in each restaurant(7 marks)
WITH RankedMenu AS (
    SELECT 
        m.menu_id,
        m.r_id,
        f.f_name,
        m.price,
        RANK() OVER (PARTITION BY m.r_id ORDER BY m.price DESC) AS price_rank
    FROM 
        menu m
    JOIN 
        food f ON m.f_id = f.f_id
)
SELECT 
    menu_id,
    r_id,
    f_name,
    price,
    price_rank
FROM 
    RankedMenu
WHERE 
    price_rank <= 3; 

-- 3d. What is the average rating for each restaurant and delivery partner? (7 marks)
select r.r_name, round(avg(o.restaurant_rating),2) as avg_restaurant_rating
from orders o
join restaurants r on o.r_id = r.r_id
group by r.r_name;

select dp.partner_name, round(avg(o.delivery_rating),2) as avg_delivery_rating
from orders o
join delivery_partner dp on o.partner_id = dp.partner_id
group by dp.partner_name;

#3e.Find the average price of vegetarian dishes (type='Veg') offered by each restaurant. (7 marks)
SELECT r.r_id, AVG(m.price) AS avg_veg_price
FROM menu m
INNER JOIN restaurants r ON m.r_id = r.r_id
INNER JOIN food f ON m.f_id = f.f_id
WHERE f.type = 'Veg'
GROUP BY r.r_id
ORDER BY r.r_id;

#3f.Find the top 3 cuisines based on total order amount(7 marks)
SELECT 
    r.cuisine,
    SUM(o.amount) AS total_order_amount
FROM 
    orders o
JOIN 
    restaurants r ON o.r_id = r.r_id
GROUP BY 
    r.cuisine
ORDER BY 
    total_order_amount DESC
LIMIT 3;



#3g.Calculate the average price of food items for each restaurant and compare it with the price of each item(7 marks)
SELECT 
    m.menu_id,
    m.r_id,
    f.f_name,
    m.price,
    AVG(m.price) OVER (PARTITION BY m.r_id) AS avg_price,
    m.price - AVG(m.price) OVER (PARTITION BY m.r_id) AS price_diff
FROM 
    menu m
JOIN 
    food f ON m.f_id = f.f_id;
    --  ========================================================================================
-- SECTION C – 40 MARKS
use movies; 

#4a. Write a SQL query to find those movies, which were released before 1998. Return movie title. (2 marks)
select mov_title
from movie
where mov_year < 1998;

#4b. Write a SQL query to find the name of all reviewers and movies together in a single list. (2 marks)

select mov_title as TitlesandReviewers
from movie
UNION
select rev_name
from reviewer;

#4c. Calculate the cumulative count of reviews for each movie (5 marks)

SELECT 
    mov_id,
    rev_id,
    rev_stars,
    num_o_ratings,
    COUNT(rev_id) OVER (PARTITION BY mov_id ORDER BY rev_id) AS cumulative_review_count
FROM 
    rating;

# 4d.Write a SQL query to find the movies without any rating.(using subquery) (3 marks)
select mov_title
from movie
where mov_id not in (select mov_id from rating);


#4e.Write a SQL query to find the actors who played a role in the movie 'Annie Hall'. Return all the fields of actor table .(7 marks)

select * 
from actor as a
where a.act_id in (select act_id  from movie_cast  	where mov_id in (select mov_id
	from movie  	where mov_title = 'Annie Hall'));




#4f. Write a SQL query to find the movies with the lowest ratings. 
-- Return reviewer name, movie title, and number of stars for those movies.(7 marks)

select rev.rev_name, m.mov_title, r.rev_stars
from movie as m, rating as r, reviewer as rev
where m.mov_id = r.mov_id
and r.rev_id = rev.rev_id
and r.rev_stars = (select min(rev_stars) from rating);

#4g. Write a SQL query to find out which actors have not appeared in any movies between 1990 and 2000 (Begin and end values are included.). 
-- Return actor first name, last name, movie title and release year. (7 marks)

select a.act_fname, a.act_lname, m.mov_title, m.mov_year
from actor as a
join movie_cast as mc on a.act_id = mc.act_id
join movie as m on mc.mov_id = m.mov_id
where m.mov_year not between 1990 and 2000;


#4h. Write a SQL query to find the years in which a movie received a rating of 3 or 4. Sort the result in increasing order on movie year. (7 marks)

select distinct m.mov_year
from movie as m
join rating as r on m.mov_id = r.mov_id
where r.rev_stars in (3, 4)
order by m.mov_year asc;










