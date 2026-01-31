-- DCL 
-- premission which user can accessibility 
-- authentication and authorization 

-- user => create => permission 

-- ddl statement 
create user regex identified by 'regex';

select * from mysql.user;

create database paridhidb;

create table paridhidb.actor as select actor_id ,first_name from sakila.actor
where actor_id between 1 and 5 ;

-- we will check here the permission 

show grants for regex ;     

-- grant permission on database to username 
create table paridhidb.actor2 as select actor_id ,first_name from sakila.actor
where actor_id between 3 and 7 ;

grant select on paridhidb.actor2 to regex ;         -- select statement permission given 


grant select on paridhidb.* to regex ;     -- all permission given of select 


grant all privileges on paridhidb.actor to regex ;

show grants for regex ;
