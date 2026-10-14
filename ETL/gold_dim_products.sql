create table gold."dim_products" as 
select 
	product_id,
	product_category,
	unit_price
from silver."Sales"