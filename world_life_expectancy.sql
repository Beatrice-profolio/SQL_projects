SELECT *
FROM world_life_expectancy;

SELECT Country, Year, CONCAT(country, year), COUNT(CONCAT(country, year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(country, year)
HAVING COUNT(CONCAT(country, year)) >1;

SELECT *
FROM ( SELECT ROW_ID,
	   CONCAT(country, Year),
       ROW_NUMBER () OVER (Partition by CONCAT(country, year) ORDER BY CONCAT(country, year)) as Row_Num
	   FROM world_life_expectancy
       ) As ROW_TABLE
WHERE Row_Num > 1
;	

DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN(
    SELECT ROW_ID
FROM(
	SELECT ROW_ID,
    CONCAT(Country, Year),
    ROW_NUMBER () OVER (Partition by CONCAT(country, year) ORDER BY CONCAT(country, year)) as Row_Num
	   FROM world_life_expectancy
       ) As ROW_TABLE
WHERE ROW_Num > 1
)
;

SELECT DISTINCT (Status)
FROM world_life_expectancy
WHERE Status <> '';

SELECT DISTINCT (Country)
FROM world_life_expectancy
WHERE status = 'Developing'

UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT (Country)
				FROM world_life_expectancy
				WHERE status = 'Developing');

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	on t1.Country = t2.Country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing'
;

SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	on t1.Country = t2.Country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed'
;

SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = '';

SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
	   t2.Country, t2.Year, t2.`Life expectancy`,
       t3.Country, t3.Year, t3.`Life expectancy`,
       ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	On t1.Country = t2.Country
    AND t1.Year = t2.Year -1
JOIN world_life_expectancy t3
	On t1.Country = t3.Country
    AND t1.Year = t3.Year +1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year -1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year +1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

SELECT country, year, `Life expectancy`
FROM world_life_expectancy;


SELECT Country, 
	   Min(`Life expectancy`), 
       MAX(`Life expectancy`),
       ROUND(MAX(`Life expectancy`) - Min(`Life expectancy`),1) AS Difference
FROM world_life_expectancy
GROUP by Country
HAVING Min(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER by Difference DESC
;

SELECT YEAR, ROUND(AVG(`LIFE expectancy`),2)
FROM world_life_expectancy
GROUP BY Year
Having AVG(`LIFE expectancy`) <>0
ORDER BY Year;
ORDER BY Year
;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_EXP, ROUND(AVG(GDP),1) As GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_EXP<> 0
AND GDP<> 0
ORDER BY Life_EXP ASC
;

SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_COUNT,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE null END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_COUNT,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE null END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
ORDER BY GDP;

SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP by status;

SELECT Status, COUNT(Distinct Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP by status;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_EXP, ROUND(AVG(BMI),1) As BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_EXP<> 0
AND BMI<> 0
ORDER BY BMI ASC
;

SELECT*
FROM world_life_expectancy;

SELECT Country,
YEAR,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER (partition by country order by year) AS Rolling_Total_of_Adult_Mortality
FROM world_life_expectancy
WHERE Country LIKE '%United%';


