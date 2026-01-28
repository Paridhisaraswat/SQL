use REGEX;

CREATE TABLE drivers (
  driver_id   INT PRIMARY KEY,
  driver_name VARCHAR(50) NOT NULL,
  base_area   VARCHAR(50) NOT NULL
);

-- -------------------------
-- Create table: trips  (DATE column included)
-- -------------------------
CREATE TABLE trips (
  trip_id      INT PRIMARY KEY,
  driver_id    INT NOT NULL,
  trip_date    DATE NOT NULL,
  distance_km  DECIMAL(5,1) NOT NULL,
  fare         INT NOT NULL,
  rating       DECIMAL(3,1) NOT NULL,
  CONSTRAINT fk_trips_driver
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- -------------------------
-- Insert data: drivers (4 rows)
-- -------------------------
INSERT INTO drivers (driver_id, driver_name, base_area) VALUES
(1, 'Asha',  'Indiranagar'),
(2, 'Ravi',  'Koramangala'),
(3, 'Meera', 'Whitefield'),
(4, 'Kabir', 'HSR Layout');

-- -------------------------
-- Insert data: trips (10 rows)
-- -------------------------
INSERT INTO trips (trip_id, driver_id, trip_date, distance_km, fare, rating) VALUES
(101, 1, '2025-11-01', 12.0, 350, 4.8),
(102, 1, '2025-11-02',  5.5, 180, 4.6),
(103, 2, '2025-11-01',  8.0, 260, 4.9),
(104, 2, '2025-11-03', 15.0, 500, 4.7),
(105, 3, '2025-11-02',  3.0, 120, 4.2),
(106, 3, '2025-11-04', 22.0, 780, 4.9),
(107, 4, '2025-11-01',  6.0, 210, 4.5),
(108, 4, '2025-11-03',  9.0, 300, 4.4),
(109, 4, '2025-11-04',  4.0, 150, 4.8),
(110, 1, '2025-11-04', 18.0, 620, 4.9);


select * from drivers ;
select * from trips ;

-- For each trip_date, show number of trips, total fare, and average rating.
select trip_date , count(*), sum(fare) ,avg(rating) from trips group by trip_date; 

-- By base_area, show total trips, total fare, and average distance. 
select d.base_area , count(*),sum(t.fare),avg(t.distance_km) from drivers as d 
join trips as t 
where d.driver_id = t.driver_id 
group by d.base_area order by d.base_area;

-- Rating buckets count (>=4.8 as “High”, else “Other”)
select
case 
	when rating >= 4.8 then 'HIGH'
    else 'other'
end as rating_buckets,
count(*) from trips
group by 
	case 
		when rating >= 4.8 then 'HIGH'
		else 'other'
end ;

-- Days where total fare >= 800 (GROUP BY + HAVING) 
select trip_date , sum(fare) from trips 
group by trip_date having sum(fare) >= 800;

-- Base-area average rating, only areas with avg rating >= 4.7 
select d.base_area , avg(t.rating) from drivers as d
join trips as t 
where d.driver_id = t.driver_id 
group by d.base_area having avg(rating) >= 4.7;


-- Trips with fare greater than the overall average fare  
select trip_id , driver_id ,fare from trips where 
fare >(select avg(fare) from trips);

-- Drivers who have at least one trip rated 4.9
select d.driver_id , d.driver_name from drivers as d
join trips as t 
where  d.driver_id = t.driver_id and rating = 4.9 ;

-- Drivers whose total fare is greater than the average total fare per driver
select t.driver_id , d.driver_name , sum(t.fare)  from trips as t 
join drivers as d where t.driver_id = d.driver_id 
group by driver_id 
having sum(fare) > 
(select avg(total_fare) from 
(select driver_id , sum(fare) as total_fare from trips group by driver_id) as driver_total) order by sum(fare) desc ;


-- Latest trip per driver
select driver_id ,trip_id ,trip_date , fare from 
(select driver_id ,trip_id ,trip_date , fare ,rank () over(partition by driver_id order by trip_date desc) as latest from trips) t
where latest = 1;

-- Row number of trips per driver ordered by date (then trip_id)
select driver_id , trip_id , trip_date , row_number() over(partition by driver_id order by trip_date , trip_id) as rn from trips ;


-- Running total fare per driver over time
select driver_id , trip_id ,trip_date , fare , sum(fare) over(partition by driver_id order by trip_date) from trips ;

-- Rank trips by fare within each driver (highest fare rank 1)
select driver_id , trip_id , fare , rank() over(partition by driver_id order by fare desc) from trips ;

-- Show each trip’s fare minus the driver’s average fare (window AVG)
select driver_id , trip_id ,fare, avg(fare) over(partition by driver_id)as driver_avg ,fare - avg(fare) over(partition by driver_id) as diff_from_avg from trips;

-- For each driver, show the previous trip’s fare (LAG) ordered by date
select driver_id , trip_id , trip_date , fare , lag(fare) over(partition by driver_id order by trip_date ) from trips ; 





