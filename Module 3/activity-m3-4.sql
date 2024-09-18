
-- -----------------------------------------------------
-- Query 4: 
-- 
-- Add a similar query to your activity-m3-4.sql but change the 
-- InvoiceID to 3, add the columns Customers.City and Customers.State between 
-- Customers.CustomerName and Date. Put this query into activity-m3-4.sql
-- 
-- EX: 
-- SELECT Invoices.InvoiceID, Customers.CustomerName, CURDATE() AS Date, Invoices.TotalDue
-- FROM Customers
-- INNER JOIN Invoices ON Customers.CustomerID = Invoices.CustomerID
-- WHERE Invoices.InvoiceID = 1;
-- -----------------------------------------------------

SELECT 
    Invoices.InvoiceID, Customers.CustomerName, Customers.City, Customers.State, CURDATE() AS Date, Invoices.TotalDue
FROM 
    Customers
INNER JOIN 
    Invoices ON Customers.CustomerID = Invoices.CustomerID
WHERE 
    Invoices.InvoiceID = 3;
