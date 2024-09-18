
-- -----------------------------------------------------
-- Query 1
--
-- Add a query to your activity-m3-1.sql that selects the columns ProductNumber, 
-- ProductName and ListPrice and sorts it by ListPrice in descending order (most expensive first).
-- -----------------------------------------------------

SELECT 
    ProductNumber, ProductName, ListPrice 
FROM 
    Products
ORDER BY 
    ListPrice DESC;
