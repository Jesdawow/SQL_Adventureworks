-- Query to retrieve total sales amount per month for each sales territory
SELECT
    CONCAT(st.Name, ' ', st.CountryRegionCode) AS Region,
    FORMAT(soh.OrderDate, 'yyyy-MM') AS OrderMonth,
    SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st
    ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name, st.CountryRegionCode, FORMAT(soh.OrderDate, 'yyyy-MM')
ORDER BY Region, OrderMonth;