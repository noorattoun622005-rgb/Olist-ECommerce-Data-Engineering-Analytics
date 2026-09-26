# Olist E-Commerce Data Engineering and Executive Analytics Pipeline

An end-to-end Data Engineering and Business Intelligence project leveraging PostgreSQL, Advanced SQL, and Power BI to transform raw Brazilian e-commerce data into executive-level decision-making dashboards.

Project Overview:
This project simulates an enterprise-grade analytics solution for Olist, Brazil’s largest e-commerce marketplace. The primary objective was to build a robust relational database schema, clean and transform multi-table transactional data, and engineer key business performance metrics such as RFM segmentation, seller tiering, logistics delivery bottlenecks, and payment structures.

##  Dataset Source & Key Highlights

This project utilizes the **Brazilian E-Commerce Public Dataset by Olist**, sourced directly from **Kaggle**. It consists of authentic commercial data generated from over 100,000 orders placed on Olist's marketplace between 2016 and 2018 in Brazil.

### Dataset Structural Highlights & Metrics
- **Real-World Commercial Scale:** Analyzes real transactional behavior spanning **100,000+ orders** and **$13.2M+ in total processed revenue**.
- **Complex Relational Architecture:** Built around **9 interconnected tables** covering orders, customer profiles, product attributes, marketplace sellers, payments, and reviews.
- **Rich Operational Diversity:** Tracks **3,000+ active marketplace sellers** selling across **32,000+ distinct product categories**.
- **End-to-End E-Commerce Scope:** Provides deep visibility into the entire customer journey — from order purchase timestamps and seller dispatch lead times to multi-installment payment gateways and customer satisfaction feedback (99K+ reviews).
Data Pipeline Architecture and Tech Stack:

* Database and Ingestion: PostgreSQL and pgAdmin for Schema Design, DDL, Constraints, and Relational Modeling
* ETL and Data Transformation: Advanced SQL including Multi-table JOINs, Window Functions, RFM Scoring, and Aggregations
* Data Modeling: Power BI Star Schema and Fact-Dimension Relationships
* DAX and Calculations: Power BI Dynamic KPIs, MoM Growth Rates, and Seller Performance Tiers
* 
##  Dashboard Executive Preview

![Executive Overview](images/Screenshot%202026-09-25%20161834.png)

![Geographic & RFM](images/Screenshot%202026-09-25%20161856.png)

![Seller Operations](images/Screenshot%202026-09-25%20161936.png)

![Payment Analytics](images/Screenshot%202026-09-25%20161950.png)

![Products & Satisfaction](images/Screenshot%202026-09-25%20162007.png)

---
Key Analytical Modules and Pages:

1. Executive Overview: High-level revenue, order volume, average order value, and overall customer loss rate metrics.
2. Geographic and RFM Analysis: Regional revenue concentration across Brazilian states combined with Recency, Frequency, and Monetary customer segmentation.
3. Seller Operations and Bottlenecks: Delivery logistics analysis highlighting average seller processing time vs final delivery duration across top states.
4. Payment Analytics: Order breakdown by installment count, credit card distribution, and payment method performance.
5. Products and Customer Satisfaction: Review score distribution, Decomposition Tree analysis for low ratings, and top or bottom rated product categories.

Project Downloads and Interactive Files

Download Full Power BI Report (.pbix): [Click Here to View on Google Drive](https://drive.google.com/file/d/1YzaHPBCzYfB17x6_8Lnw-hXcks5f2Yiy/view?usp=sharing)

Key Business Insights Generated:

* State Dominance: São Paulo represents the majority of overall revenue and active seller concentration.
* Logistics Bottlenecks: Identified critical gaps where seller processing days vs shipping transit days cause delays in specific states.
* Payment Preference: Credit cards drive over 80% of transactions, with single installment options leading overall sales volume.


* **State Dominance:** São Paulo (SP) represents the majority of overall revenue and active seller concentration.
* **Logistics Bottlenecks:** Identified critical gaps where seller processing days vs. shipping transit days cause delays in specific states.
* **Payment Preference:** Credit cards drive over 80% of transactions, with single installment options leading overall sales volume.
