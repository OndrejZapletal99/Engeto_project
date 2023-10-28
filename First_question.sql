
WITH table_q1 AS (
SELECT 
	`year`,
	industry_name,
	AVG(payroll_value) AS year_payroll,
	LAG(AVG(payroll_value),1) OVER (PARTITION BY industry_name ORDER BY `year`) AS previous_payroll,
	CASE
		WHEN LAG(AVG(payroll_value),1) OVER (PARTITION BY industry_name ORDER BY `year`) < AVG(payroll_value) THEN 'increase'
		WHEN LAG(AVG(payroll_value),1) OVER (PARTITION BY industry_name ORDER BY `year`) = AVG(payroll_value) THEN 'no change'
		ELSE 'decrease'
	END	payroll_change
FROM t_ondrej_zapletal_project_sql_primary_final tozpspf
GROUP BY industry_name, `year`
)
SELECT 
	*,
	ROUND((year_payroll - previous_payroll) / previous_payroll * 100, 2) AS `change(%)`
FROM table_q1
WHERE previous_payroll IS NOT NULL	
	AND payroll_change = 'decrease'
ORDER BY `year`; 