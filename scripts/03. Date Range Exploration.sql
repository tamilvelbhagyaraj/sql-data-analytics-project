/*
==============================================================================
Date Range Exploration
==============================================================================

Purpose:
    Analyze the temporal coverage of the dataset to understand the available
    historical period for sales transactions and customer information.

Objectives:
    1. Identify the earliest and latest sales transactions.
    2. Measure the duration of the sales history.
    3. Determine the age range of customers.
    4. Validate the completeness of date-related attributes.

Tables Used:
    - gold.fact_sales
    - gold.dim_customers

SQL Functions Used:
    - MIN()
    - MAX()
    - DATEDIFF()

==============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Sales Data Time Range
--
-- Retrieves the first and last order dates available in the sales dataset
-- and calculates the total duration of historical sales data in months.
-------------------------------------------------------------------------------

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(
        MONTH,
        MIN(order_date),
        MAX(order_date)
    ) AS sales_history_months
FROM gold.fact_sales;

-------------------------------------------------------------------------------
-- 2. Customer Age Range
--
-- Identifies the oldest and youngest customers based on their birth dates
-- and calculates their current ages.
-------------------------------------------------------------------------------

SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(
        YEAR,
        MIN(birthdate),
        GETDATE()
    ) AS oldest_customer_age,

    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(
        YEAR,
        MAX(birthdate),
        GETDATE()
    ) AS youngest_customer_age

FROM gold.dim_customers;