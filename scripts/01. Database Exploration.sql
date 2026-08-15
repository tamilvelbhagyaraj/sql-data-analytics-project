/*
==============================================================================
Database Exploration
==============================================================================

Purpose:
    Explore the database structure to understand the available tables,
    schemas, and column metadata before performing data analysis.

Objectives:
    1. Identify all tables available in the database.
    2. Review table schemas and object types.
    3. Examine the structure of specific tables.
    4. Inspect column properties such as data types and nullability.

System Views Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS

==============================================================================
*/

-------------------------------------------------------------------------------
-- 1. Explore Database Tables
--
-- Retrieves a list of all tables and views available in the current database,
-- including their catalog, schema, and object type.
-------------------------------------------------------------------------------

SELECT
    TABLE_CATALOG,
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
ORDER BY
    TABLE_SCHEMA,
    TABLE_NAME;

-------------------------------------------------------------------------------
-- 2. Explore Table Structure
--
-- Displays the metadata for the 'dim_customers' table, including:
--   • Column names
--   • Data types
--   • Nullability
--   • Maximum character length (where applicable)
--
-- This information is useful for understanding the table design before
-- performing joins, aggregations, or writing analytical queries.
-------------------------------------------------------------------------------

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'
ORDER BY
    ORDINAL_POSITION;