create table gold."dim_date" as 
select 
	order_date,
	order_month,
	order_quarter,
	order_year
from silver."Sales"
order by order_date