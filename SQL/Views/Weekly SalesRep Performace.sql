CREATE OR REPLACE VIEW vw_weekly_sales_rep AS
SELECT
    sr.sales_rep_id,
    sr.rep_name,
    sr.region,
    sr.state,
    d.year,
    d.week,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    COUNT(DISTINCT o.order_id) AS orders_count,
    DENSE_RANK() OVER (PARTITION BY d.year, d.week ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS weekly_rank
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN dim_sales_rep sr ON o.sales_rep_id = sr.sales_rep_id
JOIN dim_date d ON o.order_date = d.date
GROUP BY sr.sales_rep_id, sr.rep_name, sr.region, sr.state, d.year, d.week
ORDER BY d.year, d.week, weekly_rank;
