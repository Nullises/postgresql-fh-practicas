
CREATE EXTENSION pgcrypto;

-- encriptar
insert into "user" (username, "password")
values ('nullises', crypt('123456', gen_salt('bf')));

-- comparar contraseña con encriptada
select * from "user" 
where username = 'nullises' 
and password = crypt('123456', password)

