SELECT
    pc.Name AS Category,
    COUNT(DISTINCT p.ProductID) AS product_count
FROM Production.ProductCategory pc
JOIN Production.ProductSubcategory psc
    ON pc.ProductCategoryID = psc.ProductCategoryID
JOIN Production.Product p
    ON psc.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name
ORDER BY product_count DESC;