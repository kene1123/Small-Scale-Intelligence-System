CREATE OR REPLACE VIEW vw_weekly_product AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    d.year,
    d.week,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    SUM(oi.quantity) AS units_sold,
    DENSE_RANK() OVER (PARTITION BY d.year, d.week ORDER BY SUM(oi.quantity) DESC) AS demand_rank
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN dim_product p ON oi.product_id = p.product_id
JOIN dim_date d ON o.order_date = d.date
GROUP BY p.product_id, p.product_name, p.category, d.year, d.week
ORDER BY d.year, d.week, demand_rank;