#!/usr/bin/env python
# coding: utf-8

import psycopg2
import smtplib
from email.mime.text import MIMEText
from datetime import datetime

# DATABASE CONNECTION

import os

conn = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    sslmode="require"
)

cursor = conn.cursor()

# EMAIL CONFIG 

SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
SENDER_EMAIL = os.getenv("EMAIL_ADDRESS")
SENDER_PASSWORD = os.getenv("EMAIL_PASSWORD")

# ---------- GET TOP CUSTOMERS ----------
cursor.execute("""
WITH latest_week AS (
    SELECT year, week
    FROM public.vw_weekly_customer_sales
    ORDER BY year DESC, week DESC
    LIMIT 1
)
SELECT 
    s.customer_name,
    s.email,
    s.year,
    s.week,
    s.revenue
FROM public.vw_weekly_customer_sales s
JOIN latest_week lw
  ON s.year = lw.year
 AND s.week = lw.week
WHERE s.revenue >= 15000
""")

customers = cursor.fetchall()

for name, email, year, week, revenue in customers:

    subject = "Thank You for Being a Top Customer!"

    # ---------- CHECK DUPLICATE (ONLY SKIP IF ALREADY SENT) ----------
    cursor.execute("""
        SELECT 1
        FROM email_log
        WHERE customer_email = %s
          AND email_type = 'TOP_CUSTOMER'
          AND year = %s
          AND week = %s
          AND status = 'SENT'
        LIMIT 1
    """, (email, year, week))

    already_sent = cursor.fetchone()

    if already_sent:
        print(f"Already sent this week → {email}")
        continue

    # ---------- EMAIL BODY ----------
    body = f"""
    Hello {name},

    Thank you for your continued support.
    You are one of our top customers this week!

    Your Weekly revenue: ${revenue:,.2f}

    We truly appreciate your impact, Use this voucher
    on your next purchase 2XXWERTY5.
    """

    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = SENDER_EMAIL
    msg["To"] = email

    try:
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, email, msg.as_string())
        server.quit()

        status = "SENT"
        print(f"Email sent to {email}")

    except Exception as e:
        status = "FAILED"
        print(f"Failed for {email}: {e}")

    # ---------- LOG RESULT ----------
    cursor.execute("""
        INSERT INTO public.email_log
        (customer_name, customer_email, email_type, subject, year, week, status)
        VALUES (%s, %s, 'TOP_CUSTOMER', %s, %s, %s, %s)
    """, (name, email, subject, year, week, status))

    conn.commit()

cursor.close()
conn.close()