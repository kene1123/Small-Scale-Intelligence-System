CREATE OR REPLACE VIEW vw_sales_analysis AS
SELECT
    -- Order identifiers
    oi.order_item_id,
    o.order_id,
    o.order_date,
	-- Date attributes
    d.year,
    d.month,
    d.week,
	-- Customer attributes
    c.customer_id,
    c.customer_name,
    c.gender,
    c.signup_date,
	-- Product attributes
    p.product_id,
    p.product_name,
    p.category,
	-- Sales rep attributes
    s.sales_rep_id,
    s.rep_name,
    s.region,
    s.state,
	-- Measures
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN dim_customer c
    ON o.customer_id = c.customer_id
JOIN dim_product p
    ON oi.product_id = p.product_id
JOIN dim_sales_rep s
    ON o.sales_rep_id = s.sales_rep_id
JOIN dim_date d
    ON o.order_date = d.date;
	SELECT * FROM vw_sales_analysis;
