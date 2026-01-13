-- DDL => DATA DEFINATION LANGUAGE 
-- CREATE => (structure of the table)
-- drop , truncate, alter 

use REGEX;
create table user(col int);

-- craete table using select statement(CTAS)

-- create table as select 
create table actor_cp as 
select first_name , last_name from sakila.actor ;

select * from actor_cp ;

-- drop table => table structure and data both get deleted
drop table actor_cp ;

-- 
create table actor_cp as 
select first_name as fname , last_name as lname from sakila.actor
where actor_id between 10 and 14;

select * from actor_cp ;

-- ALTER 

-- adding column 
alter table actor_cp add column (salary int);

-- adding constraint :also add constraint name 
alter table actor_cp add constraint  new_key primary key (fname);

-- if you want to drop the constraint
alter table actor_cp drop constraint new_key;

-- to drop a column 
alter table actor_cp drop column salary;

-- rename column 
alter table actor_cp rename column lname to last_name ;

select * from  actor_cp ;
-- DML STATEMENT 
-- INSERT ,
-- UPDATE 
update actor_cp set last_name = 'saraswat' where fname = 'UMA';  


