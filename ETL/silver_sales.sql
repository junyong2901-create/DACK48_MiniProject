select *
from bronze."Raw_Sales"
order by order_id;

-- Kiểm tra định dạng của các cột
select column_name, data_type, is_nullable
from information_schema.columns 
where table_schema = 'bronze'
and table_name = 'Raw_Sales'
order by ordinal_position;

-- Loại bỏ ô trống trong các cột text
with preparation_data as (
select 
	nullif(trim(order_id), '') as order_id,
	nullif(trim(order_date), '') as order_date,
	order_month,
	order_quarter,
	order_year,
	nullif(trim(customer_id), '') as customer_id,
	nullif(trim(region), '') as region,
	nullif(trim(province), '') as province,
	nullif(trim(channel), '') as channel,
	nullif(trim(employee_id), '') as employee_id,
	nullif(trim(product_id), '') as product_id,
	nullif(trim(product_category), '') as product_category,
	quantity,
	unit_price,
	discount_pct,
	discount_amount,
	gross_amount,
	net_amount,
	nullif(trim(delivery_status), '') as delivery_status,
	nullif(trim(payment_method), '') as payment_method,
	nullif(trim(payment_status), '') as payment_status
from bronze."Raw_Sales")

-- Tìm giá trị null 
select
	sum(case when order_id is null then 1 else 0 end) as null_order_id,
	sum(case when order_date is null then 1 else 0 end) as order_date,
	sum(case when order_month is null then 1 else 0 end) as order_month,
	sum(case when order_quarter is null then 1 else 0 end) as order_quarter,
	sum(case when order_year is null then 1 else 0 end) as order_year,
	sum(case when customer_id is null then 1 else 0 end) as customer_id,
	sum(case when region is null then 1 else 0 end) as region,
	sum(case when province is null then 1 else 0 end) as province,
	sum(case when channel is null then 1 else 0 end) as channel,
	sum(case when employee_id is null then 1 else 0 end) as employee_id,
	sum(case when product_id is null then 1 else 0 end) as product_id,
	sum(case when product_category is null then 1 else 0 end) as product_category,
	sum(case when quantity is null then 1 else 0 end) as quantity,
	sum(case when unit_price is null then 1 else 0 end) as unit_price,
	sum(case when discount_pct is null then 1 else 0 end) as discount_pct,
	sum(case when discount_amount is null then 1 else 0 end) as discount_amount,
	sum(case when gross_amount is null then 1 else 0 end) as gross_amount,
	sum(case when net_amount is null then 1 else 0 end) as net_amount,
	sum(case when delivery_status is null then 1 else 0 end) as delivery_status,
	sum(case when payment_method is null then 1 else 0 end) as payment_method,
	sum(case when payment_status is null then 1 else 0 end) as payment_status
from preparation_data;

select count(*)
from bronze."Raw_Sales";

select distinct delivery_status
from bronze."Raw_Sales";

select *
from bronze."Raw_Sales"
where quantity <= 0 or unit_price = 0;

create table silver."Sales" as 
with sales_clean as (
select 
	order_id,
	to_timestamp(order_date, 'MM-DD-YYYY') as order_date,
	order_month,
	order_quarter,
	order_year,
	customer_id,
	region,
	province,
	channel,
	employee_id,
	product_id,
	product_category,
	quantity,
	unit_price,
	discount_pct,
	discount_amount,
	gross_amount,
	net_amount,
	delivery_status,
	payment_method,
	payment_status
from bronze."Raw_Sales"
)
select *
from sales_clean


