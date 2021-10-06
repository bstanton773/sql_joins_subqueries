SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;

-- Inner Join on Film Actor table with the Film table
SELECT *
FROM film_actor
JOIN film
ON film_actor.film_id = film.film_id
ORDER BY film.film_id;


-- Inner Join On Film Actor table with the Actor table
SELECT *
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id;

-- Join Film to Actor Through the Film Actor table
SELECT a_.actor_id, a_.first_name, a_.last_name, f.film_id, f.title, f.release_year
FROM film_actor AS f_a
JOIN film AS f
ON f_a.film_id = f.film_id
JOIN actor AS a_
ON a_.actor_id = f_a.actor_id
ORDER BY f.film_id;



-- SUBQUERIES!

-- Find all customers by id who have made more than $175 in payments
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 150
ORDER BY SUM(amount) DESC;


-- Find Customer Info on those customers ^
SELECT *
FROM customer
WHERE customer_id IN (148, 526, 178, 137, 144, 459);


-- Combine into subquery:
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);


-- Add on:
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
ORDER BY last_name
OFFSET 2
LIMIT 3;


-- BEWARE!
-- What categories were the most popular
SELECT category_id
FROM film_category
GROUP BY category_id
HAVING COUNT(*) > 60
ORDER BY COUNT(*) DESC;

SELECT *
FROM category
WHERE category_id IN (
	SELECT category_id
	FROM film_category
	GROUP BY category_id
	HAVING COUNT(*) > 60
	ORDER BY COUNT(*) DESC
);


SELECT *
FROM film
WHERE film_id IN (
	SELECT category_id
	FROM film_category
	GROUP BY category_id
	HAVING COUNT(*) > 60
	ORDER BY COUNT(*) DESC
)



-- USING Subquery for calculation
SELECT AVG(amount)
FROM payment;


SELECT *
FROM payment
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
)
ORDER BY amount;


ALTER TABLE customer
ADD COLUMN loyalty_member BOOLEAN DEFAULT FALSE;


SELECT *
FROM customer
WHERE loyalty_member = TRUE;

UPDATE customer
SET loyalty_member = TRUE
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING COUNT(*) > 25
);


SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 25

SELECT *
FROM customer;



SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175;


SELECT customer.customer_id, first_name, last_name, email ,address, city, district, country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON city.city_id = address.city_id
JOIN country
ON country.country_id = city.country_id
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);




SELECT *
FROM country;

