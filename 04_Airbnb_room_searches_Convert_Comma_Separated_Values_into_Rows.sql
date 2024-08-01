-- Q. Find the room types that are searched most no of times.
-- output the room type alongside the number of searches for it,  if the filter room types has more than 1 room type, consider each unique room type as a separate row
-- sort the result based on the number of searches in decreasing order

create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);

delete from airbnb_searches;


insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;

select * from airbnb_searches;

-- my approach
with cte as(
select user_id,substring_index(filter_room_types,',',1) as room_types from airbnb_searches
union
select user_id,substring_index(filter_room_types,',',-1) as room_types from airbnb_searches
)
select 
	room_types as Room_Type,
    count(user_id) as No_of_Searches
from cte
group by room_types
order by No_of_Searches DESC;

-- Ankit Bansal sir's approach
select value as room_type, count(1) as no_of_searches 
from airbnb_searches
cross apply string_split(filter_room_types,',')
grpup by value
order by no_of_searches desc
-- here, cross apply and string_split() is not available in MySQL, worked only in MS SQL Server

