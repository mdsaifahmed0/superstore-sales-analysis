
CREATE DATABASE IF NOT EXISTS superstore;

USE superstore;

CREATE TABLE IF NOT EXISTS sales (
    Row_ID        INT PRIMARY KEY,
    Order_ID      VARCHAR(20),
    Order_Date    DATE,
    Ship_Date     DATE,
    Ship_Mode     VARCHAR(20),
    Customer_ID   VARCHAR(20),
    Customer_Name VARCHAR(50),
    Segment       VARCHAR(20),
    Country       VARCHAR(30),
    City          VARCHAR(30),
    State         VARCHAR(30),
    Postal_Code   INT,
    Region        VARCHAR(20),
    Product_ID    VARCHAR(20),
    Category      VARCHAR(20),
    Sub_Category  VARCHAR(20),
    Product_Name  VARCHAR(150),
    Sales         DECIMAL(10,2),
    Quantity      INT,
    Discount      DECIMAL(10,4),
    Profit        DECIMAL(10,2),
    Year          INT
);

-- 1. Overall Business KPIs
SELECT COUNT(*) FROM sales;


-- 1. Table Structure
describe sales;



-- 2. Overall Business KPIs
SELECT 
COUNT(DISTINCT Order_ID) AS total_orders,
COUNT(DISTINCT Customer_ID) AS total_customers,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit,
ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin_pct
FROM sales;




-- 3. Category-wise Sales & Profit Analysis

SELECT 
Category,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit,
ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin_pct
FROM sales
GROUP BY Category
ORDER BY total_sales DESC;


-- 4. Region-wise Sales & Profit Analysis

SELECT 
Region,
ROUND(SUM(sales) , 2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit
FROM sales
GROUP BY Region
ORDER BY total_sales DESC;


-- 5. Customer Segment Analysis

SELECT 
Segment,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit
FROM sales
GROUP BY Segment
ORDER BY total_sales DESC;


-- 6. Year-wise Sales Trend

SELECT
Year,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit
FROM sales
GROUP BY Year
ORDER BY total_sales DESC;



-- 7. Loss-making Sub-Categories

SELECT 
Sub_Category,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY Sub_Category
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;



-- 8. Top 10 Customers by Sales

SELECT 
Customer_Name,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY Customer_Name
ORDER BY total_sales DESC
LIMIT 10;


-- 9. Ship Mode Analysis

SELECT
Ship_Mode,
COUNT(*) AS total_orders,
ROUND(SUM(sales),2) AS total_sales
FROM sales
GROUP BY Ship_Mode
ORDER BY total_orders DESC;



-- 10. Top 5 States by Sales & Profit

SELECT 
State,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY State
ORDER BY total_sales DESC
LIMIT 5;



-- 11. Most Sold Sub-Categories by Quantity

SELECT
SUB_CATEGORY,
SUM(quantity) AS total_quantity,
ROUND(SUM(sales),2) AS total_sales
FROM sales
GROUP BY SUB_CATEGORY
ORDER BY total_quantity desc limit 5;



-- 12. Average Order Value
SELECT  ROUND(SUM(Sales)/COUNT(DISTINCT Order_ID), 2) AS avg_order_value FROM sales;

SELECT  ROUND(SUM(Sales)/COUNT(Order_ID), 2) AS avg_order_value FROM sales;


-- 13. Monthly Sales Trend (2014)
SELECT 
MONTH(Order_Date) AS month,
ROUND(SUM(Sales), 2) AS total_sales
FROM sales
WHERE Year = 2014
GROUP BY MONTH(Order_Date)
ORDER BY month;