-- 2.1) найти товар который наиболее популярный за последний год
SELECT 
	*, 
	count(bought_product_original) as cnt 
FROM 
	bought_product 
WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
group by 
	bought_product_original 
ORDER BY 
	cnt 
DESC LIMIT 1;
---
--
--
-- 2.1) найти товар который наиболее популярный за последний год
SELECT 
	product_name, 
	count(bought_product_original) as cnt 
FROM 
	bought_product 
INNER JOIN 
	product 
ON bought_product_original = product_id
WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
group by 
	bought_product_original 
ORDER BY 
	cnt 
DESC LIMIT 1;