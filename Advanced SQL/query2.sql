-- We want to find out how many of each category of film MAE HOFFMAN has starred in.
-- So return a table with category_name and the count of the number_of_films that MAE was in that category.
-- Your query should return every category even if MAE has been in no films in that category
-- Order by the category name in descending order.

-- Notes: The reason we can't use a WHERE clause in this situation (easily) is because when you say
-- "WHERE actor is Mae" it will remove all of the film_category rows where Mae isn't present. When you
-- instead Join on id = id AND actor = Mae, it keeps all film_categories and only joins in Mae.
--
-- In the context of this query, all of the joins are LEFT JOINs to ensure that all the categories from the
-- "category" table are returned, even if they don't have corresponding records in the other tables. The "category"
-- table is the first table mentioned in the query and is considered the left-most table.

SELECT
    category.name AS category_name,
    COALESCE(COUNT(actor.actor_id), 0) AS number_of_films
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
LEFT JOIN film ON film_category.film_id = film.film_id
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id
    AND actor.first_name = 'MAE' AND actor.last_name = 'HOFFMAN'
GROUP BY category.name
ORDER BY category.name DESC;
