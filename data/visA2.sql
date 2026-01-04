-- Query to retrieve total sales amount by month and sales territory for the last 12 months
WITH monthly_sales AS (
    SELECT
        CONCAT(st.Name, ' ', st.CountryRegionCode) AS Region,
        FORMAT(soh.OrderDate, 'yyyy-MM') AS OrderMonth,
        SUM(soh.TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesTerritory st
        ON soh.TerritoryID = st.TerritoryID
    WHERE soh.OrderDate >= DATEADD(
        MONTH, 
        -12, 
        (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)
    )
    GROUP BY
        CONCAT(st.Name, ' ', st.CountryRegionCode),
        FORMAT(soh.OrderDate, 'yyyy-MM')
)

SELECT *
FROM monthly_sales
ORDER BY Region, OrderMonth;

