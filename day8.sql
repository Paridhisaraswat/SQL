-- TYPES OF JOIN :
-- INNER JOIN 
-- OUTER JOIN 
-- NATURAL JOIN 
-- CROSS JOIN 

CREATE DATABASE REGEX;
USE REGEX;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);



INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Los Angeles'),
(3, 'Charlie', 'Chicago'),
(4, 'David', 'Houston'),
(5, 'Eva', 'Phoenix'),
(6, 'Frank', 'Philadelphia'),
(7, 'Grace', 'San Antonio'),
(8, 'Henry', 'San Diego'),
(9, 'Ivy', 'Dallas'),
(10, 'Jack', 'San Jose');


INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(101, 1, '2024-01-05', 250.00),
(102, 2, '2024-01-06', 150.00),
(103, 3, '2024-01-07', 300.00),
(104, 1, '2024-01-10', 120.00),
(105, 5, '2024-01-12', 450.00),
(106, 6, '2024-01-15', 200.00),
(107, 2, '2024-01-18', 175.00),
(108, 8, '2024-01-20', 500.00),
(109, 11, '2024-01-22', 90.00),
(110, 12, '2024-01-25', 60.00);

select * from customers ;
select * from orders ;

select c.customer_id, c.customer_name, o.order_id,o.customer_id,o.amount  from customers as c 
inner join 
orders as o 
where c.customer_id = o.customer_id ;  

-- ON KEYWORD :: used with  joins for conditions 
select c.customer_id, c.customer_name, o.order_id,o.customer_id,o.amount  from customers as c 
inner join 
orders as o 
on c.customer_id = o.customer_id ;


-- OUTER JOIN :: all the data 
-- (A). LEFT OUTER JOIN :: give all data of the left table and common from right table 
-- NON MATCHING rows return NULL values 
select c.customer_id, c.customer_name, o.order_id,o.customer_id,o.amount  from customers as c 
left join 
orders as o 
on c.customer_id = o.customer_id ;

-- (B). RIGHT OUTER JOIN :: give all data of the right  table and common from left table 
-- NON MATCHING rows return NULL values 
select c.customer_id, c.customer_name, o.order_id,o.customer_id,o.amount  from customers as c 
right join 
orders as o 
on c.customer_id = o.customer_id ;

-- NATURAL JOIN :: 
-- in this we do not define any condition 
-- here JOIN is done on the basis of COMMON COLUMNS 
-- column name should be same 

-- with a common column name 
select c.customer_id, c.customer_name, o.order_id,o.customer_id,o.amount  from customers as c 
natural join 
orders as o ;

-- without a common column name
-- This type of JOIN is also known as CROSS JOIN or CARTESIAN JOIN  
-- every row is connected with every rows of another table 
 alter table customers rename column customer_id to cid ;
 select c.cid, c.customer_name, o.order_id,o.customer_id,o.amount  from customers as c 
natural join 
orders as o ;

-- same 
select c.cid, c.customer_name, o.order_id,o.customer_id,o.amount  from customers as c 
cross join 
orders as o ;

 -- with common column name it work as a INNER join and without it works as a CROSS join 
 -- in SQL we don't use NATURAL join 
 -- because 
 
 
select c.customer_name, c.cid, sum(o.amount)  from customers as c 
join 
orders as o 
where c.cid = o.customer_id 
group by c.cid;

select c.customer_name, c.cid, sum(o.amount)  from customers as c 
join 
orders as o 
where c.cid = o.customer_id 
group by c.cid
having sum(o.amount) > 300;



use sakila;
select * from actor ;
select * from film_actor;

-- find the actor id , actor name , and the total num of movies 
select a.actor_id,a.first_name, count(fa.film_id) from actor as a
join 
film_actor as fa 
where a.actor_id = fa.actor_id 
group by a.actor_id;






