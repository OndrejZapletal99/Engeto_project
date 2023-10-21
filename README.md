# Engeto projekt

- *Závěrečný projekt Engeto datové analýzy*
- *SQL, Excel, PowerBi*
---


# Obsah
  
- [Engeto projekt](#engeto-projekt)
- [Obsah](#obsah)
  - [1. Zadání projektu](#1-zadání-projektu)
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
  - [3. Tvorba primární finální a primární sekundární tabulky](#3-tvorba-primární-finální-a-primární-sekundární-tabulky)
    - [3.1 Primární finální tabulka](#31-primární-finální-tabulka)
    - [3.2 Sekundární finální tabulka](#32-sekundární-finální-tabulka)






## 1. Zadání projektu

Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

Tabulky pojmenujte:
- ***t_{jmeno}_{prijmeni}_project_SQL_primary_final*** (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) 
- ***t_{jmeno}_{prijmeni}_project_SQL_secondary_final*** (pro dodatečná data o dalších evropských státech).

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

Na svém GitHub účtu vytvořte repozitář (může být soukromý), kam uložíte všechny informace k projektu – hlavně SQL skript generující výslednou tabulku, popis mezivýsledků (průvodní listinu) a informace o výstupních datech (například kde chybí hodnoty apod.).

## 2. Analýza jednotlivých tabulek
Tato kapitola slouží k popisu a základní analýze jednotlivých tabulek dostupných v engeto databázi. Tyto tabulky následně slouží k vytvoření finální primární a sekundární tabulky.
Samotný popis a analýza jednotlivých tabulek bude prováděna pomocí průzkumu vlastností tabulek, ER diagramu a samotných dat. Průzkum dat bude proveden jak pomocí jednuchého pohledu na datovou tabulka, tak i pomocí základních SQL přikazů.
### 2.1 Primární tabulky
Primární tabulky jsou zdrojem dat pro finální primární tabulku tohoto projektu.
#### 2.1.1 Czechia_payroll
Tato tabulka obsahuje data týkajících o mzdách a počtu zaměstnaných v různých odvětvích průmyslu České republiky za různá sledovaná období.

Tato tabulka obsahuje osm sloupců, a to:
- **id** - id záznamu (primární klíč)
- **value** - hodnoty mezd nebo počtu osob
- **value_type_code** - kodové označení typu zaznamenané hodnoty (cizí klíč). Popsáno v podkapitole [2.1.5 Czechia\_payroll\_value\_type](#215-czechia_payroll_value_type)
- **unit_code** - kodové označení vyjadřované jednotky (cizí klíč). Popsanáno v podkapitole [2.1.4 Czechia\_payroll\_unit](#214-czechia_payroll_unit)
- **calculation_code** - kodové označení typu přepočtu pro jednotlivé záznamy(cizí klíč). Popsáno v podkapitole [2.1.2 Czechia\_payroll\_calculation](#212-czechia_payroll_calculation)
- **industry_branch_code** - kodové označení jednotlivých oblastí průmyslu České republiky (cizí klíč). Popsáné v kapitole [2.1.3 Czechia\_payroll\_industry\_branch](#213-czechia_payroll_industry_branch)
- **payroll_year** - roky, ke kterým jsou dané hodnoty přiřazeny
- **payroll_quarter** - čtvrteltí pro jednotlivé roky
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
> V tomto projektu nás bude zajímat kodové označení **200 **vyjadřující hodnotu české měny ("Kč")
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
1. Sloupce id, value, category_code, date_from a date_to nemají prázdné záznamy . Sloupec region_code obsahuje prázdné záznamy (hodnota NULL)
```
SELECT 
	value,
	category_code,
	date_from,
	date_to,
	region_code
FROM czechia_price 
WHERE 
	value IS NULL
	OR category_code IS NULL 
	OR date_from IS NULL
	OR date_to IS NULL
	OR region_code IS NULL;
```
1. V případě prázdných záznamů u sloupce regio_code se vždy jedná o průměrnou hodnoty(cenu) dané kategorie potravin za všechny kraje v daném sledovaném období
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
#### 2.1.7 Czechia_price_category
Tato tabulka obsahuje data o jednotlivých druzích potravin, jejich jednotce a hodnotě jednotky v jaké jsou zaznamenány, a také kod pro jednotlivé potraviny.

Tato tabulka obsahuje čtyři sloupce, a to:
- **code** - kody jednotlivých druhů potravin (primární klíč)
- **name** - názvy jedntnolivých druhů potravin
- **price_value** - hodnota jednotky pro daný druh potraviny, na kterou je vztažena cena potraviny
- **price_unit** - jednotka pro daný druh potraviny, na kterou je vztažena cena poraviny
### 2.2 Číselníky sdílených informací o ČR
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
#### 2.3.1 Countries
#### 2.3.2 Economies
## 3. Tvorba primární finální a primární sekundární tabulky
### 3.1 Primární finální tabulka
### 3.2 Sekundární finální tabulka