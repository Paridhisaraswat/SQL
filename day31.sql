use sakila ;
select * from customer ;

-- get customers_name and status label 
-- active = 1 ----> active_customer 
-- active = 0 ----> in active_customer 
select first_name ,active ,
case 
	when active = 1 then 'active_customer'
    when active = 0 then 'Inactive_customer'
    end as status_label
from customer ;

-- table :film
-- categorize film by length 
-- < 60 --> short film 
--  60 - 120 --->medium film 
-- > 120 ---> long film 

select film_id , title , length ,
case 
	when length < 60 then 'short film'
    when length >= 60 and length <= 120 then 'medium film'
    when length > 120 then 'long film'
    end as film_type
from film ;


-- count films per rating and rate them 
select * from film ;
select rating , count(*) as total_films,
case 
	when count(*) < 200 then 'Low Count'
    when count(*) >= 200 and count(*) <= 400 then 'medium count'
    when count(*) > 400 then 'high count'
end as category from film
group by rating;


-- calculate total payment per customer and classify :
-- low spender 
-- medium and high 

select c.customer_id  , c.first_name , sum(p.amount) as total_amount, 
case 
	 when sum(p.amount) < 50 then 'Low spender'
     when sum(p.amount) >= 50 and sum(p.amount) <= 100 then 'medium spender'
     when sum(p.amount) > 100 then 'high spender'
end as spending_level 
from customer as c join 
payment as p 
on c.customer_id = p.customer_id 
group by c.customer_id ;

