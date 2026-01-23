-- Add a row number for employees sorted by salary (highest first)
select * , row_number()over(order by salary desc) from employees limit 1 ;

-- Rank employees by salary (ties share rank)
select * , rank() over(order by salary) from employees;

-- Dense rank employees by salary (no gaps in rank numbers)
select * , dense_rank() over(order by salary) from employees ;

-- Row number within each department by salary desc
select * ,row_number() over(partition by department order by salary desc) from employees ;

-- Rank within each department by salary desc
select * ,rank() over(partition by department order by salary desc) from employees ;

-- LEAD FUNCTION 
select * ,lead(salary) over() from employees;

-- next to next 
 select * ,lead(salary,2) over() from employees;
 
 -- LAG FUNCTION 
 select * ,lag(salary) over() from employees ;
 -- previous 
 select * ,lag(salary,1) over() from employees ;
 
 select * , lag(salary ,1) over (partition by department) from employees ; 
 
 select * , lag(salary ,1) over(partition by department  order by hire_date),
 salary - lag(salary,1) over(partition by department order by hire_date) from employees ;
 
-- Show previous and next salary in overall salary order (LAG/LEAD)
 select * ,lag(salary)over() , lead(salary) over() from employees;

-- Running total of sales amounts by date (overall)
select * ,sum(amount) over(order by sale_date) from sales;

-- Running total of sales per employee by date
select * from sales ;
select * , sum(amount) over(partition by emp_id order by sale_date) from sales;

-- Total sales per row (same total repeated using window SUM)
select *,sum(amount) over() from sales;

-- Average salary per department shown on every employee row
select * , avg(salary) over(partition by department) from employees;

-- Top 2 salaries in each department (use ROW_NUMBER)
select * from (
select * ,row_number() over(partition by department order by salary desc) as row_value from employees) as temp_data 
where row_value <= 2;

-- Salary difference vs department average
select *,avg(salary) over(partition by department),
salary - avg(salary) over(partition by department) from employees;

-- Percent rank of employees by salary (overall)
select * ,sum(salary)over(),
rank() over(order by salary),
percent_rank() over(order by salary) from employees ;

-- Month-wise running total of sales (per month)
select * from sales;
select*, sum(amount) over(order by month(sale_date)) from sales;


-- NTILE is a window function in SQL that divides rows into a specified number of equal groups (called buckets)
-- NTILE(n) splits the result set into n approximately equal parts.
-- Each bucket gets nearly equal number of rows
-- If rows are not perfectly divisible, earlier buckets get extra rows

-- Salary distribution into 4 buckets (NTILE)
select * from employees;
select * , ntile(4) over(order by salary) from employees ;

-- Find each employee’s first and last sale date (MIN/MAXwindow)
select *,min(sale_date) over(partition by emp_id) , max(sale_date) over(partition by emp_id)  from sales;

-- Month-wise running total of sales (per month)
select * ,sum(amount) over(order by month(sale_date)) from sales;

-- ROWS BETWEEN 

-- Moving 3-row average of sales amount (overall)
SELECT sale_id, sale_date, amount, AVG(amount) OVER ( ORDER BY sale_date, sale_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS moving_avg_3 FROM sales;

-- For each sale, calculate the average of the current sale and the next 2 sales (based on sale_date and sale_id).
select sale_id,sale_date,amount , avg(amount) over(order by sale_date,sale_id ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) from sales;

-- For each employee, calculate the sum of the current sale amount and the previous 1 sale of the same employee (based on sale_date).
select * , sum(amount) over(partition by emp_id order by sale_date rows between 1 preceding and current row) from sales ; 

-- Compare current sale to previous sale amount per employee(LAG) 
select * , lag(amount) over(partition by emp_id order by sale_date) from sales ;

-- Identify each employee’s highest sale amount (window MAX) and flag it.
SELECT * ,
MAX(amount) OVER (PARTITION BY emp_id) AS emp_max_amount,CASE
WHEN amount = MAX(amount) OVER (PARTITION BY emp_id) THEN 'MAX_SALE'
ELSE 'NORMAL' END 
FROM sales
ORDER BY emp_id, sale_date;

-- rank employees on the basis of total_sales 
SELECT emp_id, total_sales,
RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT DISTINCT emp_id,
           SUM(amount) OVER (PARTITION BY emp_id) AS total_sales
    FROM sales
) t
ORDER BY sales_rank, emp_id;

-- Rank employees based on salary inside their department (highest salary = rank 1)
select * from employees ;
select * ,
rank() over(partition by department order by salary desc) as salary_rank
from employees ;

-- Find Top 2 Employees by Total Sales
select * ,dense_rank() over(order by total_sales desc) as sales_rank
from (select distinct emp_id ,sum(amount) over(partition by emp_id) as total_sales from sales ) t
order by total_sales desc limit 2 ;

-- Compare Each Employee’s Sale With Their Previous Sale
select * , lag(amount) over(partition by emp_id order by sale_date) from sales;

-- For each employee, calculate moving average of:current sale,previous 2 sales
select *, avg(amount) over(partition by emp_id order by sale_date rows between 2 preceding and current row) from sales;

-- Running Total of Sales Per Employee 
select * , sum(amount) over(partition by emp_id order by sale_date) from sales ;

-- Find Employees Whose Current Sale Is Greater Than Their Previous Sale
select * from
(select emp_id , sale_date ,amount , lag(amount) over(partition by emp_id order by sale_date ) as previous_amount  from sales) s 
where amount > previous_amount ;

-- Rank Cities by Average Employee Salary
SELECT city,
       AVG(salary) AS avg_salary,
       RANK() OVER (ORDER BY AVG(salary) DESC) AS city_rank
FROM employees
GROUP BY city;

-- Find Highest Sale Per Employee (Without GROUP BY)
select *, max(amount) over(partition by emp_id) from sales;