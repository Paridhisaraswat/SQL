 
 -- ORDER BY :: used to sort data in ascending or deascending order 
 use sakila ;
 select * from payment order by amount ;
 select * from payment order by customer_id ;
 
 select * from payment order by customer_id , amount ;
 
 select * from payment order  by customer_id desc , amount ;
 
use world ;
-- Display all countries sorted by Name in ascending order
select name from country order by name ;

-- List all countries in Asia, ordered by Population (highest first)
select name , population from country where continent = 'Asia' order by population desc ;

-- Display all countries where SurfaceArea > 500000, ordered by SurfaceArea
select name , SurfaceArea from country where SurfaceArea > 500000 order by SurfaceArea;

-- List all countries ordered by:Continent (ASC), Population (DESC)
select name , continent , population from country order by continent , population desc ;

-- Display average life expectancy per continent
-- Consider only continents with average life expectancy > 70
-- Order the result by average life expectancy
select avg(lifeexpectancy) from country group by continent
 having avg(lifeexpectancy) > 70 order by avg(lifeexpectancy); 
 
-- Count the number of countries in each region
-- Include only regions having more than 5 countries
-- Sort by country count (DESC)
select count(name) ,region from country group by region
having count(name) > 5 order by count(name) desc ;

-- get continent , total population , avg population of each continent where lifeexpectancy > 60 
-- total population > 500 million sort by total population desc 

select continent , sum(population) , avg(population) from country where lifeexpectancy > 60 
group by continent having sum(population) > 500000000 order by sum(population) desc ;

-- For each continent, find the population density:
-- Exclude countries with SurfaceArea = 0
-- Show only continents where population density > 50
-- Order by population density (DESC)
select continent , (sum(population)/sum(surfacearea)) as PopulationDensity from country 
where surfacearea != 0 group by continent having sum(population)/sum(surfacearea) > 50 
order by PopulationDensity desc ;


-- get the region where diff b/w max and min population > 100 Million 
-- sort by differnece 
select region , (max(population) - min(population)) as Difference from country 
group by region having max(population) - min(population) > 100000000 
order by max(population) - min(population) desc ;

-- for each continent get num of countries , avg(lifeexpectancy) where population > 1000000 and 
-- num of countries > 5 sort by avg(lifeexpectancy) desc 
select continent , count(name) , avg(lifeexpectancy) from country 
where population > 1000000 group by continent having count(name) > 5 
order by avg(lifeexpectancy) desc ; 

-- get region , count num of countries , avg(life) , total population where 
-- Country name length BETWEEN 5 AND 12
-- LifeExpectancy IS NOT NULL
-- Population BETWEEN 1 million AND 200 million
-- Display only regions having total population > 300 million
-- Sort by total population (DESC)

select region , count(name) , avg(lifeexpectancy) , sum(population) from country 
where char_length(name) between 5 and 12 and  lifeexpectancy is not  Null 
and  population between 1000000 and 200000000 group by region 
having sum(population) > 300000000 order by sum(population) desc ; 

-- for each continent get total num of countries , longest country name length , 
-- where country name should end with A
-- continent != Antarctica 
-- get continent max_name_length > 10 
-- Sort by longest name length (DESC)

select continent , count(name) , max(char_length(name)) as max_name_length  from country 
where name like '%a' and 
continent != 'Antarctica'  
group by continent 
having max(char_length(name)) > 10 
order by max_name_length desc ;

-- Find regions where:
-- Average population per country > 10 million
-- Total surface area > 1,000,000
-- Conditions:
-- Country name length > 6 characters
-- Population > 500,000
-- Sort by average population (DESC)
select region , avg(population) as avg_population  , sum(Surfacearea) from country where 
char_length(name) > 6 and 
population > 500000
group by region
having avg(population) > 10000000  and sum(SurfaceArea) > 1000000
order by avg_population desc ;


-- For each continent, calculate: Population density
-- Conditions:
-- SurfaceArea ≠ 0
-- Continent IN ('Asia', 'Europe', 'Africa')
-- Show only continents where density is BETWEEN 50 AND 300
-- Sort by density (DESC)
select continent , (sum(population)/sum(SurfaceArea)) as Population_density from country 
where SurfaceArea != 0 and 
continent in ('Asia', 'Europe', 'Africa')
group by continent
having (sum(population)/sum(SurfaceArea)) between 50 and 300 
order by Population_density ;  

-- For each continent, find:
-- Difference between maximum and minimum life expectancy
-- Conditions:
-- LifeExpectancy BETWEEN 50 AND 85
-- Exclude continents NOT IN ('Asia', 'Europe', 'Africa', 'Americas')
-- Show only continents where difference > 15
-- Sort by difference (DESC)
select continent , (max(lifeexpectancy) - min(lifeexpectancy)) as Difference from country where
lifeexpectancy between 50 and 85 and 
continent in ('Asia', 'Europe', 'Africa', 'Americas')
group by continent 
having max(lifeexpectancy) - min(lifeexpectancy) > 15 
order by (max(lifeexpectancy) - min(lifeexpectancy)) desc ;

-- For each continent: Number of countries, Average life expectancy
-- Conditions:
-- Continent must be in ('Asia', 'Europe', 'Africa')
-- Population must be BETWEEN 1 million AND 100 million
-- Show only continents having more than 5 countries
-- Sort by average life expectancy (DESC)
select continent , count(name) ,avg(lifeexpectancy) from country where 
continent in  ('Asia', 'Europe', 'Africa') and 
population between 1000000 and 100000000
group by continent 
having count(name) > 5 
order by avg(lifeexpectancy) desc ;

-- Find regions where:
-- Average population is greater than 20 million
-- Minimum population is greater than 1 million
-- Conditions:
-- Consider only countries with LifeExpectancy BETWEEN 60 AND 80
-- Sort by average population (DESC)
select continent , region  ,  avg(population) , min(population) from country where 
lifeexpectancy between 60 and 80 
group by region 
having avg(population) > 20000000 and min(population) >1000000 
order by avg(population) desc ; 


-- For each continent, calculate:
-- Total population
-- Maximum surface area
-- Conditions:
-- Country name starts with a vowel
-- Population NOT IN (0, 1000, 5000)
-- Show continents where total population > 300 million
-- Sort by total population (DESC)
select continent , sum(population) , max(surfaceArea) from country where 
name like 'A%' or name like 'E%' or name like 'I%'or name like 'O%'or name like 'U%' and 
population not in(0,1000,5000) 
group by continent 
having sum(population) > 300000000 
order by sum(population) desc;


-- List regions and:
-- Count of countries
-- Average GNP
-- Conditions:
-- Region name contains the word 'Asia'
-- GNP IS NOT NULL
-- Display only regions having at least 3 countries
-- Sort by average GNP (DESC)
select region , count(name) , avg(GNP) from country where 
GNP is not NULL and 
region like '%Asia%'
group by region 
having count(name) >= 3 
order by avg(GNP) desc ;