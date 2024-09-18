--------------------------------------------------
--Basic CRUD operations for Loya Fencing database,
--variables are denoted by colons 
---------------------------------------------------

---------------------------------------
--CRUD operations for Contractors Table
----------------------------------------

--INSERT
INSERT INTO Contractors (CompanyName, Phone, Email, Rating, TotalJobsCompleted) 
VALUES (:companyName, :phone, :email, :rating, :totalJobsCompleted);

--READ
SELECT * FROM Contractors;

--DELETE
DELETE FROM Contractors WHERE ContractorID = contractorID;


-------------------------------------
--CRUD operations for Customers Table
-------------------------------------

--INSERT
INSERT INTO Customers (Name, Phone, Email, Address, PreviousPurchases) 
VALUES (:name, :phone, :email, :address, :previousPurchases);

--READ
SELECT * FROM Customers 

--DELETE
DELETE FROM Customers WHERE CustomerID = customerID;

----------------------------------
--CRUD operations for Fences Table
----------------------------------

--INSERT
INSERT INTO Fences (Description, ListPricePerMeter) VALUES (:description, :listPricePerMeter);

--READ
SELECT * FROM Fences;

--DELETE
DELETE FROM Fences WHERE FenceID = :fenceID;

------------------------------------
--CRUD operations for Salesmen Table
------------------------------------

--INSERT
INSERT INTO Salesmen (Name, NumberOfSales, Rating) VALUES (:name, :numberOfSales, :rating);

--READ
SELECT * FROM Salesmen;

--DELETE
DELETE FROM Salesmen WHERE SalesmanID = salesmanID;

------------------------------------
--CRUD operations for Invoices Table
------------------------------------

--INSERT
INSERT INTO Invoices (CustomerID, SalesmanID, ContractorID, InvoiceDate, TotalDue) 
VALUES (:customerID, :salesmanID, :contractorID, :invoiceDate, :totalDue);

--READ with JOINs to fetch names
SELECT 
    i.InvoiceID,
    c.Name AS CustomerName,
    s.Name AS SalesmanName,
    co.CompanyName AS ContractorName,
    i.InvoiceDate,
    COALESCE(SUM(id.LineTotal), 0) AS TotalDue
FROM 
    Invoices i
JOIN 
    Customers c ON i.CustomerID = c.CustomerID
JOIN 
    Salesmen s ON i.SalesmanID = s.SalesmanID
LEFT JOIN 
    Contractors co ON i.ContractorID = co.ContractorID
LEFT JOIN 
    InvoiceDetails id ON i.InvoiceID = id.InvoiceID
GROUP BY 
    i.InvoiceID,
    c.Name,
    s.Name,
    co.CompanyName,
    i.InvoiceDate;

--ADDITIONAL FETCHES FOR DROPDOWNS
SELECT * FROM Customers;
SELECT * FROM Salesmen;
SELECT * FROM Contractors;

--UPDATE
UPDATE Invoices 
SET CustomerID = :customerID, SalesmanID = :salesmanID, ContractorID = :contractorID, InvoiceDate = :invoiceDate, TotalDue = :totalDue
WHERE InvoiceID = invoiceID;

--DELETE
DELETE FROM Invoices WHERE InvoiceID = invoiceID;

-------------------------------------------
--CRUD operations for InvoicesDetails Table
-------------------------------------------

--INSERT
INSERT INTO InvoiceDetails (InvoiceID, FenceID, MetersOrdered, UnitPricePerMeter, LineTotal) 
VALUES (:invoiceID, :fenceID, :metersOrdered, :unitPricePerMeter, :lineTotal);

--READ
SELECT
    InvoiceDetails.InvoiceDetailsID, InvoiceDetails.InvoiceID, InvoiceDetails.FenceID, 
    Fences.Description, InvoiceDetails.MetersOrdered, InvoiceDetails.UnitPricePerMeter, 
    InvoiceDetails.LineTotal
FROM InvoiceDetails
LEFT JOIN Fences ON InvoiceDetails.FenceID = Fences.FenceID

--ADDITIONAL FETCHES FOR DROPDOWNS
SELECT InvoiceID FROM Invoices
SELECT FenceID, Description FROM Fences
