DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales;


CREATE TABLE city (
	city_id INT PRIMARY KEY,
	city_name VARCHAR(15),
	population BIGINT,
	estimated_rent NUMERIC(10,2),
	city_rank INT
);

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(50),
	city_id INT,
CONSTRAINT fk_customer_city
	FOREIGN KEY(city_id) REFERENCES city(city_id)
);

CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(35),
	price NUMERIC(10,2)
);

CREATE TABLE sales (
	sales_id INT PRIMARY KEY,
	sales_date DATE,
	product_id INT NOT NULL,
	customer_id INT NOT NULL,
	total NUMERIC(10,2) NOT NULL,
	rating INT,
	
CONSTRAINT fk_sales_product
	FOREIGN KEY(product_id) REFERENCES products(product_id),

CONSTRAINT fk_sales_customer
	FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);
