CREATE TABLE email_log (
    log_id SERIAL PRIMARY KEY,
    customer_name TEXT,
    customer_email TEXT,
    email_type TEXT,      -- 'TOP_CUSTOMER' or 'DECLINING'
    subject TEXT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    year INT,
    week INT,
    status TEXT           -- SENT / FAILED / SKIPPED
);