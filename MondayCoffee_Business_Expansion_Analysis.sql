-- Question 1: Coffee Consumer Estimate 
-- 25% of each city's population as estimated coffee consumers
SELECT
    city_name,
    ROUND((population * 0.25) / 1000000, 2) AS million_consumers_per_city
FROM city
ORDER BY million_consumers_per_city DESC;

--Question 2: Total Revenue - Q4 2023
-- Total revenue per city for Oct–Dec 2023
SELECT
    ct.city_name,
    ROUND(SUM(s.total)::numeric, 2) AS total_revenue
FROM sales s
JOIN customers cs ON s.customer_id = cs.customer_id
JOIN city c     ON cu.city_id    = ci.city_id
WHERE EXTRACT(YEAR FROM s.sale_date) = 2023
  AND  EXTRACT(QUARTER FROM s.sale_date) = 4
GROUP BY ci.city_name
ORDER BY total_revenue DESC;


-- Question 3: Sales Volume by Product
-- Total units sold per product, best-seller first
SELECT
    p.product_name,
    COUNT(s.sales_id) AS units_sold
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;


-- Question 4: Average Sales per Customer by City
-- Total revenue, customer count and average sale per customer per city
SELECT
    ct.city_name,
    SUM(s.total) AS total_revenue,
    COUNT(DISTINCT s.customer_id) AS customer_count,
    ROUND(SUM(s.total)/COUNT(DISTINCT s.customer_id),2) AS avg_sale_per_customer
FROM sales s
JOIN customers cs
    ON s.customer_id = cs.customer_id
JOIN city ct
    ON cs.city_id = ct.city_id
GROUP BY ct.city_name
ORDER BY total_revenue DESC;


-- Question 5: Current Customers vs Estimated Coffee Consumers
WITH city_consumers AS (
    SELECT
        city_id,
        city_name,
        ROUND((population * 0.25) / 1000000,2) AS estimated_coffee_consumers
    FROM city
)
SELECT
    cc.city_name,
    cc.estimated_coffee_consumers,
    COUNT(DISTINCT s.customer_id) AS actual_current_customers
FROM city_consumers cc
LEFT JOIN customers cs
    ON cc.city_id = cs.city_id
LEFT JOIN sales s
    ON cs.customer_id = s.customer_id
GROUP BY
    cc.city_name,
    cc.estimated_coffee_consumers
ORDER BY estimated_coffee_consumers DESC;


-- Question 6: Top 3 Products per City
WITH ranked AS (
    SELECT
        ct.city_name,
        p.product_name,
        COUNT(s.sales_id) AS number_of_orders,
		RANK() OVER (PARTITION BY ct.city_name ORDER BY COUNT(s.sales_id) DESC
        ) AS rnk
    FROM sales s
    JOIN customers cs
        ON s.customer_id = cs.customer_id
    JOIN city ct
        ON cs.city_id = ct.city_id
    JOIN products p
        ON s.product_id = p.product_id
    GROUP BY
        ct.city_name,
        p.product_name
)
SELECT
    city_name,
    product_name,
    number_of_orders,
    rnk
FROM ranked
WHERE rnk <= 3
ORDER BY city_name, rnk;


-- Question 7: Unique Customers per City
SELECT
    ct.city_id,
    ct.city_name,
    COUNT(DISTINCT s.customer_id) AS unique_customers
FROM sales s
JOIN customers cs
    ON s.customer_id = cs.customer_id
JOIN city ct
    ON cs.city_id = ct.city_id
GROUP BY
    ct.city_id,
    ct.city_name
ORDER BY unique_customers DESC;


-- Question 8: Average Sale vs Average Rent per Customer
-- Compare spending power against occupancy cost per customer
SELECT
    ct.city_name,
    ROUND(SUM(s.total) / COUNT(DISTINCT s.customer_id), 2) AS avg_sale_per_customer,
    ROUND(ct.estimated_rent / COUNT(DISTINCT s.customer_id), 2) AS avg_rent_per_customer
FROM sales s
JOIN customers cs
    ON s.customer_id = cs.customer_id
JOIN city ct
    ON cs.city_id = ct.city_id
GROUP BY
    ct.city_name,
    ct.estimated_rent
ORDER BY avg_sale_per_customer DESC;


-- Question 9: Month-on-Month Sales Growth
-- Using LAG() and CTEs
WITH monthly AS (
    SELECT
        ct.city_name,
        DATE_TRUNC('month', s.sales_date) AS sale_month,
        SUM(s.total) AS monthly_revenue
    FROM sales s
    JOIN customers cs
        ON s.customer_id = cs.customer_id
    JOIN city ct
        ON cs.city_id = ct.city_id
    GROUP BY
        ct.city_name,
        sale_month
),
mom AS (
    SELECT
        city_name,
        sale_month,
        ROUND(monthly_revenue::numeric, 2) AS revenue,
        ROUND((monthly_revenue -
			LAG(monthly_revenue) OVER (PARTITION BY city_name ORDER BY sale_month))/ 
			LAG(monthly_revenue) OVER (PARTITION BY city_name ORDER BY sale_month)
		* 100,2) AS mom_growth_pct
    FROM monthly
)
SELECT *
FROM mom
WHERE mom_growth_pct IS NOT NULL
ORDER BY city_name, sale_month;


-- Question 10: Market Potential Summary
SELECT
    ct.city_name,
    SUM(s.total) AS total_revenue,
    ct.estimated_rent,
    COUNT(DISTINCT s.customer_id) AS total_customers,
    ROUND((ct.population * 0.25) / 1000000, 2) AS est_consumers_millions,
    ROUND(SUM(s.total) / COUNT(DISTINCT s.customer_id), 2) AS avg_sale_per_customer,
    ROUND(ct.estimated_rent / COUNT(DISTINCT s.customer_id), 2) AS avg_rent_per_customer
FROM sales s
JOIN customers cs
    ON s.customer_id = cs.customer_id
JOIN city ct
    ON cs.city_id = ct.city_id
GROUP BY
    ct.city_name,
    ct.estimated_rent,
    ct.population
ORDER BY total_revenue DESC;


-- Question 11: Highest Average Product Rating per City
SELECT
    ct.city_name,
    ROUND(AVG(s.rating),2) AS avg_rating,
    COUNT(s.sales_id) AS total_reviews
FROM sales s
JOIN customers cs
    ON s.customer_id = cs.customer_id
JOIN city ct
    ON cs.city_id = ct.city_id
WHERE s.rating IS NOT NULL
GROUP BY ct.city_name
ORDER BY avg_rating DESC;


-- Question 12: Revenue Concentration
-- Are sales driven by a small loyal base or broadly distributed?
WITH customer_spend AS (
    SELECT
        cs.city_id,
        s.customer_id,
        SUM(s.total) AS spend,
        NTILE(5) OVER (PARTITION BY cs.city_id ORDER BY SUM(s.total) DESC) AS quintile
    FROM sales s
    JOIN customers cs
        ON s.customer_id = cs.customer_id
    GROUP BY
        cs.city_id,
        s.customer_id
)
SELECT
    ct.city_name,
    ROUND(SUM(CASE WHEN quintile = 1 THEN spend
                ELSE 0
              END)
        /SUM(spend)* 100, 1) AS top20_revenue_pct
FROM customer_spend csp
JOIN city ct
    ON csp.city_id = ct.city_id
GROUP BY ct.city_name
ORDER BY top20_revenue_pct DESC;


-- Question 13: Average Days Between Purchases per City
-- Measure customer loyalty and repeat buying behavior
WITH gaps AS (
    SELECT
        cs.city_id,
        s.customer_id,
        s.sales_date,
        LAG(s.sales_date) OVER (PARTITION BY s.customer_id ORDER BY s.sales_date
        ) AS prev_sale
    FROM sales s
    JOIN customers cs
        ON s.customer_id = cs.customer_id
)
SELECT
    ct.city_name,
    ROUND(
        AVG(sales_date - prev_sale),
        2
    ) AS avg_days_between_purchases
FROM gaps g
JOIN city ct
    ON g.city_id = ct.city_id
WHERE prev_sale IS NOT NULL
GROUP BY ct.city_name
ORDER BY avg_days_between_purchases;