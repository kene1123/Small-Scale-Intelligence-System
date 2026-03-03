-- Updating date table
INSERT INTO orders (order_date, customer_id, sales_rep_id)
SELECT
    d.date,
    (SELECT customer_id
     FROM dim_customer
     OFFSET floor(random() * (SELECT COUNT(*) FROM dim_customer))
     LIMIT 1),
    (SELECT sales_rep_id
     FROM dim_sales_rep
     OFFSET floor(random() * (SELECT COUNT(*) FROM dim_sales_rep))
     LIMIT 1)
FROM dim_date d
JOIN generate_series(
    1,
    (5 + floor(random() * 20))::int 
) g ON TRUE
WHERE d.date >= '2025-01-01'
  AND d.date <= CURRENT_DATE;
 DELETE FROM orders
WHERE order_date >= '2025-01-01';