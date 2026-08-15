AdventureWorks Sales Analytics using SQL Server

A comprehensive SQL Server analytics project built on the AdventureWorks dataset to explore, analyze, and report business performance through advanced SQL techniques.

📌 Project Overview

This project demonstrates end-to-end SQL data analysis using the AdventureWorks sales dataset. It covers everything from database exploration and KPI analysis to advanced analytical techniques such as ranking, segmentation, cumulative analysis, performance comparisons, and reporting.

The project is designed to simulate real-world business reporting scenarios and showcases SQL skills commonly used by Data Analysts, Business Intelligence Developers, and Analytics Engineers.

🎯 Project Objectives
Explore and understand the database structure
Analyze business performance using SQL
Generate actionable business insights
Practice advanced SQL techniques
Build reusable reporting views
Create portfolio-ready SQL scripts following industry best practices
🛠️ Technologies Used
SQL Server
AdventureWorks Dataset
T-SQL
SQL Server Management Studio (SSMS)
📂 Project Structure
AdventureWorks-SQL-Analytics
│
├── datasets
│   └── csv-files
│
├── scripts
│   ├── 00_init_database.sql
│   ├── 01_database_exploration.sql
│   ├── 02_dimensions_exploration.sql
│   ├── 03_date_range_exploration.sql
│   ├── 04_measures_exploration.sql
│   ├── 05_magnitude_analysis.sql
│   ├── 06_ranking_analysis.sql
│   ├── 07_change_over_time_analysis.sql
│   ├── 08_cumulative_analysis.sql
│   ├── 09_performance_analysis.sql
│   ├── 10_data_segmentation.sql
│   ├── 11_part_to_whole_analysis.sql
│   ├── report_customers.sql
│   └── report_products.sql
│
└── README.md
📊 Dataset

This project uses a simplified version of the AdventureWorks dataset consisting of three core tables.

Fact Table
Table	Description
gold.fact_sales	Sales transactions including orders, quantities, revenue and pricing
Dimension Tables
Table	Description
gold.dim_customers	Customer demographic information
gold.dim_products	Product hierarchy and product details
📈 Analysis Performed
1. Database Exploration

Explore:

Database objects
Schemas
Tables
Columns
Metadata
2. Dimensions Exploration

Analyze descriptive business dimensions including:

Countries
Categories
Subcategories
Products
3. Date Range Exploration

Determine:

Earliest order
Latest order
Sales history duration
Customer age distribution
4. Business KPIs

Calculate key metrics including:

Total Sales
Total Orders
Total Quantity Sold
Average Selling Price
Total Products
Registered Customers
Active Customers
5. Magnitude Analysis

Identify business magnitude by analyzing:

Highest revenue products
Highest spending customers
Sales by category
Largest business contributors
6. Ranking Analysis

Rank products and customers using:

TOP
RANK()
ROW_NUMBER()
DENSE_RANK()

Examples include:

Top-selling products
Lowest-selling products
Highest revenue customers
Customers with the fewest orders
7. Change Over Time Analysis

Analyze trends using:

Monthly Sales
Yearly Sales
Customer Growth
Quantity Sold

Using:

YEAR()
MONTH()
DATETRUNC()
FORMAT()
8. Cumulative Analysis

Compute:

Running Total Sales
Moving Average Price

Using SQL Window Functions.

9. Performance Analysis

Compare yearly product performance against:

Historical Average Sales
Previous Year Sales

Generate insights such as:

Above Average
Below Average
Increase
Decrease
10. Data Segmentation

Segment customers into:

VIP
Regular
New

Segment products based on:

Cost
Revenue
11. Part-to-Whole Analysis

Calculate:

Category Contribution
Percentage of Total Sales

Useful for Pareto analysis and business contribution reporting.

📑 Analytical SQL Concepts Demonstrated

This project demonstrates a wide variety of SQL concepts.

Aggregations
SUM()
AVG()
COUNT()
COUNT(DISTINCT)
Window Functions
SUM() OVER()
AVG() OVER()
RANK()
DENSE_RANK()
ROW_NUMBER()
LAG()
Date Functions
YEAR()
MONTH()
DATEDIFF()
DATETRUNC()
FORMAT()
Conditional Logic
CASE
NULLIF
ISNULL
Joins
INNER JOIN
LEFT JOIN
Common Table Expressions (CTEs)
Single CTE
Multiple CTEs
Layered transformations
Reporting
Views
KPI Reports
Customer Report
Product Report
📋 Reporting Views
Customer Report

Provides customer-level analytics including:

Customer Profile
Age Group
Customer Segment
Total Orders
Total Sales
Total Quantity Purchased
Customer Tenure
Average Order Value
Average Monthly Spend
Recency
Product Report

Provides product-level analytics including:

Product Information
Product Category
Product Segment
Total Orders
Total Sales
Total Customers
Product Lifespan
Average Order Revenue
Average Monthly Revenue
Recency
💡 Business Insights Generated

The project helps answer questions such as:

Which products generate the highest revenue?
Which customers contribute the most sales?
Which product categories drive business performance?
How has sales performance changed over time?
Which products are improving or declining?
Who are the most valuable customers?
What percentage of revenue comes from each category?
Which products are top performers?
How does customer behavior differ across segments?
🚀 Skills Demonstrated
SQL Query Writing
Data Exploration
Data Cleaning
Business Analysis
Data Aggregation
Window Functions
Performance Analysis
Customer Analytics
Product Analytics
Reporting
Dashboard Data Preparation
SQL Best Practices
▶️ Getting Started
1. Clone the repository
git clone https://github.com/<your-username>/AdventureWorks-SQL-Analytics.git
2. Open SQL Server Management Studio (SSMS)

Connect to your SQL Server instance.

3. Create the database

Run:

00_init_database.sql

This script will:

Create the database
Create the Gold schema
Create dimension tables
Create the fact table
Import data from CSV files
4. Execute the analysis scripts

Run the scripts in numerical order:

01_database_exploration.sql
↓


02_dimensions_exploration.sql
↓


03_date_range_exploration.sql
↓


...


↓


11_part_to_whole_analysis.sql
5. Create reporting views

Finally execute:

report_customers.sql


report_products.sql
📷 Sample Reports

You can optionally include screenshots of:

SQL query outputs
SSMS execution results
Power BI dashboard (if created)
Customer Report
Product Report

Example folder:

images/
├── customer_report.png
├── product_report.png
├── sales_trend.png
└── dashboard.png
🌟 Future Enhancements

Potential improvements include:

Power BI Dashboard
Stored Procedures
Parameterized Reports
Dynamic Product Segmentation
Customer Lifetime Value (CLV)
RFM Analysis
Cohort Analysis
Sales Forecasting
Index Optimization
Performance Tuning
🤝 Contributing

Contributions, suggestions, and improvements are welcome.

If you'd like to contribute:

Fork the repository.
Create a feature branch.
Commit your changes.
Open a Pull Request.
👤 Author

Ennaval

Aspiring Data Analyst | SQL | Power BI | Python

GitHub: Add your GitHub profile here

LinkedIn: Add your LinkedIn profile here

⭐ If you found this project useful

If this repository helped you or inspired your own SQL learning journey, consider giving it a ⭐ Star on GitHub. It helps others discover the project and motivates future improvements.

License

This project is licensed under the MIT License. Feel free to use, modify, and share it for learning and educational purposes.
