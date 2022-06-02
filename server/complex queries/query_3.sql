-- всем пользователям у которых куплено более 1 товаров за год, снизить цену в последнем чеке на 10%
UPDATE 
	bill
SET bill_sum =  bill_sum * CAST(0.9 as decimal(10, 2))
WHERE bill_id 
IN
	(SELECT bought_product_bill FROM 
		(SELECT 
			bought_product_bill, 
			count(bought_product_original) as total_count 
		FROM 
			bought_product  
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
		GROUP BY bought_product_bill) as table1
	WHERE total_count > 1);