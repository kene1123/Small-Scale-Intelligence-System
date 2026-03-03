Customer Intelligence & Automated Reporting System
Overview

This project is an end-to-end customer intelligence system built to simulate a real-world retail analytics environment.

It combines database engineering, cloud migration, automation, customer segmentation, and business reporting into one cohesive pipeline.

The goal was simple:

Automatically generate data, identify meaningful customer behavior, trigger targeted communication, and deliver business insights without manual intervention.

What This Project Accomplishes
1. Database Design & Analytics Layer

Designed a relational retail database (fact + dimension model)

Implemented customer, product, sales rep, date, and order structures

Built analytical views to support weekly business reporting

Created segmentation logic for revenue trends and performance monitoring

The database was migrated to a cloud-hosted PostgreSQL instance and validated to ensure production-readiness.

2. Automated Daily Data Generation (Cloud ETL)

A Python automation script:

Generates realistic transactional data

Inserts new orders and order items daily

Ensures continuity by detecting the latest order date

Connects securely to the cloud database

Runs automatically via GitHub Actions

This simulates live operational activity in a retail system.

3. Customer Segmentation & Email Automation

Two independent automation scripts were built:

Top Customers

Identifies customers generating revenue above threshold

Sends appreciation emails

Logs all outreach

Prevents duplicate weekly sends

Declining Customers

Detects week-over-week revenue decline

Sends retention-focused messages

Logs communication attempts

Avoids repeat notifications

Both scripts:

Run on a weekly schedule

Use secure environment variables

Execute in the cloud

Maintain an email audit log in SQL

4. Business Intelligence & Reporting

A Power BI report was developed on top of analytical views.

The dashboard provides:

Top customer analysis

Top and lowest performing sales reps

Underperforming and high-demand products

Week-over-week comparisons

Revenue trends

It includes a Q&A visual, allowing the business owner to type natural business questions such as:

"Who was the top customer this week?"

"Which rep performed lowest?"

"Show declining customers"

"Compare this week to last week"

The system returns accurate, data-backed answers instantly.

Weekly reports are delivered to the business stakeholder automatically.

Architecture Overview

Database → Cloud PostgreSQL
Daily Data Script → GitHub Actions (scheduled)
Segmentation Scripts → GitHub Actions (weekly schedule)
Power BI → Business Reporting Layer

The system operates without manual intervention.

Tech Stack

PostgreSQL (Cloud-hosted)

Python

psycopg2

GitHub Actions (CI/CD & scheduling)

Power BI

SMTP Email Automation

Automation & Scheduling
Process	Frequency	Execution
Data Generation	Daily	GitHub Actions
Customer Email Campaign	Weekly	GitHub Actions
Business Reporting	Weekly	Power BI

All credentials are managed securely using GitHub repository secrets.

Why This Project Matters

This project demonstrates:

Data modeling and analytics engineering

Cloud database deployment

Secure credential management

Automated ETL pipelines

Behavioral customer segmentation

Production-style email automation

Business-facing BI design

CI/CD workflow orchestration

It simulates how a small-to-medium retail business could automate insights, customer engagement, and operational reporting using modern data tooling.

Future Enhancements

Campaign performance tracking.

HTML email templates.

Slack/alert integrations.

Containerized deployment.

Monitoring and failure notifications.
