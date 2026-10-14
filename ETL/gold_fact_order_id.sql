select *
from silver."Sales"

select *
from gold.dim_customers

select count(distinct employee_id)
from silver."Employees"

create table gold."fact_order_id" as 
select 
	order_id, 
	order_date,
	customer_id,
	employee_id,
	product_id,
	quantity,
	unit_price,
	discount_pct,
	discount_amount,
	gross_amount,
	net_amount,
	delivery_status,
	payment_method,
	payment_status
from silver."Sales"
order by order_id