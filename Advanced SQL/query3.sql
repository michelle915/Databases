-- Find the first_name, last_name and total_combined_film_length of Animation films for every actor.
-- That is the result should list the names of all of the actors(even if an actor has not been in any Animation films)
-- and the total length of Animation films they have been in.
-- Look at the category table to figure out how to filter data for Animation films.
-- Order your results by the actor_id in ascending order.
-- Put query for Q3 here

SELECT
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COALESCE(SUM(case when category.name = 'Animation' then film.length else 0 end), 0) as total_combined_film_length
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film_category ON film_actor.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
LEFT JOIN film ON film_actor.film_id = film.film_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY actor.actor_id ASC;
