-- create table
CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

-- insert values into it
INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

select * from events;

-- Q. Write a query to find no. of gold medals per swimmer who won only gold medals

-- find each players gold count
select
	GOLD as player_name,
    count(1) as No_of_Gold_medals
from events
group by GOLD;

-- my approach -> 2 sub-queries -> for each medal -> in main select use not in clause on sub-queries
select
	GOLD,
    count(GOLD) as no_of_golds
from events
where 
	GOLD NOT IN (select Distinct silver from events) 
    AND
	GOLD NOT IN (select Distinct bronze from events)
group by GOLD;
-- this appraoch worked fine

-- Ankit Bansal's approach 1 = using sub-query
select
	GOLD as player_name,
    count(1) as No_of_Gold_medals
from events
where GOLD NOT IN (select silver from events UNION ALL select bronze from events)
group by GOLD;

-- Ankit Bansal's approach 2 = using Having clause and CTE
with cte as(
select gold as player_name,'gold' as medal_type from events
union all
select silver as player_name,'silver' as medal_type from events
union all
select bronze as player_name,'bronze' as medal_type from events)
select 
	player_name,
    count(1) as no_of_gold_medals
from cte
group by player_name
having count(distinct medal_type)=1 AND max(medal_type)='gold'


