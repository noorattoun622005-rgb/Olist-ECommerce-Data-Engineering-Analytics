-- ==============================================================================
-- 1. DATABASE SCHEMA SETUP (DDL: Tables & Primary Keys)
-- ==============================================================================

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(20),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(50),
    seller_state VARCHAR(5)
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price FLOAT,
    freight_value FLOAT
);

CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value NUMERIC(10, 2)
);

CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);

-- ==============================================================================
-- 2. RELATIONAL CONSTRAINTS (Foreign Keys)
-- ==============================================================================

ALTER TABLE orders 
ADD CONSTRAINT fk_orders_customers 
FOREIGN KEY (customer_id) REFERENCES customers (customer_id);

ALTER TABLE order_items 
ADD CONSTRAINT fk_order_items_orders 
FOREIGN KEY (order_id) REFERENCES orders (order_id);

ALTER TABLE order_items 
ADD CONSTRAINT fk_order_items_products 
FOREIGN KEY (product_id) REFERENCES products (product_id);

ALTER TABLE order_items 
ADD CONSTRAINT fk_order_items_sellers 
FOREIGN KEY (seller_id) REFERENCES sellers (seller_id);

ALTER TABLE order_payments 
ADD CONSTRAINT fk_order_payments_orders 
FOREIGN KEY (order_id) REFERENCES orders (order_id);

ALTER TABLE order_reviews 
ADD CONSTRAINT fk_order_reviews_orders 
FOREIGN KEY (order_id) REFERENCES orders (order_id);

-- ==============================================================================
-- 3. ANALYTICAL VIEWS & ETL LOGIC (RFM Segmentation)
-- ==============================================================================

CREATE OR REPLACE VIEW vw_rfm_metrics AS
WITH last_database_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_date 
    FROM orders
)
SELECT 
    c.customer_unique_id,
    DATE_PART('day', (SELECT max_date FROM last_database_date) - MAX(o.order_purchase_timestamp)) AS recency,
    COUNT(DISTINCT o.order_id) AS frequency,
    SUM(oi.price) AS monetary
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id;

CREATE OR REPLACE VIEW vw_customer_segments AS
WITH rfm_scores AS (
    SELECT 
        customer_unique_id,
        recency,
        frequency,
        monetary,
        NTILE(4) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(4) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(4) OVER (ORDER BY monetary ASC) AS m_score
    FROM vw_rfm_metrics
)
SELECT 
    customer_unique_id,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    (r_score::VARCHAR || f_score::VARCHAR || m_score::VARCHAR) AS rfm_cell,
    CASE 
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 2 THEN 'Loyal Customers'
        WHEN r_score = 4 AND f_score = 1 THEN 'New Customers'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
        ELSE 'Need Attention'
    END AS customer_segment
FROM rfm_scores;
