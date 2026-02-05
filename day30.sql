create database corredb;
use corredb;

CREATE TABLE departments (
    dept_id     INT PRIMARY KEY,
    dept_name   VARCHAR(50)
);

CREATE TABLE employees (
    emp_id      INT PRIMARY KEY,
    emp_name    VARCHAR(50),
    dept_id     INT,
    salary      INT,
    job_title   VARCHAR(50),
    hire_date   DATE,
    CONSTRAINT fk_dept
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(10, 'HR'),
(20, 'IT'),
(30, 'Finance'),
(40, 'Sales'),
(50, 'Marketing');


INSERT INTO employees (emp_id, emp_name, dept_id, salary, job_title, hire_date) VALUES
(101, 'Alice',   10, 40000, 'HR Executive',      '2018-03-12'),
(102, 'Bob',     20, 60000, 'Software Eng',      '2019-07-19'),
(103, 'Charlie', 20, 75000, 'Senior Dev',        '2017-01-10'),
(104, 'David',   30, 50000, 'Accountant',        '2020-11-01'),
(105, 'Eva',     30, 90000, 'Finance Manager',   '2016-06-23'),
(106, 'Frank',   40, 45000, 'Sales Rep',         '2019-02-15'),
(107, 'Grace',   40, 70000, 'Sales Manager',     '2015-09-30'),
(108, 'Hannah',  50, 48000, 'Marketing Exec',    '2021-04-18'),
(109, 'Ian',     50, 65000, 'Marketing Lead',    '2018-12-07'),
(110, 'Jack',    20, 55000, 'QA Engineer',       '2020-08-25'),
(111, 'Karen',   10, 42000, 'HR Analyst',        '2019-05-14'),
(112, 'Leo',     30, 52000, 'Auditor',            '2021-09-09'),
(113, 'Mona',    40, 48000, 'Sales Exec',        '2022-01-03'),
(114, 'Nina',    20, 80000, 'Tech Lead',         '2016-10-11'),
(115, 'Oscar',   50, 47000, 'Content Writer',    '2020-06-17'),
(116, 'Paul',    10, 39000, 'Recruiter',         '2022-07-20'),
(117, 'Queen',   30, 61000, 'Financial Analyst', '2018-02-28'),
(118, 'Rick',    40, 53000, 'Sales Analyst',     '2019-09-05'),
(119, 'Steve',   20, 67000, 'DevOps Eng',        '2017-04-14'),
(120, 'Tina',    50, 72000, 'Brand Manager',     '2016-12-01');



-- get those employee whose salary is greater than the avg salary of all the employees 
select * from employees where salary >
(select avg(salary) from employees);

-- with cte 
with cte as (
select avg(salary) from employees)

select * from employees where salary >(select * from cte);

-- find the employee who earn the maximum salary 
select * from employees where salary = 
(select max(salary) from employees);

-- with cte 
with cte as (
select max(salary) from employees )

select * from employees where salary = 
(select * from cte);


-- second highest salary 
select * from employees where salary = 
	(select max(salary) from employees where salary <
		(select max(salary) from employees) ); 
        
-- windows function 
select * from 
(select * , dense_rank() over(order by salary desc) as salary_rank from employees)as ms
where salary_rank = 2;


-- find employees who are located in IT or finance 
select * from employees where dept_id in 
(select dept_id from departments where dept_name= 'IT' or dept_name ='FINANCE');


-- find the employees whose salary is greater then all the employees in HR Department 
select * from employees where salary >all
(select salary from employees where dept_id = (select dept_id from departments where dept_name = 'HR'));

-- second way ==> using max function 
select * from employees where salary >
(select max(salary) from employees where dept_id = (select dept_id from departments where dept_name = 'HR'));

-- using cte 
with cte as (
select salary from employees where dept_id = (select dept_id from departments where dept_name = 'HR'))

select * from employees where salary >all (select * from cte);

-- find employees who earn the same salary as any salary who belong to sale  department 
select * from employees where salary in (select salary from employees where dept_id = (select dept_id from departments where dept_name = 'Sales'));
-- cte 
with cte as 
(select d.dept_id ,salary from employees as e join departments as d 
where e.dept_id = d.dept_id and d.dept_name = 'Sales')

select * from employees where salary in (select salary from cte)
and dept_id not in (select dept_id from cte);

-- find the employees who earn avg salary of thier own department 
select * from employees as e where e.salary > (select avg(es.salary)  from employees as es where e.dept_id = es.dept_id );

-- cte 
with cte as (
select dept_id , avg(salary) as cte_salary from employees group by dept_id)

select e.emp_id ,e.emp_name,e.dept_id , e.salary from employees as e join cte as c where e.dept_id = c.dept_id and e.salary > c.cte_salary;


-- find employees who have the highest salary in thier department 
select * from employees as e where e.salary = (select max(salary) from employees as es where e.dept_id = es.dept_id);

-- find those dept whose avg salary is greater then the overall salary of all the employees 
select dept_id,avg(salary) from employees group by dept_id 
having avg(salary) > (select avg(salary) from employees ); 

-- find the employee who earn more then the avg salary of it department 


-- find the department with the maximum total salary 

select max(sum_of_salary) from (select sum(salary) as sum_of_salary from employees group by dept_id)  e ;

-- find the department whose min salary is greater the the min salary of sales department 

select dept_id ,min(salary) from employees group by dept_id having min(salary) > 
(select min(salary) from employees where dept_id = (select dept_id from departments where dept_name = 'Sales'));

select dept_id , min(salary) as minsalary from employees group by dept_id 
having minsalary > (select min(salary) from employees as e join departments as d 
					where e.dept_id = d.dept_id and d.dept_name = 'Sales');
		
        
-- no aggregate function here 
select dept_id , min(salary) as minsalary 
from employees group by dept_id having minsalary >any ()



