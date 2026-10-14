CREATE DATABASE ECommerceDB;
USE ECommerceDB;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNo VARCHAR(15) UNIQUE
);

CREATE TABLE Seller (
    SellerID INT PRIMARY KEY,
    SellerName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNo VARCHAR(15) UNIQUE
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CategoryID INT,
    SellerID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE SET NULL,
    FOREIGN KEY (SellerID) REFERENCES Seller(SellerID) ON DELETE SET NULL
);

CREATE TABLE `Order` (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE SET NULL
);

CREATE TABLE Address (
    CustomerID INT,
    AddressID INT,
    DoorNo VARCHAR(20) NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Pincode VARCHAR(10) NOT NULL,
    PRIMARY KEY (CustomerID, AddressID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

CREATE TABLE OrderItem (
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID) ON DELETE CASCADE
);

CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    Status VARCHAR(30) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID) ON DELETE CASCADE
);

-- Sample Data
INSERT INTO Customer VALUES
(1, 'Aditya', 'Singh', 'adityas@gmail.com', '987654321');

INSERT INTO Seller VALUES
(101, 'Tech Store', 'techstore@gmail.com', '9000000001');

INSERT INTO Category VALUES
(201, 'Electronics');

INSERT INTO Product VALUES
(301, 'Laptop', 55000.00, 201, 101);

INSERT INTO `Order` VALUES
(401, 1, '2026-08-16');

INSERT INTO Address VALUES
(1, 1, '12A', 'MG Road', 'Kanpur', 'Uttar Pradesh', '208001');

INSERT INTO OrderItem VALUES
(401, 301, 1, 55000.00);

INSERT INTO Payment VALUES
(501, 401, 54000.00, 'UPI');

INSERT INTO Delivery VALUES
(601, 401, 'Shipped');

-- Referential Integrity Violation
-- CustomerID 999 does not exist in Customer.
INSERT INTO `Order` VALUES (403, 999, '2026-08-16');

-- Expected output:
-- ERROR 1452 (23000): Cannot add or update a child row:
-- a foreign key constraint fails
