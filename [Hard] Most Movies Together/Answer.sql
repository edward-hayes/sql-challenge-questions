WITH movies_together AS (  
  SELECT f1.actor_id as actor_id1, f2.actor_id as actor_id2, f1.film_id as film_id
  FROM film_actor f1
  JOIN film_actor f2 ON f1.film_id = f2.film_id
  WHERE f1.actor_id != f2.actor_id
  ),
most_movies_together AS (
  SELECT actor_id1, actor_id2 
  FROM movies_together
  GROUP BY 1,2
  ORDER BY COUNT(*) DESC
  LIMIT 1)
  
SELECT 
actor2.first_name || ' ' || actor2.last_name as first_actor,
actor1.first_name || ' ' || actor1.last_name as second_actor,
film.title
FROM movies_together
LEFT JOIN film ON film.film_id = movies_together.film_id
LEFT JOIN actor actor1 ON actor1.actor_id = actor_id1
LEFT JOIN actor actor2 ON actor2.actor_id = actor_id2
WHERE actor_id1 = (SELECT actor_id1 FROM most_movies_together)
AND actor_id2 = (SELECT actor_id2 FROM most_movies_together)
ORDER BY film.title