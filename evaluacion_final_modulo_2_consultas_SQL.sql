
/*
## EJERCICIOS

**Base de Datos Sakila:**

Para este ejercicio utilizaremos la bases de datos Sakila que hemos estado utilizando durante el repaso de SQL. 
Es una base de datos de ejemplo que simula una tienda de alquiler de películas. 
Contiene tablas como `film` (películas), `actor` (actores), `customer` (clientes), `rental` (alquileres), `category` (categorías), entre otras. 
Estas tablas contienen información sobre películas, actores, clientes, alquileres y más
y se utilizan para realizar consultas y análisis de datos en el contexto de una tienda de alquiler de películas.*/



-- PRIMERO TENEMOS QUE LLAMAR A NUESTRA BASE DE DATOS QUE VAMOS A UTILIZAR PARA HACER LAS CONSULTAS. SE PONDRÁ EN NEGRITA LA BASE QUE ESTEMOS UTILIZANDO.
USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * -- aquí seleccionamos las columnas que queremos((*) lo utilizamos para obtener todos los campos.
FROM film; -- selecciono la tabla que quiero usar, uso el (*) para ver todos los campos y hacer la consulta.


SELECT DISTINCT title AS nombre_pelicula -- El AS lo utilizamos para poner alias. Puede ir tanto con As delante como simplemente el nombre que le doy.
FROM film; 


-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT *
FROM film; 


SELECT title nombre_pelicula
FROM film
WHERE rating = "PG-13"; -- El WHERE nos sirve para filtar en neustra consulta.


-- 3. Encuentra el título y la descripción de todas las películas que contengan la cadena de caracteres "amazing" en su descripción.


-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM film; 

SELECT title nombre_pelicula, description descripcion
FROM film 
WHERE description LIKE '%amazing%';


-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.


-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM film; 

SELECT title nombre_pelicula
FROM film 
WHERE length > 120; 


-- 5. Recupera los nombres y apellidos de todos los actores.


-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM Actor; 
SELECT first_name, last_name
FROM actor; 

SELECT CONCAT(first_name,' ',last_name) AS nombre_apellido_actores -- también podemos hacerlo de esta forma para unir nombre y apellido el AS lo utilizamos para dar un alias.
FROM actor;

-- 6. Encuentra el nombre y apellidos de los actores que tengan "Gibson" en su apellido.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM Actor; 

SELECT first_name nombre_actor, last_name apellido_actor
FROM actor
WHERE last_name = 'Gibson';


-- 7. Encuentra los nombres y apellidos de los actores que tengan un actor_id entre 10 y 20.


-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM Actor; 

SELECT actor_id, first_name nombre_actor, last_name apellido_actor
FROM actor
WHERE actor_id BETWEEN 10 AND 20;


-- 8. Encuentra el título de las películas en la tabla `film` que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT *
FROM film; 


SELECT title nombre_pelicula
FROM film 
WHERE rating NOT IN ("R","PG-13");


-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM film; 


SELECT rating AS clasificacion, COUNT(film_id) AS total_peliculas -- Hacemos un conteo de todas las peliculas que hay. 
FROM film
GROUP BY rating -- Lo agrupamos por su clasificación.
ORDER BY total_peliculas ASC; -- Lo ordenamos por ese total de peliculas menor a mayor(si no ponemos nada se ordena de esta forma).

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM customer;
SELECT * 
FROM rental;


SELECT c.customer_id id, c.first_name nombre_cliente, c.last_name apellido_cliente,  COUNT(r.rental_id) total_peliculas_alquiladas -- Count para saber el número total de pelis alquiladas.
FROM customer c -- tabla principal.
LEFT JOIN rental r -- Hago un LEFT JOIN para unir las tablas clientes y alqulier  porque quiero ver todos los clientes hayan alquilado o no.
ON c.customer_id = r.customer_id -- elemento en común por el que se unen.
GROUP BY  c.customer_id, c.first_name, c.last_name -- agrupados por. 
ORDER BY total_peliculas_alquiladas; -- orden en el que quiero orden y por lo que quiero ordenar.

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT*
FROM inventory;
SELECT * 
FROM rental;
SELECT * 
FROM category;
SELECT*
FROM  film_category;


SELECT c.name nombre_categoria, COUNT(r.rental_id) total_peliculas_alquiladas_por_categoria -- Count para saber el número total de pelis alquiladas por categoria.
FROM category c -- tabla principal por la que comparo, quiero saber todas las categorias.
LEFT JOIN film_category fc -- Hago vario LEFT JOIN join para unir las tablas por sus relaciones. 
ON c.category_id = fc.category_id -- elemento en común por el que se unen.
LEFT JOIN inventory i 
ON fc.film_id = i.film_id
LEFT JOIN rental r 
ON i.inventory_id = r.inventory_id
GROUP BY nombre_categoria   -- agrupados por categoria.
ORDER BY total_peliculas_alquiladas_por_categoria; -- orden en el que quiero orden y por loq ue quiero ordenar.


-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla `film` y muestra la clasificación junto con el promedio de duración.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM film;

SELECT rating clasificacion, ROUND(AVG(length)) promedio_duracion_peliculas -- calculamos el promedio de duración con AVG. el ROUND lo empleamops para redondear
FROM film 
GROUP BY clasificacion -- se agrupa por clasificación.
ORDER BY promedio_duracion_peliculas;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM actor;
SELECT * 
FROM film_actor; -- tenemos que usar esta tabla como intermendiaria de actor y film para poder unirlas por los id. 
SELECT * 
FROM film;

SELECT CONCAT(a.first_name,' ', a.last_name) nombre_apellido_actor -- He unido con concat las columnas nombre y apellido del actor para que aparezca solo en una.
FROM film_actor fa
INNER JOIN actor a -- Hacemos varios inner para poder conectar las tablas. Usamos el inner Join ya que quiero aquellos actores que aparezcan en x película.
ON a.actor_id = fa.actor_id
INNER JOIN film f
ON fa.film_id = f.film_id
WHERE f.title = 'Indian Love'; -- Filtramos por la película que queremos.


-- 14. Muestra el título de todas las películas que contengan la cadena de caracteres "dog" o "cat" en su descripción.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM film;

SELECT title titulo_pelicula, description descripcion
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%'; -- LIKE lo utilizamos cuando no sabemos la palabra exacta y queremos buscar usando patrones,los % indican que puede ser cualquier nº de caracteres y el orden tanto delante como detrás. 

-- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla `film_actor`.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM actor;
SELECT * 
FROM film_actor;


SELECT a.first_name nombre_actor, a.last_name apellido_actor
FROM actor a -- tabla principal quiero todos los actores, todos los registros, por eso hago un left.
LEFT JOIN film_actor fa -- comparo el LEFT con film_actor.
ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL; -- Buscamos los que quedaron NULOS en la unión exclusivamente, para saber aquellos que no aparecen en ninguna película.

-- Aparece vacío, por lo que no hay ningún actor o actriz que no aparezca en al menos una película. Todos los registros de la tabla actor tienen una correspondencia en film_actor.

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM film;


SELECT title nombre_pelicula, release_year año_lanzamiento
FROM film 
WHERE release_year BETWEEN 2005 AND 2010;

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM film;
SELECT *
FROM category;
SELECT *
FROM film_category; -- tenemos que usar esta tabla como intermendiaria de film y category para poder unirlas por los id. 


SELECT f.title nombre_pelicula, c.name categoria
FROM film_category fc
INNER JOIN film f
ON fc.film_id = f.film_id
INNER JOIN category c
ON fc.category_id = c.category_id
WHERE c.name = 'Family';


-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM actor;
SELECT * 
FROM film_actor;

SELECT  CONCAT(a.first_name,' ', a.last_name) nombre_apellido_actor, COUNT(fa.film_id) total_peliculas-- Hacemos un count del fa.film_id para saber cuantas veces ha aparecido ese actor en la peli.
FROM film_actor fa
INNER JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) > 10 -- en el Having hacememos el cálculo agrupado de cuantas veces aparece el actor, sea mayor a 10. 
ORDER BY total_peliculas DESC; -- Ordenamos de mayor a menor.


-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla `film`.
-- Hago un Select para ver toda la tabla y sus campos: 
SELECT * 
FROM film;

SELECT title nombre_pelicula, length duracion
FROM film
WHERE rating = 'R' AND length > 120
ORDER BY duracion DESC; -- Ordenamos de mayor a menor


-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.

-- Hago un Select para ver toda la tabla y sus campos:
SELECT * 
FROM film;
SELECT *
FROM category;
SELECT *
FROM film_category; -- tenemos que usar esta tabla como intermendiaria de film y category para poder unirlas por los id. 

SELECT c.name nombre_categoria, ROUND(AVG(length)) duracion_media -- hacemos el round para redondear la duración media, cálculo que realizamos con el AVG.
FROM film_category fc
INNER JOIN category c
ON fc.category_id = c.category_id
INNER JOIN film f
ON f.film_id = fc.film_id
GROUP BY c.name -- Agrupamos por nombre de categoria.
HAVING AVG(length) > 120 -- en el Having hacemos el cálculo agrupado de la duración media mayor a 120.
ORDER BY duracion_media DESC; -- Ordenamos por duracion media de mayor a menor.

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

-- Hago un Select para ver toda la tabla y sus campos:
SELECT * 
FROM actor;
SELECT * 
FROM film_actor; 

SELECT CONCAT(a.first_name,' ', a.last_name) nombre_apellido_actor, COUNT(fa.film_id) total_peliculas -- Hacemos un count del fa.film_id para saber cuantas veces ha aparecido ese actor en la peli.
FROM film_actor fa
INNER JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) >= 5 -- en el Having hacememos el cálculo agrupado de cuantas veces aparece el actor, sea mayor o igual a 5. 
ORDER BY total_peliculas DESC; -- Ordenamos de mayor a menor


-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes. PISTA = Infórmate de cómo funciona DATEDIFF

-- Hago un Select para ver toda la tabla y sus campos:
SELECT * 
FROM film;
SELECT*
FROM rental;
SELECT*
FROM inventory; -- tenemos que usar esta tabla como intermendiaria de film y rental para poder unirlas por los id. 

SELECT title nombre_pelicula 
FROM film f
WHERE f.film_id IN ( -- utilizo la subconsulta con IN para decir que de mi consulta de arriba lo que este dentro de la subconsulta se cumpla. ESTE DENTRO.
	SELECT i.film_id -- UNO film - inventory - rental 
	FROM inventory i 
    INNER JOIN rental r
    ON i.inventory_id = r.inventory_id
	WHERE DATEDIFF(r.return_date, r.rental_date) > 5); -- La función DATEDIFF es una herramienta de SQL que sirve para calcular la diferencia de tiempo entre dos fechas. "Fecha Mayor primero, Fecha Menor después".


-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

-- Hago un Select para ver toda la tabla y sus campos:
SELECT * 
FROM actor;
SELECT *
FROM category;
SELECT * 
FROM film_actor; -- tenemos que usar esta tabla como intermendiaria de film y actor para poder unirlas por los id. 
SELECT *
FROM film_category; -- tenemos que usar esta tabla como intermendiaria de film y category para poder unirlas por los id. 


SELECT CONCAT(a.first_name,' ', a.last_name) nombre_apellido_actor 
FROM actor a -- mi consulta principal es en la tabla actores ya que quiero saber el nombre y apellido de estos mismo.
WHERE a.actor_id NOT IN ( -- hago uso de la subconsulta con NOT IN para decir que NO estén, en este caso los actores en la categoria Horror, para que me los excluya y me muestre los del resto de categorias.
	SELECT fa.actor_id
	FROM film_actor fa -- hago varios inner para unir actor - film_actor - film_category - category.
	INNER JOIN film_category fc 
	ON fa.film_id = fc.film_id
	INNER JOIN  category c 
	ON fc.category_id = c.category_id
	WHERE c.name = 'Horror');  -- Donde el nombre de la categoria sea = a horror

-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla `film`.

-- Hago un Select para ver toda la tabla y sus campos:

SELECT * 
FROM film;
SELECT *
FROM category;
SELECT *
FROM film_category;  -- tenemos que usar esta tabla como intermendiaria de film y category para poder unirlas por los id. 


SELECT f.title nombre_pelicula, f.length duracion, c.name categoria
FROM film_category fc
INNER JOIN category c
ON fc.category_id = c.category_id
INNER JOIN film f
ON f.film_id = fc.film_id
WHERE c.name = 'Comedy' AND f.length > 180 
ORDER BY length ASC;
