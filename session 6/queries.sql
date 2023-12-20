-- Count the number of cities
select count(distinct city) from station;


-- Count the number of stations in each city
select city, count(station_id) as cnt from station
group by city
order by cnt desc, city;


-- Find bikes which have been transferred in at least 4 cities
select bike_id, count(distinct city) as cnt from trip join station
on trip.start_station_id = station.station_id or trip.end_station_id = station.station_id
group by bike_id
having count(distinct city) >= 4
order by cnt desc;


-- Find the percentage of trips in each city
select city, cast(count(distinct trip.id) as real)/cast((select count(*) from trip) as real)*100 as ratio
from trip join station
on station.station_id = trip.start_station_id or station.station_id = trip.end_station_id
group by city
order by ratio desc;


-- Find overlapping trips for trips with bike id between 100 and 200
with trip_2 as (select * from trip where bike_id between 100 and 200)
select * from
trip_2 as t1 join trip_2 as t2
on t1.bike_id = t2.bike_id and t1.id < t2.id
where t1.start_time < t2.end_time and t2.start_time < t1.end_time;


-- Calculate the average temperature of short and long trips
with short_trip as (select * from trip  join weather on date(start_time)=weather.date where end_time - start_time <= cast('60 seconds' as interval))
, long_trip as (select * from trip  join weather on date(start_time)=weather.date where end_time - start_time > cast('60 seconds' as interval))
select (select avg(mean_temp) from short_trip) as avg_short, (select avg(mean_temp) from long_trip) as avg_long;


select
avg(case when end_time - start_time <= cast('60 seconds' as interval) then weather.mean_temp else NULL end) as short_trip_avg_temp,
avg(case when end_time - start_time > cast('60 seconds' as interval) then weather.mean_temp else NULL end) as long_trip_avg_temp
from trip join weather on DATE(trip.start_time) = weather.date
where weather.mean_temp is not NULL;




