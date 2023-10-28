WITH q3_table AS (
	SELECT 
	 `year`,
	 ROUND(AVG(price_value), 2) AS avg_price,
	 food_name, 
	 ROUND(LAG(AVG(price_value),12) OVER (PARTITION BY food_name ORDER BY `year`), 2) AS previous_avg_price
	FROM t_ondrej_zapletal_project_sql_primary_final
	GROUP BY `year`, food_name
)
SELECT
	*,
	ROUND((avg_price - previous_avg_price) / previous_avg_price * 100, 2) AS `change(%)`
FROM q3_table
WHERE previous_avg_price IS NOT NULL
	AND ROUND((avg_price - previous_avg_price) / previous_avg_price, 2) > 0
ORDER BY ROUND((avg_price - previous_avg_price) / previous_avg_price, 2) ASC;