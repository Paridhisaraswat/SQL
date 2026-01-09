-- foreign key :
use REGEX;

create table customer(cid int , cname varchar(20));
insert into customer values(1,'paridhi'),(2,'aman');

create table orderss(order_id int , city varchar(20));
insert into orderss values(1009,'jaipur'),(1008,'goa');

drop table customer ;
drop table orderss ;

create table customer(cid int primary key,cname varchar(20));
insert into customer values(10,'Paridhi'),(2,'raghav');

create table orderss(oid int primary key , city varchar(20),cid int,foreign key(cid) references customer(cid));
insert into orderss values (1007,'jaipur',10),(1008,'goa',2),(1009,'j&k',10),(1010,'ranchi',90); 
-- it will give error as thier is no cid = 90 in the customer table
 
insert into orderss values (1007,'jaipur',10),(1008,'goa',2),(1009,'j&k',10);
select * from customer;
select * from orderss;





