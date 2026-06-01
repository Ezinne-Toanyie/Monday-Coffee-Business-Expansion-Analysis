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

### Database Schema (ERD)

*(Insert ERD Screenshot Here)*

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

### Entity Relationships

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

### Question 1 — Coffee Consumer Estimate

**Objective:**
Estimate coffee consumers per city by assuming **25% of each city's population** are coffee consumers.

**Tables Used:** `city`

**SQL Concepts Used:**

* SELECT
* Calculated columns
* ROUND()
* ORDER BY

**Key Finding:**
Cities with larger populations represent stronger long-term market opportunities.

*(Insert output screenshot here)*

---

### Question 2 — Total Revenue (Q4 2023)

**Objective:**
Calculate total city revenue during **Q4 2023 (October–December)**.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* INNER JOIN
* SUM()
* EXTRACT()
* GROUP BY
* WHERE filtering

**Key Finding:**
Pune generated the highest total revenue.

*(Insert output screenshot here)*

---

### Question 3 — Sales Volume by Product

**Objective:**
Identify the highest-selling products.

**Tables Used:** `sales`, `products`

**SQL Concepts Used:**

* COUNT()
* GROUP BY
* JOIN
* ORDER BY

**Key Finding:**
Best-selling products indicate dominant customer preferences.

*(Insert output screenshot here)*

---

### Question 4 — Average Sales per Customer by City

**Objective:**
Measure customer spending behaviour across cities.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* SUM()
* COUNT(DISTINCT)
* Aggregation
* GROUP BY

**Key Finding:**
Higher average sales per customer suggest stronger customer purchasing power.

*(Insert output screenshot here)*

---

### Question 5 — Current Customers vs Estimated Coffee Consumers

**Objective:**
Compare actual customer counts against estimated market size.

**Tables Used:** `city`, `customers`, `sales`

**SQL Concepts Used:**

* CTEs
* LEFT JOIN
* COUNT(DISTINCT)

**Key Finding:**
Delhi showed the highest estimated coffee consumer market.

*(Insert output screenshot here)*

---

### Question 6 — Top 3 Products per City

**Objective:**
Identify leading products within each city.

**Tables Used:** `sales`, `customers`, `city`, `products`

**SQL Concepts Used:**

* CTE
* Window Functions
* RANK()
* PARTITION BY

**Key Finding:**
Product demand varies by city.

*(Insert output screenshot here)*

---

### Question 7 — Unique Customers per City

**Objective:**
Measure customer reach per city.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* COUNT(DISTINCT)
* GROUP BY
* JOIN

**Key Finding:**
Jaipur recorded the highest unique customer count.

*(Insert output screenshot here)*

---

### Question 8 — Average Sale vs Average Rent per Customer

**Objective:**
Compare customer spending power against operating cost efficiency.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* Calculated metrics
* Aggregation
* GROUP BY

**Key Finding:**
Jaipur and Pune demonstrated strong rent efficiency.

*(Insert output screenshot here)*

---

### Question 9 — Month-on-Month Sales Growth

**Objective:**
Measure monthly revenue growth trends.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* DATE_TRUNC()
* LAG()
* Window Functions
* CTEs

**Key Finding:**
Positive month-on-month growth indicates expanding demand.

*(Insert output screenshot here)*

---

### Question 10 — Market Potential Summary

**Objective:**
Build a consolidated market performance comparison.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* Aggregations
* Calculated fields
* GROUP BY
* Multi-table JOINs

**Key Finding:**
Cities can be evaluated simultaneously using revenue, customers, rent, and estimated consumer size.

*(Insert output screenshot here)*

---

### Question 11 — Highest Average Product Rating by City

**Objective:**
Evaluate customer experience and satisfaction levels.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* AVG()
* Aggregation
* NULL filtering

**Key Finding:**
Higher average ratings suggest stronger product-market fit.

*(Insert output screenshot here)*

---

### Question 12 — Revenue Concentration Analysis

**Objective:**
Determine whether city revenue depends heavily on top-spending customers.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* NTILE()
* CASE expressions
* Window Functions
* CTEs

**Key Finding:**
Lower revenue concentration indicates broader customer participation.

*(Insert output screenshot here)*

---

### Question 13 — Average Days Between Purchases

**Objective:**
Measure repeat purchasing behaviour and customer loyalty.

**Tables Used:** `sales`, `customers`, `city`

**SQL Concepts Used:**

* LAG()
* Date calculations
* Window Functions
* CTEs

**Key Finding:**
Shorter repurchase intervals indicate stronger customer loyalty.

*(Insert output screenshot here)*

---

## 4. Results

The analysis identified the strongest expansion candidates:

| City   | Primary Strength                                                   |
| ------ | ------------------------------------------------------------------ |
| Pune   | Highest revenue, strong spending power, strong rent efficiency     |
| Delhi  | Largest estimated consumer market and long-term growth opportunity |
| Jaipur | Highest customer count and lowest rent per customer                |

### Recommended Expansion Order

1. **Pune**
2. **Delhi**
3. **Jaipur**

*(Insert result screenshots and summary visuals here.)*

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

**Phase 1:** Pune
**Phase 2:** Delhi
**Phase 3:** Jaipur

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
