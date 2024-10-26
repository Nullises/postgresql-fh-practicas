

-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?

select * from countrylanguage where isofficial = true;

select * from country;

select * from continent;

Select * from "language";


select count(*) AS total, b.language AS "Idioma", b.languagecode "Código" 
from country a 
inner join countrylanguage b ON a.code = b.countrycode
where  a.continent = 5 AND b.isofficial IS TRUE
group by  b.language, b.languagecode
order by total DESC
limit 1;


-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa 
-- (no hacer subquery, tomar el código anterior)


select a.name AS "Países" from country a
inner join countrylanguage b ON a.code = b.countrycode
where b.languagecode = 135 AND b.isofficial IS TRUE
order by a.name DESC;





