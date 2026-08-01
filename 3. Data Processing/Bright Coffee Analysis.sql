-- Databricks notebook source
SELECT *
FROM shop.coffee_data.sales;

--- EDA & Data Cleaning
SELECT
        CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2)) AS unit_price_clean,
        CAST(transaction_date AS DATE),
 --       CAST(transaction_time AS TIME),
        unit_price_clean * transaction_qty AS total_amount
FROM shop.coffee_data.sales;

SELECT
        YEAR(transaction_date) AS Year,
        QUARTER(transaction_date) as Quater,
        MONTH(transaction_date) AS Month_Number,
        DATE_FORMAT(transaction_date,'MMMM') AS Month_Name,
        DATE_FORMAT(transaction_date,'MMM') AS Month_Short,
        WEEKOFYEAR(transaction_date) AS Week_Number,
        DAY(transaction_date) AS Day_Number,
        DATE_FORMAT(transaction_date,'EEEE') AS Day_Name,
        CASE 
            WHEN Day_Name IN ('Saturday','Sunday') THEN 'Weekend' 
            ELSE 'Weekday' 
        END AS Week_Type
FROM shop.coffee_data.sales;

SELECT 
        DATE_FORMAT(transaction_time, 'HH:mm:ss') AS Time_of_Transaction,
        HOUR(transaction_time) AS Hour,
        MINUTE(transaction_time) AS Minute,
          CASE
        WHEN Time_of_Transaction BETWEEN '06:00:00' AND '08:59:59' THEN 'Dawn'
        WHEN Time_of_Transaction BETWEEN '09:00:00' AND '11:59:59' THEN 'Forenoon'
        WHEN Time_of_Transaction BETWEEN '12:00:00' AND '14:59:59' THEN 'Midday'
        WHEN Time_of_Transaction BETWEEN '15:00:00' AND '17:59:59' THEN 'Late Afternoon'
        ELSE 'Night'
    END AS Time_Buckets
FROM shop.coffee_data.sales;

SELECT
        transaction_qty,
        CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2)) AS unit_price_clean,
        CAST(transaction_date AS DATE),
        unit_price_clean * transaction_qty AS total_amount,
        CASE
            WHEN total_amount>=20 THEN 'High'
            WHEN total_amount>=10 THEN 'Medium'
            ELSE 'Low'
END AS Spending_Level
FROM shop.coffee_data.sales;

SELECT 
        CASE
            WHEN transaction_qty=1 THEN 'Single'
            WHEN transaction_qty BETWEEN 2 AND 4 THEN 'Small Order'
            ELSE 'Bulk Order'
END AS Order_Size
FROM shop.coffee_data.sales;

SELECT
        DISTINCT product_type,
    CASE
        WHEN product_type LIKE '%coffee%' OR product_type ILIKE '%Beans%' THEN 'Coffee'
        WHEN product_type LIKE '%tea%' THEN 'Tea'
        WHEN product_type IN ('Clothing','Housewares') THEN 'Others'
        ELSE 'Drinks/Food'
    END AS product_category
FROM shop.coffee_data.sales;



----BIG QUESRY
select
        transaction_id,
        transaction_date,
        YEAR(transaction_date) AS Year,
        CASE
            WHEN QUARTER(transaction_date)=1 THEN 'Q1'
            WHEN QUARTER(transaction_date)=2 THEN 'Q2'
            WHEN QUARTER(transaction_date)=3 THEN 'Q3'
            ELSE 'Q4'
END AS Quarter_Name,
        MONTH(transaction_date) AS Month_Number,
        DATE_FORMAT(transaction_date,'MMM yyyy') AS Month_Name,
        --DATE_FORMAT(transaction_date,'MMM') AS Month_Short,
        WEEKOFYEAR(transaction_date) AS Week_Number,
        DAY(transaction_date) AS Day_Number,
        DATE_FORMAT(transaction_date,'EEEE') AS Day_Name,
        CASE 
            WHEN Day_Name IN ('Saturday','Sunday') THEN 'Weekend' 
            ELSE 'Weekday' 
        END AS Week_Type,
       -- transaction_time,
        DATE_FORMAT(transaction_time, 'HH:mm:ss') AS Time_of_Transaction,
          CASE
        WHEN Time_of_Transaction BETWEEN '06:00:00' AND '11:59:59' THEN 'Dawn'
        WHEN Time_of_Transaction BETWEEN '12:00:00' AND '14:59:59' THEN 'Forenoon'
        WHEN Time_of_Transaction BETWEEN '15:00:00' AND '17:59:59' THEN 'Midday'
        WHEN Time_of_Transaction BETWEEN '18:00:00' AND '21:59:59' THEN 'Late Afternoon'
        ELSE 'Night'
END AS Time_Buckets,
        HOUR(transaction_time) AS Hour,
        MINUTE(transaction_time) AS Minute,
        
        transaction_qty,
         CASE
            WHEN transaction_qty=1 THEN 'Single'
            WHEN transaction_qty BETWEEN 2 AND 4 THEN 'Small Order'
            ELSE 'Bulk Order'
END AS Order_Size,
        store_id,
        store_location,
        product_id,
        unit_price,
        CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2)) AS unit_price_clean,
        unit_price_clean * transaction_qty AS total_amount,
        CASE
            WHEN total_amount>=20 THEN 'High'
            WHEN total_amount>=10 THEN 'Medium'
            ELSE 'Low'
END AS Spending_Level,
        product_category,
        product_type,
        CASE
        WHEN product_type LIKE '%coffee%' OR product_type ILIKE '%Beans%' THEN 'Coffee'
        WHEN product_type LIKE '%tea%' THEN 'Tea'
        WHEN product_type IN ('Clothing','Housewares') THEN 'Others'
        ELSE 'Drinks/Food'
    END AS product_category,
        product_detail
FROM shop.coffee_data.sales;