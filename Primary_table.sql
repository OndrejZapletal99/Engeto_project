CREATE TABLE t_ondrej_zapletal_project_SQL_primary_final AS
	SELECT 
		cp.value AS price_value,
		cp.category_code AS food_name_code,
		cpc.name AS food_name,
		cpc.price_value AS food_unit_value,
		cpc.price_unit AS food_unit,
		cp2.value AS payroll_value,
		cp2.industry_branch_code AS industry_code,
		cpib.name AS industry_name,
		cp2.payroll_year AS `year`
	FROM czechia_price cp 
	JOIN czechia_payroll cp2 
		ON YEAR(cp.date_from) = cp2.payroll_year
		AND cp2.unit_code = 200
		AND cp2.value_type_code = 5958
		AND cp2.calculation_code = 200
		AND cp.region_code IS NULL
		AND cp2.industry_branch_code IS NOT NULL
	JOIN czechia_payroll_industry_branch cpib
		ON cp2.industry_branch_code = cpib.code 
	JOIN czechia_price_category cpc
		ON cp.category_code = cpc.code;
	
SELECT DISTINCT
	*
FROM t_ondrej_zapletal_project_sql_primary_final tozpspf; 