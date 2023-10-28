CREATE TABLE t_ondrej_zapletal_project_SQL_secondary_final AS
	SELECT 
		e.country,
		e.`year`,
		e.GDP,
		c.population,
		c.surface_area
	FROM economies e 
	JOIN countries c 
		ON e.country = c.country
	WHERE c.continent = 'Europe'
		AND e.`year` BETWEEN 2006 AND 2018;