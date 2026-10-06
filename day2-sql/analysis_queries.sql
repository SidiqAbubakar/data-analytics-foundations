CREATE TABLE products(
product_id text PRIMARY KEY,
product_name text NOT NULL,
category text, 
standard_unit_price INT NOT NULL
);

CREATE TABLE customers(
customer_id TEXT PRIMARY KEY,
customer_name TEXT,
region TEXT
);

CREATE TABLE orders(
order_id TEXT PRIMARY KEY,
order_date date,
customer_id TEXT REFERENCES customers(customer_id),
product_id TEXT REFERENCES products(product_id),
quantity INT,
unit_price int,
salesperson TEXT
);

ALTER TABLE orders
ALTER COLUMN unit_price TYPE numeric(12,2);

select *
from orders;

-- 1. How many orders are in the data?  
select sum(quantity) AS total_orders
from orders;
/*
Answer:
The total number of orders processed by the company within the period of study is  2,272.
*/



-- 2. What is total revenue?  		Ans: 4,731,304.02
SELECT SUM(quantity * unit_price) AS "Total_Revenue"
FROM orders;
/*
A total revenue of 4,731,304.02 GHS was generated over the transactional period.
*/




-- 3. How many unique customers are there?  Ans: 180
SELECT COUNT (DISTINCT customer_id)
FROM orders;

--Answer:
/*
Although the company recorded 2,272 orders in general, the unique customer base was 180.
*/


-- 4. What is the average order value?    	Ans: 1.89 ~ 2
SELECT ROUND(AVG(quantity),2)
FROM orders;
--Answer:
/*
The average order value stood at 1.89. This indicates approximately 2 orders per transaction.
*/



-- 5. Which five products generate the most revenue?
SELECT 
product_id,
SUM(quantity * unit_price) AS Revenue 
FROM orders
GROUP BY product_id
ORDER BY SUM(quantity * unit_price) DESC
LIMIT 5;
-- Answer
/*
Products P0009, P008, P010, P007, P012 are the five most performing products respectively. The revenue generated
by these products ranges from 218K to a little above 1.4 million GHS.
*/



-- 6. What is revenue by region?
SELECT c.region, 
SUM(o.quantity * o.unit_price) AS Revenue 
FROM customers AS c 
INNER JOIN orders AS o
ON
c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY Revenue DESC;
-- Answer
/*
Greater Accra (1558419.20 GHS) and Ashanti (1422383.92 GHS) massively dominated the regional revenue trend with,
Volta been the least perfoming region.
*/


-- 7. What is revenue by category?
SELECT p.category, SUM(o.quantity * o.unit_price) AS Revenue
FROM products p
INNER JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY Revenue DESC;
-- Answer
/*
Computers generated over 3million GHS, making the most performing category. Accessories and Audio were the least
with revenue around 89k GHS. 
*/


-- 8. How does revenue change by month?
SELECT 
EXTRACT (MONTH FROM order_date) AS order_month,
SUM(quantity * unit_price) AS Revenue
FROM orders
GROUP BY order_month
ORDER BY order_month ASC;
-- Answer
/*
Revenue increases in the first quater, peaks in the third quater before dropping in the last quater.
*/

-- 9. Which salesperson generates the most revenue?
SELECT 
salesperson,
SUM(quantity * unit_price) AS Revenue
FROM orders
GROUP BY salesperson
ORDER BY Revenue DESC;
-- Answer
/*
Esther was the best salesperson with revenue generated of 747,277.78 GHS.
*/


-- 10. Which customers spend the most?
SELECT c.customer_name, 
SUM(o.quantity * o.unit_price) AS Revenue
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY Revenue DESC;
-- Answer
/*
Priscilla Owusu (143462.35), Daniel Osei (129150.74), Daniel Addo (115395.00), Linda Antwi (101071.70) and 
Kojo Adjei (100111.41) were the 5 customers with the most spending.
*/

-- 11. Which categories exceed a chosen revenue threshold?
SELECT p.category,
SUM(o.quantity * o.unit_price) AS Revenue
FROM products p
INNER JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.quantity * o.unit_price) >= 300000;
-- Answer 
/*
Computers, Displays, and Furniture were the only categories with revenues above 300,000.00 GHS.
*/


-- 12. What additional business question can you answer from the data?
SELECT c.customer_name, o.quantity, SUM(o.quantity * o.unit_price) AS revenue
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name, o.quantity
ORDER BY revenue DESC;
--Answer 
/*
The query above answers the question on whether customer spending is the directly proportional to the quantity of
items purchased.
That is not really the case because, both Esi Owusu and Priscilla Owusa bought 5 quantity items but at
varying costs.
*/
