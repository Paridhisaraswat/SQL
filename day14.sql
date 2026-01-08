-- table creation :
-- DDL statement (data defination language)
-- define the structure of the table 
-- create , drop ,alter,truncate 

use REGEX;
create table test1(sno int);       -- table create(  sno column name)

-- to get all the info about the table 
describe test1;

-- DML (Data manipulation language)
-- (insert , update , delete , merge)
-- to insert the data 

-- 1st method
insert into test1 values(10);
select * from test1;

-- 2nd method 
insert into test1(sno) values(11);

-- 3rd method 
insert into test1(sno) values(12),(NULL),(30);
select * from test1;

-- count(column name) ---> it doesn't count NULL values 
-- count(*) ---->it count number of rows with NULL values also 
select count(sno),count(*) from test1;


-- CONSTRAINT

-- (1)NOT NULL
create table test2(sno int not null ,salary int);
insert into test2(sno,salary) values(20,1000);
insert into test2(sno,salary) values(20,NULL);

-- this will give me an error because of constraint
insert into test2(sno,salary) values(NULL,2000);

insert into test2(sno) values(90);

-- this will give an error because of the not null constraint in (sno)
insert into test2 (salary) values(7000);

select * from test2;

-- (2)DEFAULT 
create table test3(sno int not null default 80 , salary int);
insert into test3(salary) values(90000);

insert into test3(sno) values(70);   -- here salary do not have any constraint so the value will be NULL

select * from test3 ;

-- (3)UNIQUE
create table test4(sno int not null , salary int unique default 100);

insert into test4 values(100 , 20000);
insert into test4 values(100 , 20000); -- error because of the unique constraint in salary 

insert into test4(sno) values(800);

insert into test4(sno) values(200);  -- error because the default value in already present in the table 
insert into test4 values(101 ,NULL ); -- we can insert null values in case of default and unique 
insert into test4 values(103 ,NULL); -- we can insert more then one NULL value in case of unique as no data is present their 

select * from test4;


-- (4)check :to give conditions in the constrainst 
-- check column name  condition 
create table test5(sno int, salary int ,
check(sno between 1 and 100),
check(salary in (1000,2000) ));

insert into test5 values(4 , 1000);
insert into test5 values(7,2000);

insert into test5 values(150,1000);   -- error constraint 1 sno between 1 and 100

insert into test5 values(100,25000); -- error constraint 2 salary can be 1000 or 2000

-- drop table 
drop table test5;
 create table test5(sno int, salary int ,
constraint regex_test5_sno_chk check(sno between 1 and 100),        -- renaming the contraint 
constraint regex_test5_salary_chk check(salary in (1000,2000) ));

insert into test5 values(4 , 1000);
insert into test5 values(7,2000);

insert into test5 values(150,1000);   -- it will our generated constraint name 


-- create a table name as employee 
-- emp_id PRI KEY ,
-- ENAME varchar
-- email unique 
-- clg with default value 
-- age chech age >18 
-- gurdian name should be a palindrome 


create table employees (
emp_id int primary key ,
e_name varchar(50),
email varchar(100) unique ,
clg varchar(50) default 'abc',
age int check(age> 18),
gurdian varchar(50) 
check (gurdian = reverse(gurdian)) 
);

describe employees;

 
 










