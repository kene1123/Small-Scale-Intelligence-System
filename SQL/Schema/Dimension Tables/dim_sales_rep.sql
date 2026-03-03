CREATE TABLE dim_sales_rep (
    sales_rep_id SERIAL PRIMARY KEY NOT NULL,
    rep_name TEXT UNIQUE,
    region TEXT NOT NULL,
    state TEXT NOT NULL
);

INSERT INTO dim_sales_rep (rep_name, region, state) VALUES
-- Northeast
('Michael Turner', 'Northeast', 'New York'),
('Sarah Collins', 'Northeast', 'Massachusetts'),
('David Reynolds', 'Northeast', 'Pennsylvania'),
('Emily Watson', 'Northeast', 'New Jersey'),
('Christopher Hall', 'Northeast', 'Connecticut'),
('Laura Bennett', 'Northeast', 'New York'),
('Daniel Brooks', 'Northeast', 'Massachusetts'),
('Rachel Adams', 'Northeast', 'Pennsylvania'),
('Andrew Foster', 'Northeast', 'New Jersey'),
('Olivia Price', 'Northeast', 'Connecticut'),
-- Midwest
('James Miller', 'Midwest', 'Illinois'),
('Hannah Peterson', 'Midwest', 'Ohio'),
('Robert Johnson', 'Midwest', 'Michigan'),
('Natalie Cooper', 'Midwest', 'Indiana'),
('William Scott', 'Midwest', 'Wisconsin'),
('Megan Hughes', 'Midwest', 'Illinois'),
('Thomas Green', 'Midwest', 'Ohio'),
('Rebecca Ward', 'Midwest', 'Michigan'),
('Kevin Morris', 'Midwest', 'Indiana'),
('Sophia Reed', 'Midwest', 'Wisconsin'),
-- South
('Brandon Lewis', 'South', 'Texas'),
('Ashley Martinez', 'South', 'Florida'),
('Justin Walker', 'South', 'Georgia'),
('Amanda Robinson', 'South', 'North Carolina'),
('Matthew Clark', 'South', 'Virginia'),
('Jessica Hernandez', 'South', 'Texas'),
('Ryan King', 'South', 'Florida'),
('Brittany Lopez', 'South', 'Georgia'),
('Joshua Allen', 'South', 'North Carolina'),
('Lauren Young', 'South', 'Virginia'),
-- West
('Ethan Wright', 'West', 'California'),
('Madison Hill', 'West', 'Washington'),
('Jacob Baker', 'West', 'Oregon'),
('Samantha Nelson', 'West', 'Arizona'),
('Tyler Carter', 'West', 'Colorado'),
('Victoria Ramirez', 'West', 'California'),
('Noah Mitchell', 'West', 'Washington'),
('Kylie Roberts', 'West', 'Oregon'),
('Dylan Turner', 'West', 'Arizona'),
('Chloe Phillips', 'West', 'Colorado');
SELECT * FROM dim_sales_rep;
