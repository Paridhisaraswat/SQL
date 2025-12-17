use world ;

-- NUMERIC FUNCTION 

-- Round() 
select lifeexpectancy , round(lifeexpectancy) from country ;

select 30.68 , round(30.62 , 1);
select 30.68 , round(30.68, 2);
select 456.68 , round(456.68 , 1);
select 456.68 , round(457.68,-1);
select 456.68 , round(457.68,-2);
select round(463.0052,-2);
select round(3653.68,-3);

-- trurncate() :It is used to extract values.
select truncate(3653.678,1);

-- mod() : It gives us the remainder of the value
select mod(10,3) ;

 -- pow() - It is used to obtain power of a number

select pow(2,4);
 
 -- ceil and floor 
select  ceil(4.0000000001), floor(4.9999999);


-- DATE FUNCTION 
-- (now() ==> current date and time )
select now() ;
select current_timestamp();            -- same as ==> now()
select current_date();
select current_time();

-- add date function ==> by default date add(month , year , time )
-- -- 2. Adddate() - We can add or subtract date,month,year.
select now(), adddate(now() , 2);
select now(), adddate(now() ,-2);

select now() ,adddate(now(),interval 2 week);
select now() , adddate(now() , interval 2 hour );

select now(), adddate(now() , 2), adddate(now() , interval 2 month);

select now() , adddate(now() , interval 2 year);
select now() , adddate(now() , interval-2 year);

select * from sakila.payment;
select payment_date , adddate(payment_date , 2) from sakila.payment;


-- year ==> extract year 
select now() , year(now());

-- extract ==> (year / month / hour /minute/week)
select now() , extract(hour from now());
select now() , extract(year from now());
select now() , extract(week from now());
select now() , extract(month from now());
select now() , extract(minute from now());
select now() , extract(quarter from now());


-- date_format => extract with a string message (message)

-- %m = month in num 
-- %M = month name 
-- %h  = hour 
-- %Y = year 

select now() , extract(year from now()) , date_format(now() , 'Year is %Y');
select now() , extract(year from now()) , date_format(now() , 'Year is %y');
select now() , extract(month from now()) , date_format(now() , '%m');
select now() , extract(month  from now()) , date_format(now() , ' %M');
select now() , extract(hour from now()) , date_format(now() , '%h');
