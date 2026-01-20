-- DML 
-- Insert 
-- Update 
-- Delete

select * from actor_cp ;

-- delete all the data from the table 
delete from actor_cp;

drop table actor_cp ;
create table actor_cp as 
select first_name , last_name from sakila.actor ;

-- truncate
truncate actor_cp ;

-- difference between truncate and delete 
-- truncate is a DDL statement  where as Delete is a DML statement 
-- no condition is given in truncate where as you can give conditions in delete statement 
-- in truncate we can not revert(roll back)  but in delete we can roll back

-- NOTE :
-- IN CASE : IF YOU HAVE EXECUTED ANY DDL STATEMENT YOU CAN NOT ROLL BACK 

-- OBJECTS (table): ARE STRUCTURE THAT IS USED TO STORE , MANAGE,REFER THE DATA  