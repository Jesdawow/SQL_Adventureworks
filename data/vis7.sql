-- Query to calculate average order value and number of orders by region and customer type
WITH base AS (
    SELECT
        CONCAT(st.Name, ' ', st.CountryRegionCode) AS Region,
        soh.SalesOrderID,
        soh.TotalDue,
        CASE
            WHEN s.BusinessEntityID IS NOT NULL THEN 'Store'
            ELSE 'Individual'
        END AS CustomerType
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesTerritory st
        ON st.TerritoryID = soh.TerritoryID
    JOIN Sales.Customer c
        ON c.CustomerID = soh.CustomerID
    LEFT JOIN Sales.Store s
        ON s.BusinessEntityID = c.StoreID
)

SELECT
    Region,
    CustomerType,
    SUM(TotalDue) / NULLIF(COUNT(DISTINCT SalesOrderID), 0) AS AvgOrderValue,
    COUNT(DISTINCT SalesOrderID) AS Orders
FROM base
GROUP BY Region, CustomerType;