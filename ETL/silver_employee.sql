select *
from bronze."Raw_Employees";

select column_name, data_type, is_nullable
from information_schema.columns 
where table_schema = 'bronze'
and table_name = 'Raw_Employees'
order by ordinal_position;

-- Chỉnh date_of_birth và join_date về dạng date, phone về dạng string, effective_date về dạng date

select count(*)
from bronze."Raw_Employees";

select count(distinct employee_id)
from bronze."Raw_Employees";

select
	sum(case when employee_id is null then 1 else 0 end) as null_employee,
	sum(case when full_name is null then 1 else 0 end) as null_full_name,
	sum(case when gender is null then 1 else 0 end) as null_employee,
	sum(case when date_of_birth is null then 1 else 0 end) as null_date_of_birth,
	sum(case when join_date is null then 1 else 0 end) as null_join_date,
	sum(case when position is null then 1 else 0 end) as null_position,
	sum(case when region is null then 1 else 0 end) as null_region,
	sum(case when team is null then 1 else 0 end) as null_team,
	sum(case when email is null then 1 else 0 end) as null_email,
	sum(case when phone is null then 1 else 0 end) as null_phone,
	sum(case when status is null then 1 else 0 end) as null_status,
	sum(case when version is null then 1 else 0 end) as null_employee,
	sum(case when effective_date is null then 1 else 0 end) as null_effective_date,
	sum(case when resign_date is null then 1 else 0 end) as null_resign_date,
	sum(case when transfer_note is null then 1 else 0 end) as transfer_note
from bronze."Raw_Employees";

select *
from bronze."Raw_Employees"
where transfer_note  is not null;

create table silver."Employees" as 
with employees_clean as (
select
	employee_id,
	full_name,
	gender,
	to_timestamp(date_of_birth, 'YYYY-MM-DD') as date_of_birth,
	to_timestamp(join_date, 'YYYY-MM-DD') as join_date,
	position,
	region,
	team,
	email,
	concat('0',cast(phone as text)) as phone,
	status,
	version,
	to_timestamp(effective_date, 'YYYY-MM-DD') as effective_date
from bronze."Raw_Employees"
)

select *
from employees_clean