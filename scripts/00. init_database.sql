/*
==============================================================================
Database Initialization
==============================================================================

Purpose:
    Create the DataWarehouse database, configure the required schema,
    create the dimension and fact tables, and load data from CSV files.

Objectives:
    1. Recreate the database from scratch.
    2. Create the Gold schema.
    3. Create dimension and fact tables.
    4. Load source data into the warehouse using BULK INSERT.

Database Objects:
    - Database : DataWarehouse
    - Schema   : gold
    - Tables
        • dim_customers
        • dim_products
        • fact_sales

==============================================================================
WARNING
------------------------------------------------------------------------------
Running this script will:

    • Drop the existing DataWarehouse database (if it exists)
    • Permanently delete all stored data
    • Recreate the database from scratch

Execute only in a development or testing environment, or ensure proper
backups are available before proceeding.
==============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Create Database
-------------------------------------------------------------------------------

USE master;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    ALTER DATABASE DataWarehouse
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-------------------------------------------------------------------------------
-- 2. Create Gold Schema
-------------------------------------------------------------------------------

CREATE SCHEMA gold;
GO

-------------------------------------------------------------------------------
-- 3. Create Customer Dimension
-------------------------------------------------------------------------------

CREATE TABLE gold.dim_customers
(
    customer_key       INT,
    customer_id        INT,
    customer_number    NVARCHAR(50),
    first_name         NVARCHAR(50),
    last_name          NVARCHAR(50),
    country            NVARCHAR(50),
    marital_status     NVARCHAR(50),
    gender             NVARCHAR(50),
    birth_date         DATE,
    create_date        DATE
);
GO

-------------------------------------------------------------------------------
-- 4. Create Product Dimension
-------------------------------------------------------------------------------

CREATE TABLE gold.dim_products
(
    product_key        INT,
    product_id         INT,
    product_number     NVARCHAR(50),
    product_name       NVARCHAR(50),
    category_id        NVARCHAR(50),
    category           NVARCHAR(50),
    subcategory        NVARCHAR(50),
    maintenance        NVARCHAR(50),
    product_cost       INT,
    product_line       NVARCHAR(50),
    start_date         DATE
);
GO

-------------------------------------------------------------------------------
-- 5. Create Sales Fact Table
-------------------------------------------------------------------------------

CREATE TABLE gold.fact_sales
(
    order_number       NVARCHAR(50),
    product_key        INT,
    customer_key       INT,
    order_date         DATE,
    shipping_date      DATE,
    due_date           DATE,
    sales_amount       INT,
    quantity           TINYINT,
    price              INT
);
GO

-------------------------------------------------------------------------------
-- 6. Load Customer Dimension
-------------------------------------------------------------------------------

TRUNCATE TABLE gold.dim_customers;
GO

BULK INSERT gold.dim_customers
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_customers.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

-------------------------------------------------------------------------------
-- 7. Load Product Dimension
-------------------------------------------------------------------------------

TRUNCATE TABLE gold.dim_products;
GO

BULK INSERT gold.dim_products
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_products.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

-------------------------------------------------------------------------------
-- 8. Load Sales Fact Table
-------------------------------------------------------------------------------

TRUNCATE TABLE gold.fact_sales;
GO

BULK INSERT gold.fact_sales
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.fact_sales.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

-------------------------------------------------------------------------------
-- Database initialization completed successfully.
-------------------------------------------------------------------------------