# Engeto projekt

- *Závěrečný projekt Engeto datové analýzy*
- *SQL, Excel, PowerBi*
---


# Obsah
  
- [Engeto projekt](#engeto-projekt)
- [Obsah](#obsah)
  - [1. Zadání projektu](#1-zadání-projektu)
    - [1.1 Primární tabulky](#11-primární-tabulky)
    - [1.2 Číselníky sdílených informací o ČR](#12-číselníky-sdílených-informací-o-čr)
    - [1.3 Dodatečné tabulky](#13-dodatečné-tabulky)
    - [1.4 Výzkumné otázky](#14-výzkumné-otázky)
    - [1.5 Výstup projektu](#15-výstup-projektu)
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

### 1.1 Primární tabulky
1. **czechia_payroll** – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
2. **czechia_payroll_calculation** – Číselník kalkulací v tabulce mezd.
3. **czechia_payroll_industry_branch** – Číselník odvětví v tabulce mezd.
4.** czechia_payroll_unit** – Číselník jednotek hodnot v tabulce mezd.
5. **czechia_payroll_value_type** – Číselník typů hodnot v tabulce mezd.
6. **czechia_price** – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
7. **czechia_price_category** – Číselník kategorií potravin, které se vyskytují v našem přehledu.
### 1.2 Číselníky sdílených informací o ČR
1. **czechia_region** – Číselník krajů České republiky dle normy CZ-NUTS 2.
2. **czechia_district** – Číselník okresů České republiky dle normy LAU.
### 1.3 Dodatečné tabulky
1.** countries** - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
2. **economies** - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
### 1.4 Výzkumné otázky
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
### 1.5 Výstup projektu
Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. 

Tabulky pojmenujte:
- ***t_{jmeno}_{prijmeni}_project_SQL_primary_final*** (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) 
- ***t_{jmeno}_{prijmeni}_project_SQL_secondary_final*** (pro dodatečná data o dalších evropských státech).

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

Na svém GitHub účtu vytvořte repozitář (může být soukromý), kam uložíte všechny informace k projektu – hlavně SQL skript generující výslednou tabulku, popis mezivýsledků (průvodní listinu) a informace o výstupních datech (například kde chybí hodnoty apod.).

## 2. Analýza jednotlivých tabulek
### 2.1 Primární tabulky
#### 2.1.1 Czechia_payroll
#### 2.1.2 Czechia_payroll_calculation
#### 2.1.3 Czechia_payroll_industry_branch
#### 2.1.4 Czechia_payroll_unit
#### 2.1.5 Czechia_payroll_value_type
#### 2.1.6 Czechia_price
#### 2.1.7 Czechia_price_category
### 2.2 Číselníky sdílených informací o ČR
#### 2.2.1 Czechia_region
#### 2.2.2 Czechia_district
### 2.3 Dodatečné tabulky
#### 2.3.1 Countries
#### 2.3.2 Economies
## 3. Tvorba primární finální a primární sekundární tabulky
### 3.1 Primární finální tabulka
### 3.2 Sekundární finální tabulka