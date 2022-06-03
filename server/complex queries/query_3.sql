-- всем пользователям у которых куплено более 1 товаров за год, снизить цену в последнем чеке на 10%
UPDATE 
	bill
SET bill_sum =  bill_sum * CAST(0.9 as decimal(10, 2))
WHERE bill_user 
IN
(SELECT bill_user FROM 
	(SELECT 
		bill_user, 
		sum(total_per_bill) as total_count 
	FROM 
		bill 
	INNER JOIN
		(SELECT 
			bought_product_bill, 
			count(bought_product_original) as total_per_bill
		FROM 
			bought_product  
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
		GROUP BY 
			bought_product_bill) as table1
	ON bill_id = bought_product_bill
	GROUP BY bill_user) as table2
WHERE total_count > 3)


-- пользователи которые за весь год совершили более 3 покупок
SELECT bill_user FROM 
	(SELECT 
		bill_user, 
		sum(total_per_bill) as total_count 
	FROM 
		bill 
	INNER JOIN
		(SELECT 
			bought_product_bill, 
			count(bought_product_original) as total_per_bill
		FROM 
			bought_product  
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
		GROUP BY 
			bought_product_bill) as table1
	ON bill_id = bought_product_bill
	GROUP BY bill_user) as table2
WHERE total_count > 3


-- почти доделал 
UPDATE 
	bill as bill_1
INNER JOIN 
(SELECT MAX(bill_id) AS last_id FROM bill
WHERE bill_user 
IN 
(SELECT bill_user FROM 
	(SELECT 
		bill_user, 
		sum(total_per_bill) AS total_count 
	FROM 
		bill 
	INNER JOIN
		(SELECT 
			bought_product_bill, 
			count(bought_product_original) as total_per_bill
		FROM 
			bought_product  
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
		GROUP BY 
			bought_product_bill) as table1
	ON bill_id = bought_product_bill
	GROUP BY bill_user) as table2
WHERE total_count > 3)
GROUP BY bill_user) AS bill_2
ON bill_1.bill_id = bill_2.last_id

-- обновляет все счета пользователей, который за год купили больше 3 товаров
UPDATE 
	bill 
SET bill_sum =  bill_sum * CAST(0.9 as decimal(10, 2))
WHERE bill_user
IN 
(SELECT bill_user FROM 
	(SELECT bill_user, COUNT(bought_product_original) AS total_items FROM 
		(SELECT * FROM bought_product 
		INNER JOIN bill 
		ON
		bought_product_bill = bill.bill_id 
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) as table1
	GROUP BY table1.bill_user) AS table2
WHERE total_items > 3) AND bill_user = 123


-- выбрать последние чеки для пользователей которые купили больше 3 товаров за год
(SELECT last_id FROM 
(SELECT bill_user, MAX(bill_id) AS last_id FROM 
(SELECT * FROM bill 
WHERE bill_user 
IN
	(SELECT bill_user FROM 
		(SELECT bill_user, COUNT(bought_product_original) AS total_items FROM 
			(SELECT * FROM bought_product 
			INNER JOIN bill 
			ON
			bought_product_bill = bill.bill_id 
			WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) as table1
		GROUP BY table1.bill_user) AS table2
	WHERE total_items > 3)) as table3
GROUP BY bill_user) as table4)



--- 
--- 
--- ИТОГОВЫЙ ВАРИАНТ
---
---
UPDATE 
bill 
SET bill_sum =  bill_sum * CAST(0.9 as decimal(10, 2))
WHERE bill_user
IN 
(SELECT bill_user FROM 
(SELECT bill_user, COUNT(bought_product_original) AS total_items FROM 
 		(SELECT * FROM bought_product 
 		INNER JOIN bill 
		ON
 		bought_product_bill = bill.bill_id 
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) as table1
 	GROUP BY table1.bill_user) AS table2
 WHERE total_items > 3) AND bill_id IN (SELECT last_id FROM 
(SELECT bill_user, MAX(bill_id) AS last_id FROM 
(SELECT * FROM bill 
WHERE bill_user 
IN
	(SELECT bill_user FROM 
		(SELECT bill_user, COUNT(bought_product_original) AS total_items FROM 
			(SELECT * FROM bought_product 
			INNER JOIN bill 
			ON
			bought_product_bill = bill.bill_id 
			WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) as table1
		GROUP BY table1.bill_user) AS table2
	WHERE total_items > 3)) as table3
GROUP BY bill_user) as table4)


---
--- ИТОГОВЫЙ ВАРИАНТ 2
---
UPDATE 
bill 
SET bill_sum =  bill_sum * CAST(0.9 as decimal(10, 2))
WHERE bill_user
IN 
(SELECT bill_user FROM 
(SELECT bill_user, COUNT(bought_product_original) AS total_items FROM 
 		(SELECT * FROM bought_product 
 		INNER JOIN bill 
		ON
 		bought_product_bill = bill.bill_id 
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) as table1
 	GROUP BY table1.bill_user) AS table2
 WHERE total_items > 3) AND bill_id IN (SELECT last_id FROM 
(SELECT bill_user, MAX(bill_id) AS last_id FROM 
(SELECT * FROM bill 
WHERE bill_user 
IN
	(SELECT bill_user FROM
		(SELECT bill_user, COUNT(bought_product_original) as total_buy FROM bought_product
		INNER JOIN bill
		ON
		bought_product_bill = bill.bill_id 
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
	GROUP BY bill_user) as table2
WHERE total_buy > 3)) as table3
GROUP BY bill_user) as table4)

---
--- ИТОГОВЫЙ ВАРИАНТ 3
---
UPDATE 
bill 
SET bill_sum =  bill_sum * CAST(0.9 as decimal(10, 2))
WHERE bill_user
IN 
(SELECT bill_user FROM 
(SELECT bill_user, COUNT(bought_product_original) AS total_items FROM 
 		(SELECT * FROM bought_product 
 		INNER JOIN bill 
		ON
 		bought_product_bill = bill.bill_id 
		WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) as table1
 	GROUP BY table1.bill_user) AS table2
 WHERE total_items > 3) AND bill_id IN (SELECT last_id FROM 
(SELECT bill_user, MAX(bill_id) AS last_id FROM 
(SELECT * FROM bill 
WHERE bill_user 
IN
	(SELECT bill_user FROM bought_product
	INNER JOIN bill
	ON
	bought_product_bill = bill.bill_id 
	WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
	GROUP BY bill_user
HAVING COUNT(bought_product_original) > 3)) as table3
GROUP BY bill_user) as table4)

-- запрос последних чеков
SELECT  MAX(bill_id) as last_id FROM bought_product
	INNER JOIN bill
	ON
	bought_product_bill = bill.bill_id 
	WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
	GROUP BY bill_user
HAVING COUNT(bought_product_original) > 3

--
-- итоговый вариант (не рабочий)
--
UPDATE 
bill 
SET bill_sum =  bill_sum * CAST(0.9 as decimal(10, 2))
WHERE bill_id IN (SELECT MAX(bill_id) as last_id FROM bought_product
	INNER JOIN bill
	ON
	bought_product_bill = bill.bill_id 
	WHERE bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
	GROUP BY bill_user
HAVING COUNT(bought_product_original) > 3)

-- 
-- Итоговый рабочий вариант
--

UPDATE bill 
INNER JOIN 
	(SELECT 
		MAX(bill_id) AS last_id 
	FROM 
		bought_product
	INNER JOIN 
		bill
	ON
		bought_product_bill = bill.bill_id 
	WHERE 
		bought_product_time > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
	GROUP BY 
		bill_user
	HAVING 
		COUNT(bought_product_original) > 3) AS tbl2 
ON 
	bill.bill_id = tbl2.last_id
SET 
	bill_sum = bill_sum * CAST(0.9 AS decimal(10, 2))
WHERE 
	bill.bill_id = tbl2.last_id;
