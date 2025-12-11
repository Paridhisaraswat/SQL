use world ;

show tables ;

select * from country ;

select * from country where continent = 'asia';

select * from country where indepyear = 1991;

select name , continent from country where indepyear = 1991 ;

select * from country where continent = 'africa' ;

-- IN Operator 

select * from country where continent in ('Africa','Asia');

select * from country where indepyear in (1960, 1991);

-- BETWEEN OPERATOR 

select * from country where indepyear between 1960 and 1991 ;

-- NOT OPERATOR

select * from country where indepyear not between 1960 and 1991 ;

select * from country where continent not in ('africa','asia');

-- 1 get the country name and continent where the region is not south europe 
-- 2 get the country name , continent , population along with 10 % increment in the population 
-- 3 get all the column where the life expectancy is either 75.1 or 77.8 or 63.7 
-- 4 get the country name , population , region where the population should not be from 5k to 3L

-- 1
select name , continent from country where region != ('south europe');

-- 2
select name , continent ,population+(population *10 /100) from country  ;

-- 3
select * from country where lifeexpectancy in (75.1,77.8,63.7);

-- 4
select name , continent , region from country where population not between 5000 and 300000;

-- LIKE OPERATOR 
-- match a pattern 
-- name => letter start , letter include , letter end 
-- % : special character / wildcard caharacter 
-- % : zero or more caharacter 

select * from country where name like 'An%';
select * from country where name like '%A';
select * from country where name like '%r%';
select * from country where name like '%ru%' ;

select * from country where name not like '%ru%';

-- _(underscore) : only one character 
select * from country where name like 'Ir__'; 

select * from country where name like '____' ;

select * from country where name like '_u__';

select * from country where name like '_u%';

select * from country where name like '_u_%';

select * from country where name like '_ua%';

select * from country where name like '_u%a%';

-- 1 get country name and continent where the continent start with letter N 
-- 2 get name and continent where 2nd last letter is P 
-- 3 get the country and continent where the continent have min 4 character 
-- 4 get name and continent where the 2nd letter is a and 2nd last letter is a from region 
-- 5 get name and continent where in region where the 3rd cahr is c and last 3 char is sia 
-- 6 get the name and region where the continent is america or south america

-- 1 
select name , continent from country where continent like 'N%';

-- 2 
select name , continent from country where continent like '%p_';

-- 3 
select name , continent from country where continent like '____%';

-- 4
 select name , continent from country where region like '_a%a_';
 
 -- 5 
 select name , continent from country where region like '__c%sia';
 
 -- 6 
 select name , region from country where continent in('North America','South America');
