#!/usr/bin/env python
# coding: utf-8

# In[2]:


import psycopg2
import random
from datetime import datetime, timedelta


# In[3]:


#CREATE CONNECTION

import os

conn = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    sslmode="require"
)
cur = conn.cursor()

# Fetch dimension IDs

cur.execute("SELECT customer_id FROM public.dim_customer")
customer_ids = [r[0] for r in cur.fetchall()]

cur.execute("SELECT sales_rep_id FROM public.dim_sales_rep")
sales_rep_ids = [r[0] for r in cur.fetchall()]

cur.execute("SELECT product_id FROM dim_product")
product_ids = [r[0] for r in cur.fetchall()]

# Find last order date

cur.execute("SELECT MAX(order_date) FROM public.orders")
result = cur.fetchone()[0]

if result is None:
    start_date = datetime(2025, 1, 1)
else:
    start_date = result + timedelta(days=1)

end_date = datetime.now()

# Convert start_date to datetime if it is a date

if isinstance(start_date, datetime):
    current_date = start_date
else:
    current_date = datetime.combine(start_date, datetime.min.time())

while current_date <= end_date:

    orders_today = random.randint(20, 80)

    for _ in range(orders_today):

        customer_id = random.choice(customer_ids)
        sales_rep_id = random.choice(sales_rep_ids)

        order_timestamp = current_date + timedelta(
            seconds=random.randint(0, 86400)
        )

 # Insert order

        cur.execute("""
            INSERT INTO public.orders (customer_id, sales_rep_id, order_date)
            VALUES (%s, %s, %s)
            RETURNING order_id
        """, (customer_id, sales_rep_id, order_timestamp))

        order_id = cur.fetchone()[0]

        items_count = random.randint(1, 5)

        for _ in range(items_count):
            product_id = random.choice(product_ids)
            quantity = random.randint(1, 10)
            unit_price = round(random.uniform(5, 500), 2)

            cur.execute("""
                INSERT INTO public.order_items
                (order_id, product_id, quantity, unit_price)
                VALUES (%s, %s, %s, %s)
            """, (order_id, product_id, quantity, unit_price))

    current_date += timedelta(days=1)

conn.commit()
cur.close()
conn.close()



# In[ ]:




