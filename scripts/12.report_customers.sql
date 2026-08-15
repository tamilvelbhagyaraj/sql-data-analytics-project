/* 
==============================================================================
Customer Report
==============================================================================

Purpose:
    - This report consolidates key customer metrics and behaviors.

Highlights:
    1. Gathers essential customer information such as names, ages, and
       transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics, including:
        - Total orders
        - Total sales
        - Total quantity purchased
        - Total products purchased
        - Customer lifespan (in months)
    4. Calculates key performance indicators (KPIs):
        - Recency (months since last order)
        - Average order value (AOV)
        - Average monthly spend

==============================================================================
*/

USE DataWarehouse
GO

CREATE OR ALTER VIEW gold.report_customers AS

WITH base_query AS (
/*----------------------------------------------------------------------------
1) Base Query
   - Retrieves transactional and customer information.
   - Joins sales with customer details.
   - Excludes records with NULL order dates.
----------------------------------------------------------------------------*/
    SELECT
        fs.order_number,
        fs.product_key,
        fs.order_date,
        fs.sales_amount,
        fs.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(YEAR, c.birth_date, GETDATE()) AS age
    FROM gold.fact_sales AS fs
    LEFT JOIN gold.dim_customers AS c
        ON fs.customer_key = c.customer_key
    WHERE fs.order_date IS NOT NULL
),

customer_aggregation AS (
/*----------------------------------------------------------------------------
2) Customer Aggregation
   - Summarizes customer purchasing behavior.
   - Calculates customer-level sales and order metrics.
----------------------------------------------------------------------------*/
    SELECT
        customer_key,
        customer_number,
        customer_name,
        age,

        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount)            AS total_sales,
        SUM(quantity)                AS total_quantity,
        COUNT(DISTINCT product_key)  AS total_products,

        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,

        DATEDIFF(
            MONTH,
            MIN(order_date),
            MAX(order_date)
        ) AS lifespan

    FROM base_query
    GROUP BY
        customer_key,
        customer_number,
        customer_name,
        age
)

/*----------------------------------------------------------------------------
3) Final Report
   - Classifies customers into age groups and customer segments.
   - Calculates customer KPIs.
----------------------------------------------------------------------------*/
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,

    /* Age Group */
    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and Above'
    END AS age_group,

    /* Customer Segment */
    CASE
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,

    first_order,
    last_order,

    /* Months since the customer's most recent purchase */
    DATEDIFF(MONTH, last_order, GETDATE()) AS recency,

    total_orders,
    total_sales,
    total_quantity,
    total_products,
    lifespan,

    /* Average Order Value (AOV) */
    ISNULL(
        CAST(total_sales AS DECIMAL(18,2))
        / NULLIF(total_orders,0),
    0
    ) AS avg_order_value,

    /* Average Monthly Spend */
    ISNULL(
        CAST(total_sales AS DECIMAL(18,2))
        / NULLIF(lifespan,0),
    0
    ) AS avg_monthly_spend

FROM customer_aggregation;