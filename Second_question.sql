
SELECT
	`year`, 
	food_name,
	ROUND(AVG (payroll_value) / price_value, 2) AS food_amount,
	food_unit_value,
	food_unit 
FROM t_ondrej_zapletal_project_sql_primary_final
WHERE (LOWER(food_name) LIKE '%chléb%'
	OR LOWER(food_name) LIKE '%mléko%')
	AND `year` IN (2006, 2018)
GROUP BY food_name, `year`;	