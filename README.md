# Bright Coffee Shop Analysis

## 1. Overview of the Case Study

- This project analyses Bright Coffee Shop's sales transactions from **January to June 2023** to identify sales trends, product performance, purchasing patterns and opportunities to improve business performance.
- The main business objective is to understand what drives sales across the coffee shop's three locations and provide data-driven recommendations to **increase revenue, improve product performance and optimise operations**.
- The analysis addresses five key business questions:
  - **Sales Performance:** How are revenue, transactions and units sold performing over time?
  - **Product Performance:** Which products and categories generate the most and least revenue?
  - **Sales Patterns:** Which hours, days and months generate the highest and lowest sales?
  - **Store Performance:** How does sales performance differ across the three locations?
  - **Business Improvement:** What actions can improve underperforming products, increase off-peak sales and support revenue growth?
- The findings were presented through interactive dashboards and a final business presentation containing actionable recommendations.

## 2. Process – How the Case Study Was Done

- **Step 1 – Business Understanding:** Reviewed the case study objectives and identified KPIs, including total revenue, total transactions, units sold, average transaction value and average unit price.
- **Step 2 – Project Planning:** Used Miro to create a project mind map and Gantt chart outlining the analysis workflow, timeline and deliverables.
- **Step 3 – Data Preparation:** Imported the sales dataset into Excel and Databricks, checked for duplicates, missing values, incorrect data types and inconsistencies in transaction and product information.
- **Step 4 – Data Transformation:** Used Databricks SQL to create revenue measures (`quantity × unit_price`), extract year, quarter, month, weekday and hour from transaction dates, and classify transactions into time-of-day intervals. Retained product categories, product types and store locations for analysis.
- **Step 5 – Exploratory Data Analysis:** Used SQL and Excel PivotTables to analyse sales trends, top and bottom products, category performance, peak sales periods, weekday versus weekend revenue and store-level performance.
- **Step 6 – Dashboard Development:** Developed interactive dashboards covering sales overview, product performance, time-of-day analysis, sales trends and store locations, with filters for month, day, location and product category.
- **Step 7 – Insights and Presentation:** Interpreted the findings, developed evidence-based business recommendations and designed a final Canva presentation highlighting sales performance and improvement opportunities.

## 3. Tools Used

- **Databricks SQL:** Data cleaning, transformation, revenue calculations, aggregations and sales analysis.
- **Microsoft Excel:** Data exploration, validation, PivotTables and charts.
- **Databricks Dashboards:** Interactive dashboards, KPIs and sales visualisations.
- **Microsoft Power BI:** Business intelligence dashboards and data visualisation.
- **Google Looker Studio:** Interactive reporting and sales dashboards.
- **Lovable:** Dashboard design and visual presentation of insights.
- **Miro:** Project planning, mind mapping and Gantt chart development.
- **Canva:** Final business presentation design.
- **Microsoft PowerPoint:** Presentation preparation.
- **GitHub:** Project documentation, version control and organisation of deliverables.

## 4. Summary of What Was Done and Found (Insights)

### 4.1 Overall Sales Performance

- Analysed approximately **149,120 transactions**, generating **$698.81K in revenue** and **214,470 units sold**.
- The average transaction value was approximately **$4.69**, while the average unit price was **$3.38**.
- Monthly revenue increased from approximately **$81.68K in January to $166.49K in June 2023**, indicating strong sales growth over the six-month period.

### 4.2 Product Performance

- **Coffee** was the highest-revenue product group, generating **$310.04K**, followed by Tea (**$207.62K**) and Bakery (**$82.32K**).
- **Sustainably Grown Organic Lg** generated approximately **$21.15K**, followed by **Dark chocolate Lg ($21.01K)**, making them the leading products by revenue.
- Lower-performing products included **Earl Grey ($1.27K)** and **Spicy Eye Opener Chai ($1.34K)**.
- **Key Insight:** Coffee and Tea are the main revenue drivers, while selected low-performing products present opportunities for targeted promotions and product optimisation.

### 4.3 Sales by Time of Day

- **Early Morning** generated the highest revenue at approximately **$253.30K**.
- **Evening** recorded the lowest revenue at approximately **$65.67K**.
- Sales were strongest during morning trading hours, with activity declining later in the day.
- **Key Insight:** Morning periods drive a significant portion of revenue, while evening periods present opportunities to increase demand through targeted promotions.

### 4.4 Sales by Day of the Week

- **Monday ($101.68K)** and **Friday ($101.37K)** recorded the highest total revenue.
- Weekday revenue contributed approximately **$503.59K**, compared with **$195.22K** during weekends.
- **Key Insight:** Weekday trading contributes most of the total revenue, highlighting the importance of effective staffing, stock availability and promotions during high-demand periods.

### 4.5 Store Location Performance

- **Hell's Kitchen** contributed approximately **33.84%** of total revenue, followed by **Lower Manhattan (33.23%)** and **Astoria (32.92%)**.
- Revenue was relatively evenly distributed across the three locations, with Hell's Kitchen performing slightly better.
- **Key Insight:** All three stores contribute significantly to overall revenue, providing opportunities to compare product demand, staffing and promotional performance across locations.

### 4.6 Main Business Findings

- Revenue increased over the six-month period, with Coffee and Tea contributing the largest shares of sales.
- High-performing products generated significantly more revenue than several lower-performing tea and chocolate products.
- Morning trading periods were the strongest, while evening periods recorded the lowest revenue.
- Sales performance was relatively balanced across the three store locations.
- The findings highlight opportunities to improve off-peak sales, optimise inventory and strengthen product-level marketing.

## 5. Business Recommendations

### 5.1 Increase Sales During Low-Performing Hours

- **Evidence:** Evening sales generated only **$65.67K**, compared with **$253.30K** during early morning periods.
- **Recommendation:** Introduce evening discounts, coffee-and-snack bundles and targeted promotions to attract customers during quieter periods.
- **Expected Benefit:** Increase off-peak demand and improve revenue distribution throughout the day.

### 5.2 Prioritise High-Performing Products

- **Evidence:** Coffee generated **$310.04K**, while Sustainably Grown Organic Lg and Dark chocolate Lg were among the highest-revenue individual products.
- **Recommendation:** Maintain sufficient stock of best-selling products, prioritise their availability during peak hours and feature them in promotional campaigns.
- **Expected Benefit:** Reduce potential lost sales from stock shortages and support continued revenue growth.

### 5.3 Improve Underperforming Product Sales

- **Evidence:** Earl Grey generated approximately **$1.27K**, while Spicy Eye Opener Chai generated approximately **$1.34K**.
- **Recommendation:** Introduce product bundles, limited-time discounts and promotional offers to improve awareness and demand for lower-performing products.
- **Expected Benefit:** Increase product visibility, improve sales contribution and identify products that may require changes in pricing or assortment.

### 5.4 Optimise Staffing and Store Operations

- **Evidence:** Early morning generated the highest revenue, while all three locations contributed approximately one-third of total sales.
- **Recommendation:** Align staffing and stock availability with peak demand periods and monitor sales performance across individual stores.
- **Expected Benefit:** Improve service efficiency, reduce operational inefficiencies and support consistent store performance.

### 5.5 Introduce Customer Loyalty Programmes

- **Evidence:** The average transaction value was approximately **$4.69**, providing a baseline for evaluating future purchasing incentives.
- **Recommendation:** Introduce loyalty rewards, repeat-purchase incentives and time-based promotional offers to encourage additional purchases.
- **Expected Benefit:** Increase customer engagement, encourage repeat visits and potentially improve average transaction value.

### 5.6 Improve Sales Monitoring and Decision-Making

- **Evidence:** Sales performance differs by product, time period and store location.
- **Recommendation:** Automate daily sales reporting and use interactive dashboards to monitor revenue, transactions, product performance and store-level trends.
- **Expected Benefit:** Enable faster identification of sales opportunities and support data-driven operational decisions.

### Conclusion

- The analysis identified strong revenue growth, with Coffee and Tea driving sales and morning periods generating the highest revenue.
- Opportunities were identified to improve evening sales, promote underperforming products, optimise inventory and strengthen customer engagement.
- The recommendations provide Bright Coffee Shop with practical, data-driven strategies to improve sales performance, operational efficiency and future revenue growth.