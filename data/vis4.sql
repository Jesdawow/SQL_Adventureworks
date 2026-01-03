-- Query to retrieve total number of orders and total sales amount per year
SELECT
    YEAR(OrderDate) AS OrderYear,
    COUNT(*) AS OrderCount,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;