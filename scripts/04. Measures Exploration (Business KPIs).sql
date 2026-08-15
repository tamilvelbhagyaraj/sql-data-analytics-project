/*
==============================================================================
Measures Exploration (Business KPIs)
==============================================================================

Purpose:
    Calculate key business metrics to provide a high-level overview of sales
    performance, customer activity, product inventory, and order volume.

Objectives:
    1. Calculate overall sales performance.
    2. Measure product demand and sales volume.
    3. Analyze customer and order activity.
    4. Generate a consolidated KPI summary for reporting.

Tables Used:
    - gold.fact_sales
    - gold.dim_products
    - gold.dim_customers

SQL Functions Used:
    - COUNT()
    - COUNT(DISTINCT)
    - SUM()
    - AVG()
    - UNION ALL

==============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Total Sales
--
-- Calculates the total revenue generated from all completed sales.
-------------------------------------------------------------------------------

SELECT
    SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-------------------------------------------------------------------------------
-- 2. Total Quantity Sold
--
-- Calculates the total number of product units sold.
-------------------------------------------------------------------------------

SELECT
    SUM(quantity) AS total_quantity
FROM gold.fact_sales;

-------------------------------------------------------------------------------
-- 3. Average Selling Price
--
-- Calculates the average selling price across all sales transactions.
-------------------------------------------------------------------------------

SELECT
    AVG(price) AS average_price
FROM gold.fact_sales;

-------------------------------------------------------------------------------
-- 4. Total Orders
--
-- Calculates both the total order records and the total number of
-- unique customer orders.
-------------------------------------------------------------------------------

-- Total Order Records

SELECT
    COUNT(order_number) AS total_order_records
FROM gold.fact_sales;

-- Unique Orders

SELECT
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;

-------------------------------------------------------------------------------
-- 5. Total Products
--
-- Calculates the total number of products available in the catalog.
-------------------------------------------------------------------------------

SELECT
    COUNT(*) AS total_products
FROM gold.dim_products;

-------------------------------------------------------------------------------
-- 6. Total Customers
--
-- Calculates the total number of registered customers.
-------------------------------------------------------------------------------

SELECT
    COUNT(*) AS total_customers
FROM gold.dim_customers;

-------------------------------------------------------------------------------
-- 7. Active Customers
--
-- Calculates the number of customers who have placed at least one order.
-------------------------------------------------------------------------------

SELECT
    COUNT(DISTINCT customer_key) AS active_customers
FROM gold.fact_sales;

-------------------------------------------------------------------------------
-- 8. Business KPI Dashboard
--
-- Generates a consolidated summary of key business metrics that can be
-- consumed by dashboards and executive reports.
-------------------------------------------------------------------------------

SELECT
    'Total Sales' AS metric_name,
    SUM(sales_amount) AS metric_value
FROM gold.fact_sales

UNION ALL

SELECT
    'Total Quantity',
    SUM(quantity)
FROM gold.fact_sales

UNION ALL

SELECT
    'Average Selling Price',
    AVG(price)
FROM gold.fact_sales

UNION ALL

SELECT
    'Total Orders',
    COUNT(DISTINCT order_number)
FROM gold.fact_sales

UNION ALL

SELECT
    'Total Products',
    COUNT(*)
FROM gold.dim_products

UNION ALL

SELECT
    'Registered Customers',
    COUNT(*)
FROM gold.dim_customers

UNION ALL

SELECT
    'Active Customers',
    COUNT(DISTINCT customer_key)
FROM gold.fact_sales;