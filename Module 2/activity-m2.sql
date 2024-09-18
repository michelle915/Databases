


-- -----------------------------------------------------
-- Table structure for table `Customers`
-- -----------------------------------------------------
CREATE TABLE `Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(50) DEFAULT NULL,
  `AddressLine1` VARCHAR(50) DEFAULT NULL,
  `AddressLine2` VARCHAR(50) DEFAULT NULL,
  `City` VARCHAR(50) DEFAULT NULL,
  `State` VARCHAR(50) DEFAULT NULL,
  `PostalCode` VARCHAR(50) DEFAULT NULL,
  `YTDPurchases` DECIMAL(19, 2) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
);

INSERT INTO `Customers` (`CustomerID`, `CustomerName`, `AddressLine1`, `AddressLine2`, `City`, `State`, `PostalCode`, `YTDPurchases`)
VALUES
(1, 'Bike World', '60025 Bollinger Canyon Road', NULL, 'San Ramon', 'California', '94583', NULL),
(2, 'Metro Sports', '482505 Warm Springs Blvd.', NULL, 'Fremont', 'California', '94536', NULL),
(3, 'Loya Fencing', '123 Road', NULL, 'Some City', 'Texas', '12345', NULL);

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table structure for table `Invoices`
-- -----------------------------------------------------
CREATE TABLE `Invoices` (
  `InvoiceID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT DEFAULT NULL,
  `InvoiceDate` DATETIME DEFAULT NULL,
  `TermsCodeID` VARCHAR(50) DEFAULT NULL,
  `TotalDue` DECIMAL(19, 2) DEFAULT NULL,
  PRIMARY KEY (`InvoiceID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `TermsCodeID` (`TermsCodeID`),
  CONSTRAINT `Invoices_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`),
  CONSTRAINT `Invoices_ibfk_2` FOREIGN KEY (`TermsCodeID`) REFERENCES `TermsCode` (`TermsCodeID`)
);

INSERT INTO `Invoices` (`InvoiceID`, `CustomerID`, `InvoiceDate`, `TermsCodeID`, `TotalDue`)
VALUES
(1, 2, '2014-02-07 00:00:00', 'NET30', 2388.98),
(2, 1, '2014-02-02 00:00:00', '210NET30', 2443.35),
(3, 1, '2014-02-09 00:00:00', 'NET30', 8752.32);

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table structure for table `TermsCode`
-- -----------------------------------------------------
CREATE TABLE `TermsCode` (
  `TermsCodeID` VARCHAR(50) NOT NULL,
  `Description` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`TermsCodeID`)
);

INSERT INTO `TermsCode` (`TermsCodeID`, `Description`)
VALUES
('210NET30', '2% discount in 10 days Net 30'),
('NET15', 'Payment due in 15 days.'),
('NET30', 'Payment due in 30 days.');
