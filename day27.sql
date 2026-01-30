-- view 
-- view is a virtual table based on th query result 
-- it do not store the data physically  but will access the data from the existing table 
-- views are simple and complex 

-- ADVANTAGE 
-- make your complex query easy 
-- help in security ==> by ristricting user to to access specific columns or rows


use REGEX;

create table newactor as 
select actor_id , first_name from sakila.actor where actor_id between 1 and 3 ;

select * from newactor ;

select * , substr(first_name , 2) from newactor;

-- created view here for the query 
create view actor_v as
select * , substr(first_name , 2) from newactor;       -- complex view 

-- if we use 
-- aggregate function , window function , distinct , group by , having , joins  for creating a view the 
-- we can only make changes to original table only  

select * from actor_v ;

-- if changes made to original table it will be visible in view also 
insert into newactor values (4,'riya');

select * from newactor ;

select * from actor_v;               -- changes are visible 

-- simple view -> any dml changes will be visible on original table 
 create view actor_v2 as
select * from newactor where actor_id in(1,2);

select * from actor_v2 ;

select * from newactor ;

-- if we insert in original table 
insert into newactor values(5,'paridhi');

select * from newactor;     -- changes are visible in newactor 
select * from actor_v2 ;     -- but not in view table beacuse we have made it using filter condition for actor_id 

-- insert in view 
insert into actor_v2 values (8,'newdata of view');    -- if it is a simple view changes will be visible 

select * from newactor ;





create table newpayment as 
select payment_id ,amount from sakila.payment where payment_id between 1 and 7;

select * from newpayment ;

create view payment_v as 
select count(*) from newpayment ;

select * from payment_v ;

insert into payment_v values(10);         -- if we try to insert into complex view it will give error 
