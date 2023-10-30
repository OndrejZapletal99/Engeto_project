WITH q5_table AS (
SELECT 
	s.GDP AS gdp,
	LAG(s.GDP, 1)  OVER (ORDER BY p.`year`) AS avg_previous_gdp,
	AVG(p.price_value) AS avg_price,
	AVG(p.payroll_value) AS avg_payroll,
	p.`year` AS actual_year,
	LAG(AVG(p.price_value), 1)  OVER (ORDER BY p.`year`) AS avg_previous_price,
	LAG(AVG(p.payroll_value), 1)  OVER (ORDER BY p.`year`) AS avg_previous_payroll,
	LAG(AVG(p.price_value), 2)  OVER (ORDER BY p.`year`) AS avg_2_previous_price,
	LAG(AVG(p.payroll_value), 2)  OVER (ORDER BY p.`year`) AS avg_2_previous_payroll
FROM t_ondrej_zapletal_project_sql_primary_final p
JOIN t_ondrej_zapletal_project_sql_secondary_final s 
	ON p.`year` = s.`year`
WHERE s.country = 'Czech republic'
GROUP BY p.`year`
)
SELECT 
	actual_year,
	ROUND((gdp - avg_previous_gdp) / avg_previous_gdp * 100, 2) AS `gdp_change(%)`,
	ROUND((avg_price - avg_previous_price) / avg_previous_price * 100, 2) AS `avg_price_change_one_year(%)`,
	ROUND((avg_payroll - avg_previous_payroll) / avg_previous_payroll * 100, 2) AS `avg_payroll_change_one_year(%)`,
	ROUND((avg_price - avg_2_previous_price) / avg_2_previous_price * 100, 2) AS `avg_price_change_two_years(%)`,
	ROUND((avg_payroll - avg_2_previous_payroll) / avg_2_previous_payroll * 100, 2) AS `avg_payroll_change_two_years(%)`
FROM q5_table;
