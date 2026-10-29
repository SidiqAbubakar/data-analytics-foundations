-- QUESTION 1 :  Calculate monthly revenue and month-on-month performance.
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS sales_month,
        SUM(quantity * unit_price) AS current_month_revenue
    FROM orders
    GROUP BY 1
),
monthly_comparison AS (
	SELECT 
		sales_month,
		current_month_revenue,
		LAG(current_month_revenue) OVER(ORDER BY sales_month) AS previous_month_revenue
	FROM 
		monthly_sales
)
SELECT 
	sales_month,
	current_month_revenue,
	previous_month_revenue,
	ROUND(((current_month_revenue - previous_month_revenue)/ previous_month_revenue )* 100, 2) AS mom_performance
FROM 
	monthly_comparison;
/*
This query calculates monthly revenue, as well determine the month-on-month performance of the company. It helps
the company identify it's month-on-month financial health. 
*/



--QUESTION 2: Rank products by revenue within each category.
WITH product_table AS ( 
	SELECT
		p.product_name AS name,
		p.category AS category,
		SUM(o.quantity * o.unit_price) as revenue
	FROM products p
	INNER JOIN orders o
	ON p.product_id = o.product_id
	GROUP BY 1, 2
)
SELECT 
	name,
	category,
	revenue,
	RANK () OVER( PARTITION BY category ORDER BY revenue DESC) AS product_rank
FROM
	product_table;
/*
The query above ranks the product in each category per revenue generated over the period of study. The result helps
management identify the most and least performing product in each category. 
*/


--QUESTION 3:  Find the top 3 customers in each region by total spend.
WITH region_tab AS (
	SELECT 
		c.customer_name AS customer,
		c.region AS region,
		SUM(o.quantity*unit_price) AS total_spent
	FROM customers c
	INNER JOIN orders o
	ON c.customer_id = o.customer_id
	GROUP BY 1,2
),
rank_tab AS (
	SELECT 
		customer, 
		region,
		total_spent,
		DENSE_RANK() OVER(PARTITION BY region ORDER BY total_spent DESC) AS rank_num
	FROM 
		region_tab
)
SELECT
	customer,
	region,
	total_spent,
	rank_num
FROM 
	rank_tab
WHERE rank_num <=3;
/* 
This query helps identify the companies top 3 performing customers in each region.
It also helps check regional performance of customers.
*/


-- QUESTION 4: Calculate each category's percentage contribution to total revenue.
WITH rev_table AS (
SELECT 
	p.category,
	SUM(o.quantity*o.unit_price) AS revenue
FROM products p
INNER JOIN orders o
ON o.product_id = p.product_id
GROUP BY 1
)
SELECT 
	category,
	revenue,
	ROUND(revenue/SUM(revenue) OVER() * 100,2) AS percentage_contribution
FROM 
	rev_table
ORDER BY 3 DESC;
/*
The query above calculates the percentage contribution of each category to the 
overall revenue generated over the transactional period. This information helps 
management know or identify which category needs more attention to revamp it sales.
*/


-- QUESTION 5: Classify customers into High, Medium and Low value groups using CASE WHEN.
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        SUM(o.quantity * o.unit_price) AS total_spent
    FROM customers c
    LEFT JOIN orders o 
	ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT 
    customer_id,
    customer_name,
    ROUND(total_spent, 2) AS total_spend,
    CASE 
        WHEN total_spent >= 90000 THEN 'High'
        WHEN total_spent >= 10000 AND total_spent < 90000 THEN 'Medium'
        ELSE 'Low'
    END AS customer_segment
FROM customer_spending
ORDER BY total_spend DESC;
/*
The code above segment the customers into high, medium and low levels based on 
their total amount spent. The result helps management know which customers should
be poached with premium subscriptions, or otherwise given discounts to enable them
increase their purchases.
*/

-- QUESTION 6: Identify products or regions whose performance is below an appropriate average/benchmark.
-- FOR PRODUCTS;
WITH product_tab AS (
	SELECT 
		p.product_id,
		p.product_name,
		SUM(o.quantity*unit_price) AS revenue
	FROM 
		products p
	INNER JOIN orders o
	ON p.product_id = o.product_id
	GROUP BY 1,2
),
avg_tab AS (
	SELECT 
		product_id,
		product_name,
		revenue,
		ROUND(AVG(revenue) OVER(),2) AS avg_revenue
	FROM product_tab
)
SELECT 
	product_id,
	product_name,
	revenue,
	avg_revenue
FROM
	avg_tab
WHERE revenue < avg_revenue
ORDER BY revenue DESC;
/* This query identifies items/products whose revenue generated is lesser than the
average revenue of entire transactional period. The result shows quite a great 
difference in individual product revenue against the average revenue, indicating 
purchasing strength in just few poducts.
*/


-- FOR REGION;
WITH region_tab AS (
	SELECT 
		c.region,
		SUM(o.quantity*unit_price) AS revenue
	FROM customers c
	INNER JOIN orders o
	ON c.customer_id = o.customer_id
	GROUP BY 1
),
region_avg AS (
	SELECT 
		region,
		revenue,
		ROUND(AVG(revenue) OVER(), 2) AS avg_revenue
	FROM 
		region_tab
)
SELECT 
	region,
	revenue,
	avg_revenue
FROM 
	region_avg
WHERE revenue < avg_revenue
ORDER BY revenue DESC;

/* Regional performance is key to navigating sales. The query brings to light the 
the regions with revenues below the average revenue generated.
*/