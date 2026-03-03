CREATE OR REPLACE VIEW vw_weekly_customer_trend AS
SELECT
    *,
    CASE
        WHEN prev_week_revenue IS NULL THEN 'No Prior Data'
        WHEN revenue < prev_week_revenue * 0.95 THEN 'Declined'
        WHEN revenue > prev_week_revenue * 1.05 THEN 'Increased'
        ELSE 'Stable'
    END AS revenue_trend
FROM vw_weekly_customer_wow;