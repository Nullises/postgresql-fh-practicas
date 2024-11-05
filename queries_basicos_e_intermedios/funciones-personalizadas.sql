CREATE OR REPLACE FUNCTION comment_replies( id integer )
RETURNS json
AS
$$
DECLARE result json;

BEGIN
	
	select 
		json_agg( json_build_object(
		  'user', comments.user_id,
		  'comment', comments.content
		)) into result
	from comments where comment_parent_id = id;


	return result;
END;
$$
LANGUAGE plpgsql;



select comment_replies(4);


select 
	a.*,
	comment_replies(a.post_id) as replies
from comments a
where comment_parent_id is null;

-- funcion greet employee
CREATE OR REPLACE FUNCTION greet_employee(employee_name VARCHAR)
RETURNS VARCHAR
AS
$$
BEGIN
RETURN 'Hola ' || employee_name;
END;
$$
LANGUAGE plpgsql

-- funcion calcula el maximo aumento
CREATE OR REPLACE FUNCTION max_raise(empl_id int)
RETURNS NUMERIC(8,2)
AS
$$

DECLARE possible_raise NUMERIC(8,2);

BEGIN
	SELECT j.max_salary - e.salary INTO possible_raise
	FROM employees e
INNER JOIN jobs j on e.job_id = j.job_id
WHERE e.employee_id = empl_id;

RETURN possible_raise;

END;
$$
LANGUAGE plpgsql

-- uso de la funcion de aumento
SELECT concat(e.first_name, ' ') || e.last_name as full_name, 
e.salary, max_raise(e.employee_id) as possible_raise 
FROM employees e

-- funcion calcula maximo aumento de acuerdo a la posición
	possible_raise NUMERIC(8,2);

BEGIN
	
	-- Tomar el puesto de trabajo y el salario
	select 
		job_id, salary
		into employee_job_id, current_salary
	from employees where employee_id = empl_id;

	-- Tomar el max salary, acorde a su job
	select max_salary into job_max_salary from jobs where job_id = employee_job_id;
	
	
	-- Cálculos
	possible_raise = job_max_salary - current_salary;


	return possible_raise;
	
END;
$$ LANGUAGE plpgsql;

-- uso de max_raise_2
SELECT concat(first_name, ' ') || last_name as full_name, 
salary, max_raise_2(employee_id) as possible_raise FROM employees

-- Función con condicionales y manejo de errores
CREATE OR REPLACE FUNCTION max_raise_2( empl_id int )
returns NUMERIC(8,2) as $$

DECLARE
	employee_job_id int;
	current_salary NUMERIC(8,2);

	job_max_salary NUMERIC(8,2);
	possible_raise NUMERIC(8,2);

BEGIN
	
	-- Tomar el puesto de trabajo y el salario
	select 
		job_id, salary
		into employee_job_id, current_salary
	from employees where employee_id = empl_id;

	-- Tomar el max salary, acorde a su job
	select max_salary into job_max_salary from jobs where job_id = employee_job_id;
	
	
	-- Cálculos
	possible_raise = job_max_salary - current_salary;
	
	-- Condiciones
	IF (possible_raise < 0) THEN
-- Lanzará una excepción si hay un numero negativo	
		raise exception 'Persona con salario mayor al posible aumento, %', empl_id;
-- Será cero si el possible_raise es negativo		
--		possible_raise = 0;
	END IF;


	return possible_raise;
	
END;
$$ LANGUAGE plpgsql;

-- Función con condiciones y Rowtype
CREATE OR REPLACE FUNCTION max_raise_2( empl_id int )
returns NUMERIC(8,2) as $$

DECLARE

	-- rowtype: guarda toda la información del row
	selected_employee employees%rowtype;
	selected_job 	  jobs%rowtype;

	possible_raise NUMERIC(8,2);

BEGIN
	
	-- Guardar todo el row en el rowtype de empleado
	select 
		*
	from employees into selected_employee
	where employee_id = empl_id;

	-- Guardar todo el row en el rowtype de job
	-- el job_id será el mismo del rowtype de empleado
	select * from jobs into selected_job where job_id = selected_employee.job_id;
	
	
	-- Cálculos
	possible_raise = selected_job.max_salary - selected_employee.salary;
	
	-- Condiciones
	IF (possible_raise < 0) THEN
-- Lanzará una excepción si hay un numero negativo	
		-- raise exception 'Persona con salario mayor al posible aumento, %', selected_employee.first_name;
-- Será cero si el possible_raise es negativo		
		possible_raise = 0;
	END IF;


	return possible_raise;
	
END;
$$ LANGUAGE plpgsql;

-- uso de la función
SELECT concat(first_name, ' ') || last_name as full_name, 
salary, max_raise_2(employee_id) as possible_raise FROM employees;


-- funcion que retorna un query
create or replace function country_region()
	returns table (id CHARACTER(2), name varchar(40), region VARCHAR(25))
	as $$
	
	BEGIN
	return query 
		select country_id, country_name, region_name from countries
		inner join regions on countries.region_id = regions.region_id;
	END;
	
	$$ LANGUAGE plpgsql;



SELECT * FROM country_region();