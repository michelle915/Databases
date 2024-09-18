
-- -----------------------------------------------------
-- Query 3: 
-- 
-- Add a query to your activity-m3-3.sql that selects the Customers.CustomerName, 
-- Invoices.InvoiceID, the sum of InvoiceDetails.LineTotal. Group the result set by InvoiceID 
-- and order the result set by the sum of LineTotal in descending order.
-- 
-- Hint: INNER JOIN will be required twice. Always keep in mind what the two tables you are joining have in common.
-- -----------------------------------------------------

SELECT
    Customers.CustomerName,
    Invoices.InvoiceID,
    SUM(InvoiceDetails.LineTotal) AS LineSum
FROM
    Customers
INNER JOIN
    Invoices ON Customers.CustomerID = Invoices.CustomerID
INNER JOIN
    InvoiceDetails ON Invoices.InvoiceID = InvoiceDetails.InvoiceID
GROUP BY
    Invoices.InvoiceID
ORDER BY
    LineSum DESC;
