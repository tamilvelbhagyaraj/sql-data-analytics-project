/*
==============================================================================
Dimensions Exploration
==============================================================================

Purpose:
    Explore the dimension tables to understand the descriptive attributes
    available for analysis. This step helps identify the business entities
    and their hierarchical relationships before performing analytical queries.

Objectives:
    1. Explore the geographical distribution of customers.
    2. Understand the product hierarchy.
    3. Identify the available dimensions for filtering and grouping data.
    4. Validate the uniqueness and consistency of dimension attributes.

Dimension Tables:
    - gold.dim_customers
    - gold.dim_products

SQL Concepts Used:
    - DISTINCT
    - ORDER BY

==============================================================================
*/

USE DataWarehouse
GO

-------------------------------------------------------------------------------
-- 1. Customer Geography
--
-- Retrieves the list of unique countries where customers are located.
-- This information can be used to understand the geographical coverage
-- of the business and support regional sales analysis.
-------------------------------------------------------------------------------

SELECT DISTINCT
    country
FROM gold.dim_customers
ORDER BY
    country;

-------------------------------------------------------------------------------
-- 2. Product Hierarchy
--
-- Retrieves the complete product hierarchy consisting of:
--   • Category
--   • Subcategory
--   • Product Name
--
-- This hierarchy is commonly used for product-level reporting,
-- category analysis, and drill-down dashboards.
-------------------------------------------------------------------------------

SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM gold.dim_products
ORDER BY
    category,
    subcategory,
    product_name;