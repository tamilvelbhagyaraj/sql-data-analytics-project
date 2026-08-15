/*
==============================================================================
Change Over Time Analysis
==============================================================================

Purpose:
    Analyze business performance over time by tracking key metrics across
    different time periods. This analysis helps identify growth trends,
    seasonality, and changes in customer purchasing behavior.

Objectives:
    1. Analyze monthly sales performance.
    2. Track customer acquisition and purchasing activity over time.
    3. Measure changes in sales volume.
    4. Compare different approaches for grouping date values.

Table Used:
    - gold.fact_sales

SQL Concepts Used:
    - YEAR()
    - MONTH()
    - DATETRUNC()
    - FORMAT()
    - SUM()
    - COUNT(DISTINCT)
    - GROUP BY
    - ORDER BY

==============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Monthly Sales Trend (YEAR & MONTH)
--
-- Aggregates business performance by year and month using the YEAR()
-- and MONTH() date functions.
--
-- Metrics:
--   • Total Sales
--   • Active Customers
--   • Total Quantity Sold
-------------------------------------------------------------------------------

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS active_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;

-------------------------------------------------------------------------------
-- 2. Monthly Sales Trend (DATETRUNC)
--
-- Groups sales data by the first day of each month using DATETRUNC().
-- This approach produces cleaner date values and is recommended for
-- reporting and visualization.
-------------------------------------------------------------------------------

SELECT
    DATETRUNC(MONTH, order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS active_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    DATETRUNC(MONTH, order_date)
ORDER BY
    order_month;

-------------------------------------------------------------------------------
-- 3. Monthly Sales Trend (FORMAT)
--
-- Formats the month as 'YYYY-MMM' (e.g., 2013-Jan) for presentation
-- purposes. This approach is useful for reporting but is generally less
-- efficient than DATETRUNC() because it converts dates to strings.
-------------------------------------------------------------------------------

SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS active_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    FORMAT(order_date, 'yyyy-MMM')
ORDER BY
    FORMAT(order_date, 'yyyy-MMM');

-------------------------------------------------------------------------------
-- End of Change Over Time Analysis
-------------------------------------------------------------------------------