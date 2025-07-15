INSERT OR IGNORE INTO dim_customer (customer_id)
SELECT DISTINCT customer_id FROM v_clean_raw WHERE customer_id IS NOT NULL;

-- order-mode
INSERT OR IGNORE INTO dim_order_mode (order_mode)
SELECT DISTINCT order_mode FROM v_clean_raw WHERE order_mode IS NOT NULL;

-- segment
INSERT OR IGNORE INTO dim_segment (segment)
SELECT DISTINCT segment FROM v_clean_raw WHERE segment IS NOT NULL;

-- category
INSERT OR IGNORE INTO dim_category (category)
SELECT DISTINCT category FROM v_clean_raw WHERE category IS NOT NULL;

-- location
INSERT OR IGNORE INTO dim_location (city, region, country, postal_code)
SELECT DISTINCT city, region, country, postal_code
FROM v_clean_raw
WHERE city IS NOT NULL AND region IS NOT NULL AND country IS NOT NULL;

-- date
INSERT OR IGNORE INTO dim_date (full_date, year, month, quarter, week, day)
SELECT DISTINCT
       order_date                                    AS full_date,
       CAST(STRFTIME('%Y', order_date) AS INTEGER)   AS year,
       CAST(STRFTIME('%m', order_date) AS INTEGER)   AS month,
       CASE
           WHEN CAST(STRFTIME('%m', order_date) AS INTEGER) BETWEEN 1 AND 3 THEN 1
           WHEN CAST(STRFTIME('%m', order_date) AS INTEGER) BETWEEN 4 AND 6 THEN 2
           WHEN CAST(STRFTIME('%m', order_date) AS INTEGER) BETWEEN 7 AND 9 THEN 3
           ELSE 4
       END                                           AS quarter,
       CAST(STRFTIME('%W', order_date) AS INTEGER)   AS week,
       CAST(STRFTIME('%d', order_date) AS INTEGER)   AS day
FROM v_clean_raw
WHERE order_date IS NOT NULL;

-- product (needs FK to dim_category)
INSERT OR IGNORE INTO dim_product (product_id, product_name, sub_category, category_id)
SELECT  vr.product_id,
        MIN(vr.product_name)  AS product_name,
        MIN(vr.sub_category)  AS sub_category,
        c.category_id
FROM   v_clean_raw  AS vr
JOIN   dim_category AS c
       ON vr.category = c.category
WHERE  vr.product_id IS NOT NULL
GROUP  BY vr.product_id;