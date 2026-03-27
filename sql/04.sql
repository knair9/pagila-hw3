/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT DISTINCT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film_category ON film_actor.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Children'
  AND NOT EXISTS (
    SELECT 1
    FROM film_actor fa2
    JOIN film_category fc2 ON fa2.film_id = fc2.film_id
    JOIN category c2 ON fc2.category_id = c2.category_id
    WHERE fa2.actor_id = actor.actor_id
      AND c2.name = 'Horror'
  )
ORDER BY actor.last_name, actor.first_name;
