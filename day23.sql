-- TCL :(Transaction control language)
-- Transaction => set of logical statement (no permanent changes),
-- used to handle logical statement 

-- we use tcl for maintaing data consistency 

use regex;

create table actor_cp_ as select actor_id , first_name from sakila.actor 
where actor_id between 1 and 5 ;

select * from actor_cp_;

insert into actor_cp_ values (6,'PARIDHI');

select * from actor_cp_;

-- to check if autocommit is enable  
select @@autocommit;

-- to disable autocommit 
set @@autocommit= 0;
insert into actor_cp_ values (7,'SNEHAL');  -- this insert will not be visible in new connection beacuse the autocommit is disable 
-- but it will be visible in the current session 

insert into actor_cp_ values (8,'MANSI');
-- (1) COMMIT : it is use to save changes over different session 
commit; 

insert into actor_cp_ values (9,'SOHA');
update actor_cp_ set actor_id = 100; 
rollback;  -- it gets you back to your previsous position where you left 

-- if i fisrt commit changes then rollback 
-- data will be saved
insert into actor_cp_ values (9,'SOHA');
commit;
-- now roll back 
rollback; -- no changes will be revert back as it was saved already 
 
select * from actor_cp_;
set @@autocommit= 1;

-- TRABSACTION 
-- when it will start 
-- if auto commit is disabled  or write down START TRANSACTION 
-- in case if you run any DML OPERATION
-- after this any insert or update will be logical changes 
-- not permanent changes 

-- when my transaction will automatically close 
-- when we will use any TCL command statement like 
-- COMMIT ,ROLLBACK
-- or in case if run any DDL OPERATION 
-- or any DCL OPARATION 

start transaction ;
insert into actor_cp_ values(11,'RIDDHI');
select * from actor_cp_; 
commit;
-- after this if we insert one more value it will be saved automatically 
-- because we have use commit 
-- to again start transaction we have to use or start it again 
start transaction ;
insert into actor_cp_ values(10,'SIDDHI');
select * from actor_cp_; 
-- to automatically save we can use any DDL statement 
create table xyz(id int);
select * from actor_cp_; 

start transaction ; -- these changes will not be visible in second connection 
insert into actor_cp_ values(12,'RAGHAV');
insert into actor_cp_ values(13,'DAKSH');
delete from actor_cp_ where actor_id in (1,3,5);
select * from actor_cp_;
rollback ;
select * from actor_cp_;

-- to save our work to a specific piont 
start transaction ;
insert into actor_cp_ values(16,'DEV');
insert into actor_cp_ values(13,'TANISHQ');
-- save point 
savepoint db_actor_cp_savepoint1;
delete from actor_cp_ where actor_id in (8);
select * from actor_cp_;
rollback ; -- here all these changes will be roll back 
-- because we have not specify the point to where we want to roll back 
rollback to db_actor_cp_savepoint1;
select * from actor_cp_;




