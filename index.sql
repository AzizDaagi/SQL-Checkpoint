CREATE TABLE Product
(
    Product_Id VARCHAR2(20) PRIMARY KEY,
    Product_Name VARCHAR2(20) NOT NULL,
    Price NUMBER CHECK (Price > 0)
);
CREATE TABLE Customer
(
    Customer_Id VARCHAR2(20) PRIMARY KEY,
    Customer_Name VARCHAR2(20) NOT NULL,
    Customer_Tel NUMBER
);
CREATE TABLE Orders
(
    Customer_Id VARCHAR2(20) FOREIGN KEY REFERENCES Customer(Customer_Id),
    Product_Id VARCHAR2(20) FOREIGN KEY REFERENCES Product(Product_Id),
    Quantity NUMBER,
    Total_amount NUMBER
);
ALTER TABLE Product
ADD Category VARCHAR2(20);

ALTER TABLE Orders
ADD OrderDate DATE DEFAULT SYSDATE;

INSERT INTO Product
    ( Product_Id, Product_Name, Category, Price )
VALUES
    ("P01", "Samsung Galaxy S20", "Smartphone", 3299),
    ("P02", "ASUS Notebook", "PC", 4599);

INSERT INTO Customer
    (Customer_Id, Customer_Name, Customer_Tel)
VALUES
    ("C01", "ALI", 71321009),
    ("C02", "ASMA", 77345823);

INSERT INTO Orders
    (Customer_Id, Product_Id, OrderDate, Quantity, Total_amount)
VALUES
    ("C01", "P02", NULL, 2, 9198),
    ("C02", "P01", "2020-05-28", 1, 3299);

SELECT * FROM Customer;

SELECT Product_Name, Category FROM Product WHERE Price BETWEEN 5000 and 10000;

SELECT * FROM Product ORDER BY Price DESC;

SELECT
    COUNT(*) AS total_orders,
    AVG(Total_amount) AS average_amount,
    MAX(Total_amount) AS highest_total_amount,
    MIN(Total_amount) AS lower_total_amount
FROM Orders;

SELECT Product_Id, COUNT(*) AS total_orders
FROM Orders
GROUP BY Product_Id;

SELECT Customer_Id
FROM Orders
GROUP BY Customer_Id
HAVING COUNT(*) > 2;

SELECT
    EXTRACT(MONTH FROM OrderDate) AS month,
    COUNT(*) AS total_orders
FROM Orders
WHERE EXTRACT(YEAR FROM OrderDate) = 2020
GROUP BY EXTRACT(MONTH FROM OrderDate);


SELECT o.Customer_Id, o.Product_Id, p.Product_Name, c.Customer_Name, o.OrderDate
FROM Orders o
    JOIN Product p ON o.Product_Id = p.Product_Id
    JOIN Customer c ON o.Customer_Id = c.Customer_Id;

SELECT *
FROM Orders
WHERE OrderDate = ADD_MONTHS(TRUNC(SYSDATE), -3);

SELECT c.Customer_Id
FROM Customer c
    LEFT JOIN Orders o ON c.Customer_Id = o.Customer_Id
WHERE o.Customer_Id IS NULL; 