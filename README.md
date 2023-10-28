# Engeto projekt

- *Závěrečný projekt Engeto datové analýzy*
- *SQL*
- *DISCORD*: "ondrej_zapletal"
---


# Obsah
  
- [Engeto projekt](#engeto-projekt)
- [Obsah](#obsah)
	- [1. Zadání projektu](#1-zadání-projektu)
		- [1.1 Výzkumné otázky](#11-výzkumné-otázky)
	- [2. Analýza jednotlivých tabulek](#2-analýza-jednotlivých-tabulek)
		- [2.1 Primární tabulky](#21-primární-tabulky)
			- [2.1.1 Czechia\_payroll](#211-czechia_payroll)
			- [2.1.2 Czechia\_payroll\_calculation](#212-czechia_payroll_calculation)
			- [2.1.3 Czechia\_payroll\_industry\_branch](#213-czechia_payroll_industry_branch)
			- [2.1.4 Czechia\_payroll\_unit](#214-czechia_payroll_unit)
			- [2.1.5 Czechia\_payroll\_value\_type](#215-czechia_payroll_value_type)
			- [2.1.6 Czechia\_price](#216-czechia_price)
			- [2.1.7 Czechia\_price\_category](#217-czechia_price_category)
		- [2.2 Číselníky sdílených informací o ČR](#22-číselníky-sdílených-informací-o-čr)
			- [2.2.1 Czechia\_region](#221-czechia_region)
			- [2.2.2 Czechia\_district](#222-czechia_district)
		- [2.3 Dodatečné tabulky](#23-dodatečné-tabulky)
			- [2.3.1 Countries](#231-countries)
			- [2.3.2 Economies](#232-economies)
		- [2.4 Závěry a výspupy pro projekt](#24-závěry-a-výspupy-pro-projekt)
			- [2.4.1 Primární tabulky](#241-primární-tabulky)
			- [2.4.2 Sekundární tabulky](#242-sekundární-tabulky)
	- [3. Tvorba primární finální a primární sekundární tabulky](#3-tvorba-primární-finální-a-primární-sekundární-tabulky)
		- [3.1 Primární finální tabulka](#31-primární-finální-tabulka)
		- [4.3 Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?](#43-která-kategorie-potravin-zdražuje-nejpomaleji-je-u-ní-nejnižší-percentuální-meziroční-nárůst)
  





## 1. Zadání projektu

Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

Tabulky pojmenujte:
- ***t_{jmeno}_{prijmeni}_project_SQL_primary_final*** (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) 
- ***t_{jmeno}_{prijmeni}_project_SQL_secondary_final*** (pro dodatečná data o dalších evropských státech).

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

Na svém GitHub účtu vytvořte repozitář (může být soukromý), kam uložíte všechny informace k projektu – hlavně SQL skript generující výslednou tabulku, popis mezivýsledků (průvodní listinu) a informace o výstupních datech (například kde chybí hodnoty apod.).
### 1.1 Výzkumné otázky 
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
## 2. Analýza jednotlivých tabulek
Tato kapitola slouží k popisu a základní analýze jednotlivých tabulek dostupných v engeto databázi. Tyto tabulky následně slouží k vytvoření finální primární a sekundární tabulky.
Samotný popis a analýza jednotlivých tabulek bude prováděna pomocí průzkumu vlastností tabulek, ER diagramu a samotných dat. Průzkum dat bude proveden jak pomocí jednuchého pohledu na datovou tabulka, tak i pomocí základních SQL přikazů.
### 2.1 Primární tabulky
Primární tabulky jsou zdrojem dat pro finální primární tabulku tohoto projektu.
#### 2.1.1 Czechia_payroll
Tato tabulka obsahuje data týkající se mezd a počtu zaměstnaných v různých odvětvích průmyslu České republiky za vybraná období.

Tato tabulka obsahuje osm sloupců, a to:
- **id** - id záznamu (primární klíč)
- **value** - hodnoty mezd nebo počtu osob
- **value_type_code** - kodové označení typu zaznamenané hodnoty (cizí klíč). Popsáno v podkapitole [2.1.5 Czechia\_payroll\_value\_type](#215-czechia_payroll_value_type)
- **unit_code** - kodové označení vyjadřované jednotky (cizí klíč). Popsanáno v podkapitole [2.1.4 Czechia\_payroll\_unit](#214-czechia_payroll_unit)
- **calculation_code** - kodové označení typu přepočtu pro jednotlivé záznamy(cizí klíč). Popsáno v podkapitole [2.1.2 Czechia\_payroll\_calculation](#212-czechia_payroll_calculation)
- **industry_branch_code** - kodové označení jednotlivých oblastí průmyslu České republiky (cizí klíč). Popsáné v kapitole [2.1.3 Czechia\_payroll\_industry\_branch](#213-czechia_payroll_industry_branch)
- **payroll_year** - roky, ke kterým jsou dané hodnoty přiřazeny
- **payroll_quarter** - čtvrteltí pro jednotlivé roky
1. Sloupce industry_branch_code a value obsahují prázdné hodnoty. Ostatní sloupce nikoliv (hodnota NULL).
 ```
SELECT 
	calculation_code 
FROM czechia_payroll 
WHERE calculation_code IS NULL;
```
>Následně analogicky pro všechny sloupce
2. V případě, že se vezme v potaz to, že se bude anayzovat průměrná hrubá mzda přepočetená na celý úvazek pro jednotlivé oblasti průmyslu, tak lze ostatní hodnoty eliminovat v následných analýzách pomocí příslušných kodů viz podpkapitoly níže. I při této eliminaci zůstalo asi 86 záznamů s prázdnou hodnotou u industry_branch_code. Sloupec value po zavedení omezovacích podmínek už prázdné hodnoty neobsahuje.
```
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
```
3. Sledované období je v od roku 2000 do roku 2021.
 ```
SELECT DISTINCT
	payroll_year
FROM czechia_payroll;
```
#### 2.1.2 Czechia_payroll_calculation
Tato tabulka obsahuje kodobé označení a popis jednotlivých hodnot, na které jsou jednotlivé záznamy překalkulovány.

Data jsou zaznamenána do dvou sloupců, a to:
- **code** - dva kody označují dvě hodnoty , které byly v tabulce mezd použity na překalkulování
- **name** - názvy dvou zaznamenávaných hodnot
> V tomto projektu nás bude zajímat kodové označení **200**. Tento kod přepočítává hodnoty na plné úvazky. Je obecně známo, že ne každý pracuje na plný úvazek a tudíž to může následně zkreslovat hodnoty průměrných mezd. Věšina lidí je v České republice zatím zaměstnána na plný úvazek.
#### 2.1.3 Czechia_payroll_industry_branch
Tato tabulka obsahuje data s názvy jednotlivých oblastí průmyslu České republiky a jejich kodového označení. 

Tato data jsou uspořádáná do dvou sloupců, a to:
- **code** -  kody jednotlivých oblastů průmyslu (primární klíč)
- **name** -  názvy oblastí průmyslu
#### 2.1.4 Czechia_payroll_unit
Tato tabulka obsahuje kodobé označení a popis jednotlivých jednotek, na které jsou vztaženy zaznamenané hodnoty.

Data jsou zaznamenána do dvou sloupců, a to:
- **code** - dva kody označují dvě hodnoty , které byly v tabulce mezd zaznamenávány (primární klíč)
- **name** - názvy dvou zaznamenávaných hodnot
> V tomto projektu nás bude zajímat kodové označení **200** vyjadřující hodnotu české měny ("Kč")
#### 2.1.5 Czechia_payroll_value_type
Tato tabulka obsahuje kodobé označení a popis jednotlivých druhů hodnot vstupujících do tabulky mezd.

Data jsou zaznamenána do dvou sloupců, a to:
- **code** - dva kody označují dvě hodnoty , které byly v tabulce mezd zaznamenávány (primární klíč)
- **name** - názvy dvou zaznamenávaných hodnot
> V tomto projektu nás bude zajímat kodové označení **5958** vyjadřující průměrnou hrubou mzdu na jednoho zaměstnance
#### 2.1.6 Czechia_price
Tato tabulka obsahuje data ohledně cen jednotlivých druhů potravin ve sledovaných obdobích podle sledovaných krajů.

V této tabulce je celkem 6 sloupců
- **id** - id záznamu měření (primární klíč)
- **value** - hodnot (cena) jednotlivých záznamů
- **category_code** - číselný kod pro jednotlivé kategorie potravin (cizí klíč)
- **date_from** - počáteční datum měření
- **date_to** - konečné datum měření 
- **region_code** - kod jednotlivých regionů
1. Sloupce id, value, category_code, date_from a date_to nemají prázdné záznamy. Sloupec region_code obsahuje prázdné záznamy (hodnota NULL).
```
SELECT 
 value
FROM czechia_price 
WHERE 
	value IS NULL
```
>Následně analogicky pro všechny sloupce
2. V případě prázdných záznamů u sloupce regio_code se vždy jedná o průměrnou hodnoty(cenu) dané kategorie potravin za všechny kraje v daném sledovaném období.
```
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
```
3. Počet záznamů pro chybějící hodnoty v region_code se téměř rovná počtu záznamů pro jakýkoliv kraj zvlášť (až na odchylku u pár krajů o 1-3 záznamy)
```
SELECT 
	COUNT(category_code) AS num_values,
	region_code
FROM czechia_price 
GROUP BY region_code;
```

>Pokud v následojících datových analýzách nebude potřeba rozdělení na kraje tak je lepší využíta region_code s prázdnými hodnotami. Pokud bude potřeba výsledné hodnoty o cenách atd rozdělit podle krajů je lepší prázné hodnoty v region_code vyloučit
4. Sledované období je v od roku 2006 do roku 2018.
```
SELECT DISTINCT
 YEAR(date_from) AS `year`
FROM czechia_price
ORDER BY YEAR(date_from);
```
#### 2.1.7 Czechia_price_category
Tato tabulka obsahuje data o jednotlivých druzích potravin, jejich jednotce a hodnotě jednotky v jaké jsou zaznamenány, a také kod pro jednotlivé potraviny.

Tato tabulka obsahuje čtyři sloupce, a to:
- **code** - kody jednotlivých druhů potravin (primární klíč)
- **name** - názvy jedntnolivých druhů potravin
- **price_value** - hodnota jednotky pro daný druh potraviny, na kterou je vztažena cena potraviny
- **price_unit** - jednotka pro daný druh potraviny, na kterou je vztažena cena potraviny
### 2.2 Číselníky sdílených informací o ČR

Číselníkové tabulky jsou doplňkovým zdrojem informací pro finální primární tabulku.
#### 2.2.1 Czechia_region
Tato tabulka obsahuje data s názvy jednotlivých krajů České republiky a jejich kodového označení. 

Tato data jsou uspořádáná do dvou sloupců, a to:
- **code** -  kody jednotlivých krajů (primární klíč)
- **name** -  názvy jednotlivých krajů
#### 2.2.2 Czechia_district
Tato tabulka obsahuje data s názvy jednotlivých okresů České republiky a jejich kodového označení. 

Tato data jsou uspořádáná do dvou sloupců, a to:
- **code** - kody jednotlivých okrsů (primární klíč)
- **name** - názvy jednotlivých okresů
### 2.3 Dodatečné tabulky
Dodatečné tabulky jsou zdrojem dat pro sekundární finální tabulku projektu.
#### 2.3.1 Countries
Tato tabulka obsahuje demografická a geografická data jednotlivých států. Tato data mohou být následně použita pro zjišťování ruzných ekonomických jevů v závislosti na např. typu vlády atd.

Data pochází z více zdrojů a mohou být nekompletní nebo nekonzistentní.

V případě našeho projektu nás z této tabulky budou zajímat data ohledně názvu země, populace, rozloze země. Tyto údaje jsou zazamenány ve třech sloupcích, a to:
- **country** - název země
- **population** - populace v dané zemi
- **surface_area** - rozloha dané země
>U těchto dat je velká nevýhoda, že není známa jejich aktuálnost a také tyto hodnoty mění každý rok. Pro základní analýzu však postačí.
#### 2.3.2 Economies
Tato tabulka obsahuje data ohledně zákadních ekonomických ukazatelů daných státu v ruzných letech.

Je tvořena osmi sloupci, a to:
- **country** - název státu nebo oblasti (primární klíč v kabinaci s 'year')
- **year** - rok měření (primární klíč v kabinaci s 'country')
- **GDP** - hrubý domácí produkt v daném roce
- **populace** - populace v daném roce
- **gini** - GINI koeficient v daném roce
- **taxes** - daně v daném roce
- **fertelity** - plodost v daném roce
- **mortality_under5** - úmrtnost v daném roce

>Pro tento projekt budou podstatné sloupce s názvem státu, GDP ukazatelem a rokem měření.

1. Sloupce country a year neobsahují prázdné hodnoty. Sloupec s ukazatelem GDP obsahuje nulové hodnoty
```
SELECT 
	`year` 
FROM economies 
WHERE `year`  IS NULL;
```
2. Ekonomiické ukazatele byly zaznamenávány v období od roku 1960 do roku 2020.
```
SELECT DISTINCT 
	`year` 
FROM economies;
```
###  2.4 Závěry a výspupy pro projekt
#### 2.4.1 Primární tabulky
1. Pro czechia_payroll_calculation  bude použito omezení/filtr pouze na hodnotu "**200**" ze sloupce code aby hodnoty vyjadřovavané hodnoty byly přepočtené na celé úvazky.
2. Pro czechia_payroll_unit  bude použito omezení/filtr pouze na hodnotu "**200**" ze sloupce code aby hodnoty byly vyjádřeny v Kč.
3. Pro czechia_payroll_value_type  bude použito omezení/filtr pouze na hodnotu "**5958**" ze sloupce code aby hodnoty vyjadřovaly průměrnou hrubou mzdu zaměstnance.
4. Sloupec payroll_year z tabulky czechia_payroll obsahuje časové období od roku 2000 do 2021
5. Sloupec date_from z tabulky czechia_price obsauje časové období od roku 2006 a 2018
6. Sloupec 'payroll_year' z tabulky czechia_payroll a sloupec 'date_from' z tabulky czechia_price bude spojovacím sloupcem pro spojení těchto dvou tabulek.
7. Sloupec region_code z tabulky czechia_price obsahuje prázdné hodnoty. Tyto prázdné hodnoty znamenají celkový průměr za všechny kraje.
8. Sloupec industry_branch_code z tabulky czechia_payroll obsahuje prázdné hodnoty.
 #### 2.4.2 Sekundární tabulky
 1. V projektu budou spíše využita data z tabulky economies, které budou doplněny o data z tabulky country v nové vzniklé finální sekundární tabulce.
 2. Spojovacím sloupcem bude 'country' v obou tabulkách
## 3. Tvorba primární finální a primární sekundární tabulky
### 3.1 Primární finální tabulka
Finální primární tabulka obsahuje sloupce:
- **price_value** - průměrná cena dané kategorie potravin za všechny kraje
- **food_name_code** - kod kategorie potravin
- **food_name** - název kategorie potravin
- **food_unit_value** - hodnota, ne kterou je vztažena jednotka dané potraviny
- **food_unit** - jednotka dané potraviny
- **payroll_value** - průěmrná hrubá mzda v Kč vztažená na celý úvazek
- **industry_code** - kod kategorie průmyslu České republiky
- **industry_name** - název kategorie průmyslu České republiky
- **rok** - časové období měření
  ```
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
	```
### 3.2 Sekundární finální tabulka 
Finální primární tabulka obsahuje sloupce:
- **county** - název dané země
- **year** - rok 
- **GDP** - hrubý domácí produkt
- **population** - populace
- **surface_area** - rozloha

Data byla omezena na evropksý kontinent v letech 2006 a 2018. Toto časové období koresponduje s časovým obdobím cen v České republice v primání finální tabulce.

```
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
```

# 4. Výzkumné otázky
### 4.1 Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Pro získání odpovědi na tuto otázku byl vytvořen následující SQL script
```
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
	(year_payroll - previous_payroll) / previous_payroll * 100 AS `change(%)`
FROM table_q1
WHERE previous_payroll IS NOT NULL	
	AND payroll_change = 'decrease'
ORDER BY `year`; 
```
>>>**Dle tabulky/dat získaných díky výše uvedenému scriptu lze říci, že existovala odvětví průmyslu České republiky, které zaznamelana meziroční pokles průměrných mezd. Převážně se jednalo o poklesy obodobí ekonomických krizí od roku 2006 do roku 2O12/13.**
Výsledná data dostupná v CSV formátu v souboru [q1_export_data](https://github.com/OndrejZapletal99/Engeto_project/blob/main/q1_export_data.csv).
### 4.2 Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Pro získání odpovědi na tuto otázku byl vytvořen následující SQL script
```
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
```
>>>**Dle tabulky/dat získaných díky výše uvedenému scriptu lze říci, že v roce 2008 si lidé mohli z průměrné hrubé mzdy zakoupit 1219,9 kg chleba a 1469,8 l mléka. V roce 2018 si lidé mohli zakoupit 1336,49 kg chleba a 1628,52 l mléka.**
Výsledná data dostupná v CSV formátu v souboru [q2_export_data]().
### 4.3 Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
