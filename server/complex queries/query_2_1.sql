-- 2.1) найти товар который наиболее популярный за последний год
SELECT 
	*, 
	count(bought_product_original) as cnt 
FROM 
	bought_product 
group by 
	bought_product_original 
ORDER BY 
	cnt 
DESC LIMIT 1;