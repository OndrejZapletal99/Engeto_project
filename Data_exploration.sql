##Czechia payroll##
SELECT 
	calculation_code 
FROM czechia_payroll 
WHERE calculation_code IS NULL;

SELECT 
	value_type_code  
FROM czechia_payroll 
WHERE value_type_code  IS NULL;

SELECT 
	industry_branch_code  
FROM czechia_payroll 
WHERE industry_branch_code  IS NULL;

SELECT 
	value 
FROM czechia_payroll 
WHERE value IS NULL;

SELECT 
	payroll_quarter 
FROM czechia_payroll 
WHERE payroll_quarter  IS NULL;


SELECT 
	payroll_year 
FROM czechia_payroll 
WHERE payroll_year  IS NULL;


SELECT 
	value,
	unit_code,
	industry_branch_code,
	calculation_code,
	value_type_code
FROM czechia_payroll 
WHERE 
	unit_code = 200 AND 
	value_type_code = 5958 AND
	calculation_code = 200 AND
	(value IS NULL OR industry_branch_code IS NULL)
ORDER BY value;

SELECT DISTINCT
	payroll_year
FROM czechia_payroll;
	


## Czechia_price exploration##

SELECT 
 value
FROM czechia_price 
WHERE 
	value IS NULL;

SELECT 
 category_code 
FROM czechia_price 
WHERE 
	category_code  IS NULL;

SELECT 
 region_code 
FROM czechia_price 
WHERE 
	region_code  IS NULL;

SELECT 
 date_from 
FROM czechia_price 
WHERE 
	date_from  IS NULL;

SELECT 
 date_to 
FROM czechia_price 
WHERE 
	date_to IS NULL;

SELECT 
	category_code,
	AVG (value) AS average
FROM czechia_price 
WHERE category_code = 112201
	AND date_from = '2017-11-13'
	AND date_to = '2017-11-19'
	AND region_code IS NOT NULL;

SELECT 
	category_code,
	value 
FROM czechia_price 
WHERE category_code = 112201
	AND date_from = '2017-11-13'
	AND date_to = '2017-11-19'
	AND region_code IS NULL;


SELECT 
	COUNT(category_code) AS num_values,
	region_code
FROM czechia_price 
GROUP BY region_code;

SELECT DISTINCT
 YEAR(date_from) AS `year`S
FROM czechia_price
ORDER BY YEAR(date_from);

##Economies exploration##

SELECT 
	country 
FROM economies 
WHERE country IS NULL;

SELECT 
	`year` 
FROM economies 
WHERE `year`  IS NULL;

SELECT DISTINCT 
	`year` 
FROM economies;