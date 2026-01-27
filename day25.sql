-- CTE: Common table expression 
-- it is a temporary name of the result of your SQL query 
 -- they are not stored on a permanent basis 
 -- it will help to break complex queries into smaller and readable format 
 
 
 select * from sakila.actor;
 
 with paridhi_cte as (select * from sakila.actor where actor_id between 5 and 90 )
 
 select * from paridhi_cte;
 
 select * from paridhi_cte ;    -- it will give error beacuse cte is validated until a ';'
 
 with cte as 
 (select *,month(payment_date) from sakila.payment)
 
 select * from cte ;
 
 with cte as 
 (select *,month(payment_date) from sakila.payment)
 
 select month(payment_date) ,count(*) from cte group by month(payment_date) ;


-- you need to find out all payment info where the amt is the second highest amt
with cte  as 
(select * ,dense_rank() over(order by amount desc) as rankings  from sakila.payment)

select * from cte where rankings = 2;


-- get every customers 2nd highest amount 
with cte as
(select *,dense_rank() over(partition by customer_id order by amount desc)
as rankings from sakila.payment )

select * from cte where rankings = 2; 


create database test90;
use test90;

CREATE TABLE employee (
    emp_id     INT PRIMARY KEY,
    emp_name   VARCHAR(50),
    department VARCHAR(30),
    salary     INT,
    manager_id INT
);

INSERT INTO employee (emp_id, emp_name, department, salary, manager_id) VALUES
(1, 'Alice',   'HR',      50000, NULL),
(2, 'Bob',     'HR',      45000, 1),
(3, 'Charlie', 'HR',      55000, 1),

(4, 'David',   'IT',      70000, NULL),
(5, 'Eva',     'IT',      65000, 4),
(6, 'Frank',   'IT',      72000, 4),
(7, 'Grace',   'IT',      68000, 4),

(8, 'Henry',   'Sales',   60000, NULL),
(9, 'Irene',   'Sales',   58000, 8),
(10,'Jack',    'Sales',   62000, 8);


select * from employee;

select department, avg(salary) from employee group by department;

-- correlated
select emp_id, emp_name,department,salary from employee as e
where salary>( select avg(salary) from employee where department=e.department);

-- cte
with cte as (
select department as dept, avg(salary) as deptsalary from employee group by department)

select  emp_id, emp_name,department,salary, dept, deptsalary
from employee as e join cte where e.department=cte.dept
and salary>deptsalary;
