create view gold."dim_products" as 
select 
	distinct product_id,
	product_category,
	unit_price
from silver."Sales"