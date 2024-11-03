-- COMMON TABLE EXPRESSION (CTE)
WITH post_week_cte_2024 AS (
SELECT date_trunc('week', posts.created_at) AS weeks,
	COUNT(DISTINCT posts.post_id) AS total_posts,
	SUM(claps.counter) AS total_claps
FROM posts
INNER JOIN claps on claps.post_id = posts.post_id
GROUP BY weeks
ORDER BY weeks DESC
)

SELECT * from post_week_cte_2024
WHERE weeks BETWEEN '2024-01-01' AND '2024-12-31' AND total_claps >= 600;

-- Multiples CTE
WITH claps_per_post AS (
	SELECT post_id, SUM(counter) FROM claps
GROUP by post_id
), posts_from_2023 AS (
	SELECT * from posts where created_at BETWEEN '2023-01-01' AND '2023-12-31'
)

SELECT * FROM claps_per_post
	WHERE claps_per_post.post_id in (SELECT post_id FROM posts_from_2023)

-- CTE RECURSIVO
-- countdown: nombre de la tabla en memoria
-- val: campos que va a tener la tabla
WITH RECURSIVE countdown(val) AS (
	SELECT 5 as val
	UNION
	-- Query recursivo (se llama a sí mismo, hasta que se cumpla una condición para
	-- evitar una llamada infinita)	 
	SELECT val - 1 FROM countdown WHERE val > 1
)

-- SELECT de los campos
SELECT * FROM countdown;

-- NUMEROS ASCENDENTES
WITH RECURSIVE count_asc(val) AS (
	SELECT 1 as val
	UNION 
	SELECT val + 1 FROM count_asc WHERE val < 10
)

SELECT * FROM count_asc;

-- TABLA DE MULTIPLICAR
WITH RECURSIVE multiplier(base, val, res) AS (
	SELECT 5 as base, 1 as val, 5 * 1 as res
	UNION
	SELECT base, val + 1, (val+1) * base FROM multiplier WHERE val < 10
)

SELECT * FROM multiplier;

-- Tabla de empleados
WITH RECURSIVE bosses AS (

	SELECT id, name, name as boss, 1 as depth_level FROM employees WHERE id = 1
	UNION
	--recursive
	SELECT employees.id, employees.name, b.name as boss, depth_level + 1 FROM employees
		INNER JOIN bosses b ON b.id = employees.reports_to
		WHERE depth_level < 4
)

SELECT * FROM bosses;

-- Ejemplo sin recursividad
SELECT u.name as "twitter_user", ul.name as followed_by FROM followers f
INNER JOIN "user" u ON f.follower_id = u.id 
INNER JOIN "user" ul ON f.leader_id = ul.id