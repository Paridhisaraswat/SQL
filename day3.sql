-- BASIC FUNCTION 
-- functions 

-- CASE conversion
use world; 
select name , upper(name), lower(name) from country ;


-- CONCAT function 
select name , code , concat(name,code) from country ;
select name , code , concat(name,'_',code) from country ;


-- CONCAT_WS ---> joins with a seperator 
select name , code ,concat_ws('$',name , code) from country ;

select name from country where concat(name , ' ', code) = 'Afghanistan AFG';

-- select name , region where in the region the continent name should be present 
select name , region from country where region like concat('%',continent);

-- get name where name is same as region name 
select name from country where name = region ;


-- LEFT FUNCTION 
-- name , continent , population where the first char of the continent as the name 
select name , continent , population from country where left(continent , 1) = left(name , 1);


-- substr : substring :
-- Indexing start from 1 
-- space is also count as a character 
select name , substr(name , 1) from country ;
select name , substr(name , 2)  , substr(name , 2,4) from country ;

select name , substr(name , -1 ) from country ;
select name , substr(name , -3) from country ;
select name , substr(name , -4 , 2) from country ;


-- get name of country where 1st cahr of name is same as continent 1st char 
select name , continent from country where substr(name , 1,1) = substr(continent , 1,1) ;

-- get the name and population where the starting 3 char of the country is alg 
select name , population from country where substr(name , 1,3) = 'Alg';

 -- instr :
 -- returns the index where the char is present in the string  
 
select name , instr(name , 'e') from country ;

-- char_length :
-- count the number of character in the string 

select name , char_length(name) from country ;


-- trim : Removes the extra wide spaces 
select ('       paridhi         ');
select char_length(trim('       paridhi         '));

-- also remove rigth most and left most char also 
select trim(both 's' from'    paridhissssssss');

select name ,  trim(both 'A' from name) from country ;
select name , trim(both 'a' from trim(both 'A' from name)) from country ; 
 
 
-- rtrim :
select char_length(rtrim('       paridhi         '));
-- ltrim:
select char_length(ltrim('       paridhi         '));


-- lpad and rpad 
-- we wnat to define a column with fixed size 

select name , population ,rpad(population,9, "#")from country ;
select name , population ,lpad(population,9,0)from country ;

-- replace :
-- it is use to replace character from a string 
select name , replace(name,'a',' ') from country ;


