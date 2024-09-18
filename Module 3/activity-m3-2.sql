
-- -----------------------------------------------------
-- Query 2
--
-- Add a query to your activity-m3-2.sql that selects the columns InvoiceDetails.InvoiceID, 
-- Products.ProductName and InvoiceDetails.UnitPrice and sorts it in ASCending order by UnitPrice where the InvoiceID = 3.
--
-- Hint: InvoiceDetails contains ProductNumber, not ProductName, but there's a way to join the two. What do the two tables have in common?
-- -----------------------------------------------------

SELECT 
    InvoiceDetails.InvoiceID, InvoiceDetails.UnitPrice, Products.ProductName
FROM 
    InvoiceDetails
INNER JOIN 
    Products ON InvoiceDetails.ProductNumber = Products.ProductNumber
WHERE 
    InvoiceDetails.InvoiceID = 3
ORDER BY 
    InvoiceDetails.UnitPrice ASC;
