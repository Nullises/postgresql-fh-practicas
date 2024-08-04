SELECT
    name,
FROM
    users;
UPDATE
    users
SET
    first_name = TRIM(SUBSTRING(name, 0, (POSITION(' ' IN name)))),
    last_name = TRIM(
        SUBSTRING(name, (POSITION(' ' IN name)), LENGTH(name))
    );
SELECT
    *
FROM
    users;
