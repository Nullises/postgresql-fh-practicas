
-- ¿Quiero saber los idiomas oficiales que se hablan por continente?

select distinct a."language", c."name" as continent from countrylanguage a 
inner JOIN country b ON a.countrycode = b.code
inner join continent c on b.continent = c.code
where a.isofficial = true
group by c.name, a.language;


-- ¿Cuantos idiomas oficiales se hablan por continente?
select count(*), continent from (
	select distinct a."language", c."name" as continent from countrylanguage a 
	inner JOIN country b ON a.countrycode = b.code
	inner join continent c on b.continent = c.code
	where a.isofficial = true
) as totales
group by continent;


-- tarea: sustituir a."language" por a.languagecode
select distinct d.name, c."name" as continent from countrylanguage a 
inner JOIN country b ON a.countrycode = b.code
inner join continent c on b.continent = c.code
Inner join language d on a.languagecode = d.code 
where a.isofficial = true
group by c.name, d.name;

-- tarea: sustituir a."language" por a.languagecode 
-- ¿Cuantos idiomas oficiales se hablan por continente?
select count(*), continent from (
	select distinct d.name, c."name" as continent from countrylanguage a 
    inner JOIN country b ON a.countrycode = b.code
    inner join continent c on b.continent = c.code
    Inner join language d on a.languagecode = d.code 
    where a.isofficial = true
) as totales
group by continent;