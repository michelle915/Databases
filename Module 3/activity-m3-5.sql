
-- -----------------------------------------------------
-- Query 5: 
-- 
-- Create a final query for your last activity-m3-5.sql. From left to right, 
-- the columns that should appear are Products.ProductNumber, Products.ProductName, 
-- InvoiceDetails.LineTotal, InvoiceDetails.OrderQty, and InvoiceDetails.UnitPrice. 
-- The InvoiceID we want the details for is 3. Your results should be similar to the below. 
-- Nothing is ordered or grouped.
-- -----------------------------------------------------

SELECT
    Products.ProductNumber, Products.ProductName, InvoiceDetails.LineTotal, InvoiceDetails.OrderQty, InvoiceDetails.UnitPrice
FROM 
    InvoiceDetails
INNER JOIN 
    Products ON InvoiceDetails.ProductNumber = Products.ProductNumber
WHERE 
    InvoiceDetails.InvoiceID = 3;
