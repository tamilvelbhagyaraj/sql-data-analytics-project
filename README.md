# 📊 SQL Data Analytics Project

Exploratory and advanced SQL analytics built on top of a Gold-layer star schema — turning raw sales, customer, and product data into business-ready insights using pure T-SQL.

This project is part of my hands-on journey learning SQL for data analytics, following **[Data with Baraa](https://www.youtube.com/@DataWithBaraa)**'s SQL Data Warehouse & Analytics series. I rebuilt every script myself to internalize the logic, then extended the formatting, comments, and documentation to match my own working style.

---

## 🧭 About This Project

The goal of this project is to demonstrate the full analytics workflow a Data Analyst performs once clean data lands in a warehouse's **Gold layer** — from first exploring the data, to answering core business questions, to producing reusable, dashboard-ready reporting views.

It sits on top of a **Medallion Architecture Data Warehouse** (Bronze → Silver → Gold) built in SQL Server using the AdventureWorks dataset. *(Linked separately — see [Related Projects](#-related-projects) below.)*

The queries here operate on three Gold-layer objects:

| Object | Type | Description |
|---|---|---|
| `gold.fact_sales` | Fact table | Order-level sales transactions |
| `gold.dim_customers` | Dimension table | Customer demographic and profile data |
| `gold.dim_products` | Dimension table | Product catalog, category, and cost data |

---

## 🗂️ Project Structure

Scripts are numbered in the order they're meant to be run, moving from broad exploration to focused, decision-ready reporting.

| # | Script | Purpose |
|---|--------|---------|
| 01 | *Database Exploration* | Initial inspection of tables, columns, and schema |
| 02 | *Dimensions Exploration* | Understand distinct values across dimension tables |
| **03** | `Date_Range_Exploration` | Sales history duration and customer age range |
| **04** | `Measures_Exploration__Business_KPIs_.sql` | Core KPIs: total sales, quantity, price, orders, customers |
| **05** | `Magnitude_Analysis` | Distribution of customers, products, and revenue across categories |
| **06** | `Ranking_Analysis` | Top/bottom performing products and customers |
| 07 | *Change-Over-Time Analysis* | Trends in sales performance across time |
| 08 | *Cumulative Analysis* | Running totals and moving averages |
| 09 | *Performance Analysis* | Year-over-year / category-over-category comparisons |
| 10 | *Data Segmentation* | Bucketing customers/products into meaningful groups |
| 11 | *Part-to-Whole Analysis* | Category contribution to overall revenue |
| **12** | `report_products` | Consolidated **Product Report** view |
| **13** | `report_customers` | Consolidated **Customer Report** view |

> **Note:** Scripts 01–02 and 07–11 follow the same structure and gold-layer sources as 03–06 and 12–13 — add them here as you bring the rest of your project across, adjusting names/numbers to match your actual repo.
>
> **Housekeeping tip:** in your uploads, the file containing the *Product Report* logic is currently named `12. report_customer.sql`. Worth renaming to `12_report_products.sql` before pushing, so the filename matches its content (`13_report_customers.sql` is correctly named).

---

## 🔍 Script Breakdown

### 03 · Date Range Exploration
Establishes the temporal boundaries of the dataset — first and last order dates, total sales history in months, and the age range of customers based on birth date.

### 04 · Measures Exploration (Business KPIs)
Calculates the core numbers every stakeholder asks for first: total sales, total quantity sold, average selling price, total and unique orders, product count, and total vs. active customers — then rolls them into a single `UNION ALL` KPI summary table ready for a dashboard.

### 05 · Magnitude Analysis
Breaks totals down by dimension: customers by country and gender, products by category, average product cost by category, revenue by category, revenue by individual customer, and units sold by country.

### 06 · Ranking Analysis
Surfaces top and bottom performers using both the `TOP` clause and the `RANK()` window function — top 5 products by revenue, bottom 5 products by revenue, top 10 customers by revenue, and customers with the fewest orders.

### 12 · Product Report
A single consolidated view (built with layered CTEs) summarizing every product's lifetime performance:
- Total orders, sales, quantity, and unique customers
- Product lifespan and recency (months since last sale)
- Average order revenue and average monthly revenue
- **Dynamic segmentation** into High Performer / Mid Range / Low Performer using `PERCENT_RANK()`

### 13 · Customer Report
A single consolidated view summarizing every customer's lifetime behavior:
- Total orders, sales, quantity, and products purchased
- Customer lifespan and recency (months since last order)
- Average order value and average monthly spend
- **Segmentation** into age groups and VIP / Regular / New customer tiers based on lifespan and spend

Both reports are built as reusable `VIEW`s (`gold.report_products`, `gold.report_customers`) so they can be queried directly by Power BI or any downstream reporting tool without repeating the underlying logic.

---

## 🛠️ Key SQL Concepts Practiced

- Common Table Expressions (CTEs) and layered/multi-step query design
- Window functions — `RANK()`, `PERCENT_RANK()` for dynamic ranking and segmentation
- Aggregate functions — `SUM()`, `COUNT()`, `COUNT(DISTINCT ...)`, `AVG()`
- `CASE` expressions for business-rule-driven segmentation (age groups, customer tiers, performance tiers)
- Date logic with `DATEDIFF()` for lifespan, recency, and tenure calculations
- Safe division using `NULLIF()` to prevent divide-by-zero errors
- `UNION ALL` to consolidate multiple metrics into a single KPI summary table
- Reusable, production-style `VIEW`s for downstream BI consumption

---

## ❓ Business Questions Answered

- How much historical sales data do we have, and how old is our customer base?
- What are our headline KPIs — total sales, orders, customers, products?
- Which countries, categories, and genders drive the most volume and revenue?
- Who are our best and worst performing products and customers?
- Which customers are VIP, Regular, or New — and how much are they worth?
- Which products are High, Mid, or Low performers, and how recently did they sell?

---

## 💻 Tech Stack

- **Database:** Microsoft SQL Server
- **Tool:** SQL Server Management Studio (SSMS)
- **Data Source:** AdventureWorks (transformed into a custom Bronze → Silver → Gold warehouse)
- **Downstream Consumption:** Power BI

---

## 🔗 Related Projects

- **SQL Server Medallion Architecture Data Warehouse** — the Bronze/Silver/Gold ETL pipeline this analytics layer is built on. *(https://github.com/tamilvelbhagyaraj/sql-data-warehouse-project)*

---

## 🙏 Acknowledgments

This project was built while learning from **[Data with Baraa](https://www.youtube.com/@DataWithBaraa)**'s free SQL Data Warehouse & Analytics course. All scripts were written and formatted by me as a hands-on learning exercise — full credit to Baraa Khatib Salkini for the course structure and teaching approach that this project follows.

---

## 🙋 About Me

**Tamilvel B** — Power BI Developer & Data Analyst, and founder of **Latent Data Solutions**, where I build BI dashboards and teach Excel, Power BI, SQL, VBA, and Power Platform.

- 🔗 GitHub: [github.com/Tamilvelbhagyaraj](https://github.com/Tamilvelbhagyaraj)
- 🔗 LinkedIn: [linkedin.com/in/tamilvel-b-059301240](https://www.linkedin.com/in/tamilvel-b-059301240/)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) — free to use, fork, adapt, and build on for your own SQL practice.
