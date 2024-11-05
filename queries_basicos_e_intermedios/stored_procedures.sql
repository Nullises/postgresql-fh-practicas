CREATE OR REPLACE PROCEDURE insert_region_proc(INT, VARCHAR)
AS $$
BEGIN

	raise notice 'Variable 1: %', $1;
	raise notice 'Variable 2: %', $2;

	INSERT INTO regions(region_id, region_name)
		VALUES ($1, $2);
		
	-- ROLLBACK;
    COMMIT;

END;
$$ LANGUAGE plpgsql;


CALL insert_region_proc(5, 'Central America');
SELECT * FROM regions;

-- Store Procedure con parámetros
-- percentage: 5
create or REPLACE PROCEDURE controlled_raise ( percentage NUMERIC ) AS
$$
DECLARE
	real_percentage NUMERIC(8,2);
	total_employees int;

BEGIN
	real_percentage = percentage / 100; --5% = 0.05;
	
	-- Mantener el historico
	insert into raise_history( date, employee_id, base_salary, amount, percentage )
	select 
		CURRENT_DATE as "date",
		employee_id,
		salary,
		max_raise( employee_id ) * real_percentage as amount,
		percentage
	from employees;

	-- Impactar la tabla de empleados
	update employees
		set salary = (max_raise( employee_id ) * real_percentage) + salary;

	COMMIT;

	select count(*) into total_employees from employees;

	raise notice 'Afectados % empleados', total_employees;

END;
$$ LANGUAGE plpgsql;



CALL controlled_raise(1);

-- Stored procedure login
CREATE OR REPLACE PROCEDURE public.user_login(IN user_name character varying, IN user_password character varying)
 LANGUAGE plpgsql
AS $procedure$ 
declare was_found boolean;
BEGIN
select
    count(*) into was_found
from
    "user"
where
    username = user_name
    and password = crypt(user_password, password);
    
    if (was_found = false) THEN
	    insert into session_failed(username, attempt) values (user_name, now());
    	commit;
		raise EXCEPTION 'Usuario o contraseña incorrectos';
    end if;
    
    update "user" set last_login = now() where username = user_name;
    commit;
	raise notice 'Usuario encontrado %', was_found;
end;
$procedure$

