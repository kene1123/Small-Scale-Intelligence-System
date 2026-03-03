CREATE TABLE dim_date (
    date DATE PRIMARY KEY,
    year INT,
    week INT,
    month INT,
    week_start DATE
);

INSERT INTO dim_date
SELECT
    d::DATE,
    EXTRACT(YEAR FROM d),
    EXTRACT(WEEK FROM d),
    EXTRACT(MONTH FROM d),
    DATE_TRUNC('week', d)::DATE
FROM generate_series('2024-01-01', '2030-12-31', INTERVAL '1 day') d;
SELECT * FROM dim_date;
