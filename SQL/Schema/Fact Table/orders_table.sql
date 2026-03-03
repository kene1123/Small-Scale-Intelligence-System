CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    customer_id INT REFERENCES dim_customer(customer_id),
    sales_rep_id INT REFERENCES dim_sales_rep(sales_rep_id)
);
INSERT INTO orders (order_date, customer_id, sales_rep_id)
SELECT
    d.date,
    (random() * 499 + 1)::INT,
    (random() * 39 + 1)::INT
FROM dim_date d
WHERE random() < 0.30;
SELECT * FROM orders;
