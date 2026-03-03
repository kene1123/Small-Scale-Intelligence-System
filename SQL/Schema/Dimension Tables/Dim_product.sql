CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY NOT NULL,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL
);

INSERT INTO dim_product (product_name, category)
SELECT
    'Product_' || gs,
    CASE
        WHEN random() < 0.4 THEN 'Electronics'
        WHEN random() < 0.7 THEN 'Clothing'
        ELSE 'Home'
    END
FROM generate_series(1,50) gs;
SELECT * FROM dim_product;