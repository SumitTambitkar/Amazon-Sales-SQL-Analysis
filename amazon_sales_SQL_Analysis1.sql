
--  Amazon Sales SQL Analysis Project --

-- Create database
CREATE DATABASE amazon_sales_analysis;

-- use database
use amazon_sales_analysis;

-- Create Table 
create table amazon_sales ( 
order_id varchar(50), 
order_date date, 
product_id varchar(50), 
product_caterory varchar(100), 
price decimal(10,2), 
discount_percent decimal(5,2),
quantity_sold int, 
customer_region varchar(100), 
payment_method varchar(50), 
rating decimal(3,2), 
review_count int, 
discounted_price decimal(10,2), 
total_revenue decimal(12,2));

-- count all rows
SELECT COUNT(*) AS total_rows
FROM amazon_sales;

-- show all data
select * from amazon_sales;

-- Check table structure and data types
DESCRIBE amazon_sales;

-- Check sales date range
select min(order_date) as first_order_date,
max(order_date) as last_order_date from amazon_sales;

-- Data Cleaning

-- NULL values check 
select
sum(order_id is NULL) as null_order_id,
sum(order_date is NULL) as null_order_date,
sum(product_id is NULL) as null_product_id,
sum(product_caterory is NULL) as null_product_caterory,
sum(price is NULL) as null_price,
sum(discount_percent is NULL) as null_discount_percent,
sum(quantity_sold is NULL) as null_quantity_sold,
sum(customer_region is NULL) as null_customer_region,
sum(payment_method is NULL) as null_payment_method,
sum(rating is NULL) as null_rating,
sum(review_count is NULL) as null_review_count,
sum(discounted_price is NULL) as null_discounted_price,
sum(total_revenue is NULL) as null_total_revenue
from amazon_sales;

-- Duplicate records check 
select 
count(*) as duplicate_group
from(
select order_id from amazon_sales group by order_id having count(*)>1)
as duplicates;

-- Negative ya invalid values check
select * from amazon_sales where 
price < 0 
or discount_percent < 0
or quantity_sold <= 0
or discounted_price < 0
or total_revenue < 0;

-- Rating range check
SELECT 
    MIN(rating) AS minimum_rating,
    MAX(rating) AS maximum_rating
FROM amazon_sales;

-- Exact Duplicate Rows Check
SELECT 
    order_id,
    order_date,
    product_id,
    product_caterory,
    price,
    discount_percent,
    quantity_sold,
    customer_region,
    payment_method,
    rating,
    review_count,
    discounted_price,
    total_revenue,
    COUNT(*) AS duplicate_count
FROM amazon_sales
GROUP BY 
    order_id,
    order_date,
    product_id,
    product_caterory,
    price,
    discount_percent,
    quantity_sold,
    customer_region,
    payment_method,
    rating,
    review_count,
    discounted_price,
    total_revenue
HAVING COUNT(*) > 1;

-- check total extra duplicate rows 
SELECT 
    COUNT(*) AS total_duplicate_rows
FROM (
    SELECT 
        order_id,
        order_date,
        product_id,
        product_caterory,
        price,
        discount_percent,
        quantity_sold,
        customer_region,
        payment_method,
        rating,
        review_count,
        discounted_price,
        total_revenue,
        COUNT(*) AS duplicate_count
    FROM amazon_sales
    GROUP BY 
        order_id,
        order_date,
        product_id,
        product_caterory,
        price,
        discount_percent,
        quantity_sold,
        customer_region,
        payment_method,
        rating,
        review_count,
        discounted_price,
        total_revenue
    HAVING COUNT(*) > 1
) AS duplicates;

-- extra duplicate rows
SELECT 
    SUM(duplicate_count - 1) AS extra_duplicate_rows
FROM (
    SELECT 
        COUNT(*) AS duplicate_count
    FROM amazon_sales
    GROUP BY 
        order_id,
        order_date,
        product_id,
        product_caterory,
        price,
        discount_percent,
        quantity_sold,
        customer_region,
        payment_method,
        rating,
        review_count,
        discounted_price,
        total_revenue
    HAVING COUNT(*) > 1
) AS duplicates;


-- new amazon_sales_clean table
CREATE TABLE amazon_sales_clean AS
SELECT DISTINCT *
FROM amazon_sales;

SELECT COUNT(*) AS clean_records
FROM amazon_sales_clean;

-- Dataset Overview
SELECT 
    COUNT(*) AS total_orders,
    COUNT(DISTINCT product_id) AS total_products,
    COUNT(DISTINCT product_caterory) AS total_categories,
    COUNT(DISTINCT customer_region) AS total_regions
FROM amazon_sales_clean;

-- Overall Sales Performance
SELECT 
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    SUM(quantity_sold) AS total_units_sold,
    ROUND(AVG(total_revenue), 2) AS average_order_revenue
FROM amazon_sales_clean;

-- Sales Date Range
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM amazon_sales_clean;

-- Category-wise Revenue Analysis
select 
product_caterory,
round(sum(total_revenue), 2) as total_revenue,
sum(quantity_sold) as total_units_sold
from amazon_sales_clean
group by product_caterory
order by total_revenue desc;

-- Top 10 Products by Revenue
select
product_id,
product_caterory,
round(sum(total_revenue), 2) as total_revenue,
sum(quantity_sold) as total_units_sold
from amazon_sales_clean
group by product_id, product_caterory
order by total_revenue desc
limit 10;

-- Category-wise Average Rating
select
product_caterory,
round(avg(rating), 2) as average_rating,
round(sum(total_revenue), 2) as total_revenue
from amazon_sales_clean
group by product_caterory
order by average_rating desc;

-- Region-wise Revenue Analysis
select
customer_region,
round(sum(total_revenue), 2) as total_revenue,
sum(quantity_sold) as total_unit_sold
from amazon_sales_clean
group by customer_region
order by total_revenue desc;

-- Region-wise Average Order Revenue
select
customer_region,
round(avg(total_revenue),2) as average_order_revenue
from amazon_sales_clean
group by customer_region
order by average_order_revenue desc;

-- Region-wise Average Customer Rating
select 
customer_region,
round(avg(rating),2)as average_rating
from amazon_sales_clean
group by customer_region
order by average_rating desc;

-- Payment Method-wise Total Revenue
select 
payment_method,
round(sum(total_revenue), 2) as total_revenue,
count(*) as total_orders
from amazon_sales_clean
group by payment_method
order by total_revenue desc;

-- Payment Method-wise Average Order Revenue
select 
payment_method,
round(avg(total_revenue), 2) as average_order_revenue
from amazon_sales_clean
group by payment_method
order by average_order_revenue desc;

-- Payment Method-wise Average Rating
select
payment_method,
round(avg(rating), 2) as average_rating,
round(sum(total_revenue), 2) as total_revenue
from amazon_sales_clean
group by payment_method
order by average_rating desc;

-- Product Category-wise Average Discount
select
product_caterory,
round(avg(discount_percent), 2) as average_discount_percent,
round(sum(total_revenue),2) as total_revenue
from amazon_sales_clean
group by product_caterory
order by average_discount_percent desc;

-- Discount Range-wise Sales Analysis
select
case 
when discount_percent = 0 then 'No Discount'
when discount_percent <= 10 then '1-10%'
when discount_percent <= 25 then '11-25%'
when discount_percent <= 50 then '25-50%'
else 'Above 50%'
end as discount_range,
count(*) as total_order,
sum(quantity_sold) as total_unit_sold,
round(sum(total_revenue),2) as total_revenue
from amazon_sales_clean
group by discount_range
order by total_revenue desc;

-- Discount vs Quantity Sold
select
discount_percent,
sum(quantity_sold) as total_unit_sold,
round(sum(total_revenue), 2) as total_revenue
from amazon_sales_clean
group by discount_percent
order by discount_percent;

-- top 10 Rating-wise Sales Performance
select 
rating,
count(*) as total_orders,
round(sum(total_revenue), 2) as total_revenue,
sum(quantity_sold) as total_unit_sold
from amazon_sales_clean
group by rating
order by rating desc
limit 10;

-- Category-wise Rating and Reviews
select
product_caterory,
round(avg(rating),2) as average_rating,
sum(review_count) as total_reviews,
round(sum(total_revenue), 2) as total_revenue
from amazon_sales_clean
group by product_caterory
order by average_rating desc;

-- Review Count Range Analysis
select
case 
when review_count = 0 then ' No Reviews'
when review_count <= 10 then ' 1-10 Reviews'
when review_count <= 50 then ' 11-50 Reviews'
when review_count <= 100 then ' 50-100 Reviews'
else '100+ Reviews'
end as review_range,
count(*) as total_orders,
round(avg(rating), 2) as average_rating,
round(sum(total_revenue), 2) as total_revenue
from amazon_sales_clean
group by review_range
order by total_revenue desc;

-- Monthly Revenue Trend
select
date_format(order_date, '%y-%m') as month,
round(sum(total_revenue), 2) as total_revenue,
sum(quantity_sold) as total_units_sold
from amazon_sales_clean
group by date_format(order_date, '%y-%m')
order by month;

-- Top 5 Revenue Months
select
date_format(order_date, '%y-%m') as month,
round(sum(total_revenue), 2) as total_revenue
from amazon_sales_clean
group by date_format(order_date, '%y-%m')
order by total_revenue desc
limit 5;

-- Month-to-Month Revenue Growth
with monthly_sales as (
select 
date_format(order_date, '%y-%m') as month,
sum(total_revenue) as monthly_revenue
from amazon_sales_clean
group by date_format(order_date, '%y-%m') 
)
select
month, 
round(monthly_revenue, 2) as monthly_revenue,
round(
monthly_revenue - lag(monthly_revenue) OVER (order by month),2)
as revenue_change
from monthly_sales
order by month;

-- Rank Product Categories by Revenue
with caterory_revenue as (
select
product_caterory,
sum(total_revenue) as total_revenue
from amazon_sales_clean
group by product_caterory
)
select
product_caterory,
round(total_revenue, 2) as total_revenue,
rank() over (order by total_revenue desc) as revenue_rank
from caterory_revenue;

-- Top 3 Products in Each Category
with product_revenue as (
select
product_caterory,
product_id,
sum(total_revenue) as total_revenue
from amazon_sales_clean
group by product_caterory, product_id
),
ranked_products as (
select
product_caterory,
product_id,
total_revenue,
rank() over (
partition by product_caterory order by total_revenue desc
) as product_rank
from product_revenue
)
select
product_caterory,
product_id,
round(total_revenue, 2) as total_revenue,
product_rank
from ranked_products
where product_rank <=3
order by product_caterory, product_rank;

-- Rank Regions by Revenue
select
customer_region,
round(sum(total_revenue), 2) as total_revenue,
rank() over (
order by sum(total_revenue) desc
) as region_rank
from amazon_sales_clean
group by customer_region;