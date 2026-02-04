-- Indexes 
use sakila ;

create table test100 as select actor_id , first_name from actor where actor_id between 1 and 10 ;

select * from test100 ;

desc test100;      -- no primary key 

explain select * from test100 where actor_id = 5 ;

-- indedx :
-- an index is a db object that allows the db engine to
-- find rows faster by creating a stored refrences to one or more columns in a table 
-- is like a data structure which is used to access your data in a faster way 


-- clustered index :
-- define the physical order in which data is stored in a database 
-- there is only one clustered index or column in a table
-- because the data rows themseleves can be stored in data order  
-- it stores the data in sorted format 

insert into test100 values(14,'abc'),(13,'def'),(11,'aman'),(12,'paridhi');

select * from test100 ;

alter table test100 add primary key(actor_id);      -- clustered index 
desc test100;

explain select * from test100 where first_name = 'NICK' ; 
-- it takes more time to search on a non clustered columns 
-- or on which we have not creqated indexes 

select * from test100 ;

alter table test100 drop primary key;

explain select * from test100 where actor_id = 5 ;-- it will take more time to search 

drop table test100;
create table test100 as select actor_id , first_name from actor where actor_id between 1 and 10 ;
insert into test100 values(14,'abc'),(13,'def'),(11,'aman'),(12,'paridhi');

-- non-clustered index 
create index index1 on test100 (actor_id);

show indexes from test100;
select * from test100 ;
desc test100;

explain select * from test100 where actor_id = 5 ;

select * from test100 ;

insert into test100 values(12,'tushar'),(15,'raghav');

select * from test100 ;
explain select * from test100 where actor_id = 12 ;

drop index index1 on test100;

-- MULTI COLUMN INDEX
create index indx_composite on test100(actor_id , first_name);

show index from test100;

explain select * from test100 where actor_id = 4;

explain select * from test100 where first_name= 'paridhi';  -- this will take more time 

explain select * from test100 where actor_id > 10 and first_name= 'paridhi';

insert into test100 values(16,'JOHN'),(17,'pari'),(18,'MATRIX'),(19,'dev');

drop index indx_composite on test100;
show index from  test100;

-- PARTIAL INDEX :
-- index over a subset 

create index index_3_chr on test100(first_name(3));

show index from test100;

select * from test100 where first_name = 'JOHNNY';

explain select * from test100 where first_name = 'JOHNNY';

explain select * from test100 where first_name like 'JOH%';
