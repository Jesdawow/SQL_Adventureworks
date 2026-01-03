-- Query to retrieve total sales and unique customers per sales territory
SELECT
    CONCAT(st.Name, ' ', st.CountryRegionCode) AS Region,
    SUM(soh.TotalDue) AS TotalSales,
    COUNT(DISTINCT soh.CustomerID) AS UniqueCustomers
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c
    ON soh.CustomerID = c.CustomerID
JOIN Sales.SalesTerritory st
    ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name, st.CountryRegionCode
ORDER BY TotalSales DESC;