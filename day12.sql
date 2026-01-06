-- sub query 
-- is a query within another query 
-- also known as nested query , inner query 
-- sub query are used to access data based on the conditions 
-- it is used to filter data as a condition for outer query 
-- it is used to filter or apply calculation on data based on dynamic conditions 

-- SINGLE ROW SUB QUERY ==> when a sub query returns only one row then it is called sub query  

-- get the payment id and amount where the amt is not equal to the amt of the payment id 23 
use sakila ;
select payment_id , amount from payment where amount != (select amount from payment where payment_id = 23 ) ; 

-- get the payment_id,customer_id , amt , payment_date where the month of payment hould be same as of payment_id 6 
select payment_id , customer_id , amount , payment_date from payment
where month(payment_date)=(select month(payment_date) from payment where payment_id = 6);

-- get all the column from the payment table where the staff serving the customers
-- should be same as of payment_id 7 

select * from payment where staff_id = (select staff_id from payment where payment_id = 7 );

-- get all the payment info where the amt is same as of the highest amt from the payment table 
select * from payment ;
select payment_id , amount , payment_date from payment where amount = (select amount from payment order by amount desc limit 1);

-- get the amt , the total num of payment done for each amount 
-- only for those payment whose amt is less then the amount of rental_id = 1725 
select amount , count(amount) from payment 
where amount < (select amount from payment where rental_id = 1725) 
group by amount ;

-- get the month and the total amt spent only for those customers 
-- whose month of payment > customer_id 1 and payment_id 3 

select month(payment_date) , sum(amount) from payment 
where month(payment_date) > (select month(payment_date) from payment where customer_id = 1 and payment_id = 3)
group by month(payment_date);


select * from payment where amount = (select amount from payment where payment_id = 3);

-- MULTI ROW SUB QUERY :
-- while using multi row sub query we can not use any comparision operators directly 

-- we use :

-- IN OPERATOR 
 select * from payment where amount in
(select amount from payment where payment_id = 3 or payment_id = 2);

-- NOT IN OPERATOR 
select * from payment where amount not in
(select amount from payment where payment_id = 3 or payment_id = 2);

-- ANY 
-- checks from any one 
-- =any is same as in 
-- we can use comparision operators with any 
 select * from payment where amount =any 
(select amount from payment where payment_id = 3 or payment_id = 2);

select * from payment where amount >any 
(select amount from payment where payment_id = 3 or payment_id = 2);

select * from payment where amount <any 
(select amount from payment where payment_id = 3 or payment_id = 2);

-- ALL OPERATOR
-- checks from all  
select * from payment where amount >all
(select amount from payment where payment_id = 3 or payment_id = 2);

select * from payment where amount <all
(select amount from payment where payment_id = 3 or payment_id = 2);

select * from payment where amount <=all
(select amount from payment where payment_id = 3 or payment_id = 2);

-- get all the payment info where the moth of payment should be same as of payment_id = 2 or 3 
select * from payment where month(payment_date) in
(select month(payment_date) from payment where payment_id = 2 or payment_id = 3) ;

-- get all the payment info whose amount is larger then among all the amount of payment_id 2 to 8 
select * from payment where amount >all
(select amount from payment where payment_id in (2,3 , 4, 5, 6 ,7 ,8));
