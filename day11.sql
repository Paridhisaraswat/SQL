-- case :it is used to give multiple conditions 
/*
case 
	when condition | expression then output
    when condition then output 
end 
*/ 

use world ;
select name , population ,
case 
	when population = 0 then 'NO POPULATION'
end from country ;

select name , population ,
case 
	when population = 0 then 'NO POPULATION'
    when population between 8000 and 70000 then 'MED POPULATION'
end from country ;

-- if condition is false 
select name , population ,
case 
	when population = 0 then 'NO POPULATION'
    when population between 8000 and 70000 then 'MED POPULATION'
    else 'condition is false'
end from country ;


-- case with group by 
select count(*),
case 
	when population = 0 then 'NO POPULATION'
    when population between 8000 and 70000 then 'MED POPULATION'
    else 'condition is false'
end as 'population_status' from country group by population_status ;


-- how many countries are thier which have a population b/w 8k to 70k 
select continent,
sum(
case 
	when population between 8000 and 70000 then 1
    else 0
end) 
from country group by continent ;


