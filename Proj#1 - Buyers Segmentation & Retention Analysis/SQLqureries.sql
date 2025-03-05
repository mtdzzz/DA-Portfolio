-- Remove duplicate in Customer_id (table Orders)
DELETE FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM (
        SELECT customer_id, ROW_NUMBER() OVER (PARTITION BY customer_unique_id ORDER BY customer_id) AS row_num
        FROM customers
    ) t
    WHERE t.row_num > 1
);

-- Calculate Buyers Performance Metrics: Purchase frequency, Total spend, Retention days and Retention status
select
	c.customer_unique_id,
	c.customer_id,
	o.order_id,
	o.order_status,
	count(distinct o.order_id) as purchase_frequency,
	sum(p.payment_value) as total_spent,
	min(o.order_purchase_timestamp) as first_purchase_date,
	max(o.order_purchase_timestamp) as last_purchase_date,
	DATEDIFF(day, min(o.order_purchase_timestamp),max(o.order_purchase_timestamp)) as retention_days,
	CASE 
        WHEN count(o.order_id) > 1 THEN 'Retained'
        ELSE 'One-time Buyer'
    END AS is_retained
from orders o
join customers c on o.customer_id = c.customer_id
join order_payments p on p.order_id = o.order_id
group by c.customer_unique_id, c.customer_id, o.order_id, o.order_status
having o.order_status = 'delivered' 
------------------------------------------------------------------------------------------------------------
-- Create RFM Base table
WITH rfm_base AS (
    SELECT
        c.customer_unique_id,
		o.customer_id,
        MIN(o.order_purchase_timestamp) AS first_purchase_date,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(o.order_id) AS purchase_frequency,
        SUM(oi.price + oi.freight_value) AS total_spend
    FROM [Brazil Ecommerce].[dbo].[orders] o
    JOIN [Brazil Ecommerce].[dbo].[customers] c ON o.customer_id = c.customer_id
    JOIN [Brazil Ecommerce].[dbo].[order_items] oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id, o.customer_id
),
---- Create RFM Score table
rfm_score as (
select
	customer_unique_id,
	DATEDIFF(day, first_purchase_date,(SELECT MAX(order_purchase_timestamp) FROM [Brazil Ecommerce].[dbo].[orders])) AS Recency_value,
	purchase_frequency as Frequency_value,
	total_spend as Monetary_value,
	NTILE(5) OVER (ORDER BY DATEDIFF(DAY, last_purchase_date, (SELECT MAX(order_purchase_timestamp) FROM [Brazil Ecommerce].[dbo].[orders])) DESC) AS R_score,
    NTILE(5) OVER (ORDER BY purchase_frequency) AS F_score,
    NTILE(5) OVER (ORDER BY total_spend) AS M_score
FROM rfm_base
),
rfm_final as (
select *,
	CAST(CONCAT(R_score, F_score, M_score) as varchar) AS RFM_score
from rfm_score
)

-- Create RFM segmentation
select *,
	CASE
        WHEN R_score IN (4, 5) AND F_score IN (4, 5) AND M_score IN (4, 5) THEN 'Loyal Customers'
        WHEN R_score IN (3, 4) AND F_score IN (3, 4) THEN 'Frequent Buyers'
        WHEN R_score IN (1, 2) AND F_score IN (3, 4) AND M_score IN (4, 5) THEN 'Churn Risk'
        WHEN R_score IN (4, 5) AND F_score IN (1, 2) THEN 'New Customers'
        ELSE 'Lost Customers'
    END AS customer_segment
from rfm_final
------------------------------------------------------------------------------------------------------------

-- Identify First Purchase Month (Cohort Month)
WITH Cohort_month AS (
    SELECT
        c.customer_unique_id,
        MIN(CONVERT(DATE, o.order_purchase_timestamp)) AS first_purchase_date,
        FORMAT(MIN(o.order_purchase_timestamp), 'yyyy-MM') AS cohort_month
    FROM [Brazil Ecommerce].[dbo].[orders] o
    JOIN [Brazil Ecommerce].[dbo].[customers] c 
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'  -- Only consider completed purchases
    GROUP BY c.customer_unique_id
),

-- Count Total Buyers Per Cohort Month
Cohort_size AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT customer_unique_id) AS total_buyers
    FROM Cohort_month
    GROUP BY cohort_month
),

-- Assign Month Number to Each Order, Ensuring No Negative Values
Buyer_orders AS (
    SELECT 
        c.customer_unique_id,
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS purchase_month,  -- Current order month
        cm.cohort_month,
        CASE 
            WHEN DATEDIFF(MONTH, cm.first_purchase_date, o.order_purchase_timestamp) < 0 
            THEN 0  -- Prevent negative values
            ELSE DATEDIFF(MONTH, cm.first_purchase_date, o.order_purchase_timestamp)
        END AS month_number
    FROM [Brazil Ecommerce].[dbo].[orders] o
    JOIN [Brazil Ecommerce].[dbo].[customers] c 
        ON o.customer_id = c.customer_id
    JOIN Cohort_month cm 
        ON c.customer_unique_id = cm.customer_unique_id
    WHERE o.order_status = 'delivered'  -- Ensure only valid purchases are counted
)

-- Calculate Retention Rate by Month Number
SELECT 
    bo.cohort_month,
    bo.month_number,
    cs.total_buyers,
    COUNT(DISTINCT bo.customer_unique_id) AS retained_buyers,
    ROUND((CAST(COUNT(DISTINCT bo.customer_unique_id) AS FLOAT) / cs.total_buyers) * 100, 2) AS retention_rate
FROM Buyer_orders bo
JOIN Cohort_size cs 
    ON bo.cohort_month = cs.cohort_month
GROUP BY bo.cohort_month, bo.month_number, cs.total_buyers
ORDER BY bo.cohort_month, bo.month_number;


