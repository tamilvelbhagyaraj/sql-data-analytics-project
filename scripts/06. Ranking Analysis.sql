/*
==============================================================================
Ranking Analysis
==============================================================================

Purpose:
    Rank business entities based on key performance metrics to identify
    top and bottom performers across products and customers.

Objectives:
    1. Identify the highest and lowest revenue-generating products.
    2. Identify the highest revenue-generating customers.
    3. Find customers with the fewest orders.
    4. Demonstrate different ranking techniques using TOP and
       SQL Server window functions.

Tables Used:
    - gold.fact_sales
    - gold.dim_products
    - gold.dim_customers

SQL Concepts Used:
    - TOP
    - RANK()
    - GROUP BY
    - ORDER BY
    - Window Functions

==============================================================================
*/

USE DataWarehouse
GO
-------------------------------------------------------------------------------
-- 1. Top 5 Revenue-Generating Products
--
-- Retrieves the five products that generated the highest total revenue.
-- Uses the TOP clause for a simple ranking approach.
-------------------------------------------------------------------------------

SELECT TOP (5)
    dp.product_name,
    SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
INNER JOIN gold.dim_products AS dp
    ON fs.product_key = dp.product_key
GROUP BY
    dp.product_name
ORDER BY
    total_revenue DESC;

-------------------------------------------------------------------------------
-- 2. Top 5 Revenue-Generating Products (Window Function)
--
-- Produces the same result using the RANK() window function.
-- This approach is more flexible because it allows filtering,
-- partitioning, and handling ties.
-------------------------------------------------------------------------------

WITH product_ranking AS (
    SELECT
        dp.product_name,
        SUM(fs.sales_amount) AS total_revenue,
        RANK() OVER (
            ORDER BY SUM(fs.sales_amount) DESC
        ) AS product_rank
    FROM gold.fact_sales AS fs
    INNER JOIN gold.dim_products AS dp
        ON fs.product_key = dp.product_key
    GROUP BY
        dp.product_name
)

SELECT
    product_name,
    total_revenue,
    product_rank
FROM product_ranking
WHERE product_rank <= 5
ORDER BY
    product_rank;

-------------------------------------------------------------------------------
-- 3. Bottom 5 Revenue-Generating Products
--
-- Retrieves the five products generating the lowest revenue.
-------------------------------------------------------------------------------

SELECT TOP (5)
    dp.product_name,
    SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
INNER JOIN gold.dim_products AS dp
    ON fs.product_key = dp.product_key
GROUP BY
    dp.product_name
ORDER BY
    total_revenue ASC;

-------------------------------------------------------------------------------
-- 4. Top 10 Revenue-Generating Customers
--
-- Identifies customers who have generated the highest lifetime revenue.
-------------------------------------------------------------------------------

SELECT TOP (10)
    dc.customer_key,
    CONCAT(dc.first_name, ' ', dc.last_name) AS customer_name,
    SUM(fs.sales_amount) AS total_revenue
FROM gold.fact_sales AS fs
INNER JOIN gold.dim_customers AS dc
    ON fs.customer_key = dc.customer_key
GROUP BY
    dc.customer_key,
    dc.first_name,
    dc.last_name
ORDER BY
    total_revenue DESC;

-------------------------------------------------------------------------------
-- 5. Customers with the Fewest Orders
--
-- Identifies customers with the lowest purchase frequency based on the
-- number of distinct orders placed.
-------------------------------------------------------------------------------

SELECT TOP (3)
    dc.customer_key,
    CONCAT(dc.first_name, ' ', dc.last_name) AS customer_name,
    COUNT(DISTINCT fs.order_number) AS total_orders
FROM gold.fact_sales AS fs
INNER JOIN gold.dim_customers AS dc
    ON fs.customer_key = dc.customer_key
GROUP BY
    dc.customer_key,
    dc.first_name,
    dc.last_name
ORDER BY
    total_orders ASC;

-------------------------------------------------------------------------------
-- End of Ranking Analysis
-------------------------------------------------------------------------------