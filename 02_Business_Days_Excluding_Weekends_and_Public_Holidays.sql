-- Q. Write a query to find no of business days between created on and resolved date by excluding weekends and public holidays
--

create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);

delete from tickets;

insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');

create table holidays
(
holiday_date date
,reason varchar(100)
);

delete from holidays;

insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

select * from holidays;
select * from tickets;

-- Ankit Bansal sir's approach
select 
	A.*,
    datediff(resolved_date,create_date) as actual_no_of_days,
    datediff(resolved_date, create_date) - floor(2*datediff(resolved_date, create_date)/7)  - no_of_holidays as business_days
from
(select 
	ticket_id,
    create_date,
    resolved_date,
    count(holiday_date) as no_of_holidays
from tickets
left join holidays on holiday_date between create_date and resolved_date
group by ticket_id, create_date, resolved_date) A
-- here, datediff() syntax is different than MS SQL Servers datediff() syntax, 
-- in MySQL we cant find the weekly or monthly difference using datediff() function, so used this approach












