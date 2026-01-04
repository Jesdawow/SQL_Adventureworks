-- Query to get total sales by region and product category for the last 12 months
WITH last_12_months AS(
    SELECT DATEADD(MONTH, DATEDIFF(MONTH,0,MAX(OrderDate)),0) AS max_month_start
    FROM Sales.SalesOrderHeader
)
SELECT
    CONCAT(st.Name, ' ', st.CountryRegionCode) AS Region,
    pc.Name AS Category,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh
    ON sod.SalesOrderID = soh.SalesOrderID
JOIN Sales.SalesTerritory st
    ON soh.TerritoryID = st.TerritoryID
JOIN Production.Product p
    ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
CROSS JOIN last_12_months lm
WHERE soh.OrderDate >= DATEADD(MONTH, -12, lm.max_month_start)
    AND soh.OrderDate < DATEADD(MONTH, 1, lm.max_month_start)
GROUP BY st.Name, st.CountryRegionCode, pc.Name;