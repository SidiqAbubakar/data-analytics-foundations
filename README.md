# data-analytics-foundations


# End-to-End Sales Analytics Project

## Project Overview
This project demonstrates an end-to-end data analytics pipeline, tracking business performance across customers, products, and orders. The analysis evaluates core volume metrics, regional performance, product category concentrations, and individual sales productivity to deliver actionable business strategies.

The project journey spanned three distinct phases: Data Wrangling (Excel), Relational Database Management (PostgreSQL), and Interactive Business Intelligence (Power BI).

---

## The Project Journey & Tooling

### Phase 1: Data Wrangling & Exploration (Excel)
- Cleaned and structured raw transactional datasets.
- Performed initial data profiling to establish baseline metrics (record counts, column definitions, and basic data types).

### Phase 2: Database Infrastructure & Advanced Querying (PostgreSQL)
- Designed the database schema and imported tables (customers, products, orders) ensuring relational integrity.
- Developed advanced analytical scripts utilizing Common Table Expressions (CTEs) and Window Functions (DENSE_RANK, SUM() OVER, AVG() OVER()).
- Solved complex business queries including month-on-month performance trends, customer segmentation tiers, and regional underperformance against category benchmarks.

### Phase 3: Data Modeling & Visualization (Power BI)
- Connected Power BI Desktop natively to the local PostgreSQL database instance (localhost:5432).
- Built a clean data model and authored dynamic DAX Measures for key performance indicators (KPIs) including:
  - Total Revenue, Total Orders, Total Quantity Sold
  - Average Order Value (AOV), Total Customers, Average Revenue per Customer
- Designed an interactive multi-metric executive dashboard showcasing high-level operational performance.

---

## Executive Summary & Business Insights

- Core Performance Baselines: Total Revenue reached GHS 4.73M across 1,200 total orders from 180 unique customers, yielding a high Average Order Value (AOV) of GHS 3.94K.
- Geographical Concentrations: Territory performance is heavily concentrated; the Greater Accra and Ashanti regions significantly outperformed the rest of the country, with each region crossing the GHS 1.4M milestone individually.
- Product Line Vulnerability: The Computers category heavily dominated the product ecosystem, accounting for GHS 3.3M (approx. 70%) of total revenue, driven primarily by Performance Laptops, Office Laptops, and Mini PCs.
- Sales Force Productivity: Operational output was strong across the team, with Esther leading sales performance by securing 173 individual orders.

---

## Strategic Recommendations

1. Bridge the Regional Revenue Gap: Greater Accra and Ashanti combined generated GHS 2.98M, heavily eclipsing the combined revenue of all other regions (GHS 1.75M). Management should launch geo-targeted marketing campaigns and localized promotional pricing to stimulate demand in lagging territories.
2. Mitigate Category Concentration Risk: Relying on Computers for 70% of total revenue creates a severe supply chain vulnerability. Marketing budgets should be reallocated toward advertising peripheral categories to balance the revenue pipeline.
3. Accelerate Customer Acquisition: A customer base of 180 clients represents a tight risk profile for a company generating GHS 4.73M. The business should launch B2B lead-generation initiatives and corporate referral programs to expand its client footprint and reduce dependency risk.

