SELECT*
FROM us_household_income;

SELECT*
FROM us_household_income_statistics;

ALTER TABLE us_household_income_statistics RENAME Column `ï»¿id` TO `id`;

SELECT count(id)
FROM us_household_income_statistics;

SELECT count(id)
FROM us_household_income;

Select id, count(id)
FROM us_household_income
GROUP BY id
Having COUNT(id) > 1
;

DELETE FROM us_household_income
WHERE row_id IN (
				SELECT row_id
				FROM (SELECT row_id,
							 id,
							 ROW_NUMBER() OVER (Partition by id ORDER BY id) AS row_num
					  FROM us_project.us_household_income
					  ) duplicates
WHERE row_num > 1)
;

Update us_household_income
SET State_Name = 'Georgia'
WHERE state_name = 'georia'
;

Update us_household_income
SET State_Name = 'Alabama'
WHERE state_name = 'alabama'
;

SELECT DISTINCT state_name
FROM us_household_income
ORDER BY 1;


SELECT *
FROM us_household_income
WHERE Place = 'Autaugaville'
AND City = 'Vinemont'
ORDER BY 1;

UPDATE us_household_income
SET place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY type;

UPDATE us_household_income
SET TYPE = 'Borough'
WHERE TYPE = 'Boroughs'
;

SELECT ALand, AWATER
FROM us_project.us_household_income
WHERE (AWATER = 0 OR AWATER = '' OR AWATER is NULL)
AND (ALand = 0 OR ALand = '' OR ALand is NULL);

SELECT State_Name, SUM(ALAND), SUM(AWATER)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10;

SELECT u.State_Name, ROUND(AVG(Mean),1), Round(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10;

SELECT u.State_Name, ROUND(AVG(Mean),1), Round(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 DESC
LIMIT 10;

SELECT TYPE, COUNT(TYPE), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
Having Count(Type) > 100
ORDER BY 3 DESC
LIMIT 20;

SELECT u.State_Name, City, ROUND(AVG(Mean),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.state_name, City
ORDER BY ROUND(AVG(Mean),1) DESC;