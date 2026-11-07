-- Databricks notebook source
---------------------------------
--EDA (exploratory data analysis) 
---------------------------------
--Check 1rst 10 rows of the data
SELECT *
FROM shop.coffee_data.sales
LIMIT 10;

--Checking the size of the data and duplicates
SELECT COUNT(*)                       AS row_count,
       COUNT(DISTINCT transaction_id) AS distinct_transactions
FROM shop.coffee_data.sales;
--row_count=distinct_transactions=149116, THUS THE TRANSACTION ID'S are distinct.

--Checking the minimum and maximum dates
SELECT MIN(transaction_date)          AS first_date,
       MAX(transaction_date)          AS last_date
FROM shop.coffee_data.sales;
--Thus first_date=2023-01-01 and last_date=2023-06-30

SELECT COUNT(DISTINCT store_id)       AS stores,
       COUNT(DISTINCT product_id)     AS products
FROM shop.coffee_data.sales;
 

 --Checking the columns if they are null or not by flagging those that have a null with 1 and those not with 0
 SELECT SUM(CASE WHEN transaction_id    IS NULL THEN 1 ELSE 0 END) AS null_transaction_id,
       SUM(CASE WHEN transaction_date  IS NULL THEN 1 ELSE 0 END) AS null_date,
       SUM(CASE WHEN transaction_time  IS NULL THEN 1 ELSE 0 END) AS null_time,
       SUM(CASE WHEN transaction_qty   IS NULL THEN 1 ELSE 0 END) AS null_qty,
       SUM(CASE WHEN store_id          IS NULL THEN 1 ELSE 0 END) AS null_store_id,
       SUM(CASE WHEN store_location    IS NULL THEN 1 ELSE 0 END) AS null_store_location,
       SUM(CASE WHEN product_id        IS NULL THEN 1 ELSE 0 END) AS null_product_id,
       SUM(CASE WHEN unit_price        IS NULL THEN 1 ELSE 0 END) AS null_unit_price,
       SUM(CASE WHEN product_category  IS NULL THEN 1 ELSE 0 END) AS null_category,
       SUM(CASE WHEN product_type      IS NULL THEN 1 ELSE 0 END) AS null_type,
       SUM(CASE WHEN product_detail    IS NULL THEN 1 ELSE 0 END) AS null_detail
FROM shop.coffee_data.sales;
---All my columns return a 0 flag, thus none of my columns have null value.

--Checking how many rows have a  commas as as decimal sign in the unit price
SELECT SUM(CASE WHEN CAST(unit_price AS STRING) LIKE '%,%' THEN 1 ELSE 0 END) AS prices_with_comma,
       COUNT(*)                                                                AS total_rows
FROM shop.coffee_data.sales;
--Therefore price with comma = 105078 out of 149116 row that we have, thus those that are in the right format are in 44038 rows.

--Checking the different categories and type ijn the data
SELECT product_category, 
       product_type, 
       COUNT(*) AS rows_in_type
FROM shop.coffee_data.sales
GROUP BY product_category, product_type
ORDER BY product_category, product_type;
--As observed the same product category can fall in different product type, e.g Bakery can either be Bisotti, Pastry or Scones

--Checking to which store id each store location is assigned to
SELECT store_id, 
       store_location, 
       COUNT(*) AS rows_in_store
FROM shop.coffee_data.sales
GROUP BY store_id, store_location;
--Those in Lower Manhattan store id is 5, those in Hell's Kitchen store id is 8 and those in Astoria store id is 3.

--Checking if the quantity sold are valid or not
SELECT MIN(transaction_qty) AS min_qty, 
       MAX(transaction_qty) AS max_qty
FROM shop.coffee_data.sales;
--Thus there is no zero or negative transaction quantity

---------------------------------------------------------------------------------------------
---Cleaning the Data
---------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW shop.coffee_data.sale_clean AS
SELECT transaction_id,
       transaction_date,
       COALESCE(DATE_FORMAT(transaction_time, 'HH:mm:ss'),
                CAST(transaction_time AS STRING))                              AS Time_of_Transaction,--Turning the time into proper time
       transaction_qty,
       store_id,
       store_location,
       product_id,
       unit_price,
       TRY_CAST(REPLACE(CAST(unit_price AS STRING), ',', '.') AS DECIMAL(10,2)) AS unit_price_clean,--Turning the part that shows the decimal into a full stop instead of it being a comma
       product_category,
       product_type,
       product_detail
FROM shop.coffee_data.sales;

---Displaying my newly created table
Select *
FROM shop.coffee_data.sale_clean;


--Now checking the Minimum and maximum operated hours
SELECT MIN(Time_of_Transaction)                                       AS first_sale_time,
       MAX(Time_of_Transaction)                                       AS last_sale_time
FROM shop.coffee_data.sale_clean;
--Min is 06:00:00 aand Max is 20:59:32


----------------------------------------------------------------------------------.
----Big Query
----------------------------------------------------------------------------------.
---CTE
CREATE OR REPLACE VIEW shop.coffee_data.sale_clean_model AS
WITH base AS (
    SELECT transaction_id,
           transaction_date,
 
           -- Date parts: needed for trends by year, quarter, month, week and day
           YEAR(transaction_date)                       AS Year,
           QUARTER(transaction_date)                    AS Quarter_Number,
           MONTH(transaction_date)                      AS Month_Number,
           DATE_FORMAT(transaction_date, 'MMMM')        AS Month_Name,
           DATE_FORMAT(transaction_date, 'MMM')         AS Month_Short,
           DATE_FORMAT(transaction_date, 'yyyy-MM')     AS Year_Month,          
           WEEKOFYEAR(transaction_date)                 AS Week_Number,
           DAY(transaction_date)                        AS Day_Number,
           DAYOFWEEK(transaction_date)                  AS Day_Of_Week_Number,  
           DATE_FORMAT(transaction_date, 'EEEE')        AS Day_Name,
 
           -- Time parts: Hour and Minute drive every time bucket below
           Time_of_Transaction,
           TRY_CAST(SUBSTRING(Time_of_Transaction, 1, 2) AS INT) AS Hour,
           TRY_CAST(SUBSTRING(Time_of_Transaction, 4, 2) AS INT) AS Minute,
 
           transaction_qty,
           unit_price,
           unit_price_clean,
           unit_price_clean * transaction_qty           AS total_amount,        -- Total Amount = unit_price * transaction_qty
 
           store_id,
           store_location,
           product_id,
           product_category,
           product_type,
           product_detail
    FROM shop.coffee_data.sale_clean
)
SELECT transaction_id,
       transaction_date,
       Year,
       CONCAT('Q', Quarter_Number)                                       AS Quarter_Name,
       Month_Number,
       Month_Name,
       Month_Short,
       Year_Month,
       Week_Number,
       Day_Number,
       Day_Of_Week_Number,
       Day_Name,
       CASE WHEN Day_Of_Week_Number IN (1, 7) THEN 'Weekend' ELSE 'Weekday' END AS Week_Type,
 
       Time_of_Transaction,
       Hour,
       Minute,
      
      -------dUE TO THE STRICK CONDITION OF HAVING TO CREATE A 30 MIN OR 3 HOURS BUCKET, THERE WILL BE A SLIGHT DIFFICULTY IN LABELING MY TIME BUCKET AFTER CHOOSING 3 HOURS, AS IT GOT A BIT TRICKY FOR BE BETWEEN THE TIME 10:00:00 AND 13:59:59 TIME. THUS THERE IS NOI MISTAKE IN THE WAY THAT I WILL LABEL NOE, THOUGH I AM AWARE IT MIGHT LOOK LIKE A LOGICAL ERROR OR NOT MAKE SENSE AS I WILL MENTION TWO OPPOSING THINGS AT THE SAME TIME
        CASE
            WHEN Time_of_Transaction BETWEEN '06:00:00' AND '09:59:59' THEN 'Early Morning'
            WHEN Time_of_Transaction BETWEEN '10:00:00' AND '13:59:59' THEN 'Late Morning to Early Afternoon (10am <= x < 2pm)'
            WHEN Time_of_Transaction BETWEEN '14:00:00' AND '17:59:59' THEN 'Late Afternoon'
            WHEN Time_of_Transaction BETWEEN '18:00:00' AND '21:59:59' THEN 'Evening'
            ELSE 'Night'
            END AS Time_Bucket_3hr,            
 
 
       transaction_qty,
       CASE WHEN transaction_qty = 1 THEN 'Single'
            WHEN transaction_qty BETWEEN 2 AND 4 THEN 'Small Order'
            ELSE 'Bulk Order' END                                        AS Order_Size,
 
       unit_price,                                                       -- original text value, kept for audit
       unit_price_clean,
       total_amount,
       CASE WHEN total_amount >= 20 THEN 'High'
            WHEN total_amount >= 10 THEN 'Medium'
            ELSE 'Low' END                                               AS Spending_Level,
 
       store_id,
       store_location,
       product_id,
       product_category,                                                 -- original category from the source table
 
       -- Broader grouping built from the original category and type.
       -- ILIKE ignores upper/lower case. Check it against the list from EDA step 0.5.
       CASE WHEN product_category ILIKE '%coffee%'    OR product_type ILIKE '%coffee%'
                 OR product_type  ILIKE '%espresso%'  OR product_type ILIKE '%beans%'  THEN 'Coffee'
            WHEN product_category ILIKE '%tea%'       OR product_type ILIKE '%tea%'    THEN 'Tea'
            WHEN product_category ILIKE '%chocolate%' OR product_type ILIKE '%chocolate%' THEN 'Chocolate'
            WHEN product_category ILIKE '%bakery%'                                     THEN 'Bakery'
            ELSE 'Other' END                                             AS Product_Group,
       product_type,
       product_detail
FROM base;

---------------------------------------BIG QUERY COMPLETE---------------------------------------------------

--Viewing the Big Table I created, and will download which I will use to create my dashboard and do analysis
SELECT *
FROM shop.coffee_data.sale_clean_model;
