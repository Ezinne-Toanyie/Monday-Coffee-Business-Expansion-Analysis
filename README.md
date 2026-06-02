# Monday Coffee Expansion Analysis 

## 1. Problem Statement

Monday Coffee plans to expand by opening its first physical store locations. The objective of this project is to use SQL-based data analysis to identify the **top three cities** that offer the strongest business opportunity for expansion.

The analysis evaluates:

* Revenue performance
* Customer demand
* Market size and estimated consumer potential
* Cost efficiency (rent versus customer base)
* Product popularity
* Customer loyalty and purchasing behaviour

The final goal is to make a **data-driven recommendation** for the most suitable cities for Monday Coffee’s first physical stores.

---

## 2. Data Description

The project uses a **relational PostgreSQL database** composed of four connected tables: **city, customers, products, and sales**.

The database structure supports business intelligence analysis by linking **customer purchases, products, and city-level market information**.



### Table 1: `city`

Stores city-level information used for market sizing and operating cost analysis.

| Column         | Data Type     | Description                 |
| -------------- | ------------- | --------------------------- |
| city_id        | INTEGER       | Primary key                 |
| city_name      | VARCHAR(15)   | Name of city                |
| population     | BIGINT        | Total city population       |
| estimated_rent | NUMERIC(10,2) | Estimated store rental cost |
| city_rank      | INTEGER       | City ranking                |

**Purpose:**
Used to evaluate **market potential, estimated coffee consumer base, and occupancy cost efficiency**.

![city-table.png](https://i.postimg.cc/yYYQ8FKx/city-table.png)

---

### Table 2: `customers`

Stores customer identity and geographic association.

| Column        | Data Type   | Description                  |
| ------------- | ----------- | ---------------------------- |
| customer_id   | INTEGER     | Primary key                  |
| customer_name | VARCHAR(50) | Customer name                |
| city_id       | INTEGER     | Foreign key → `city.city_id` |

**Purpose:**
Connects customers to cities for **location-based revenue and customer analysis**.

![customers-table.png](https://i.postimg.cc/t4djG3NG/customers-table.png)

---

### Table 3: `products`

Stores product catalog information.

| Column       | Data Type     | Description           |
| ------------ | ------------- | --------------------- |
| product_id   | INTEGER       | Primary key           |
| product_name | VARCHAR(35)   | Coffee product name   |
| price        | NUMERIC(10,2) | Product selling price |

**Purpose:**
Used to analyse **product popularity, product sales volume, and purchasing patterns**.

![products-table.png](https://i.postimg.cc/4xp9CSSj/products-table.png)

---

### Table 4: `sales`

Contains transaction-level sales data.

| Column      | Data Type     | Description                           |
| ----------- | ------------- | ------------------------------------- |
| sales_id    | INTEGER       | Primary key                           |
| sales_date  | DATE          | Transaction date                      |
| product_id  | INTEGER       | Foreign key → `products.product_id`   |
| customer_id | INTEGER       | Foreign key → `customers.customer_id` |
| total       | NUMERIC(10,2) | Transaction revenue                   |
| rating      | INTEGER       | Customer satisfaction score           |

**Purpose:**
Acts as the **core transactional table** used for revenue analysis, customer behaviour analysis, growth tracking, and performance measurement.

![sales-table.png](https://i.postimg.cc/VLxKB2Mr/sales-table.png)

---

### Entity Relationships

#### Database Schema(ERD)

![Monday-Coffee-ERD.png](https://i.postimg.cc/W3ZRS0zb/Monday-Coffee-ERD.png)

The schema contains three major one-to-many relationships:

* **City → Customers:** One city can contain many customers.
* **Customers → Sales:** One customer can generate multiple transactions.
* **Products → Sales:** One product can appear in multiple sales records.

This relational design supports:

* Revenue analysis
* Customer segmentation
* Product performance analysis
* Geographic market evaluation
* Customer loyalty analysis
* Business expansion recommendations

---

## 3. Methodology (Questions and SQL Analysis)

The analysis was completed using thirteen SQL business questions.

### Question 1: Coffee Consumer Estimate(in millions)

Estimate coffee consumers per city by assuming **25% of each city's population** are coffee consumers.

![Q1.png](https://i.postimg.cc/vZQwt1fp/Q1.png)
#### Data Output
![Data-Output-1.png](https://i.postimg.cc/63QsJFMW/Data-Output-1.png)

---

### Question 2: Total Revenue (Q4 2023)

Calculate total city revenue during **Q4 2023 (October–December)**.

![Q2.png](https://i.postimg.cc/gcCZjp8C/Q2.png)
#### Data Output
![Data-Output-2.png](https://i.postimg.cc/hGvjMZVz/Data-Output-2.png)

---

### Question 3: Sales Volume by Product

Identify the highest-selling products.

![Q3.png](https://i.postimg.cc/t4htpTcJ/Q3.png)
#### Data Output
![Data-Output-3.png](https://i.postimg.cc/sDgtBFzx/Data-Output-3.png)

---

### Question 4: Average Sales per Customer by City

Measure customer spending behaviour across cities.

![Q4.png](https://i.postimg.cc/Bvz54V38/Q4.png)
#### Data Output
![Data-Output-4.png](https://i.postimg.cc/pXPjbHjc/Data-Output-4.png)

---

### Question 5: Current Customers vs Estimated Coffee Consumers

Compare actual customer counts against estimated market size.

![Q5.png](https://i.postimg.cc/pTdS17Zv/Q5.png)
#### Data Output
![Data-Output-5.png](https://i.postimg.cc/3wj7HPmz/Data-Output-5.png)

---

### Question 6: Top 3 Products per City

Identify leading products within each city.

![Q6.png](https://i.postimg.cc/PqJcS9KQ/Q6.png)
#### Data Output
![Data-Output-6.png](https://i.postimg.cc/kGvfJvfC/Data-Output-6.png)

---

### Question 7: Unique Customers per City

Measure customer reach per city.

![Q7.png](https://i.postimg.cc/RhWZ9gMS/Q7.png)
#### Data Output
![Data-Output-7.png](https://i.postimg.cc/zfYb7Yqw/Data-Output-7.png)

---

### Question 8: Average Sale vs Average Rent per Customer

Compare customer spending power against operating cost efficiency.

![Q8.png](https://i.postimg.cc/XY4XBcLR/Q8.png)
#### Data Output
![Data-Output-8.png](https://i.postimg.cc/0N6vzbT3/Data-Output-8.png)

---

### Question 9: Month-on-Month Sales Growth

Measure monthly revenue growth trends.

![Q9.png](https://i.postimg.cc/qMYjkqGB/Q9.png)
#### Data Output
![Data-Output-9.png](https://i.postimg.cc/4yfFh0Kd/Data-Output-9.png)

---

### Question 10: Market Potential Summary

Build a consolidated market performance comparison using revenue, customer count, rent and estimated consumer size.

![Q10.png](https://i.postimg.cc/0y0n7ns7/Q10.png)
#### Data Output
![Data-Output-10.png](https://i.postimg.cc/mrh9hyZw/Data-Output-10.png)

---

### Question 11: Highest Average Product Rating by City

Evaluate customer experience and satisfaction levels.

![Q11.png](https://i.postimg.cc/J42MMNgD/Q11.png)
#### Data Output
![Data-Output-11.png](https://i.postimg.cc/zGvvkXmw/Data-Output-11.png)

---

### Question 12: Revenue Concentration Analysis

Determine whether city revenue depends heavily on top-spending customers.

![Q12.png](https://i.postimg.cc/3JV5PK4J/Q12.png)
#### Data Output
![Data-Output-12.png](https://i.postimg.cc/xCT4X7N8/Data-Output-12.png)

---

### Question 13: Average Days Between Purchases

Measure repeat purchasing behaviour and customer loyalty.

![Q13.png](https://i.postimg.cc/C58X08ff/Q13.png)
#### Data Output
![Data-Output-13.png](https://i.postimg.cc/tTM2YgHz/Data-Output-13.png)

---

## 4. Results

The analysis identified the strongest expansion candidates:

| City   | Primary Strength                                                   |
| ------ | ------------------------------------------------------------------ |
| Pune   | Highest revenue, strong spending power, strong rent efficiency     |
| Delhi  | Largest estimated consumer market and long-term growth opportunity |
| Jaipur | Highest customer count and lowest rent per customer                |


---

## 5. SQL Concepts Used

This project applied multiple SQL analytical techniques:

* SELECT statements
* WHERE filtering
* ORDER BY sorting
* Aggregate functions (`SUM`, `COUNT`, `AVG`)
* `COUNT(DISTINCT)`
* `GROUP BY`
* INNER JOIN
* LEFT JOIN
* Common Table Expressions (CTEs)
* Window Functions
* `RANK()`
* `NTILE()`
* `LAG()`
* `DATE_TRUNC()`
* `EXTRACT()`
* Calculated columns
* CASE expressions

---

## 6. Key Insights and Recommendations

### Pune — Best Overall Expansion Choice

Pune is recommended as the strongest launch city because it combines:

* Highest Q4 revenue
* Strong average customer spending
* Strong rent efficiency
* Balanced profitability indicators

### Delhi — Largest Market Opportunity

Delhi is recommended for long-term growth because of:

* Largest estimated coffee consumer base (~7.7 million)
* High customer participation
* Strong expansion potential

### Jaipur — Most Cost-Efficient Market

Jaipur stands out because it offers:

* Highest unique customer count
* Lowest average rent per customer
* Healthy customer spending behaviour

### Strategic Recommendation

A phased launch strategy is recommended:

* **Phase 1:** Pune
* **Phase 2:** Delhi
* **Phase 3:** Jaipur

This balances **immediate profitability, long-term growth potential, and operational efficiency**.

---

## 7. Limitations and Future Work

### Limitations

* Analysis uses historical transaction data only.
* Coffee consumer estimation assumes **25% of city population** are coffee consumers.
* External factors such as competition, demographics, income distribution, and foot traffic were unavailable.
* Limited time coverage may not fully capture seasonality.

### Future Work

Future analysis could incorporate:

* Predictive sales forecasting
* Customer segmentation
* Geographic location intelligence
* Competitor benchmarking
* Demand forecasting models
* Customer lifetime value analysis

These additions would improve future expansion planning accuracy.
