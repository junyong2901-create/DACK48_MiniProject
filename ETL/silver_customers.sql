select *
from bronze."Raw_Customers";

-- Xem kiểu dữ liệu của các cột
select 
	column_name, data_type, is_nullable
from information_schema.columns
where table_schema = 'bronze'
and table_name = 'Raw_Customers'
order by ordinal_position;

-- Đếm null theo từng cột
select
	sum(case when customer_id is null then 1 else 0 end) as null_customer,
	sum(case when customer_name is null then 1 else 0 end) as null_customer_name,
	sum(case when customer_type is null then 1 else 0 end) as null_customer_type,
	sum(case when channel is null then 1 else 0 end) as null_channel,
	sum(case when province is null then 1 else 0 end) as null_province,
	sum(case when region is null then 1 else 0 end) as null_region,
	sum(case when address is null then 1 else 0 end) as null_address,
	sum(case when phone is null then 1 else 0 end) as null_phone,
	sum(case when tax_code is null then 1 else 0 end) as null_tax_code, 
	sum(case when join_date is null then 1 else 0 end) as null_join_date, 
	sum(case when credit_limit is null then 1 else 0 end) as null_credit_limit,
	sum(case when status is null then 1 else 0 end) as null_status
from bronze."Raw_Customers"

-- Thay null bằng "Unknown"

SELECT customer_id, join_date
FROM bronze."Raw_Customers"
WHERE join_date IS NOT NULL
  AND trim(join_date) !~ '^\d{1,2}/\d{1,2}/\d{4}$';

-- Kiểm tra dữ liệu trùng lặp
select 
	customer_id,
	count(*) as cnt
from bronze."Raw_Customers"
group by customer_id
having count(*) > 1;

create table silver."Customers" as 
with cleaning_data as (
	select 
		customer_id,
		customer_name,
		customer_type,
		channel,
		province,
		region,
		address,
		concat('0', cast(phone as text)) as phone,
		coalesce(tax_code::text,'Unknown') as tax_code,
		to_timestamp(join_date, 'MM/DD/YYYY') as join_date,
		credit_limit,
		status
	from bronze."Raw_Customers"
)

select *
from cleaning_data;