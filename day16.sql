-- DATA TYPES 
-- numbers => int , decimal 
-- tiny int , small int , mediumint ,int , bigint 
-- 1bytes ,   2bytes ,    3bytes , 4 bytes,8 bytes 

use REGEX;
create table salary1(salary tinyint);

-- tinyint 
-- 1byte = 8 bit 2 ** 8 => 256 (-128 to 127) 
insert into salary1 values(127);

insert into salary1 values(128); -- this will give error as the value is out of range 

-- float ,double  
-- 4 bytes , 8bytes
-- float takes only specific number of decimal values 
-- where as double takes all decimal values 
create table salary2(salary float, price double);

insert into salary2 values(123.123456,123.123456);
select * from salary2;

-- type casting :
insert into salary2 values(123.123456,'423.123456'); -- here sql will convert this into double 

-- STRING VALUES 
-- CHAR OR VARCHAR 
-- char => fixed size charecter 
-- char ==> it is faster than varchar 
-- varchar => variable length charecter 

create table info(name varchar(50), gender char(10));
insert into info values('paridhi','female'),('raghav','male');

select * from info ;

insert into info values('raj        ','male        ') ;

select * , length(name),length(gender) from info; 
-- char will truncate all the wide spaces from the last 
-- where as varchar will have all the wide spaces upto the size of column



 
