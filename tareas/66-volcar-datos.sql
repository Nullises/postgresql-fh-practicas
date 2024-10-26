CREATE TABLE continent ("code" serial,"name" text, PRIMARY KEY ("code"));

INSERT INTO continent(name)
SELECT DISTINCT continent FROM country ORDER BY continent ASC;

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."country_bk" (
    "code" bpchar(3) NOT NULL,
    "name" text NOT NULL,
    "continent" text NOT NULL,
    "region" text NOT NULL,
    "surfacearea" float4 NOT NULL,
    "indepyear" int2,
    "population" int4 NOT NULL,
    "lifeexpectancy" float4,
    "gnp" numeric(10,2),
    "gnpold" numeric(10,2),
    "localname" text NOT NULL,
    "governmentform" text NOT NULL,
    "headofstate" text,
    "capital" int4,
    "code2" bpchar(2) NOT NULL,
    PRIMARY KEY ("code")
);

-- VOLCAR DATOS A UNA TABLA TEMPORAL

INSERT INTO country_bk
	SELECT * FROM country ORDER BY code ASC;
	
ALTER TABLE country	
	DROP CONSTRAINT country_continent_check;
	
	
-- VALIDAR QUE EL code SEA IGUAL AL continent (MEDIANTE UN SUBQUERY)
SELECT cou.name, cou.continent,
	(SELECT "code" FROM continent con WHERE con.name = cou.continent  )
FROM country cou;

-- ACTUALIZAR country PARA QUE EN VEZ DE CONTINENT SEA code
UPDATE country cou
	SET continent = (SELECT "code" FROM continent con WHERE con.name = cou.continent  );
	
-- CAMBIAMOS EL TIPO DE DATO
ALTER TABLE country
ALTER COLUMN continent TYPE int4
USING continent::integer;

	
-- CREAMOS EL FOREIGN KEY PARA QUE country SE RELACIONE CON continent
 ALTER TABLE country 
     ADD CONSTRAINT "fk_continent_country" 
     FOREIGN KEY (continent) 
     REFERENCES continent(code)
     ON DELETE CASCADE
     ON UPDATE CASCADE;

-- BORRAMOS LA TABLA TEMPORAL
DROP TABLE country_bk;