/*
==============================================================================
Product Report
==============================================================================

Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential product information such as product name, category,
       subcategory, and cost.
    2. Segments products by revenue into High-Performers, Mid-Range, and
       Low-Performers.
    3. Aggregates product-level metrics, including:
        - Total orders
        - Total sales
        - Total quantity sold
        - Total unique customers
        - Product lifespan (in months)
    4. Calculates key performance indicators (KPIs):
        - Recency (months since last sale)
        - Average order revenue (AOR)
        - Average monthly revenue

==============================================================================
*/

WITH base_query AS(
/*----------------------------------------------------------------------------
1) Base Query
   - Retrieves sales transactions along with product information.
   - Excludes records with NULL order dates.
----------------------------------------------------------------------------*/
SELECT
    fs.order_number,
    fs.order_date,
    fs.customer_key,
    fs.sales_amount,
    fs.quantity,

    p.product_key,
    p.product_name,
    p.category,
    p.subcategory,
    p.product_cost
FROM gold.fact_sales fs
LEFT JOIN gold.dim_products p
ON        fs.product_key = p.product_key
WHERE fs.order_date IS NOT NULL
),

product_aggregation AS (
/*----------------------------------------------------------------------------
2) Product Aggregation
   - Summarizes product performance metrics.
----------------------------------------------------------------------------*/
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    product_cost,

    MIN(order_date) AS first_sale,
    MAX(order_date) AS last_sale,
    DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
    COUNT(DISTINCT order_number) AS total_orders,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
    ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity,0)),1) AS avg_selling_price

FROM base_query
GROUP BY 
    product_key,
    product_name,
    category,
    subcategory,
    product_cost
),

product_segment AS (
/*----------------------------------------------------------------------------
3) Product Segmentation
   - Dynamically segments products based on revenue ranking.
   - Top 20%      -> High Performer
   - Middle 30%   -> Mid Range
   - Bottom 50%   -> Low Performer
----------------------------------------------------------------------------*/
SELECT 
    *,
    CASE
        WHEN PERCENT_RANK() OVER (ORDER BY total_sales DESC) <= 0.20
            THEN 'High Performer'
        WHEN PERCENT_RANK() OVER (ORDER BY total_sales DESC) <= 0.50
            THEN 'Mid Range'
        ELSE 'Low Performer'
    END AS product_segment
FROM product_aggregation
)


/*----------------------------------------------------------------------------
4) Final Report
   - Returns product metrics, KPIs, and performance segments.
----------------------------------------------------------------------------*/
SELECT
  product_key,
  product_name,
  category,
  subcategory,
  product_cost,
  
  first_sale,
  last_sale,

  -- Month since the most recent sale
  DATEDIFF(month, last_sale, GETDATE()) AS recency_in_months,

  total_orders,
  total_sales,  
  total_quantity,
  total_customers,
  lifespan,
  avg_selling_price,
  
  --Average Monthly Revenue
    ROUND(
        CASE
            WHEN lifespan = 0 THEN total_sales
            ELSE CAST(total_sales AS FLOAT) / lifespan
        END,
        2
    ) AS avg_monthly_revenue

FROM product_segment

