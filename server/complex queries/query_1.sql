-- 1) найти покупателей которые купили больше всех товаров(сумма);
SELECT bill_user, SUM(bill_sum) as total_sum FROM (SELECT 
	* 
FROM 
	bill 
INNER JOIN 
	`user` 
ON 
	bill.bill_user = `user`.user_id) as table1
GROUP BY
	bill_user
ORDER BY total_sum DESC
limit 3;