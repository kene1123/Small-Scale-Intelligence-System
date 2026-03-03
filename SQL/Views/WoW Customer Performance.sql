CREATE OR REPLACE VIEW vw_weekly_customer_wow AS
SELECT
    c.customer_id,
    c.customer_name,
    d.year,
    d.week,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    LAG(SUM(oi.quantity * oi.unit_price)) 
        OVER (PARTITION BY c.customer_id ORDER BY d.year, d.week) AS prev_week_revenue,
	c.email	
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN dim_customer c ON o.customer_id = c.customer_id
JOIN dim_date d ON o.order_date = d.date
GROUP BY c.customer_id, c.customer_name, d.year, d.week;