-- SET operators ==> are used to combine the result of  2 or more query 
-- UNION 
select first_name from sakila.actor
union 
select actor_id from sakila.actor ;

select actor_id , first_name from sakila.actor where actor_id between 1 and 4 
union 
select actor_id , first_name  from sakila.actor where actor_id between 3 and 5 ;

select actor_id , first_name from sakila.actor where actor_id between 1 and 4 
union all 
select actor_id,first_name  from sakila.actor where actor_id between 3 and 5 ;

-- Recursive CTE 
with recursive cte as (
select 10 as num                  -- assinging values to this num column (starting point)
union all 
select num + 1 from cte           -- cte call 
where num < 15 )                   -- terminating condition(stop point)

select * from cte ;

-- we have to find out employee hierarchy 
create database cte ;
use cte ;
CREATE TABLE employees (
    employeeid INT PRIMARY KEY,
    name VARCHAR(50),
    managerid INT
);


INSERT INTO employees (employeeid, name, managerid) VALUES
(1, 'Alice', NULL),      -- CEO
(2, 'Bob', 1),           -- Reports to Alice
(3, 'Charlie', 2),       -- Reports to Bob
(4, 'Diana', 2),         -- Reports to Bob
(5, 'Eve', 3);   

select * from employees ;

 with recursive xyz as (
select employeeid , name , name as hierarchy_path from employees where managerid is NULL
union all 
select employees.employeeid , employees.name , concat(employees.name, '->' ,xyz.hierarchy_path) from employees join xyz 
where employees.managerid = xyz.employeeid and employees.employeeid < 5
)

select * from xyz ;


with recursive xyz as (
select employeeid , name , name as hierarchy_path from employees where managerid is NULL
union all 
select employees.employeeid , employees.name , concat(xyz.hierarchy_path , '->' ,employees.name) from employees join xyz 
where employees.managerid = xyz.employeeid and employees.employeeid < 5
)

select * from xyz ;


with recursive xyz as (
select employeeid , name , 1 as levels from employees where managerid is null
union all 
select employees.employeeid , employees.name ,levels+1  from employees join xyz 
where employees.managerid = xyz.employeeid and employees.employeeid < 5
)

select * from xyz ;
