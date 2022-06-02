-- 2.2) найти товар который наиболее популярный за каждый месяц отдельно
SELECT 
	* 
from 
	product
INNER JOIN (SELECT
				MAX(cnt),
				bought_product_original,
				month_type
			FROM
				(SELECT
					*, 
					MONTH(bought_product_time) as month_type,
					count(bought_product_original) as cnt
				from
					bought_product
				group by
					bought_product_original, 
					month_type
				ORDER BY
					cnt 
				DESC
				) as table1
			GROUP BY
				month_type
			) as table2 
ON product_id = table2.bought_product_original
ORDER BY month_type