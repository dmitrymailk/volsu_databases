-- 4) посчитать среднюю цену товара в каждом типе товара
SELECT 
	product_type , 
	AVG(product_price) as avg_price 
FROM 
	product 
GROUP BY 
	product_type;