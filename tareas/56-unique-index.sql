CREATE UNIQUE INDEX "unique_country_continent" ON country (
    name,
    continent
);

CREATE INDEX "index_district" ON city(district);

SELECT * FROM city WHERE district = 'Sind';

CREATE UNIQUE INDEX "unique_name_country_district" ON city(name, countrycode, district);

SELECT * FROM city WHERE name = 'Old Jinzhou' AND countrycode = 'CHN' AND district = 'Liaoning';

UPDATE "public"."city" SET "name" = 'Old Jinzhou' WHERE "id" = 2238;