#!/usr/bin/env python
# coding: utf-8

# In[1]:


import psycopg2
import smtplib
from email.mime.text import MIMEText

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

# GET DECLINING CUSTOMERS

cursor.execute("""
WITH latest_week AS (
    SELECT year, week
    FROM vw_weekly_customer_trend
    ORDER BY year DESC, week DESC
    LIMIT 1
)

SELECT
    customer_name,
    email, t.year, t.week,
    SUM(revenue) AS revenue,
    SUM(prev_week_revenue) AS prev_rev
FROM vw_weekly_customer_trend t
JOIN latest_week lw
ON t.year = lw.year
AND t.week = lw.week
GROUP BY customer_name, email, t.year, t.week
HAVING SUM(revenue) < SUM(prev_week_revenue)
""")

customers = cursor.fetchall()

for name, email, year, week, revenue, prev_rev in customers:

    subject = "We Miss You — How Can we Help?"

# CHECK DUPLICATE 

    cursor.execute("""
        SELECT COUNT(*)
        FROM email_log
        WHERE customer_email = %s
          AND email_type = 'DECLINING'
          AND year = %s
          AND week = %s
    """, (email, year, week))

    already_sent = cursor.fetchone()[0]

    if already_sent:
        print(f"Skipped duplicate for {email}")
        cursor.execute("""
            INSERT INTO public.email_log
            (customer_name, customer_email, email_type, subject, year, week, status)
            VALUES (%s, %s, 'DECLINING', %s, %s, %s, 'SKIPPED')
        """, (name, email, subject, year, week))
        conn.commit()
        continue

# EMAIL BODY

    body = f"""
    Hello {name},

    We've noticed your activity has declined recently.

    Your Previous week revenue: ${prev_rev:,.2f}
    Your Current week revenue: ${revenue:,.2f}

    We'd love to hear from you.
    If there’s anything we can improve, please let us know.
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

# LOG RESULT

    cursor.execute("""
        INSERT INTO public.email_log
        (customer_name, customer_email, email_type, subject, year, week, status)
        VALUES (%s, %s, 'DECLINING', %s, %s, %s, %s)
    """, (name, email, subject, year, week, status))

    conn.commit()

cursor.close()
conn.close()


# In[ ]:




