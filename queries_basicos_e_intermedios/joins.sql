-- 1) INNER JOIN
SELECT a.name as country, b.name as continent
FROM country a 
INNER JOIN continent b ON a.continent = b.code
ORDER BY a.name ASC;

-- 2) FULL OUTER JOIN
SELECT a.name AS countryName, b.name AS continentName
FROM country a
FULL OUTER JOIN continent b ON a.continent = b.code
ORDER BY countryName DESC;

-- 3) RIGHT OUTER JOIN CON EXCLUSION
SELECT a.name AS countryName, b.name AS continentName
FROM country a
RIGHT JOIN continent b ON a.continent = b.code
WHERE a.name IS NULL
ORDER BY countryName DESC;

-- 4) JOIN CON AGREGACIÓN
SELECT COUNT(*) AS count_countries, b.name FROM country a
INNER JOIN continent b ON a.continent = b.code
GROUP BY a.continent, b.name
ORDER BY count_countries ASC;

-- 5) JOIN CON AGREGACIÓN + UNION
SELECT COUNT(*) AS count_countries, b.name FROM country a
INNER JOIN continent b ON a.continent = b.code
GROUP BY a.continent, b.name
UNION
SELECT 0 AS count_countries, b.name FROM country a
RIGHT JOIN continent b ON a.continent = b.code
WHERE a.continent IS NULL
GROUP BY a.continent, b.name
ORDER BY count_countries ASC;