-- number of shaws and starkmarket
SELECT Store, COUNT(*)
FROM BI
GROUP BY Store

-- percentage of store could be schedule for each store brand
SELECT Availability, COUNT(*)
FROM BI
WHERE Store = 'Star Market'
GROUP BY Availability

SELECT Availability, COUNT(*)
FROM BI
WHERE Store = 'Shaws'
GROUP BY Availability

-- the schedule availability in each city
SELECT *, (x.Available_Count*1.00)/(x.Total_Count*1.00)*100 AS availability_rate
FROM
(SELECT City,
       SUM(CASE WHEN Availability LIKE '%Availability%' THEN 1 ELSE 0 END) AS Available_Count,
       COUNT(*) AS Total_Count
FROM BI
GROUP BY City) x
ORDER BY x.Available_Count/x.Total_Count DESC
