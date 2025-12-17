-- DISTINCT  ==> return unique values only 
use world ;
select distinct continent from country ;

select distinct continent , region from country ;

-- AGGREGATE FUNCTION 
-- multi line function => will give you some result 
-- apply some calculation over set of rows 

-- 1. count(column) :: count the num of rows w/o NULL values    
select count(indepyear) from country ;
select count(population) from country ;
select count(distinct continent) from country;

-- 2. count(*) :: count num of rows with NULL values 
select count(*) from country ;

-- 3. sum() :
select sum(population) from country ;

-- 4. avg () :
select max(population) from country ;

-- 5. max():
select max(population) from country ;

-- 6. min():
select min(population) from country ;


-- get the country name from asia which are independent 
select name , indepyear from country where continent = 'Asia';

-- get the total country name, total region , avg lifeexpectancy and the total population for the country
-- who have got their independency after 1947 and before 1998 

select count(name), count(region), avg(lifeexpectancy) , sum(population) from country where indepyear > 1947 and indepyear < 1998;
 
 -- get the total num of country , the unique region along with the total population and max lifeexpextancy rate with the total capital
 -- for the country starting with letter a and d 
 
 select count(name) , count(distinct region) , sum(population) , max(lifeexpectancy) , sum(capital) from country 
 where name like 'A%' or name like 'D%';

-- GROUP BY :: to collect similar values in a group 

select continent from country group by continent; 
select region from country group by region ; 
 
 select continent , count(name) from country group by continent;
 
 -- get the total country and total population for each indepyear 
 select indepyear , count(name) , sum(population) from country group by indepyear ;

select sum(population) from country ;

select continent , count(name) from country group by continent ;

select continent , count(name) from country where indepyear >1950 
group by continent ;


-- HAVING Clause ::filter the data on the column which is calculated 
-- filter data when using aggregate function 
-- used after group by clause  

-- get those continent where total num of country is greater then 30 
select continent , count(name) from country 
group by continent having count(name) > 30 ; 
 
-- find out total population in each continent 
select continent , sum(population) from country 
group by continent ;

-- find out total population in each continent where the total population is greater then 100 
select continent , sum(population) from country group by continent having sum(population) > 100 ;
 
 -- find out how many country are independent in each year 
 select indepyear , count(name) from country group by indepyear ;
 
 -- find out how many country are independent in each year after 1930 
 select indepyear , count(name) from country where indepyear > 1930 group by indepyear ;
 
 -- find out how many country are independent in each year after 1930 and num of country should be greater then 2 
  select indepyear , count(name) from country where indepyear > 1930 group by indepyear having count(name) > 2 ;
  
  -- 1.  you need to get govt form and the total num of country for each govt form
  -- where the total num of country is greater then 20 
  
  -- 2. where the country should have capital > 30 
  -- 3. get the total number of  country and the total region, the total population 
  -- where life expectancy > 38 and population in each continent is greater then > 3L  
  
  select * from country ;
  -- 1. 
  select GovernmentForm , count(name) from country group by GovernmentForm having count(name) > 20 ;
 
 -- 2.   
 select GovernmentForm , count(name) from country where capital > 30  group by GovernmentForm;
 
 -- 3. 
 select continent , count(name) , count(region) , sum(population) from country 
 where lifeexpectancy > 38 group by continent having sum(population) > 30 ; 
 
 
 use sakila ;

show tables ;

select * from payment;
select count(*) from payment where amount = 2.99;

select amount , count(*) from payment group by amount ;

select customer_id , sum(amount) from payment group by customer_id ;
select customer_id , sum(amount) from payment where amount > 3 group by customer_id ;

-- total transaction of each customer in month of may 
select customer_id , count(amount) from payment 
where month (payment_date) = 5 group by customer_id ;

-- find out the max amount of transaction , avg transaction amt and total transaction amt done through each staff 
select staff_id , max(amount) , avg(amount) , sum(amount) from payment group by staff_id ;

-- find max , avg , total amount done through each staff where customer_id is even 
select staff_id , max(amount) , avg(amount) , sum(amount) from payment where mod(customer_id,2) = 0 group by staff_id ; 

-- get the amount and the total transaction done for each amt only for the payment done through the staff_id = 1 aqnd the total num of transaction should be > 30 
select amount , count(amount) from payment where staff_id = 1  group by amount having count(amount) > 30  ;

-- 1. find out the num of customer , avg amt and the total amt spent in each month for staff_id 1 or 2  
-- 2. find out the num of customer , avg amt and the total amt spent in each month of each year  for staff_id 1 or 2 

-- 1.
select month(payment_date) ,count(customer_id) , avg(amount) , sum(amount) from payment
 where staff_id = 1 or staff_id = 2 group by month(payment_date);

-- 2.
 select year(payment_date) , month(payment_date) ,count(customer_id) , avg(amount) , sum(amount) from payment 
 where staff_id = 1 or staff_id = 2 group by  year(payment_date),month(payment_date) ;
 
 
 