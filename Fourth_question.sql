##První mmožnost řešení##

WITH q4_table AS (
	SELECT 
	 `year`,
	 ROUND(AVG(price_value), 2) AS avg_price,
	 ROUND(LAG(AVG(price_value),1) OVER (ORDER BY `year`), 2) AS previous_avg_price
	FROM t_ondrej_zapletal_project_sql_primary_final
	GROUP BY `year`
)
SELECT
	*,
	ROUND((avg_price - previous_avg_price) / previous_avg_price * 100, 2) AS `change(%)`
FROM q4_table
WHERE previous_avg_price IS NOT NULL
	AND ROUND((avg_price - previous_avg_price) / previous_avg_price, 2) > 10;

##Druhá mmožnost řešení##
WITH q4_table AS (
	SELECT
		`year`, 
		AVG(price_value) AS avg_price
	FROM t_ondrej_zapletal_project_sql_primary_final
	GROUP BY `year`
)
SELECT 
	ROUND(t1.avg_price, 2) AS avg_price,
	ROUND(t2.avg_price, 2) AS avg_price_previous,
	t1.`year`,
	t2.`year`,
	ROUND((t1.avg_price - t2.avg_price) / t2.avg_price * 100, 2) AS `change(%)`
FROM q4_table t1
 JOIN q4_table t2
 	ON t1.`year` = t2.`year` + 1
ORDER BY ROUND((t1.avg_price - t2.avg_price) / t2.avg_price * 100, 2) DESC;	