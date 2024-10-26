-- COMO YO LO RESOLVÍ
SELECT sub1.country, MAX(sub1.total) AS total_cities FROM
(SELECT a.name AS country, COUNT(*) AS total FROM country a
INNER JOIN city b ON b.countrycode = a.code
GROUP BY a.name) AS sub1
WHERE sub1.total =  (SELECT MAX(sub1.total) 
    FROM 
        (SELECT a.name AS country, COUNT(*) AS total 
        FROM country a
        INNER JOIN city b 
        ON b.countrycode = a.code
        GROUP BY a.name) AS sub1
    )
GROUP BY sub1.country

-- COMO EL LO RESOLVIÓ
SELECT a.name AS country, COUNT(*) AS total 
        FROM country a
        INNER JOIN city b 
        ON b.countrycode = a.code
        GROUP BY a.name
        ORDER BY total DESC
        limit 1;