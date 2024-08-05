SELECT
    COUNT(*) as total,
    SUBSTRING(email,(POSITION('@' IN email)) + 1, LENGTH(email)) AS url_domain
FROM
    users
GROUP BY
    url_domain
HAVING
    COUNT(*) > 1
ORDER BY
    total DESC