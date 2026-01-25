use REGEX;
CREATE TABLE events (
  event_id   INT PRIMARY KEY,
  event_name VARCHAR(100) NOT NULL,
  city       VARCHAR(50)  NOT NULL
);

CREATE TABLE ticket_sales (
  sale_id          INT PRIMARY KEY,
  event_id         INT NOT NULL,
  sale_date        DATE NOT NULL,
  ticket_type      VARCHAR(20) NOT NULL,
  qty              INT NOT NULL,
  price_per_ticket INT NOT NULL,
  CONSTRAINT fk_ticket_sales_event
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

INSERT INTO events (event_id, event_name, city) VALUES
(1, 'Music Fest', 'Mumbai'),
(2, 'Tech Summit', 'Bengaluru'),
(3, 'Food Carnival', 'Delhi'),
(4, 'Startup Meetup', 'Mumbai');

INSERT INTO ticket_sales (sale_id, event_id, sale_date, ticket_type, qty, price_per_ticket) VALUES
(101, 1, '2025-01-05', 'Regular', 2, 1500),
(102, 1, '2025-01-10', 'VIP',     1, 5000),
(103, 2, '2025-02-03', 'Regular', 3, 2000),
(104, 2, '2025-02-10', 'VIP',     1, 6000),
(105, 3, '2025-03-01', 'Regular', 5,  800),
(106, 3, '2025-03-15', 'VIP',     2, 2500),
(107, 4, '2025-01-20', 'Regular', 4, 1200),
(108, 4, '2025-02-05', 'Regular', 1, 1200);

select * from events;

select * from ticket_sales;

-- get the the total quantity sold per event_id 
select event_id , sum(qty) from ticket_sales group by event_id;

-- get the total revenue per event_id 
select  event_id,sum(price_per_ticket) from ticket_sales group by event_id;

-- get the monthly total revenue group by month of sale date 
select  month(sale_date),sum(qty * price_per_ticket)  from ticket_sales group by month(sale_date);

-- Find the maximum price_per_ticket per event_id.
select event_id ,max(price_per_ticket) from ticket_sales group by event_id ; 

-- Find total revenue per month and ticket_type.
select month(sale_date) ,ticket_type,sum(qty * price_per_ticket) from ticket_sales group by month(sale_date) , ticket_type;

-- List all sales with event_name and sale_date
select t.sale_id , e.event_name , t.sale_date from ticket_sales as t 
join events as e 
on t.event_id = e.event_id ;

-- Show event_name, ticket_type, qty for each sale.
select e.event_name , t.ticket_type , t.qty from ticket_sales as t 
join events as e 
on t.event_id = e.event_id ;

-- Show sales where the event city is Mumbai
select * from events ;
select t.sale_id ,e.event_name, e.city ,t.sale_date from ticket_sales as t 
join events as e 
on t.event_id = e.event_id and e.city = 'Mumbai';

select e.event_name , t.sale_id , t.sale_date from ticket_sales as t 
join events as e 
on t.event_id = e.event_id ;

-- Show distinct event names that have at least one sale.
 select distinct(e.event_name) from events as e 
 join ticket_sales as t 
 on t.event_id = e.event_id and qty >= 1;
 
 
 -- Show each sale’s computed revenue with event name.
 select t.sale_id , e.event_name , (t.qty * t.price_per_ticket) as revenue from ticket_sales as t
 join events as e 
 on t.event_id = e.event_id ;

-- Find total quantity per event_name.
 select e.event_name , sum(t.qty) from ticket_sales as t 
 join events as e 
 on t.event_id = e.event_id group by e.event_name ;
 
 -- Find total VIP revenue per event_name.
 select e.event_name , (t.qty * t.price_per_ticket) as vip_revenue from ticket_sales as t
 join events as e 
 on t.event_id = e.event_id and t.ticket_type = 'VIP' ;
  
-- Find monthly revenue per city.
select e.city , month(t.sale_date) as sale_month, sum(t.qty * t.price_per_ticket) as total_revenue from ticket_sales as t 
join events as e 
on t.event_id = e.event_id group by e.city ,month(t.sale_date); 

-- Find total quantity per city and ticket_type.
select e.city , t.ticket_type , sum(t.qty) as total_quantity from ticket_sales as t 
join events as e 
on t.event_id = e.event_id group by e.city , t.ticket_type ;

-- Find sales that happened on the latest sale_date in the table.
select * from ticket_sales order by sale_date desc limit 1;

-- Find sales where revenue is greater than the overall average sale revenue.

select sale_id , event_id ,(qty * price_per_ticket) as revenue from ticket_sales
where(qty * price_per_ticket) > (select avg(qty * price_per_ticket) from ticket_sales);

-- Find events that have at least one VIP sale.
select e.event_id , e.event_name from events as e 
join ticket_sales as t 
on e.event_id = t.event_id and t.ticket_type = "VIP";

-- Find events in cities that have at least one VIP sale
select e.event_id , e.event_name ,e.city  from events as e 
join ticket_sales as t 
on e.event_id = t.event_id  and t.ticket_type = "VIP";

-- Find events that have at least one sale in February 2025.
select e.event_id ,(e.event_name),e.city from events as e 
join ticket_sales as t 
on e.event_id = t.event_id and year(t.sale_date) = 2025 and month(sale_date) = 2;

select * from ticket_sales;

-- For each event, return the highest price_per_ticket sale row.
select * from ticket_sales as ts where 
ts.price_per_ticket = 
(select max(price_per_ticket) from ticket_sales as t where ts.event_id = t.event_id);

-- Show monthly total revenue and monthly total quantity, but only include months
-- where total revenue is at least 10,000.
select month(sale_date),sum(qty),sum(qty * price_per_ticket) from ticket_sales 
group by month(sale_date) having sum(qty * price_per_ticket) > 10000;

-- Show month-wise count of sales rows, but only include months that have at least 3 sales rows.
select year(sale_date) ,month(sale_date) , count(sale_id)  from ticket_sales group by year(sale_date), month(sale_date) having count(sale_id) >= 3;

-- Show average revenue per sale row per month, but only include months where
-- average sale revenue is above 4000. 
select month(sale_date),avg(qty * price_per_ticket) from ticket_sales 
group by month(sale_date) having avg(qty * price_per_ticket) > 4000;

-- Show revenue per month and ticket_type, but only include groups where total
-- revenue is at least 5000. 
select month(sale_date), ticket_type, sum(qty * price_per_ticket)from ticket_sales 
group by month(sale_date),ticket_type  having sum(qty * price_per_ticket) >= 5000