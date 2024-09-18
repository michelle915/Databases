-- Find all films with minimum length or maximum rental duration (compared to all other % films).
-- In other words let L be the minimum film length, and let R be the maximum rental duration in the table film. You need
-- to find all films that have length L or duration R or both length L and duration R.
-- If a film has either a minimum length OR a maximum rental duration it should appear in the result set. It does not
-- need to have both the minimum length and the maximum duration.
-- You just need to return the film_id for this query.
-- Order your results by film_id in descending order.

-- Put query for Q1 here

SELECT film_id FROM film
WHERE length = (SELECT MIN(length) FROM film) OR rental_duration = (SELECT MAX(rental_duration) FROM film)
ORDER BY film_id DESC;
