-- WINDOWS FUNCTION 
-- apply aggregate function to each row or window (set of rows)
-- is used to perform the calculation on the set of rows with refrence to current row 
-- there are majorly three parts 
-- (1) OVER :
-- USE :apply the function over a window 

use world ;
select code , name , population from country ;

select sum(population) from country ;

select code , name ,continent, population,(select sum(population) from country)  from country;

-- basic syntax 
select code , name , continent , population ,
sum(population)over(),avg(population)over() from country ;

-- (2) PARTITION BY :
-- Same as group by which is used to divide your data in groups
-- used to apply logic to the groups 

select continent , sum(population) from country group by continent ;

select code , name , continent , population , 
sum(population) over(partition by continent) from country ; 


-- running sum, cummulative sum 
-- (3)ORDER BY :
-- use order by 

select code , name , continent , population , 
sum(population) over(order by population) from country ; 

