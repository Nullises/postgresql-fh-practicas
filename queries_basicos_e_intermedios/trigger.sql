-- crear función que disparará el trigger
create or REPLACE function create_session_log()
RETURNS TRIGGER as 
$$

    -- new hace referencia al usuario recien creado cuando hace el update 
    -- el trigger más abajo
	insert into "session" (user_id, last_login) values ( new.id, now() );
	
	return new;
end;
$$ language plpgsql;

-- crear trigger. after update significa que se disparará después que 
-- se haga la actualización
create or replace trigger create_session_trigger after update on "user"
for each row 
WHEN (OLD.last_login IS DISTINCT FROM NEW.last_login)
execute function create_session_log();

-- probamos el login (el stored procedure que creamos antes)
call user_login('nullises', '123456');