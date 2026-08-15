/*
==============================================================================
Cumulative Analysis
==============================================================================

Purpose:
    Analyze cumulative business performance over time using window functions.
    This analysis helps track long-term growth trends by calculating running
    totals and moving averages.

Objectives:
    1. Calculate total sales for each time period.
    2. Compute cumulative (running) sales over time.
    3. Calculate the moving average of product prices.
    4. Demonstrate the use of SQL window functions for time-series analysis.

Table Used:
    - gold.fact_sales

SQL Concepts Used:
    - Common Table Expressions (CTEs)
    - Window Functions
        • SUM() OVER()
        • AVG() OVER()
    - DATETRUNC()
    - ORDER BY

==============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Annual Sales Performance
--
-- Aggregates yearly sales and average selling price.
-------------------------------------------------------------------------------

WITH yearly_sales AS
(
    SELECT
        DATETRUNC(YEAR, order_date) AS order_year,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS average_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY
        DATETRUNC(YEAR, order_date)
)

-------------------------------------------------------------------------------
-- 2. Running Total & Moving Average
--
-- Calculates:
--   • Running Total Sales
--   • Moving Average Selling Price
--
-- Window functions accumulate values based on the chronological order
-- of the sales periods.
-------------------------------------------------------------------------------

SELECT
    order_year,
    total_sales,

    SUM(total_sales) OVER (
        ORDER BY order_year
    ) AS running_total_sales,

    ROUND(
        AVG(average_price) OVER (
            ORDER BY order_year
        ),
        2
    ) AS moving_average_price

FROM yearly_sales
ORDER BY
    order_year;

-------------------------------------------------------------------------------
-- End of Cumulative Analysis
-------------------------------------------------------------------------------