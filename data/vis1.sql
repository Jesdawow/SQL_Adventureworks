--- Query to count the number of products in each product category
SELECT
    pc.Name AS CategoryName,
    COUNT(DISTINCT p.ProductID) AS TotalProducts
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory psc
    ON pc.ProductCategoryID = psc.ProductCategoryID
JOIN Production.Product p
    ON psc.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name
ORDER BY TotalProducts DESC;