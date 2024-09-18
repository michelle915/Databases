--
-- Database: `Loya Fencing`
--

-- --------------------------------------------------------

--
-- Table structure for table `Contractors`
--

CREATE TABLE `Contractors` (
  `ContractorID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `CompanyName` varchar(70) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(320) NOT NULL,
  `Rating` enum('A','B','C','D','F','-') DEFAULT '-',
  `TotalJobsCompleted` int(11) DEFAULT 0
);

--
-- Dumping data for table `Contractors`
--

INSERT INTO `Contractors` (`ContractorID`, `CompanyName`, `Phone`, `Email`, `Rating`, `TotalJobsCompleted`) VALUES
(1, 'ABC Constructions', '5555555555', 'abc@constructions.com', 'A', 20),
(2, 'DEF Builders', '6666666666', 'def@builders.com', 'B', 5),
(3, 'GHI Industries', '7777777777', 'ghi@industries.com', 'C', 15);

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `CustomerID` int(11) NOT NULL,
  `Name` varchar(70) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(320) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `PreviousPurchases` int(11) DEFAULT 0
);

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`CustomerID`, `Name`, `Phone`, `Email`, `Address`, `PreviousPurchases`) VALUES
(1, 'Bobby Bob', '2222222222', 'bobby@gmail.com', '123 Road St.', 3),
(2, 'Bobert Bobby', '3333333333', 'bobert@gmail.com', '456 Road St.', 2),
(3, 'Bob Bobert', '4444444444', 'bob@gmail.com', '789 Road St.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Fences`
--

CREATE TABLE `Fences` (
  `FenceID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Description` varchar(255) NOT NULL,
  `ListPricePerMeter` decimal(19,2) NOT NULL
);

--
-- Dumping data for table `Fences`
--

INSERT INTO `Fences` (`FenceID`, `Description`, `ListPricePerMeter`) VALUES
(1, 'Standard Chain Link', 30.00),
(2, 'Redwood Picket', 45.00),
(3, 'Wrought Iron', 90.00);

-- --------------------------------------------------------

--
-- Table structure for table `Salesmen`
--

CREATE TABLE `Salesmen` (
  `SalesmanID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(70) NOT NULL,
  `NumberOfSales` int(11) DEFAULT 0,
  `Rating` enum('A','B','C','D','F','-') DEFAULT '-'
);


--
-- Dumping data for table `Salesmen`
--

INSERT INTO `Salesmen` (`SalesmanID`, `Name`, `NumberOfSales`, `Rating`) VALUES
(1, 'Molly Mollert', 5, 'B'),
(2, 'Mitch Mitchard', 10, 'C'),
(3, 'Milly Mill', 20, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `Invoices`
--

CREATE TABLE `Invoices` (
  `InvoiceID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `CustomerID` int(11) NOT NULL,
  `SalesmanID` int(11) NOT NULL,
  `ContractorID` int(11),
  `InvoiceDate` date NOT NULL,
  `TotalDue` decimal(19,2) NOT NULL,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (SalesmanID) REFERENCES Salesmen(SalesmanID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ContractorID) REFERENCES Contractors(ContractorID) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Dumping data for table `Invoices`
--

INSERT INTO `Invoices` (`InvoiceID`, `CustomerID`, `SalesmanID`, `ContractorID`, `InvoiceDate`, `TotalDue`) VALUES
(1, 1, 1, 1, '2023-01-01', 13500.00),
(2, 2, 2, 2, '2023-02-01', 5625.00),
(3, 3, 3, 3, '2023-03-01', 18000.00);

-- --------------------------------------------------------

--
-- Table structure for table `InvoiceDetails`
--

CREATE TABLE `InvoiceDetails` (
  `InvoiceDetailsID` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `InvoiceID` int(11) NOT NULL,
  `FenceID` int(11) NOT NULL,
  `MetersOrdered` float NOT NULL,
  `UnitPricePerMeter` decimal(19,2) NOT NULL,
  `LineTotal` decimal(19,2) NOT NULL,
  FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (FenceID) REFERENCES Fences(FenceID) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Dumping data for table `InvoiceDetails`
--

INSERT INTO `InvoiceDetails` (`InvoiceDetailsID`, `InvoiceID`, `FenceID`, `MetersOrdered`, `UnitPricePerMeter`, `LineTotal`) VALUES
(1, 1, 1, 150, 30.00, 4500.00),
(2, 1, 3, 100, 90.00, 9000.00),
(3, 2, 2, 125, 45.00, 5625.00),
(4, 3, 3, 200, 90.00, 18000.00);
