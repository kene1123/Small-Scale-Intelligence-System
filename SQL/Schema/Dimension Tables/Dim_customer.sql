CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY NOT NULL,
    customer_name TEXT NOT NULL,
    gender TEXT NOT NULL
        CHECK (gender IN ('Female', 'Male')),
    email TEXT NOT NULL UNIQUE,
    signup_date DATE NOT NULL
);
INSERT INTO dim_customer (customer_name, gender, email, signup_date)
SELECT
    'Customer_' || gs AS customer_name,
    CASE
        WHEN gs <= 500 * 0.62 THEN 'Female'
        ELSE 'Male'
    END AS gender,
    gs || '@mail.com' AS email,
    DATE '2023-01-01' + (random() * 365)::INT AS signup_date
FROM generate_series(1,500) gs;
SELECT * FROM dim_customer;