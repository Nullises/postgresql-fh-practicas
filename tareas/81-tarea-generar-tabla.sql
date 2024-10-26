-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America
-- 51	  | Asia
-- 58	  | Africa

-- COMO YO LO RESOLVÍ
SELECT SUM(sub.america_countries) AS total, 'America' AS continent_name
FROM (
    SELECT COUNT(*) AS america_countries
    FROM country a
    INNER JOIN continent b ON a.continent = b.code
    WHERE b.name LIKE '%America%'
) AS sub
UNION
SELECT COUNT(*) AS total, b.name AS continent_name FROM country a
RIGHT JOIN continent b ON a.continent = b.code
WHERE b.name NOT LIKE '%America%' AND a.name IS NOT NULL 
GROUP BY a.continent, b.name
ORDER BY total ASC;

-- COMO EL LO RESOLVIO
(
	SELECT
		count(*) AS Total,
		b.name
	FROM
		country a
		INNER JOIN continent b ON a.continent = b.code
	WHERE
		b.name NOT LIKE '%America%'
	GROUP BY
		b.name)
UNION (
	SELECT
		count(*) AS total,
		'America'
	FROM
		country a
		INNER JOIN continent b ON a.continent = b.code
	WHERE
		b. "name" LIKE '%America%')
ORDER BY
	total ASC;
