--Q1. Read customers, normalize their attributes, and clean them:
 
-- Create a new table to store the normalized and cleaned customer data
CREATE TABLE Dim_Customer_Norm (
  CustomerID NUMBER PRIMARY KEY,
  FirstName  VARCHAR2(100),
  LastName   VARCHAR2(100),
  Address    VARCHAR2(100),
  ZIPCode    VARCHAR2(10),
  City       VARCHAR2(100)
);

-- Insert the normalized and cleaned customer data
INSERT INTO Dim_Customer_Norm (CustomerID, FirstName, LastName, Address, ZIPCode, City)
SELECT CustomerID, FirstName, LastName, Address, ZIPCode, City
FROM Customer;

--Q2. Detect duplicate customer tuples:

-- Create a new table to store the unique customer mappings to branches

CREATE TABLE Customer_Branch_Mapping (
  CustomerID NUMBER,
  BranchID   NUMBER,
  CONSTRAINT pk_customer_branch_mapping PRIMARY KEY (CustomerID, BranchID),
  CONSTRAINT fk_customer_branch_mapping_customer FOREIGN KEY (CustomerID) REFERENCES Dim_Customer_Norm (CustomerID),
  CONSTRAINT fk_customer_branch_mapping_branch FOREIGN KEY (BranchID) REFERENCES Dim_Branch (BranchID)
);

-- Insert the unique customer mappings to branches

INSERT INTO Customer_Branch_Mapping (CustomerID, BranchID)
SELECT DISTINCT CustomerID, BranchID
FROM Sale;

--Q3. Read products, normalize and clean their attributes:
-- Create a new table to store the normalized and cleaned product data
CREATE TABLE Dim_Product_Norm (
  ProductID   NUMBER PRIMARY KEY,
  ProductName VARCHAR2(100),
  CategoryID  NUMBER,
  CONSTRAINT fk_product_norm_category FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);

-- Insert the normalized and cleaned product data
INSERT INTO Dim_Product_Norm (ProductID, ProductName, CategoryID)
SELECT ProductID, ProductName, CategoryID
FROM Product;

--Q4. Calculate turnover (sales volume):
-- Create a new table to store the turnover data
CREATE TABLE Fact_Turnover (
  SaleID    NUMBER,
  Turnover  NUMBER,
  CONSTRAINT pk_fact_turnover PRIMARY KEY (SaleID),
  CONSTRAINT fk_fact_turnover_sale FOREIGN KEY (SaleID) REFERENCES Sale (SaleID)
);

-- Calculate and insert the turnover data
INSERT INTO Fact_Turnover (SaleID, Turnover)
SELECT SaleID, Quantity * Price -- Assuming there is a Price column in the Sale table
FROM Sale;

--Q5. Calculate the amount of sales in liters for the turnover calculation:

-- Create a new table to store the sales volume data in liters
CREATE TABLE Fact_Sales_Volume (
  SaleID   NUMBER,
  Volume   NUMBER,
  CONSTRAINT pk_fact_sales_volume PRIMARY KEY (SaleID),
  CONSTRAINT fk_fact_sales_volume_sale FOREIGN KEY (SaleID) REFERENCES Sale (SaleID)
);

-- Calculate and insert the sales volume data in liters
INSERT INTO Fact_Sales_Volume (SaleID, Volume)
SELECT SaleID, Quantity
FROM Sale;

--Q6. Determine the age groups of customers:

-- Create a new table to store the age group data
CREATE TABLE Dim_AgeGroup_Norm (
  AgeGroupID   NUMBER PRIMARY KEY,
  AgeGroupName VARCHAR2(20)
);

-- Insert the age group data based on the customer's date of birth
INSERT INTO Dim_AgeGroup_Norm (AgeGroupID, AgeGroupName)
SELECT CustomerID,
       CASE
         WHEN MONTHS_BETWEEN(SYSDATE, DateOfBirth) / 12 <= 15 THEN 'child'
         WHEN MONTHS_BETWEEN(SYSDATE, DateOfBirth) / 12 <= 19 THEN 'youngster'
         WHEN MONTHS_BETWEEN(SYSDATE, DateOfBirth) / 12 <= 29 THEN 'young adult'
         WHEN MONTHS_BETWEEN(SYSDATE, DateOfBirth) / 12 <= 49 THEN 'adult'
         ELSE 'old adult'
       END
FROM Customer;