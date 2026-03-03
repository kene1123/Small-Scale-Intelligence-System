CREATE OR REPLACE VIEW vw_weekly_customer_sales AS
SELECT
    c.customer_name,
	c.email,
    d.year,
    d.week,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    COUNT(DISTINCT o.order_id) AS orders_count
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN dim_customer c ON o.customer_id = c.customer_id
JOIN dim_date d ON o.order_date = d.date
GROUP BY c.customer_name, c.email, d.year, d.week
ORDER BY d.year, d.week, revenue DESC;