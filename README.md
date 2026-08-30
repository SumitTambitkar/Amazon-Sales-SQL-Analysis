# Amazon Sales SQL Analysis

![Amazon Sales SQL Analysis](YAHAN_COPIED_LINK_PASTE_KARO)

## Project Overview

This project analyzes Amazon sales data using SQL to identify sales trends, product performance, regional performance, customer behavior, discount impact, and revenue patterns.

The project includes data cleaning, exploratory data analysis, product and category analysis, region-wise analysis, payment method analysis, discount analysis, customer rating and review analysis, time-based analysis, and advanced SQL techniques using CTEs and window functions.

---

## Dataset Information

The dataset contains Amazon sales records from January 2022 to December 2023.

### Dataset Summary

| Metric | Value |
|---|---:|
| Total Clean Records | 11,651 |
| Total Products | 3,757 |
| Total Categories | 6 |
| Total Regions | 4 |
| Total Revenue | 7,680,337.99 |
| Total Units Sold | 35,341 |
| Average Order Revenue | 659.20 |
| First Order Date | 2022-01-01 |
| Last Order Date | 2023-12-31 |

The original dataset contained 13,375 records. After identifying and removing exact duplicate records, the clean dataset contained 11,651 records.

---

## Dataset Columns

The dataset contains the following columns:

- Order ID
- Order Date
- Product ID
- Product Category
- Price
- Discount Percent
- Quantity Sold
- Customer Region
- Payment Method
- Rating
- Review Count
- Discounted Price
- Total Revenue

---

## Data Cleaning

The following data cleaning steps were performed:

- Checked for NULL values
- Checked duplicate order IDs
- Identified exact duplicate records
- Checked for invalid or negative values
- Checked the minimum and maximum rating values
- Created a clean table by removing exact duplicate records
- Verified the final clean record count

### Data Cleaning Result

- Original Records: 13,375
- Clean Records: 11,651
- NULL Values: 0
- Duplicate Records Removed: 1,724
- Rating Range: 1.00 to 5.00

---

# Exploratory Data Analysis

The following overall business metrics were analyzed:

- Total orders
- Total unique products
- Total product categories
- Total customer regions
- Total revenue
- Total units sold
- Average order revenue
- Sales date range

---

# Product Category Analysis

The following analyses were performed:

- Category-wise revenue analysis
- Category-wise units sold analysis
- Top 10 products by revenue
- Category-wise average rating analysis

### Key Finding

The **Sports** category generated the highest revenue.

- Total Revenue: **1,243,016.59**

The top revenue-generating product was:

- Product ID: **2250**
- Product Category: **Sports**
- Total Revenue: **4,873.81**
- Total Units Sold: **18**

---

# Region-Wise Sales Analysis

The following analyses were performed:

- Region-wise revenue analysis
- Region-wise units sold analysis
- Region-wise average order revenue
- Region-wise average customer rating
- Region ranking by total revenue

### Key Finding

**North America** was the highest revenue-generating customer region.

- Total Revenue: **1,941,346.78**
- Total Units Sold: **8,888**

---

# Payment Method Analysis

The following analyses were performed:

- Payment method-wise total revenue
- Payment method-wise total orders
- Payment method-wise average order revenue
- Payment method-wise average customer rating

### Key Finding

**UPI** generated the highest revenue among the available payment methods.

- Total Revenue: **1,553,035.99**
- Total Orders: **2,386**

---

# Discount Analysis

The following analyses were performed:

- Product category-wise average discount
- Discount range-wise sales analysis
- Discount percentage vs quantity sold
- Discount percentage vs total revenue

This analysis helps understand how different discount levels are associated with sales volume and revenue.

---

# Customer Rating and Review Analysis

The following analyses were performed:

- Rating-wise sales performance
- Category-wise average rating
- Category-wise review analysis
- Review count range analysis

This analysis helps evaluate customer satisfaction, engagement, and their relationship with sales performance.

---

# Time-Based Sales Analysis

The following analyses were performed:

- Monthly revenue trend
- Monthly units sold
- Top 5 revenue months
- Month-to-month revenue change

### Key Finding

**March 2023** was the highest revenue-generating month.

- Total Revenue: **358,440.71**

Month-to-month revenue changes were also analyzed using the `LAG()` window function.

---

# Advanced SQL Analysis

The project uses advanced SQL techniques including:

- Common Table Expressions (CTEs)
- Window Functions
- `RANK()`
- `LAG()`
- `PARTITION BY`

The following advanced analyses were performed:

- Ranking product categories by total revenue
- Identifying the top 3 products by revenue within each category
- Ranking customer regions by total revenue
- Calculating month-to-month revenue changes

---

# Key Business Insights

1. The **Sports** category was the highest revenue-generating product category, with total revenue of **1,243,016.59**.

2. **Product ID 2250** from the Sports category was the highest revenue-generating product, generating **4,873.81** in revenue.

3. **North America** was the strongest customer region, generating **1,941,346.78** in total revenue.

4. **UPI** was the highest revenue-generating payment method, generating **1,553,035.99** in revenue.

5. **March 2023** was the highest revenue-generating month, with revenue of **358,440.71**.

6. The dataset covers a two-year sales period from **January 2022 to December 2023**, allowing sales performance and monthly trends to be analyzed over time.

7. Discount analysis was used to evaluate the relationship between discount levels, quantity sold, and total revenue.

8. Advanced SQL techniques such as CTEs and window functions were used to perform revenue ranking and month-to-month sales analysis.

---

# SQL Skills Demonstrated

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- `DISTINCT`
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `ROUND()`
- `CASE`
- `LIMIT`
- Common Table Expressions (CTEs)
- Window Functions
- `RANK()`
- `LAG()`
- `PARTITION BY`
- `DATE_FORMAT()`

---

# Tools Used

- MySQL
- MySQL Workbench
- GitHub

---

# Project Files

```text
Amazon-Sales-SQL-Analysis
│
├── Amazon_Sales_SQL_Analysis.sql
├── amazon_sales_dataset.csv
└── README.md
