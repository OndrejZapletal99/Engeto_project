##První možnost rešení##
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
	food_name,
	ROUND((avg_price - previous_avg_price) / previous_avg_price * 100, 2) AS `change(%)`
FROM q3_table
WHERE previous_avg_price IS NOT NULL
ORDER BY ROUND((avg_price - previous_avg_price) / previous_avg_price, 2) ASC;

##Druhá možnost rešení##
WITH q3_table AS (
	SELECT
		`year`,
		food_name,
		AVG(price_value) AS avg_price
	FROM t_ondrej_zapletal_project_sql_primary_final
	WHERE `year` IN (2006, 2018)
	GROUP BY YEAR, food_name
)
SELECT 
	t1.food_name,
	ROUND(t1.avg_price,2) AS avg_price,
	ROUND(t2.avg_price,2) AS avg_price_previous,
	t1.`year`,
	t2.`year` AS previous_year,
	ROUND((t1.avg_price - t2.avg_price) / t2.avg_price * 100, 2) AS `change(%)`
FROM q3_table  t1
	JOIN q3_table t2 ON
	t1.`year` = t2.`year` + 12
	AND t1.food_name = t2.food_name
	ORDER BY ROUND((t1.avg_price - t2.avg_price) / t2.avg_price * 100, 2);