-- PRIMAKRY KEY 
-- FOREIGN KEY 
-- JOINS 
use world ;

select * from city ;
describe city ;
-- city( id ==> primary Key) 
-- countrycode ===> foreign key here  


select * from country ;
-- code is primary key 
select count(code) , count(distinct(code)) from country ;

-- there will be only one primary key in a table and contain only unique values 
-- foreign key can contain null and duplicate values 


-- JOIN : it is used to connect two tables 
select c.id , c.name , c.countrycode from city as c ;

select cnt.code , cnt.name , cnt.continent from country as cnt ;
-- join ==> city(country code) will match with country(code) 

select c.id , c.name , c.countrycode, cnt.name , cnt.continent  from city as c 
join 
country as cnt 
where c.countrycode = cnt.code ;


-- find the city name , population , country name ,along with the govt form for each city 
select c.name , c.population , cnt.name , cnt.GovernmentForm from city as c 
join 
country as cnt 
where c.countrycode = cnt.code;

select * from countrylanguage ;
select * from country ;

-- get the country name ,population ,language spoken with the percentage of each language 
 select ctry.name , ctry.population , lang.language , lang.percentage from country as ctry 
 join 
 countrylanguage as lang 
 where ctry.code = lang.countrycode ;

use sakila;
select * from actor ;
select * from film_actor ;
select count(actor_id) , count(distinct(actor_id)) from actor ;

select a.first_name , a.actor_id from actor as a 
join 
film_actor as fa 
where a.actor_id = fa.actor_id;

select * from film ;
select * from film_actor ;

-- COMPOSITE KEY ::
-- when two or more columns are combined together to form a primary key 
-- then it is known as COMPOSITE KEY 
 
 select count(film_id) , count(distinct(film_id)) from film ;
 
 select fa.actor_id , fa.film_id , f.film_id , f.title from film_actor as fa 
 join 
 film as f 
 where fa.film_id = f.film_id ;
 
-- JOIN ON THREE TABLES  
select * from actor ;
select * from film_actor ;
select * from film;


-- here join on three table 
-- actor :: actor_id(pri) join film_actor(actor_id)(For) - film_actor(film_id)(for) join  film(film_id)(pri)

select a.actor_id , a.first_name , fa.film_id , f.film_id , f.title from actor as a 
join 
film_actor as fa 
join
film as f 
where a.actor_id  = fa.actor_id and f.film_id = fa.film_id ; 

 















