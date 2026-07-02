-- Create database and table
CREATE DATABASE retail_sales_db;
USE retail_sales_db;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- Data cleaning: check for null values
SELECT * FROM retail_sales 
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL 
   OR gender IS NULL OR age IS NULL OR category IS NULL 
   OR quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;

-- Q1: Revenue and transaction count by category
SELECT category, 
       SUM(total_sale) AS total_revenue,
       COUNT(*) AS num_transactions
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC;

-- Q2: Profit and profit margin by category
SELECT category,
       SUM(total_sale) AS total_revenue,
       SUM(cogs) AS total_cost,
       SUM(total_sale - cogs) AS total_profit,
       ROUND(SUM(total_sale - cogs) / SUM(total_sale) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;

-- Q3: Monthly revenue trend
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(total_sale) AS monthly_revenue,
    COUNT(*) AS num_transactions
FROM retail_sales
GROUP BY sale_month
ORDER BY sale_month;

-- Q4: Top 10 customers by total spend
SELECT customer_id, 
       SUM(total_sale) AS total_spent,
       COUNT(*) AS num_purchases
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;
