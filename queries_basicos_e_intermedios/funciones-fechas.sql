SELECT DATE_PART('days', CURRENT_DATE) AS día, DATE_PART('months', CURRENT_DATE) AS mes, DATE_PART('years', CURRENT_DATE) AS año;

SELECT * FROM employees
WHERE hire_date >= '2000-01-01'
ORDER BY hire_date ASC;

SELECT first_name as nombre, last_name as apellido, MAX(hire_date) as fecha_contratacion
from employees
group by first_name, last_name
ORDER BY fecha_contratacion DESC
limit 1;


-- empleados ultimos 5 años
SELECT * FROM employees
WHERE hire_date BETWEEN '1995-01-01' AND '2001-01-01'
ORDER BY hire_date DESC;

-- Funcion interval
SELECT max(hire_date) + INTERVAL '20 years' AS hire_date FROM employees;

-- Sumar año, mes y dia con interval
SELECT max(hire_date) as hire_date, max(hire_date) + INTERVAL '24.4 years' AS hire_date_plus FROM employees;

-- Sumar dato dinamico con make_interval
SELECT 
max(hire_date) as hire_date, 
max(hire_date) + MAKE_INTERVAL(YEARS := 24) as hire_with_current_date
FROM employees;

-- sumar con intervalo dinamico
SELECT hire_date, MAKE_INTERVAL(YEARS := DATE_PART('years', CURRENT_DATE)::integer - 
EXTRACT (YEARS FROM hire_date)::integer) AS computed_interval 
FROM employees;

-- Actualizar dinámicamente años de contratación de los empleados (con año actual)
UPDATE employees SET hire_date = hire_date + MAKE_INTERVAL(YEARS := DATE_PART('years', CURRENT_DATE)::integer - 
EXTRACT (YEARS FROM hire_date)::integer);

-- agrupar empleados que tienen menos de tres meses (no reciben aumento) vs. más de 3 meses (reciben aumento)
SELECT 
	first_name,
	last_name,
	hire_date,
	CASE
		WHEN EXTRACT (MONTH FROM hire_date)::integer >= DATE_PART('months', CURRENT_DATE)::integer - 2 THEN 'NUEVO INGRESO'
		ELSE 'RECIBE AUMENTO'
	END AS rango_antiguedad
FROM
	employees
ORDER BY hire_date DESC;