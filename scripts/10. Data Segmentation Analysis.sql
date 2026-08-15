/*
==============================================================================
Data Segmentation Analysis
==============================================================================

Purpose:
    Group business entities into meaningful segments based on predefined
    business rules. Segmentation enables targeted analysis, customer profiling,
    and product categorization for better business decision-making.

Objectives:
    1. Categorize products based on their product_cost.
    2. Segment customers according to purchasing behavior.
    3. Summarize the number of entities within each segment.
    4. Demonstrate the use of CASE expressions for business classification.

Tables Used:
    - gold.dim_products
    - gold.fact_sales
    - gold.dim_customers

SQL Concepts Used:
    - Common Table Expressions (CTEs)
    - CASE
    - GROUP BY
    - COUNT()
    - SUM()
    - MIN()
    - MAX()
    - DATEDIFF()

==============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Product product_cost Segmentation
--
-- Groups products into predefined product_cost ranges and counts the number of
-- products within each segment.
-------------------------------------------------------------------------------

WITH product_segments AS
(
    SELECT
        product_key,
        product_name,
        product_cost,

        CASE
            WHEN product_cost < 100 THEN 'Below 100'
            WHEN product_cost BETWEEN 100 AND 500 THEN '100 - 500'
            WHEN product_cost BETWEEN 500 AND 1000 THEN '500 - 1000'
            ELSE 'Above 1000'
        END AS product_cost_range

    FROM gold.dim_products
)

SELECT
    product_cost_range,
    COUNT(*) AS total_products
FROM product_segments
GROUP BY
    product_cost_range
ORDER BY
    total_products DESC;

-------------------------------------------------------------------------------
-- 2. Customer Segmentation
--
-- Segments customers based on purchasing behavior.
--
-- Business Rules:
--   • VIP      : Customer tenure >= 12 months and spending > €5,000
--   • Regular  : Customer tenure >= 12 months and spending <= €5,000
--   • New      : Customer tenure < 12 months
-------------------------------------------------------------------------------

WITH customer_summary AS
(
    SELECT
        dc.customer_key,

        SUM(fs.sales_amount) AS total_spending,

        MIN(fs.order_date) AS first_order,

        MAX(fs.order_date) AS last_order,

        DATEDIFF(
            MONTH,
            MIN(fs.order_date),
            MAX(fs.order_date)
        ) AS customer_tenure

    FROM gold.fact_sales AS fs
    INNER JOIN gold.dim_customers AS dc
        ON fs.customer_key = dc.customer_key

    WHERE fs.order_date IS NOT NULL

    GROUP BY
        dc.customer_key
),

customer_segments AS
(
    SELECT
        customer_key,

        CASE
            WHEN customer_tenure >= 12
                 AND total_spending > 5000
                THEN 'VIP'

            WHEN customer_tenure >= 12
                THEN 'Regular'

            ELSE 'New'
        END AS customer_segment

    FROM customer_summary
)

SELECT
    customer_segment,
    COUNT(*) AS total_customers
FROM customer_segments
GROUP BY
    customer_segment
ORDER BY
    total_customers DESC;

-------------------------------------------------------------------------------
-- End of Data Segmentation Analysis
-------------------------------------------------------------------------------