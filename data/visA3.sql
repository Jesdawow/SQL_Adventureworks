-- Query to get total sales by region for the last 12 months with average order value
SELECT
    CONCAT(st.Name, ' ', st.CountryRegionCode) AS Region,
    SUM(soh.TotalDue) AS TotalSales,
    COUNT(DISTINCT soh.SalesOrderID) AS Orders,
    SUM(soh.TotalDue) / NULLIF(COUNT(DISTINCT soh.SalesOrderID), 0) AS AvgOrderValue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st
    ON soh.TerritoryID = st.TerritoryID
WHERE soh.OrderDate >= DATEADD(
    MONTH, 
    -12, 
    DATEADD(
        MONTH, 
        DATEDIFF(MONTH,0,(SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)),0
    )
)
AND soh.OrderDate < DATEADD(
    MONTH, DATEDIFF(MONTH,0,(SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)), 0)
GROUP BY st.Name, st.CountryRegionCode
ORDER BY TotalSales DESC;