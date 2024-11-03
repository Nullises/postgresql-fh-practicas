-- Crear la vista
CREATE VIEW claps_per_week AS
SELECT date_trunc('week', posts.created_at) AS weeks,
	COUNT(DISTINCT posts.post_id) AS total_posts,
	SUM(claps.counter) AS total_claps
FROM posts
INNER JOIN claps on claps.post_id = posts.post_id
GROUP BY weeks
ORDER BY weeks DESC;

-- Consultar la vista
SELECT * FROM claps_per_week;

-- Crear vista materializada
CREATE MATERIALIZED VIEW claps_per_week_materialized AS
SELECT date_trunc('week', posts.created_at) AS weeks,
	COUNT(DISTINCT posts.post_id) AS total_posts,
	SUM(claps.counter) AS total_claps
FROM posts
INNER JOIN claps on claps.post_id = posts.post_id
GROUP BY weeks
ORDER BY weeks DESC;

-- Actualizar vista materializada
REFRESH MATERIALIZED VIEW claps_per_week_materialized;

-- Cambiar nombre a vistas y vistas materializadas

ALTER VIEW claps_per_week RENAME TO posts_and_claps_per_week
ALTER MATERIALIZED VIEW claps_per_week_materialized RENAME TO posts_and_claps_per_week_mat