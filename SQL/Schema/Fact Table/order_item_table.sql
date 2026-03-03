CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES dim_product(product_id),
    quantity INT,
    unit_price NUMERIC(10,2)
);
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT
    o.order_id,
    (random() * 49 + 1)::INT,
    (random() * 4 + 1)::INT,
    ROUND((random() * 300 + 20)::NUMERIC, 2)
FROM orders o
JOIN generate_series(1, (FLOOR(random() * 3 + 1))::INT) gs ON true;
SELECT * FROM order_items;