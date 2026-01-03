-- Query to retrieve total sales amount by product category and sales territory
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
GROUP BY st.Name, st.CountryRegionCode, pc.Name;