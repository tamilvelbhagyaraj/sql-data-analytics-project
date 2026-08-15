/*
==============================================================================
Performance Analysis
==============================================================================

Purpose:
    Evaluate product performance over time by comparing yearly sales against
    historical averages and previous-year performance. This analysis helps
    identify growth trends, performance fluctuations, and consistently
    high-performing products.

Objectives:
    1. Calculate annual sales for each product.
    2. Compare yearly sales with the product's average annual sales.
    3. Measure Year-over-Year (YoY) sales growth.
    4. Classify products based on sales performance trends.

Tables Used:
    - gold.fact_sales
    - gold.dim_products

SQL Concepts Used:
    - Common Table Expressions (CTEs)
    - Window Functions
        • AVG() OVER()
        • LAG()
    - CASE
    - YEAR()
    - GROUP BY

==============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Annual Product Sales
--
-- Aggregates yearly sales for each product.
-------------------------------------------------------------------------------

WITH yearly_product_sales AS
(
    SELECT
        YEAR(fs.order_date) AS order_year,
        dp.product_name,
        SUM(fs.sales_amount) AS current_sales
    FROM gold.fact_sales AS fs
    INNER JOIN gold.dim_products AS dp
        ON fs.product_key = dp.product_key
    WHERE fs.order_date IS NOT NULL
    GROUP BY
        YEAR(fs.order_date),
        dp.product_name
),

-------------------------------------------------------------------------------
-- 2. Performance Comparison
--
-- Computes:
--   • Average yearly sales for each product
--   • Previous year's sales
-------------------------------------------------------------------------------

performance_analysis AS
(
    SELECT
        order_year,
        product_name,
        current_sales,

        AVG(current_sales) OVER (
            PARTITION BY product_name
        ) AS average_sales,

        LAG(current_sales) OVER (
            PARTITION BY product_name
            ORDER BY order_year
        ) AS previous_year_sales

    FROM yearly_product_sales
)

-------------------------------------------------------------------------------
-- 3. Final Performance Report
--
-- Compares each year's sales against:
--   • Historical average sales
--   • Previous year's sales
-------------------------------------------------------------------------------

SELECT
    order_year,
    product_name,

    current_sales,

    average_sales,

    current_sales - average_sales AS difference_from_average,

    CASE
        WHEN current_sales > average_sales THEN 'Above Average'
        WHEN current_sales < average_sales THEN 'Below Average'
        ELSE 'Average'
    END AS average_performance,

    previous_year_sales,

    current_sales - previous_year_sales AS year_over_year_change,

    CASE
        WHEN previous_year_sales IS NULL THEN 'No Previous Year'
        WHEN current_sales > previous_year_sales THEN 'Increase'
        WHEN current_sales < previous_year_sales THEN 'Decrease'
        ELSE 'No Change'
    END AS year_over_year_trend

FROM performance_analysis

ORDER BY
    product_name,
    order_year;

-------------------------------------------------------------------------------
-- End of Performance Analysis
-------------------------------------------------------------------------------