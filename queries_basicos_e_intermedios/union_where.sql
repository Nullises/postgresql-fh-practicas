SELECT cou.name AS country_name, con.name AS continent_name FROM country cou, continent con
WHERE cou.continent = con.code
ORDER BY cou.name ASC;