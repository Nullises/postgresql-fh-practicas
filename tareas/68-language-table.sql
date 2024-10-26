-- Tarea con countryLanguage

-- Crear la tabla de language

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS language_code_seq;


-- Table Definition
CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT 	nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);

-- Crear una columna en countrylanguage
ALTER TABLE countrylanguage
ADD COLUMN languagecode varchar(3);

-- Paso previo insertar data en lenguage
SELECT DISTINCT language FROM countrylanguage ORDER BY language ASC;
INSERT INTO language(name)
	SELECT DISTINCT language FROM countrylanguage ORDER BY language ASC;

-- Empezar con el select para confirmar lo que vamos a actualizar
select "language", 
(SELECT code FROM language b WHERE a."language" = b."name" )
from countrylanguage a;


-- Actualizar todos los registros
UPDATE countrylanguage
SET languagecode = (SELECT code FROM language b WHERE countrylanguage."language" = b."name" );
	

-- Cambiar tipo de dato en countrylanguage - languagecode por int4
ALTER TABLE countrylanguage
ALTER COLUMN languagecode TYPE int4
USING languagecode::integer;

-- Crear el forening key y constraints de no nulo el language_code

 
 ALTER TABLE countrylanguage
     ADD CONSTRAINT "fk_countrylanguage_language"
     FOREIGN KEY (languagecode)
     REFERENCES language(code)
     ON DELETE CASCADE
     ON UPDATE CASCADE;
     
SELECT lan.name, 
	(SELECT con.language FROM "countrylanguage" con WHERE  lan.name = con.language )
FROM "language" lan;

     
 ALTER TABLE countrylanguage
 	ALTER COLUMN languagecode SET NOT NULL;


-- Revisar lo creado