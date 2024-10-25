ALTER TABLE country 
    ADD CHECK(
        surfacearea > 0
    );


SELECT DISTINCT continent from country;

ALTER TABLE country
    ADD CHECK (
        (continent = 'Asia'::text) OR
        (continent = 'Africa'::text) OR
        (continent = 'Europe'::text) OR
        (continent = 'North America'::text) OR
        (continent = 'South America'::text) OR
        (continent = 'Oceania'::text) OR
        (continent = 'Antarctica'::text) OR
    );

ALTER TABLE country
    DROP CONSTRAINT "country_continent_check";

UPDATE country SET continent = 'Central America' WHERE region = 'Central America';